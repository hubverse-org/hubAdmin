# Target Data Validation Utilities

## GLOBAL LEVEL VALIDATIONS ----

#' Validate global observable_unit contains only valid columns
#'
#' Checks that the global observable_unit array only contains:
#' - Task ID columns (from tasks.json)
#' - date_col value
#' - target_col value (if present and not NULL)
#'
#' @param config_json Parsed target-data.json as list
#' @param schema JSON schema for target-data
#' @param config_tasks Parsed tasks.json as list
#'
#' @return NULL if validation passes, or data.frame with error row if validation fails
#' @noRd
validate_global_observable_unit <- function(config_json, schema, config_tasks) {
  observable_unit <- config_json[["observable_unit"]]

  # If no observable_unit defined, skip validation
  if (is.null(observable_unit) || length(observable_unit) == 0) {
    return(NULL)
  }

  # Get task ID and target from config tasks
  task_id_cols <- hubUtils::get_task_id_names(config_tasks)

  # Get date_col from target data config
  date_col <- get_date_col(config_json)

  allowed_cols <- unique(task_id_cols, date_col)

  # Check for invalid columns
  invalid_cols <- setdiff(observable_unit, allowed_cols)

  if (length(invalid_cols) > 0) {
    error_row <- data.frame(
      instancePath = get_error_path(schema, "observable_unit", "instance"),
      schemaPath = get_error_path(schema, "observable_unit", "schema"),
      keyword = "observable_unit values",
      message = glue::glue(
        "observable_unit column(s) '{glue::glue_collapse(invalid_cols, \", \", last = \" & \")}' ",
        "not valid. Must be task ID column(s), date_col, or target_col (if specified)."
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


## DATASET LEVEL VALIDATIONS ----

#' Validate time-series config for internal consistency
#'
#' Validates:
#' - Dataset-level observable_unit (if specified)
#' - non_task_id_schema doesn't contain task ID columns or reserved columns
#'
#' @param config_json Parsed target-data.json as list
#' @param schema JSON schema for target-data
#' @param config_tasks Parsed tasks.json as list
#'
#' @return NULL if validation passes, or data.frame with error rows if validation fails
#' @noRd
validate_time_series_config <- function(config_json, schema, config_tasks) {
  time_series <- config_json[["time-series"]]

  # Skip if time-series not present
  if (is.null(time_series)) {
    return(NULL)
  }

  errors <- list()

  # Validate dataset-level observable_unit if present
  dataset_ou_error <- validate_dataset_observable_unit(
    config_json,
    schema,
    config_tasks,
    dataset_type = "time-series"
  )
  if (!is.null(dataset_ou_error)) {
    errors <- c(errors, list(dataset_ou_error))
  }

  # Validate non_task_id_schema
  non_task_id_schema <- time_series[["non_task_id_schema"]]
  if (!is.null(non_task_id_schema)) {
    non_task_schema_error <- validate_non_task_id_schema(
      config_json,
      schema,
      config_tasks,
      non_task_id_schema
    )
    if (!is.null(non_task_schema_error)) {
      errors <- c(errors, list(non_task_schema_error))
    }
  }

  if (length(errors) == 0) {
    return(NULL)
  }

  purrr::list_rbind(errors)
}


#' Validate oracle-output config for internal consistency
#'
#' Validates dataset-level observable_unit (if specified)
#'
#' @param config_json Parsed target-data.json as list
#' @param schema JSON schema for target-data
#' @param config_tasks Parsed tasks.json as list
#'
#' @return NULL if validation passes, or data.frame with error row if validation fails
#' @noRd
validate_oracle_output_config <- function(config_json, schema, config_tasks) {
  oracle_output <- config_json[["oracle-output"]]

  # Skip if oracle-output not present
  if (is.null(oracle_output)) {
    return(NULL)
  }

  # Validate dataset-level observable_unit if present
  validate_dataset_observable_unit(
    config_json,
    schema,
    config_tasks,
    dataset_type = "oracle-output"
  )
}


#' Validate dataset-level observable_unit contains only valid columns
#'
#' @param config_json Parsed target-data.json as list
#' @param schema JSON schema for target-data
#' @param config_tasks Parsed tasks.json as list
#' @param dataset_type Character, either "time-series" or "oracle-output"
#'
#' @return NULL if validation passes, or data.frame with error row if validation fails
#' @noRd
validate_dataset_observable_unit <- function(
  config_json,
  schema,
  config_tasks,
  dataset_type
) {
  dataset <- config_json[[dataset_type]]
  observable_unit <- dataset[["observable_unit"]]

  # Skip if no dataset-level observable_unit (inherits from global)
  if (is.null(observable_unit) || length(observable_unit) == 0) {
    return(NULL)
  }

  # Get task ID columns
  task_id_cols <- hubUtils::get_task_id_names(config_tasks)

  # Get date_col and target_col
  date_col <- get_date_col(config_json)
  target_col <- get_target_task_id(config_json)

  # Build list of allowed columns
  allowed_cols <- task_id_cols
  if (!is.null(date_col)) {
    allowed_cols <- c(allowed_cols, date_col)
  }
  if (!is.null(target_col)) {
    allowed_cols <- c(allowed_cols, target_col)
  }
  allowed_cols <- unique(allowed_cols)

  # Check for invalid columns
  invalid_cols <- setdiff(observable_unit, allowed_cols)

  if (length(invalid_cols) > 0) {
    error_row <- data.frame(
      instancePath = get_error_path(
        schema,
        glue::glue("{dataset_type}/observable_unit"),
        "instance"
      ),
      schemaPath = get_error_path(
        schema,
        glue::glue("{dataset_type}/observable_unit"),
        "schema"
      ),
      keyword = glue::glue("{dataset_type} observable_unit values"),
      message = glue::glue(
        "{dataset_type} observable_unit column(s) ",
        "'{glue::glue_collapse(invalid_cols, \", \", last = \" & \")}' ",
        "not valid. Must be task ID column(s), date_col, or target_col (if specified)."
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


#' Validate non_task_id_schema doesn't contain invalid columns
#'
#' Checks that non_task_id_schema doesn't contain:
#' - Task ID columns
#' - Reserved columns: as_of, output_type, output_type_id
#'
#' @param config_json Parsed target-data.json as list
#' @param schema JSON schema for target-data
#' @param config_tasks Parsed tasks.json as list
#' @param non_task_id_schema The non_task_id_schema object to validate
#'
#' @return NULL if validation passes, or data.frame with error row if validation fails
#' @noRd
validate_non_task_id_schema <- function(
  config_json,
  schema,
  config_tasks,
  non_task_id_schema
) {
  schema_cols <- names(non_task_id_schema)

  if (is.null(schema_cols) || length(schema_cols) == 0) {
    return(NULL)
  }

  # Get task ID columns
  task_id_cols <- hubUtils::get_task_id_names(config_tasks)

  # Get reserved columns
  reserved_cols <- get_reserved_columns()

  # Combine forbidden columns
  forbidden_cols <- c(task_id_cols, reserved_cols)

  # Check for invalid columns
  invalid_cols <- intersect(schema_cols, forbidden_cols)

  if (length(invalid_cols) > 0) {
    # Separate task ID columns from reserved columns for clearer error message
    invalid_task_ids <- intersect(schema_cols, task_id_cols)
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

#' Get effective observable_unit for a dataset
#'
#' Returns dataset-level observable_unit if specified, otherwise global
#'
#' @param config_json Parsed target-data.json as list
#' @param dataset_type Character, either "time-series" or "oracle-output"
#'
#' @return Character vector of observable_unit columns
#' @noRd
get_effective_observable_unit <- function(config_json, dataset_type) {
  dataset_ou <- config_json[[dataset_type]][["observable_unit"]]
  if (is.null(dataset_ou)) {
    return(config_json[["observable_unit"]])
  }
  dataset_ou
}


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
