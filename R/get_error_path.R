#' Create a schema or instance path locating a config validation error
#'
#' @param schema list representation of a schema object or property containing the
#' property the error is located in.
#' @param element character string. The name of or partial path to the property
#' to create a path to. If there are multiple paths matching the property name,
#' the path at the highest depth is returned. To target properties at a specific depth
#' use a longer part of the path instead of just the property name.
#' @param type character string. Path type. One of "schema" or "instance".
#' @param append_item_n Logical. Whether to append an items index for the contents
#' of an array property (`TRUE`) or just create a path to the property itself
#' (`FALSE` default).
#'
#'
#' @return a path, either to an instance location in the config or a location in
#' the schema. Note that in instance paths, any array location indices are
#' unevaluated in the output and are instead encoded a glue interpolation strings
#' (i.e wrapped in `{}`).
#' They are defined by variables `round_i`, `model_task_i` or `target_key_i` depending
#' on the depth of the property being validated. Values for these variables need to be passed
#' using `glue::glue_data()` and explicitly passing an index variable
#' and it's value as a named list.
#' @noRd
#' @examples
#' # Return the instance path to the origin date task ID in the second modeling task
#' # (overriding the `model_task_i` value in the caller environment)
#' model_task_i <- 1L
#' round_i <- 2L
#' glue::glue_data(
#'   list(model_task_i = 2L),
#'   get_error_path(schema, "origin_date", "instance")
#' )
#' # By default, firsth highest level match returned
#' get_error_path(schema, "derived_task_ids", "schema")
#' # Target lower level properties by defining more of the path
#' get_error_path(schema, "rounds/items/properties/derived_task_ids", "schema")
get_error_path <- function(schema, element = "target_metadata",
                           type = c("schema", "instance"),
                           append_item_n = FALSE) {
  type <- rlang::arg_match(type)

  # Create a character vector of schema paths
  schema_paths <- schema %>%
    jsonlite::fromJSON(simplifyDataFrame = FALSE) %>%
    unlist(recursive = TRUE, use.names = TRUE) %>%
    names() %>%
    gsub("\\.", "/", .) %>%
    paste0("/", .)

  # Subset to the schema paths to the element in question. By sub-setting to the `type[0-9]`
  # path associated with a property, we ensure we limit to a leaf path (not
  #  deeper paths in the schema that include the property of interest as a parent).
  path <- grep(paste0(".*", element, "/type([0-9])?$"),
    schema_paths,
    value = TRUE
  ) %>%
    # here we remove the unnecessary `type[0-9]` part of the path we used to ensure
    # a leaf path.
    gsub("/type([0-9])?", "", .) %>%
    unique() |>
    detect_first()


  # Instance paths to custom task IDs (which will not have been matched in the schema)
  # can be created by appending the element name to the task ID properties path.
  if (length(path) == 0L && type == "instance") {
    path <- grep(paste0(".*", "task_ids", "/type([0-9])?$"),
      schema_paths,
      value = TRUE
    ) %>%
      gsub("/type([0-9])?", "", .) %>%
      unique() %>%
      paste("properties", element, sep = "/")
  }

  # Schema paths to custom task IDs can be created by sub-setting the task_ids
  # additionalProperties schema (which is a stand-in for custom task IDs in the
  # schema).
  # This will only return a path with schema v2.0.0 and above, when
  # additionalProperties became an object.
  if (length(path) == 0L && type == "schema") {
    path <- grep(".*task_ids/additionalProperties/type([0-9])?$",
      schema_paths,
      value = TRUE
    ) %>%
      gsub("/type([0-9])?", "", .) %>%
      unique()
  }

  # If the path we are targeting is an an array (i.e. property name is followed
  # by "items" and `append_item_n` is `TRUE`, (i.e. we want to include the
  # index to a specific element in that object), then add an "\items" string to the
  # end of the path where a location index will be added during instance
  # path interpolation.
  if (append_item_n && any(
    grepl(
      paste(path, "items", sep = "/"),
      schema_paths
    )
  ) &&
    length(path) != 0L
  ) {
    path <- paste(path, "items", sep = "/")
  }

  switch(type,
    schema = if (length(path) == 0L) NA else paste0("#", path),
    instance = generate_instance_path_glue(path)
  )
}

# To create instance path, remove `properties/` elements and substitute `items`
# elements with error position index glue interpolation expression. to be evaluated
# later via glue::glue_data().
generate_instance_path_glue <- function(path) {
  item_props <- c(
    "{round_i - 1}",
    "{model_task_i - 1}",
    "{target_key_i - 1}"
  )
  split_path <- gsub("properties/", "", path) %>%
    strsplit("/") %>%
    unlist()
  is_item <- split_path == "items"
  n_item_props <- sum(is_item)
  split_path[is_item] <- utils::head(item_props, n_item_props)
  paste(split_path, collapse = "/")
}

# Find the first path in a vector of paths by depth (ordered by order of depth -
# deepest last)
detect_first <- function(paths) {
  min_idx <- stringr::str_split(paths, "/") |>
    lengths() |>
    which.min()
  paths[min_idx]
}
