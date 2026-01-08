#' Box elements of a `<config>` class object that can be arrays
#'
#' Due to inconsistencies between R and JSON data types, in particular the
#' fact that R has no concept of a scalar, when writing R list objects to JSON
#' with [write_config()],
#' some properties in the output file may not conform to schema expectations.
#' In particular, list elements that are vectors of length `1L` will be written
#' as scalars, regardless of whether the schema expects an array. This function
#' uses the hubverse schema to identify elements that can be arrays and "box" any
#' such elements that exist in the `<config>` object and have a length of 1.
#' This ensures that they are written out as arrays instead of scalars in JSON
#' output files.
#' The transformation is also applied to any properties that should be arrays
#' covered by `additionalProperties` in the schema (e.g. custom task IDs).
#'
#' @param config a `<config>` class object.
#' @param box_extra_paths a list of character vectors of paths to elements in the
#' `<config>` that can be arrays of vectors but are not covered by the schema.
#' Elements in a path where arrays of objects are expected should be encoded
#' as `"items"`. See output of [get_array_schema_paths()] for more details,
#' especially the examples.
#' @importFrom rlang !!!
#'
#' @return a `<config>` class object with list elements that can be arrays boxed.
#' @export
#'
#' @examples
#' config <- create_config(
#'   create_rounds(
#'     create_round(
#'       round_id_from_variable = TRUE,
#'       round_id = "origin_date",
#'       model_tasks = create_model_tasks(
#'         create_model_task(
#'           task_ids = create_task_ids(
#'             create_task_id("origin_date",
#'               required = NULL,
#'               optional = c(
#'                 "2023-01-02",
#'                 "2023-01-09",
#'                 "2023-01-16"
#'               )
#'             ),
#'             create_task_id("location",
#'               required = "US",
#'               optional = c("01", "02", "04", "05", "06")
#'             ),
#'             create_task_id("horizon",
#'               required = 1L,
#'               optional = 2:4
#'             )
#'           ),
#'           output_type = create_output_type(
#'             create_output_type_mean(
#'               is_required = TRUE,
#'               value_type = "double",
#'               value_minimum = 0L
#'             )
#'           ),
#'           target_metadata = create_target_metadata(
#'             create_target_metadata_item(
#'               target_id = "inc hosp",
#'               target_name = "Weekly incident influenza hospitalizations",
#'               target_units = "rate per 100,000 population",
#'               target_keys = NULL,
#'               target_type = "discrete",
#'               is_step_ahead = TRUE,
#'               time_unit = "week"
#'             )
#'           )
#'         )
#'       ),
#'       submissions_due = list(
#'         relative_to = "origin_date",
#'         start = -4L,
#'         end = 2L
#'       )
#'     )
#'   )
#' )
#' schema_autobox(config)
#' schema_autobox(config) |>
#'   jsonlite::toJSON(
#'     auto_unbox = TRUE, na = "string",
#'     null = "null", pretty = TRUE
#'   )
schema_autobox <- function(config, box_extra_paths = NULL) {
  checkmate::assert_list(box_extra_paths, null.ok = TRUE)
  if (!inherits(config, "config")) {
    cli::cli_abort(
      c(
        "x" = "{.arg config} must be an object of class {.cls config}
             not {.cls {class(config)}}."
      )
    )
  }
  schema_id <- attr(config, "schema_id")
  schema_version <- hubUtils::extract_schema_version(schema_id)
  # If we can extract a branch from the config object, use that.
  # Otherwise, default to main
  branch <- attr(config, "branch")
  if (is.null(branch)) {
    branch <- "main"
  }
  schema <- download_tasks_schema(schema_version, branch)

  # Get list of paths to config properties that can be arrays and may require
  # boxing.
  paths <- get_array_schema_paths(schema)
  if (!is.null(box_extra_paths)) {
    paths <- c(paths, box_extra_paths) |> unique()
  }

  # Identify and append any additional properties that may need to be boxed.
  paths <- append_additional_properties(config, paths)

  paths <- paths |>
    # expand_path_items() basically expands arrays of objects that in the schema
    # are encoded as "items" to integer indices in an actual config file,
    # according to the number of each element in the config.
    purrr::map(~ expand_path_items(.x, config)) |>
    purrr::list_flatten()

  # For every boxable path that exists in the config and has length 1L, coerce
  # to list. This will force such elements to be written out as an array in JSON
  # files.
  for (path in paths) {
    if (purrr::pluck_exists(config, !!!path)) {
      config <- purrr::modify_in(
        .x = config,
        .where = path,
        .f = box
      )
    }
  }
  return(config)
}

#' Get potential paths to properties in a config file that can be arrays from a hubverse schema
#'
#' The functions identifies properties in a hubverse schema that can be arrays of
#' vectors and returns the paths of such elements in a config. Properties that can
#' be arrays of objects are ignored.
#' Useful to determine elements in a config object that may need to be boxed.
#' Note that any `"items"` elements indicate that the property is an array of objects
#'  and will be expanded with element index when applied to config objects.
#' @param schema a list representation of a hubverse schema
#'
#' @return a list where each element is character vector of a path to a property
#'  in the schema that can be an array of vectors. Elements returned as `"items"`
#' @export
#' @examplesIf curl::has_internet()
#' schema <- download_tasks_schema("v3.0.1")
#' get_array_schema_paths(schema)
get_array_schema_paths <- function(schema) {
  checkmate::assert_list(schema)
  is_array_recursive(schema) |>
    unlist() |>
    names() |>
    stringr::str_replace_all("properties\\.|oneOf\\.", "") |>
    unique() |>
    stringr::str_split("\\.")
}

# Check that a list element can be an array. Only returns TRUE when the element
# can be an array of values (i.e. a leaf), not an array of objects (i.e. a node).
can_be_array <- function(x) {
  "array" %in% x[["type"]] && !"object" %in% x[["items"]][["type"]]
}

is_array_recursive <- function(x) {
  if (is.atomic(x)) {
    return(NULL)
  }
  if (can_be_array(x)) {
    x <- TRUE
  }
  if (inherits(x, "list")) {
    x[] <- purrr::map(x, is_array_recursive)
  }
  x
}

box <- function(x) {
  if (is.list(x) || is.null(x) || length(x) > 1L) {
    return(x)
  }
  list(x)
}


expand_items <- function(x, config) {
  item_idx <- purrr::map_lgl(x, \(.x) .x == "items") |>
    which() |>
    utils::head(1L)
  # This identifies the first instance of an "items" element in a schema path
  # and subsets the parent path to it (which is also a valid config file path)
  at <- x[seq_len(item_idx - 1L)]
  # It then counts how many elements the above parent path contains.
  # It's used below to expand a single schema path to as many paths as actual elements
  # in the config by substituting the "items" elements in the schema path with
  # integer indices. This is effectively transforming a schema path to valid config paths
  item_n <- purrr::pluck(config, !!!at) |>
    length()

  purrr::map(
    seq_len(item_n),
    \(.x, item_idx) {
      x <- as.list(x)
      x[[item_idx]] <- as.integer(.x)
      x
    },
    item_idx = item_idx
  )
}


expand_path_items <- function(path, config) {
  path <- list(path)
  while (purrr::some(path, ~ purrr::has_element(.x, "items"))) {
    path <- purrr::map(
      path,
      \(.x) {
        expand_items(.x, config)
      }
    ) |>
      purrr::list_flatten()
  }
  path
}
