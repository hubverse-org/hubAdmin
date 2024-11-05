#' Create a schema or instance path locating a config validation error
#'
#' @param schema list representation of a schema object or property containing the
#' property the error is located in.
#' @param element character string. The name of the property to create a path to.
#' @param type character string. Path type. One of "schema" or "instance".
#' @param append_item_n Logical. Whether to append an items index for the contents
#' of an array property (`TRUE`) or just create a path to the property itself
#' (`FALSE` default).
#'
#'
#' @return a path, either to an instance location in the config or a location in
#' the schema.
#' @noRd
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

  # Subset to the schema paths to the element in question
  path <- grep(paste0(".*", element, "/type([0-9])?$"),
    schema_paths,
    value = TRUE
  ) %>%
    gsub("/type([0-9])?", "", .) %>%
    unique()

  # Instance paths to custom task IDs (which will not have been matche in the schema)
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

generate_instance_path_glue <- function(path) {
  split_path <- gsub("properties/", "", path) %>%
    strsplit("/") %>%
    unlist()

  is_item <- split_path == "items"
  split_path[is_item] <- c(
    "{round_i - 1}",
    "{model_task_i - 1}",
    "{target_key_i - 1}"
  )[1:sum(is_item)]
  paste(split_path, collapse = "/")
}
