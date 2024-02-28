#' Validate a hub config file against a Infectious Disease Modeling Hubs schema
#'
#' @param hub_path Path to a local hub directory.
#' @param config Name of config file to validate. One of `"tasks"` or `"admin"`.
#' @param config_path Defaults to `NULL` which assumes all config files are in
#'   the `hub-config` directory in the root of hub directory. Argument
#'   `config_path` can be used to override default by providing a path to the
#'    config file to be validated.
#' @param schema_version Character string specifying the json schema version to
#'   be used for validation. The default value `"from_config"` will use the
#'   version specified in the `schema_version` property of the config file.
#'   `"latest"` will use the latest version available in the Infectious Disease
#'   Modeling Hubs
#'   [schemas repository](https://github.com/Infectious-Disease-Modeling-Hubs/schemas).
#'   Alternatively, a specific version of a schema (e.g. `"v0.0.1"`)  can be
#'  specified.
#' @param branch The branch of the Infectious Disease Modeling Hubs
#'   [schemas repository](https://github.com/Infectious-Disease-Modeling-Hubs/schemas)
#'   from which to fetch schema. Defaults to `"main"`.
#' @return Returns the result of validation. If validation is successful, will
#'   return `TRUE`. If any validation errors are detected, returns `FALSE` with
#'   details of errors appended as a data.frame to an `errors` attribute.
#'   To access
#'   the errors table use `attr(x, "errors")` where `x` is the output of the function.
#'
#'   You can print a more concise and easier to view version of an errors table with
#'   [view_config_val_errors()].
#' @export
#' @seealso [view_config_val_errors()]
#' @family functions supporting config file validation
#'
#' @examples
#' # Valid config file
#' validate_config(
#'   hub_path = system.file(
#'     "testhubs/simple/",
#'     package = "hubUtils"
#'   ),
#'   config = "tasks"
#' )
#' # Config file with errors
#' config_path <- system.file("error-schema/tasks-errors.json",
#'   package = "hubUtils"
#' )
#' validate_config(config_path = config_path, config = "tasks")
validate_config <- function(hub_path = ".",
                            config = c("tasks", "admin"),
                            config_path = NULL, schema_version = "from_config",
                            branch = "main") {
  if (!(requireNamespace("jsonvalidate"))) {
    cli::cli_abort(
      "Package {.pkg jsonvalidate} must be installed to use {.fn validate_config}. Please install it to continue.
        Alternatively, to be able to use all packages required for hub maintainer functionality,
        re-install {.pkg hubUtils} using argument {.code dependencies = TRUE}"
    )
  }

  config <- rlang::arg_match(config)

  if (is.null(config_path)) {
    checkmate::assert_directory_exists(hub_path)
    config_path <- fs::path(hub_path, "hub-config", config, ext = "json")
  }

  # check config file to be checked exists and is correct extension
  checkmate::assert_file_exists(config_path, extension = "json")

  if (schema_version == "from_config") {
    schema_version <- get_config_file_schema_version(config_path, config)
  }

  # Get the latest version available in our GitHub schema repo
  if (schema_version == "latest") {
    schema_version <- hubUtils::get_schema_valid_versions(branch = branch) %>%
      sort() %>%
      utils::tail(1)
  }

  # TODO: Remove notification when back-compatibility retired
  hubUtils::check_deprecated_schema(
    config_version = get_config_file_schema_version(config_path, config),
    valid_version = "v2.0.0",
    hubutils_version = "0.0.0.9010"
  )

  schema_url <- hubUtils::get_schema_url(
    config = config,
    version = schema_version,
    branch = branch
  )

  schema_json <- hubUtils::get_schema(schema_url)


  validation <- jsonvalidate::json_validate(
    json = config_path,
    schema = schema_json,
    engine = "ajv",
    verbose = TRUE
  )

  attr(validation, "config_path") <- config_path
  attr(validation, "schema_version") <- schema_version
  attr(validation, "schema_url") <- schema_url


  if (validation) {
    validation <- validate_schema_version_property(validation, config)
    if (config == "tasks") {
      validation <- perform_dynamic_config_validations(validation)
    }
  }

  if (validation) {
    cli::cli_alert_success(
      "Successfully validated config file {.file {config_path}} against schema {.url {schema_url}}"
    )
  } else {
    cli::cli_warn(
      "Schema errors detected in config file {.file {config_path}} validated against schema {.url {schema_url}}"
    )
  }
  return(validation)
}



#' Perform dynamic validation of target keys and schema_ids for internal consistency against
#'  task ids. Check only performed once basic jsonvalidate checks pass against
#'  schema.
#'
#' @param validation validation object returned by jsonvalidate::json_validate().
#'
#' @return If validation successful, returns original validation object. If
#'  validation fails, value of validation object is set to FALSE and the error
#'  table is appended to attribute "errors".
#' @noRd
perform_dynamic_config_validations <- function(validation) {
  config_json <- jsonlite::read_json(attr(validation, "config_path"),
    simplifyVector = TRUE,
    simplifyDataFrame = FALSE
  )
  schema <- hubUtils::get_schema(attr(validation, "schema_url"))


  errors_tbl <- c(
    # Map over Round level validations
    purrr::imap(
      config_json[["rounds"]],
      ~ val_round(
        round = .x, round_i = .y,
        schema = schema
      )
    ),
    # Perform config level validation
    list(validate_round_ids_unique(config_json, schema))
  ) %>%
    purrr::list_rbind()


  if (nrow(errors_tbl) > 1) {
    # assign FALSE without loosing attributes
    validation[] <- FALSE
    attr(validation, "errors") <- rbind(
      attr(validation, "errors"),
      errors_tbl
    )
  }

  return(validation)
}

## Dynamic schema validation utilities ----
val_round <- function(round, round_i, schema) {
  model_task_grps <- round[["model_tasks"]]

  c(
    purrr::imap(
      model_task_grps,
      ~ val_model_task_grp_target_metadata(
        model_task_grp = .x, model_task_i = .y,
        round_i = round_i, schema = schema
      )
    ),
    purrr::imap(
      model_task_grps,
      ~ val_task_id_names(
        model_task_grp = .x, model_task_i = .y,
        round_i = round_i, schema = schema
      )
    ),
    purrr::imap(
      model_task_grps,
      ~ validate_mt_property_unique_vals(
        model_task_grp = .x, model_task_i = .y,
        round_i = round_i, property = "task_ids",
        schema = schema
      )
    ),
    purrr::imap(
      model_task_grps,
      ~ validate_mt_property_unique_vals(
        model_task_grp = .x, model_task_i = .y,
        round_i = round_i, property = "output_type",
        schema = schema
      )
    ),
    list(
      validate_round_ids_consistent(
        round = round,
        round_i = round_i,
        schema = schema
      )
    )
  ) %>%
    purrr::list_rbind()
}

