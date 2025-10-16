# Target Data Validation Utilities

## OBSERVABLE UNIT VALIDATION ----

#' Validate observable_unit contains only valid columns
#'
#' Checks that the observable_unit array only contains:
#' - Task ID columns (from tasks.json)
#' - date_col value
#'
#' @param config_json Parsed target-data.json as list
#' @param schema JSON schema for target-data
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
  date_col <- get_date_col(config_json)

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

  # Get reserved columns
  reserved_cols <- get_reserved_columns()

  # Combine forbidden columns
  forbidden_cols <- c(task_id_names, reserved_cols)

  # Check for invalid columns
  invalid_cols <- intersect(schema_cols, forbidden_cols)

  if (length(invalid_cols) > 0) {
    # Separate task ID columns from reserved columns for clearer error message
    invalid_task_ids <- intersect(schema_cols, task_id_names)
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
        "non_task_id_schema must NOT contain task ID columns or reserved columns. ",
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


## HELPER FUNCTIONS ----

#' Get reserved column names
#'
#' Returns list of reserved column names that cannot be used in non_task_id_schema
#'
#' @return Character vector of reserved column names
#' @noRd
get_reserved_columns <- function() {
  c("as_of", "output_type", "output_type_id")
}


#' Get date_col value from config
#'
#' Extract date_col value from config (required property)
#'
#' @param config_target_data Parsed target-data.json as list
#'
#' @return Character value of date_col
#' @noRd
get_date_col <- function(config_target_data) {
  config_target_data[["date_col"]]
}
