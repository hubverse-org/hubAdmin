#' Create an object of class `target_metadata_item`
#'
#' Create a representation of a target_metadata item as a list object of
#' class `target_metadata_item`. This can be combined with
#' additional target_metadata items using function [`create_target_metadata()`] to
#' create a target_metadata object for a given model_task.
#' Such building blocks can ultimately be combined and then written out as or
#' appended to `tasks.json` Hub config files.
#' @param target_id character string. Short description that uniquely identifies
#' the target.
#' @param target_name character string. A longer human readable target description
#' that could be used, for example, as a visualisation axis label.
#' @param target_units character string. Unit of observation of the target.
#' @param target_keys named list or `NULL`. The `target_keys` value defines a
#' single target.
#' Should be a named list containing a single character string element.
#' The name of the element should match a `task_id` variable name within the same
#' `model_tasks` object and the value should match a single value of that variable
#' as described in
#' [target metadata section of the official hubverse documentation](https://docs.hubverse.io/en/latest/user-guide/tasks.html#target-metadata). # nolint: line_length_linter
#' Otherwise, `NULL` in the case where the target is not specified as a task_id
#' but is specified solely through the `target_id` argument.
#' @param description character string (optional). An optional verbose description
#' of the target that might include information such as definitions of a 'rate' or similar.
#' @param target_type character string. Target statistical data type. Consult the
#' [appropriate version of the hub schema](
#' https://docs.hubverse.io/en/latest/format/hub-metadata.html#model-tasks-tasks-json-interactive-schema)
#' for potential values.
#' @param is_step_ahead logical. Whether the target is part of a sequence of values
#' @param time_unit character string. If `is_step_ahead` is `TRUE`, then this
#' argument is required and defines the unit of time steps. if `is_step_ahead` is
#' `FALSE`, then this argument is not required and will be ignored if given.
#' @inheritParams create_task_id
#' @param ... additional optional properties to add in the target metadata list
#' output. Only available for schema version equal or greater than v5.1.0,
#' ignore for past version.
#' @seealso [create_target_metadata()]
#' @details For more details consult
#' the [documentation on `tasks.json` Hub config files](
#' https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).
#' @return a named list of class `target_metadata_item`.
#' @export
#'
#' @examples
#' create_target_metadata_item(
#'   target_id = "inc hosp",
#'   target_name = "Weekly incident influenza hospitalizations",
#'   target_units = "rate per 100,000 population",
#'   target_keys = list(target = "inc hosp"),
#'   target_type = "discrete",
#'   is_step_ahead = TRUE,
#'   time_unit = "week"
#' )
#' # For schema version >= v.5.1.0, example with an additional optional property
#' create_target_metadata_item(
#'   target_id = "inc hosp",
#'   target_name = "Weekly incident influenza hospitalizations",
#'   target_units = "rate per 100,000 population",
#'   target_keys = list(target = "inc hosp"),
#'   target_type = "discrete",
#'   is_step_ahead = TRUE,
#'   time_unit = "week",
#'   uri = "https://ontobee.org/"
#' )
#' options(hubAdmin.schema_version = "v3.0.1")
#' create_target_metadata_item(
#'   target_id = "inc hosp",
#'   target_name = "Weekly incident influenza hospitalizations",
#'   target_units = "rate per 100,000 population",
#'   target_keys = list(target = "inc hosp"),
#'   target_type = "discrete",
#'   is_step_ahead = TRUE,
#'   time_unit = "week"
#' )
#' options(hubAdmin.schema_version = "latest")
create_target_metadata_item <- function(target_id, target_name, target_units,
                                        target_keys = NULL, description = NULL,
                                        target_type, is_step_ahead, time_unit = NULL,
                                        schema_version = getOption(
                                          "hubAdmin.schema_version",
                                          default = "latest"
                                        ),
                                        branch = getOption(
                                          "hubAdmin.branch",
                                          default = "main"
                                        ), ...) {
  rlang::check_required(target_id)
  rlang::check_required(target_name)
  rlang::check_required(target_units)
  rlang::check_required(target_keys)
  rlang::check_required(target_type)
  rlang::check_required(is_step_ahead)
  call <- rlang::current_env()

  schema <- download_tasks_schema(schema_version, branch)
  target_metadata_schema <- get_schema_target_metadata(schema)

  if (is.null(description)) {
    property_names <- c(
      "target_id", "target_name", "target_units",
      "target_keys", "target_type", "is_step_ahead"
    )
  } else {
    property_names <- c(
      "target_id", "target_name", "target_units",
      "target_keys", "description", "target_type",
      "is_step_ahead"
    )
  }

  if (is_step_ahead) {
    if (is.null(time_unit)) {
      cli::cli_abort(c(
        "!" = "A value must be provided for {.arg time_unit} when {.arg is_step_ahead}
            is {.val {TRUE}}"
      ))
    }
    property_names <- c(property_names, "time_unit")
  }

  purrr::walk(
    property_names[property_names != "target_keys"],
    function(.x) {
      check_input(
        input = get(.x),
        property = .x,
        target_metadata_schema,
        parent_property = NULL,
        scalar = TRUE,
        call = call
      )
    }
  )

  check_target_keys(target_keys,
    schema_version = schema$`$id`,
    call = call
  )

  if (!check_target_id(target_id, target_keys)) {
    cli::cli_abort(
      c(
        "!" = "{.arg target_id} value {.val {target_id}} does not match
        corresponding {.arg target_keys} value
        {.val {names(target_keys)}.{unlist(target_keys,
        use.names = FALSE)}}."
      ),
      call = call
    )
  }

  obj <- mget(property_names)
  names <- property_names
  vers <- stringr::str_extract(
    schema$`$id`, "v[0-9]+\\.[0-9]+\\.[0-9]+(\\.9([0-9]+)?)?"
  )
  opt_property <- list(...)
  if (length(opt_properties) > 0L) {
    if (hubUtils::version_gte("v5.1.0", schema_version = vers)) {
      obj <- c(obj, opt_property)
      names <- c(names, names(opt_property))
    } else {
      cli::cli_inform(
        c(
          "!" = "Only schema version equal or greater than {.val v.5.1.0} accept
          additional properties, {.arg ...} ignored"
        )
      )
    }
  }

  structure(obj, class = c("target_metadata_item", "list"), names = names,
            schema_id = schema$`$id`, branch = branch)
}

check_target_keys <- function(target_keys, schema_version,
                              call = rlang::caller_env()) {
  if (is.null(target_keys)) {
    return()
  }

  if (!rlang::is_list(target_keys) || inherits(target_keys, "data.frame")) {
    cli::cli_abort(
      c(
        "!" = "{.arg target_keys} must be a {.cls list} not a
            {.cls {class(target_keys)}}"
      ),
      call = call
    )
  }
  if (!rlang::is_named(target_keys)) {
    cli::cli_abort(
      c(
        "!" = "{.arg target_keys} must be a named {.cls list}."
      ),
      call = call
    )
  }
  is_gte_v5_0_0 <- hubUtils::version_gte(
    "v5.0.0",
    schema_version = schema_version
  )
  target_key_n <- length(target_keys)
  if (is_gte_v5_0_0 && target_key_n > 1L) {
    cli::cli_abort(
      c(
        "!" = "{.arg target_keys} must be a named {.cls list} of
        length {.val {1L}} not {.val {target_key_n}}."
      ),
      call = call
    )
  }

  purrr::walk2(
    target_keys,
    names(target_keys),
    ~ check_target_key_value(
      .x, .y,
      call = call
    )
  )
}


check_target_key_value <- function(target_key, target_key_name,
                                   call = rlang::caller_env()) {
  if (!rlang::is_character(target_key, n = 1)) {
    cli::cli_abort(
      c(
        "!" = "{.arg target_keys} element {.field {target_key_name}} must be
            a {.cls character} vector of length {.val {1L}} not a
            {.cls {class(target_key)}} vector of length
            {.val {length(target_key)}}"
      ),
      call = call
    )
  }
}

get_schema_target_metadata <- function(schema) {
  purrr::pluck(
    schema,
    "properties", "rounds",
    "items", "properties", "model_tasks",
    "items", "properties", "target_metadata",
    "items", "properties"
  )
}

check_target_id <- function(target_id, target_keys) {
  target_key_values <- unlist(target_keys)
  # Check not possible if target_key is NULL as target_id value
  # represents the target value.
  if (is.null(target_key_values)) {
    return(TRUE)
  }
  # skip if target_key length is greater than 1L (i.e. in schema
  # < v5.0.0). Too messy to perform for older schema but will caught
  # as error for schema => v5.0.0 by other checks
  if (length(target_id) != length(target_key_values)) {
    return(TRUE)
  }
  target_id == target_key_values
}
