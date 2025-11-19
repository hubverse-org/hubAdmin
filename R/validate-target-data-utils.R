# Target Data Validation Utilities

## OBSERVABLE UNIT VALIDATION ----

#' Validate observable_unit contains only valid columns
#'
#' Checks that the observable_unit array only contains:
#' - Task ID columns (from tasks.json)
#' - date_col value
#'
#' @param config_json Parsed target-data.json as list
#' @param schema JSON schema for target-data (i.e. the contents of
#' `target-data-schema.json` in the schemas repo)
#' @param task_id_names Character vector of task ID names
#' @param level Character, one of "global", "time-series", or "oracle-output"
#'
#' @return NULL if validation passes, or data.frame with error row if validation fails
#' @noRd
validate_observable_unit <- function(
  config_json,
  schema,
  task_id_names,
  level = c("global", "time-series", "oracle-output")
) {
  level <- rlang::arg_match(level)
  # Extract observable_unit based on level
  if (level == "global") {
    observable_unit <- config_json[["observable_unit"]]
    path <- "observable_unit"
  } else {
    observable_unit <- config_json[[level]][["observable_unit"]]
    path <- glue::glue("{level}/observable_unit")
  }

  # If no observable_unit defined, skip validation
  if (is.null(observable_unit) || length(observable_unit) == 0) {
    return(NULL)
  }

  # Get date_col from target data config
  date_col <- hubUtils::get_date_col(config_json)

  # Build allowed columns
  allowed_cols <- unique(c(task_id_names, date_col))

  # Check for invalid columns
  invalid_cols <- setdiff(observable_unit, allowed_cols)

  if (length(invalid_cols) > 0) {
    # Format level for error message
    level_label <- if (level == "global") "" else paste0(level, " ")

    error_row <- data.frame(
      instancePath = get_error_path(schema, path, "instance"),
      schemaPath = get_error_path(schema, path, "schema"),
      keyword = paste0(level_label, "observable_unit values"),
      message = glue::glue(
        "{level_label}observable_unit column(s) ",
        "'{glue::glue_collapse(invalid_cols, \", \", last = \" & \")}' ",
        "not valid. Must be task ID column(s) or date_col."
      ),
      schema = "",
      data = glue::glue(
        "observable_unit values: {glue::glue_collapse(observable_unit, ', ')}; ",
        "allowed values: {glue::glue_collapse(allowed_cols, ', ')}"
      ),
      stringsAsFactors = FALSE
    )
    return(error_row)
  }

  NULL
}


## TIME-SERIES SPECIFIC VALIDATIONS ----

#' Validate non_task_id_schema doesn't contain invalid columns
#'
#' Checks that non_task_id_schema doesn't contain:
#' - Task ID columns
#' - date_col (whether or not it's a task ID)
#' - Reserved columns: as_of, output_type, output_type_id
#'
#' @param config_json Parsed target-data.json as list
#' @param schema JSON schema for target-data
#' @param task_id_names Character vector of task ID names
#'
#' @return NULL if validation passes, or data.frame with error row if validation fails
#' @noRd
validate_non_task_id_schema <- function(
  config_json,
  schema,
  task_id_names
) {
  non_task_id_schema <- config_json[["time-series"]][["non_task_id_schema"]]

  if (is.null(non_task_id_schema) || length(non_task_id_schema) == 0) {
    return(NULL)
  }
  schema_cols <- names(non_task_id_schema)

  # Get date_col (special column that should not appear in non_task_id_schema)
  date_col <- hubUtils::get_date_col(config_json)

  # Get reserved columns
  reserved_cols <- get_reserved_columns()

  # Combine forbidden columns: task IDs, date_col, and reserved columns
  forbidden_cols <- unique(c(task_id_names, date_col, reserved_cols))

  # Check for invalid columns
  invalid_cols <- intersect(schema_cols, forbidden_cols)

  if (length(invalid_cols) > 0) {
    # Separate different types of invalid columns for clearer error message
    invalid_task_ids <- intersect(schema_cols, task_id_names)
    invalid_date_col <- intersect(schema_cols, date_col)
    invalid_reserved <- intersect(schema_cols, reserved_cols)

    error_details <- character()
    if (length(invalid_task_ids) > 0) {
      error_details <- c(
        error_details,
        glue::glue(
          "task ID column(s): {glue::glue_collapse(invalid_task_ids, ', ')}"
        )
      )
    }
    if (length(invalid_date_col) > 0) {
      error_details <- c(
        error_details,
        glue::glue("date_col: {date_col}")
      )
    }
    if (length(invalid_reserved) > 0) {
      error_details <- c(
        error_details,
        glue::glue(
          "reserved column(s): {glue::glue_collapse(invalid_reserved, ', ')}"
        )
      )
    }

    error_row <- data.frame(
      instancePath = get_error_path(
        schema,
        "time-series/non_task_id_schema",
        "instance"
      ),
      schemaPath = get_error_path(
        schema,
        "time-series/non_task_id_schema",
        "schema"
      ),
      keyword = "non_task_id_schema column names",
      message = glue::glue(
        "non_task_id_schema must NOT contain task ID columns, date_col, or reserved columns. ",
        "Invalid: {glue::glue_collapse(invalid_cols, ', ', last = ' & ')}"
      ),
      schema = "",
      data = glue::glue_collapse(error_details, "; "),
      stringsAsFactors = FALSE
    )
    return(error_row)
  }

  NULL
}


## DATE_COL VALIDATION ----

#' Validate date_col references a Date type task ID
#'
#' Checks that if date_col references a task ID name, that task ID must be
#' a Date type task ID (i.e., contains date values in ISO 8601 format).
#'
#' @param config_json Parsed target-data.json as list
#' @param config_tasks Parsed tasks.json as list
#' @param schema JSON schema for target-data
#'
#' @return NULL if validation passes, or data.frame with error row if validation fails
#' @noRd
validate_date_col_is_date_type <- function(
  config_json,
  config_tasks,
  schema
) {
  date_col <- hubUtils::get_date_col(config_json)
  task_id_names <- hubUtils::get_task_id_names(config_tasks)

  # If date_col is not a task ID, validation passes. It will be cast as date
  # when creating target dataset schema
  if (!date_col %in% task_id_names) {
    return(NULL)
  }

  # Get the data type of the date_col task ID
  task_id_type <- get_task_id_type(config_tasks, date_col)

  # If it's not a Date type, return error
  if (task_id_type != "Date") {
    error_row <- data.frame(
      instancePath = get_error_path(schema, "date_col", "instance"),
      schemaPath = get_error_path(schema, "date_col", "schema"),
      keyword = "date_col task ID type",
      message = glue::glue(
        "date_col references task ID '{date_col}' which is of type '{task_id_type}' ",
        "but must be of type 'Date'."
      ),
      schema = "",
      data = glue::glue("date_col: {date_col}; task ID type: {task_id_type}"),
      stringsAsFactors = FALSE
    )
    return(error_row)
  }

  NULL
}


## HELPER FUNCTIONS ----

#' Get reserved column names
#'
#' Returns list of reserved column names that cannot be used in non_task_id_schema
#'
#' @return Character vector of reserved column names
#' @noRd
get_reserved_columns <- function() {
  c("as_of", "output_type", "output_type_id", "observation", "oracle_value")
}


#' Get task ID data type from config
#'
#' Determines the R data type of a task ID by examining all values across all rounds.
#'
#' @details
#' This function is adapted from `hubData::get_task_id_type()`.
#' It is temporarily duplicated here pending migration to hubUtils.
#'
#' @param config_tasks Parsed tasks.json as list
#' @param task_id_name Character, name of the task ID
#'
#' @return Character, one of "character", "double", "integer", "logical", or "Date"
#' @noRd
get_task_id_type <- function(config_tasks, task_id_name) {
  values <- get_task_id_values(config_tasks, task_id_name)
  get_data_type(values)
}


#' Get all task ID values from config
#'
#' Extracts all values for a specific task ID across all rounds and model tasks.
#'
#' @details
#' This function is adapted from `hubData::get_task_id_values()`.
#' It is temporarily duplicated here pending migration to hubUtils.
#'
#' @param config_tasks Parsed tasks.json as list
#' @param task_id_name Character, name of the task ID
#'
#' @return Vector of all task ID values
#' @noRd
get_task_id_values <- function(config_tasks, task_id_name) {
  model_tasks <- purrr::map(
    config_tasks[["rounds"]],
    ~ .x[["model_tasks"]]
  )

  model_tasks %>%
    purrr::map(
      ~ .x %>%
        purrr::map(~ .x[["task_ids"]][[task_id_name]])
    ) %>%
    unlist(recursive = FALSE) %>%
    unlist()
}


#' Determine data type from values
#'
#' Determines R data type, checking if character values are ISO 8601 dates.
#'
#' @details
#' This function is adapted from `hubData::get_data_type()`.
#' It is temporarily duplicated here pending migration to hubUtils.
#'
#' @param x Vector of values
#'
#' @return Character, one of "character", "double", "integer", "logical", or "Date"
#' @noRd
get_data_type <- function(x) {
  type <- typeof(x)

  if (type == "character" && test_iso_date(x)) {
    type <- "Date"
  }
  type
}


#' Test if character values are valid ISO 8601 dates
#'
#' Checks if all non-NA character values can be parsed as dates in ISO 8601 format (YYYY-MM-DD).
#'
#' @details
#' This function is adapted from `hubData::test_iso_date()`.
#' It is temporarily duplicated here pending migration to hubUtils.
#'
#' @param x Character vector
#'
#' @return Logical, TRUE if all values are valid dates, FALSE otherwise
#' @noRd
test_iso_date <- function(x) {
  to_date <- try(as.Date(x), silent = TRUE)
  isFALSE(inherits(to_date, "try-error")) &&
    # Check that coercion to Date does not introduce NA values
    isTRUE(
      all.equal(
        which(is.na(x)),
        which(is.na(to_date))
      )
    )
}
