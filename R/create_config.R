#' Create a `config` class object.
#'
#' Create a representation of a complete `"tasks"` config file as a list object of
#' class `config`. This can be written out to a `tasks.json` file.
#'
#' @param rounds An object of class `rounds` created using function
#' [`create_rounds()`]
#' @param output_type_id_datatype A character string specifying the value of the
#'  `output_type_id_datatype` property. Only available since [hubverse schema v3.0.1](
#'  https://github.com/hubverse-org/schemas/releases/tag/v3.0.1).
#'  Ignored if NULL (default) and throws a warning if a value is provided and the
#'  schema version used for the config is <= v3.0.1.
#'  This property is used to set the data type of the `output_type_id` column in
#' model outputs and can take values of `"auto"`, `"character"`, `"double"`,
#' `"integer"`, `"logical"`, or `"Date"`.
#' For more details consult the [hubDocs documentation on model output datatypes](
#' https://hubverse.io/en/latest/user-guide/model-output.html#the-importance-of-a-stable-model-output-file-schema)
#' @param derived_task_ids character vector of derived task id names (i.e. task IDs
#' whose values are depended on the values of other task IDs). Only available for
#' schema version v4.0.0 and later.
#'
#' @return a named list of class `config`.
#' @export
#' @seealso [create_rounds()]
#' @details For more details consult
#' the [documentation on `tasks.json` Hub config files](
#' https://hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).
#'
#' @examples
#' rounds <- create_rounds(
#'   create_round(
#'     round_id_from_variable = TRUE,
#'     round_id = "origin_date",
#'     model_tasks = create_model_tasks(
#'       create_model_task(
#'         task_ids = create_task_ids(
#'           create_task_id("origin_date",
#'             required = NULL,
#'             optional = c(
#'               "2023-01-02",
#'               "2023-01-09",
#'               "2023-01-16"
#'             )
#'           ),
#'           create_task_id("location",
#'             required = "US",
#'             optional = c("01", "02", "04", "05", "06")
#'           ),
#'           create_task_id("horizon",
#'             required = 1L,
#'             optional = 2:4
#'           )
#'         ),
#'         output_type = create_output_type(
#'           create_output_type_mean(
#'             is_required = TRUE,
#'             value_type = "double",
#'             value_minimum = 0L
#'           )
#'         ),
#'         target_metadata = create_target_metadata(
#'           create_target_metadata_item(
#'             target_id = "inc hosp",
#'             target_name = "Weekly incident influenza hospitalizations",
#'             target_units = "rate per 100,000 population",
#'             target_keys = NULL,
#'             target_type = "discrete",
#'             is_step_ahead = TRUE,
#'             time_unit = "week"
#'           )
#'         )
#'       )
#'     ),
#'     submissions_due = list(
#'       relative_to = "origin_date",
#'       start = -4L,
#'       end = 2L
#'     )
#'   )
#' )
#' create_config(rounds)
create_config <- function(rounds,
                          output_type_id_datatype = NULL,
                          derived_task_ids = NULL) {
  rlang::check_required(rounds)
  check_object_class(rounds, "rounds")
  schema_id <- attr(rounds, "schema_id")
  if (!is.null(derived_task_ids)) {
    check_derived_task_ids(derived_task_ids, rounds = rounds)
  }
  output_type_id_datatype <- check_output_type_id_datatype(
    schema_id,
    output_type_id_datatype
  )

  structure(
    list(
      schema_version = schema_id,
      rounds = rounds$rounds,
      output_type_id_datatype = output_type_id_datatype,
      derived_task_ids = derived_task_ids
    ) %>% purrr::compact(), # remove output_type_id_datatype if NULL
    class = c("config", "list"),
    schema_id = schema_id
  )
}

check_output_type_id_datatype <- function(schema_id, output_type_id_datatype) {
  checkmate::assert_choice(output_type_id_datatype,
    c(
      "auto", "character", "double", "integer",
      "logical", "Date"
    ),
    null.ok = TRUE
  )
  pre_v3_1 <- hubUtils::extract_schema_version(schema_id) < "v3.0.1"
  not_null <- !is.null(output_type_id_datatype)

  if (pre_v3_1 && not_null) {
    cli::cli_alert_warning(
      "{.arg output_type_id_datatype} not avalaible in
      schema versions < {.val v3.0.1}"
    )
    return(NULL)
  }
  return(output_type_id_datatype)
}

check_derived_task_ids <- function(derived_task_ids, rounds, model_tasks,
                                   call = rlang::caller_env()) {
  rlang::check_exclusive(rounds, model_tasks)
  if (rlang::is_missing(rounds)) {
    schema_id <- attr(model_tasks, "schema_id")
    all_model_tasks <- model_tasks$model_tasks
    object <- "model_tasks"
  } else {
    schema_id <- attr(rounds, "schema_id")
    all_model_tasks <- purrr::map(rounds$rounds, ~ .x$model_tasks) |>
      purrr::flatten()
    object <- "rounds"
  }
  pre_v4 <- hubUtils::version_lt("v4.0.0", schema_version = schema_id)
  if (pre_v4) {
    cli::cli_warn(
      c("!" = "{.arg derived_task_ids} argument is only available for schema version
                {.val v4.0.0} and later. Ignored."),
      call = call
    )
    return(invisible(FALSE))
  }

  task_ids <- purrr::map(
    all_model_tasks,
    ~ names(.x$task_ids)
  ) |>
    unlist() |>
    unique()

  invalid_derived_task_ids <- setdiff(derived_task_ids, task_ids)

  if (length(invalid_derived_task_ids) > 0L) {
    cli::cli_abort(
      c(
        "x" = "{cli::qty(length(invalid_derived_task_ids))}
        {.arg derived_task_ids} value{?s} {.val {invalid_derived_task_ids}}
        {?is/are} not valid {.arg task_id} variable{?s}
        in the provided {.arg {object}} object.",
        "i" = "Valid {.arg task_id} variables are: {.val {task_ids}}"
      ),
      call = call
    )
  }
}
