#' Create an object of class `round`
#'
#' Create a representation of a round item as a list object of
#' class `round`. This can be combined with
#' additional `round` objects using function [`create_rounds()`].
#' Such building blocks can ultimately be combined and then written out as or
#' appended to `tasks.json` Hub config files.
#' @param round_id_from_variable logical. Whether `round_id` is inferred from the
#' values of a `task_id` variable within the `model_tasks` `model_task` items.
#' @param round_id character string. The round identifier.
#' If `round_id_from_variable = TRUE`, `round_id` should be the name of a `task_id`
#' variable present in all  `model_tasks` `model_task` items.
#' @param round_name character string. An optional round name. This can be useful
#' for internal referencing of rounds, for examples, when a date is used as
#' `round_id` but hub maintainers and teams also refer to rounds as round-1, round-2 etc.
#' @param model_tasks an object of class `model_tasks` created with function
#' [create_model_tasks()].
#' @param submissions_due named list conforming to one of the two following structures:
#' 1. Submission dates for round is determined relative to an origin date.
#'     - `relative_to`: character string of the name of the `task_id` variable containing
#'     origin dates in relation to which submission start and end dates are determined.
#'     - `start`: integer. Difference in days between start and origin date.
#'     - `end`: integer. Difference in days between end and origin date.
#' 2. Submission dates for round are provided explicitly.
#'     - `start`: character. Submission start date in ISO 8601 format (YYYY-MM-DD).
#'     - `end`: character. Submission end date in ISO 8601 format (YYYY-MM-DD).
#' @param last_data_date character date in ISO 8601 format (YYYY-MM-DD).
#' The last date with recorded data in the data set used as input to a model.
#' Optional.
#' @param file_format character string. An optional specification of a file format for the round.
#' This option in only available for some versions of the schema and is ignored if
#'  not allowed in the version of the schema used. It also overrides any specification
#'  of file format in `admin.json`. For more details on whether this argument can
#'  be used as well as available formats, please consult
#' the [documentation on `tasks.json` Hub config files](
#' https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).
#' @param ... additional optional properties to add to the round list output.
#' In schema versions greater or equal to v6.0.0, these properties are placed in
#' the `additional_metadata` field.
#' @inheritParams create_config
#' @return a named list of class `round`.
#' @export
#' @seealso [create_rounds()]
#' @details For more details consult
#' the [documentation on `tasks.json` Hub config files](
#' https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).
#' @examples
#' model_tasks <- create_model_tasks(
#'   create_model_task(
#'     task_ids = create_task_ids(
#'       create_task_id("origin_date",
#'         required = NULL,
#'         optional = c(
#'           "2023-01-02",
#'           "2023-01-09",
#'           "2023-01-16"
#'         )
#'       ),
#'       create_task_id("location",
#'         required = "US",
#'         optional = c("01", "02", "04", "05", "06")
#'       ),
#'       create_task_id("horizon",
#'         required = 1L,
#'         optional = 2:4
#'       )
#'     ),
#'     output_type = create_output_type(
#'       create_output_type_mean(
#'         is_required = TRUE,
#'         value_type = "double",
#'         value_minimum = 0L
#'       )
#'     ),
#'     target_metadata = create_target_metadata(
#'       create_target_metadata_item(
#'         target_id = "inc hosp",
#'         target_name = "Weekly incident influenza hospitalizations",
#'         target_units = "rate per 100,000 population",
#'         target_keys = NULL,
#'         target_type = "discrete",
#'         is_step_ahead = TRUE,
#'         time_unit = "week"
#'       )
#'     )
#'   )
#' )
#' create_round(
#'   round_id_from_variable = TRUE,
#'   round_id = "origin_date",
#'   model_tasks = model_tasks,
#'   submissions_due = list(
#'     relative_to = "origin_date",
#'     start = -4L,
#'     end = 2L
#'   ),
#'   last_data_date = "2023-01-02"
#' )
#' # For schema version >= v6.0.0, example with an additional optional property
#' create_round(
#'   round_id_from_variable = TRUE,
#'   round_id = "origin_date",
#'   model_tasks = model_tasks,
#'   submissions_due = list(
#'     relative_to = "origin_date",
#'     start = -4L,
#'     end = 2L
#'   ),
#'   last_data_date = "2023-01-02",
#'   round_label = "Round 1",
#'   data_source = "https://example.com/data"
#' )
create_round <- function(
  round_id_from_variable,
  round_id,
  round_name = NULL,
  model_tasks,
  submissions_due,
  last_data_date = NULL,
  file_format = NULL,
  derived_task_ids = NULL,
  ...
) {
  rlang::check_required(round_id_from_variable)
  rlang::check_required(round_id)
  rlang::check_required(model_tasks)
  rlang::check_required(submissions_due)
  call <- rlang::current_env()

  check_object_class(model_tasks, "model_tasks")

  schema_version <- hubUtils::extract_schema_version(
    attr(model_tasks, "schema_id")
  )
  branch <- attr(model_tasks, "branch")
  schema <- download_tasks_schema(schema_version, branch)

  round_schema <- get_schema_round(schema)

  property_names <- c(
    "round_id_from_variable",
    "round_id",
    "round_name",
    "model_tasks",
    "submissions_due",
    "last_data_date",
    "file_format",
    "derived_task_ids"
  ) |>
    purrr::keep(~ .x %in% names(round_schema))
  properties <- mget(property_names) |>
    purrr::compact()
  property_names <- names(properties)
  properties$model_tasks <- model_tasks$model_tasks

  check_properties_scalar(properties, round_schema, call = call)
  check_properties_array(properties, round_schema, call = call)
  check_submission_due(submissions_due, round_schema, model_tasks)
  if (!is.null(derived_task_ids)) {
    check_derived_task_ids(derived_task_ids, model_tasks = model_tasks)
  }
  if (round_id_from_variable) {
    check_round_id_variable(model_tasks, round_id)
    check_round_id_pattern_vals(model_tasks, round_id)
  } else {
    check_round_id_pattern(round_id)
  }

  # Handle additional properties
  vers <- hubUtils::extract_schema_version(schema$`$id`)
  opt_properties <- list(...)
  if (length(opt_properties) > 0L) {
    if (hubUtils::version_gte("v6.0.0", schema_version = vers)) {
      properties <- c(properties, list(opt_properties))
      property_names <- c(property_names, "additional_metadata")
    } else {
      properties <- c(properties, opt_properties)
      property_names <- c(property_names, names(opt_properties))
    }
  }

  structure(
    properties,
    class = c("round", "list"),
    names = property_names,
    round_id = round_id,
    schema_id = schema$`$id`,
    branch = branch
  )
}

check_round_id_variable <- function(
  model_tasks,
  round_id,
  call = rlang::caller_env()
) {
  invalid_round_id <- purrr::map_lgl(
    model_tasks$model_tasks,
    ~ !round_id %in% names(.x$task_ids)
  )

  if (any(invalid_round_id)) {
    cli::cli_abort(
      c(
        "!" = "{.arg round_id} value must correspond to a valid {.arg task_id}
                variable in every {.arg model_task} object.",
        "x" = "{.arg round_id} value {.val {round_id}} does not correspond
              to a valid  variable in provided {cli::qty(sum(invalid_round_id))}
              {.arg model_tasks} {.arg model_task} object{?s}
              {.val {which(invalid_round_id)}}."
      ),
      call = call
    )
  }
}

check_submission_due <- function(
  submissions_due,
  round_schema,
  model_tasks,
  call = rlang::caller_env()
) {
  if (
    !rlang::is_list(submissions_due) || inherits(submissions_due, "data.frame")
  ) {
    cli::cli_abort(
      c(
        "!" = "{.arg submissions_due} must be a {.cls list} not a
            {.cls {class(submissions_due)}}"
      ),
      call = call
    )
  }

  schema_valid_names <- purrr::map(
    round_schema$submissions_due$oneOf,
    ~ names(.x$properties)
  ) |>
    unlist() |>
    unique()
  invalid_properties <- !names(submissions_due) %in% schema_valid_names

  if (any(invalid_properties)) {
    invalid_property_names <- names(submissions_due)[invalid_properties] # nolint: object_usage_linter
    cli::cli_abort(
      c(
        "x" = "Propert{?y/ies} {.val {invalid_property_names}} in
            {.arg submissions_due} {?is/are} invalid.",
        "!" = "Valid {.arg submissions_due} properties:
            {.val {schema_valid_names}}"
      ),
      call = call
    )
  }

  is_relative_to_schema <- purrr::map_lgl(
    round_schema$submissions_due$oneOf,
    ~ "relative_to" %in% names(.x$properties)
  )

  if ("relative_to" %in% names(submissions_due)) {
    oneof_schema <- purrr::pluck(
      round_schema,
      "submissions_due",
      "oneOf",
      which(is_relative_to_schema),
      "properties"
    )
    check_relative_to_variable(
      submissions_due,
      model_tasks$model_tasks,
      call = call
    )
  } else {
    oneof_schema <- purrr::pluck(
      round_schema,
      "submissions_due",
      "oneOf",
      which(!is_relative_to_schema),
      "properties"
    )
  }

  purrr::walk(
    names(oneof_schema),
    ~ check_input(
      input = submissions_due[[.x]],
      property = .x,
      oneof_schema,
      parent_property = NULL,
      scalar = TRUE,
      call = call
    )
  )
}

check_relative_to_variable <- function(
  submissions_due,
  model_tasks,
  call = rlang::caller_env()
) {
  relative_to_value <- submissions_due$relative_to
  invalid_relative_to <- purrr::map_lgl(
    model_tasks,
    function(.x) {
      !relative_to_value %in% names(.x$task_ids)
    }
  )

  if (any(invalid_relative_to)) {
    cli::cli_abort(
      c(
        "!" = "{.arg submissions_due} {.arg relative_to} value must
                correspond to a valid {.arg task_id} variable in every
                {.arg model_tasks} {.arg model_task} object.",
        "x" = "{.arg relative_to} value {.val {relative_to_value}}
                does not correspond to a valid {.arg task_id} variable in
                provided {cli::qty(sum(invalid_relative_to))}
              {.arg model_tasks} {.arg model_task} object{?s}
              {.val {which(invalid_relative_to)}}."
      ),
      call = call
    )
  }
}

get_schema_round <- function(schema) {
  purrr::pluck(
    schema,
    "properties",
    "rounds",
    "items",
    "properties"
  )
}
# Check round_id pattern in `round_id` var values when
# round_id_from_variable = TRUE
check_round_id_pattern_vals <- function(
  model_tasks,
  round_id,
  call = rlang::caller_env()
) {
  invalid_round_id_vals <- purrr::map(
    model_tasks$model_tasks,
    ~ {
      round_id_var_vals <- purrr::pluck(
        .x,
        "task_ids",
        round_id
      )
      invalid_round_id_var_patterns(round_id_var_vals) |>
        purrr::compact()
    }
  )
  invalid_round_id_vals <- purrr::set_names(
    invalid_round_id_vals,
    seq_along(invalid_round_id_vals)
  )

  if (length(unlist(invalid_round_id_vals)) > 0L) {
    invalid_vals_bullets <-
      purrr::compact(invalid_round_id_vals) |>
      # iterate over any model tasks containing invalid values
      purrr::imap(
        ~ {
          mt_idx <- .y
          # iterate over invalid values in "required" and "optional" properties if present
          purrr::imap_chr(
            .x,
            ~ {
              # Create a separate message for invalid values in each model task and property
              cli::format_inline(
                "In {.arg model_tasks[[{mt_idx}]]${round_id}${.y}}: {.val {.x}}"
              )
            }
          )
        }
      ) |>
      unlist() |>
      purrr::set_names("x")

    cli::cli_abort(
      c(
        "!" = "Values in {.var round_id} var {.val {round_id}} must contain either
        ISO formatted dates or alphanumeric characters separated by underscores ('_').",
        invalid_vals_bullets
      ),
      call = call
    )
  }
}
# Check round_id pattern when round_id_from_variable = FALSE
check_round_id_pattern <- function(round_id, call = rlang::caller_env()) {
  if (!validate_round_id_pattern(round_id)) {
    cli::cli_abort(
      c(
        "!" = "{.var round_id} must contain either ISO formatted date or
      alphanumeric characters separated by underscores ('_').",
        "x" = "{.val {round_id}} does not match expected pattern"
      ),
      call = call
    )
  }
}
