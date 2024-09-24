#' Write config class object to a JSON file.
#'
#' Write a **tasks** `<config>` class object to a `tasks.json` JSON file.
#'
#' @param config Object of class `<config>` to write to a JSON file.
#' @param hub_path Path to the hub directory. Defaults to the current working directory.
#'  Ignored if `config_path` is specified.
#' @param config_path Path to write the config object to. If `NULL` defaults to
#' `hub-config/tasks.json` within `hub_path`. If specified, overrides `hub_path`.
#' @param autobox Logical. Whether to automatically box vectors of length `1L` that
#' should be arrays in the JSON output according to the hubverse schema.
#' See [schema_autobox()] for more details.
#' @param overwrite Logical. Whether to overwrite the file if it already exists.
#' @param silent Logical. Whether to suppress informational messages.
#' @inheritParams schema_autobox
#'
#' @return TRUE invisibly.
#' @export
#'
#' @examplesIf curl::has_internet()
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
#' # Create config object
#' config <- create_config(rounds)
#' # Create temporary hub
#' temp_hub <- tempdir()
#' dir.create(file.path(temp_hub, "hub-config"))
#' # Write config
#' write_config(config, hub_path = temp_hub)
#' cat(readLines(file.path(temp_hub, "hub-config/tasks.json")), sep = "\n")
#' # Validate config
#' validate_config(hub_path = temp_hub)
#'
#' # Add a custom additional property (allowed by in schema version >= v3.0.0) that
#' # should be an array to the first round of the config.
#' rounds[[1]][[1]]$extra_array_property <- "length_1L_property"
#' config <- create_config(rounds)
#' write_config(
#'   config = config, hub_path = temp_hub, overwrite = TRUE,
#'   box_extra_paths = list(c("rounds", "items", "extra_array_property"))
#' )
#' cat(readLines(file.path(temp_hub, "hub-config/tasks.json")), sep = "\n")
#' unlink(temp_hub)
write_config <- function(config, hub_path = ".", config_path = NULL,
                         autobox = TRUE, box_extra_paths = NULL,
                         overwrite = FALSE, silent = FALSE) {
  if (!inherits(config, "config")) {
    cli::cli_abort(
      c("x" = "{.arg config} must be an object of class {.cls config}
             not {.cls {class(config)}}.")
    )
  }

  if (is.null(config_path)) {
    checkmate::assert_scalar(hub_path)
    config_path <- fs::path(hub_path, "hub-config", "tasks", ext = "json")
  } else {
    checkmate::assert_scalar(config_path)
  }
  parent_dir <- fs::path_dir(config_path)
  if (!fs::dir_exists(parent_dir)) {
    cli::cli_abort(
      c("x" = "{.arg config_path} parent directory {.field {parent_dir}} does not exist.
              Can't write to a file in a non-existent directory.")
    )
  }

  if (fs::file_exists(config_path) && isFALSE(overwrite)) {
    cli::cli_abort(
      c("x" = "File {.arg {config_path}} already exists. Set {.arg overwrite = TRUE}
              to overwrite the file.")
    )
  }

  if (autobox) {
    config <- schema_autobox(config, box_extra_paths = box_extra_paths)
  }

  jsonlite::write_json(
    x = config,
    path = config_path,
    auto_unbox = TRUE,
    na = "string", null = "null",
    pretty = TRUE
  )

  if (isFALSE(silent)) {
    cli::cli_alert_success("{.arg config} written out successfully.")
    if (isFALSE(autobox)) {
      cli::cli_bullets(
        c(
          "!" = "Autoboxing was disabled. Some properties in the output file may
          not conform to schema expectations.",
          "i" = "Due to inconsistencies between R and JSON data types,
          some properties in the output file might be an {.cls array} when a
          {.cls scalar} is required or vice versa.",
          "*" = "Please validate the file with {.code validate_config()}
        to identify any deviations."
        )
      )
    }
  }
  invisible(stats::setNames(TRUE, config_path))
}
