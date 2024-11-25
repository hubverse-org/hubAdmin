#' Append one or more rounds to a config class object.
#'
#' Append one or more `<round>`s sequentially to the end of the `rounds` property of
#' a `<config>` class object.
#' @param config an object of class `<config>`.
#' @param ... one or more objects of class `<round>`.
#'
#' @return an object of class `<config>` with the rounds appended sequentially to
#' the end of the `rounds` property.
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
#' # Add a new round with an age_group task_id
#' new_round <- create_round(
#'   round_id_from_variable = TRUE,
#'   round_id = "origin_date",
#'   model_tasks = create_model_tasks(
#'     create_model_task(
#'       task_ids = create_task_ids(
#'         create_task_id("origin_date",
#'           required = NULL,
#'           optional = c(
#'             "2023-01-23"
#'           )
#'         ),
#'         create_task_id("location",
#'           required = "US",
#'           optional = c("01", "02", "04", "05", "06")
#'         ),
#'         create_task_id("horizon",
#'           required = 1L,
#'           optional = 2:4
#'         ),
#'         create_task_id("age_group",
#'           required = NULL,
#'           optional = c("1", "2", "3", "4", "5")
#'         )
#'       ),
#'       output_type = create_output_type(
#'         create_output_type_mean(
#'           is_required = TRUE,
#'           value_type = "double",
#'           value_minimum = 0L
#'         )
#'       ),
#'       target_metadata = create_target_metadata(
#'         create_target_metadata_item(
#'           target_id = "inc hosp",
#'           target_name = "Weekly incident influenza hospitalizations",
#'           target_units = "rate per 100,000 population",
#'           target_keys = NULL,
#'           target_type = "discrete",
#'           is_step_ahead = TRUE,
#'           time_unit = "week"
#'         )
#'       )
#'     )
#'   ),
#'   submissions_due = list(
#'     relative_to = "origin_date",
#'     start = -4L,
#'     end = 2L
#'   )
#' )
#' append_round(config, new_round)
#' # Append in existing config file
#' config <- hubUtils::read_config_file(
#'   system.file("v4-tasks.json", package = "hubAdmin")
#' )
#' append_round(config, new_round)
append_round <- function(config, ...) {
  checkmate::assert_class(config, "config")

  rounds <- create_rounds(...)

  config_schema_version <- attr(config, "schema_id")
  round_schema_version <- attr(rounds, "schema_id")

  if (config_schema_version != round_schema_version) {
    cli::cli_abort(
      c(
        "x" = "Schema version mismatch between {.arg config} and
        {cli::qty(length(rounds$rounds))} round{?s}.",
        "!" = "Must be the same.",
        "*" = "{.arg config}: {.val {config_schema_version}}",
        "*" = "{cli::qty(length(rounds$rounds))} round{?s}:
        {.val {round_schema_version}}"
      )
    )
  }

  config_round_ids <- hubUtils::get_round_ids(config)
  round_round_ids <- hubUtils::get_round_ids(rounds)

  if (any(config_round_ids %in% round_round_ids)) {
    dups <- config_round_ids[config_round_ids %in% round_round_ids] |> # nolint: object_usage_linter
      unique()
    cli::cli_abort(
      c(
        "x" = "{.arg round_id}{?s} {.val {dups}} already exist{?s/} in {.arg config}.",
        "!" = "Please ensure new rounds contain unique
        {.arg round_id}{cli::qty(length(dups))}s."
      )
    )
  }

  config[["rounds"]] <- c(config[["rounds"]], rounds[["rounds"]])

  return(config)
}
