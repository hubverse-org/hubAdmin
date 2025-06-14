#' Create a point estimate output type object of class `output_type_item`
#'
#' Create a representation of a `mean` or `median` output type as a list object of
#' class `output_type_item`. This can be combined with
#' additional `output_type_item` objects using function [`create_output_type()`] to
#' create an `output_type` object for a given model_task.
#' This can be combined with other building blocks which can then be written as
#' or appended to `tasks.json` Hub config files.
#' @param is_required Logical. Is the output type required?
#' @param value_type Character string. The data type of the output_type values.
#' @param value_minimum Numeric. The inclusive minimum of output_type values.
#' @param value_maximum Numeric. The inclusive maximum of output_type values.
#'
#' @details For more details consult
#' the [documentation on `tasks.json` Hub config files](
#' https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).
#' @return a named list of class `output_type_item` representing a `mean` or
#' `median` output type.
#' @inheritParams create_task_id
#' @export
#' @describeIn create_output_type_mean Create a list representation of a `mean`
#' output type.
#' @seealso [create_output_type()]
#' @examples
#' create_output_type_mean(
#'   is_required = TRUE,
#'   value_type = "double",
#'   value_minimum = 0L
#' )
#' create_output_type_median(
#'   is_required = FALSE,
#'   value_type = "integer"
#' )
#' # Pre v4.0.0 schema output
#' create_output_type_mean(
#'   is_required = TRUE,
#'   value_type = "double",
#'   value_minimum = 0L,
#'   schema_version = "v3.0.1"
#' )
#' # Set schema version for all subsequent calls
#' options(hubAdmin.schema_version = "v3.0.1")
#' create_output_type_mean(
#'   is_required = TRUE,
#'   value_type = "double",
#'   value_minimum = 0L,
#'   schema_version = "v3.0.1"
#' )
#' options(hubAdmin.schema_version = "latest")
create_output_type_mean <- function(is_required, value_type, value_minimum = NULL,
                                    value_maximum = NULL,
                                    schema_version = getOption(
                                      "hubAdmin.schema_version",
                                      default = "latest"
                                    ),
                                    branch = getOption(
                                      "hubAdmin.branch",
                                      default = "main"
                                    )) {
  create_output_type_point(
    output_type = "mean", is_required = is_required,
    value_type = value_type, value_minimum = value_minimum,
    value_maximum = value_maximum, schema_version = schema_version,
    branch = branch
  )
}

#' @export
#' @describeIn create_output_type_mean Create a list representation of a `median`
#' output type.
create_output_type_median <- function(is_required, value_type,
                                      value_minimum = NULL,
                                      value_maximum = NULL,
                                      schema_version = getOption(
                                        "hubAdmin.schema_version",
                                        default = "latest"
                                      ),
                                      branch = getOption(
                                        "hubAdmin.branch",
                                        default = "main"
                                      )) {
  create_output_type_point(
    output_type = "median", is_required = is_required,
    value_type = value_type, value_minimum = value_minimum,
    value_maximum = value_maximum, schema_version = schema_version,
    branch = branch
  )
}


create_output_type_point <- function(output_type = c("mean", "median"),
                                     is_required, value_type,
                                     value_minimum = NULL,
                                     value_maximum = NULL,
                                     schema_version = getOption(
                                       "hubAdmin.schema_version",
                                       default = "latest"
                                     ),
                                     branch = getOption(
                                       "hubAdmin.branch",
                                       default = "main"
                                     ),
                                     call = rlang::caller_env()) {
  rlang::check_required(value_type)
  rlang::check_required(is_required)

  if (!rlang::is_logical(is_required, n = 1L)) {
    cli::cli_abort(c(
      "x" = "Argument {.arg is_required} must be {.cls logical} and have length 1."
    ))
  }
  output_type <- rlang::arg_match(output_type)
  schema <- download_tasks_schema(schema_version, branch)
  pre_v4 <- hubUtils::version_lt("v4.0.0", schema_version = schema$`$id`)

  # create output_type_id
  if (pre_v4 && is_required) {
    output_type_id <- list(output_type_id = list(
      required = NA_character_,
      optional = NULL
    ))
  }
  if (pre_v4 && !is_required) {
    output_type_id <- list(output_type_id = list(
      required = NULL,
      optional = NA_character_
    ))
  }
  if (!pre_v4) {
    output_type_id <- list(
      output_type_id = list(
        required = NULL
      ),
      is_required = is_required
    )
  }

  if (hubUtils::version_lt("v2.0.0", schema_version = schema$`$id`)) {
    # Get output type id property according to config schema version
    config_tid <- hubUtils::get_config_tid(
      config_version = hubUtils::get_schema_version_latest(schema_version, branch)
    )
    names(output_type_id) <- config_tid
  }


  output_type_schema <- get_schema_output_type(schema,
    output_type = output_type
  )

  value_schema <- purrr::pluck(
    output_type_schema,
    "properties",
    "value",
    "properties"
  )

  value <- list(
    type = value_type,
    minimum = value_minimum,
    maximum = value_maximum
  ) %>%
    purrr::compact()

  check_properties_scalar(value, value_schema,
    call = call,
    parent_property = "value"
  )

  structure(
    list(c(output_type_id, list(value = value))),
    class = c("output_type_item", "list"),
    names = output_type,
    schema_id = schema$`$id`,
    branch = branch
  )
}


#' Create a distribution output type object of class `output_type_item`
#'
#' Create a representation of a `quantile`, `cdf`, `pmf` or `sample` output
#' type as a list object of class `output_type_item`. This can be combined with
#' additional `output_type_item`s using function [`create_output_type()`] to
#' create an `output_type` object for a given model_task.
#' This can be combined with other building blocks which can then be written as
#' or appended to `tasks.json` Hub config files.
#' @param required Atomic vector of required `output_type_id` values. Can be NULL if
#'  all values are optional.
#' @param optional `r lifecycle::badge('deprecated')` **(schema >= v4.0.0)**. Atomic vector of optional
#' `output_type_id` values. Can be NULL if all values are required.
#' @inheritParams create_task_id
#' @inheritParams create_output_type_mean
#' @details For more details consult
#' the [documentation on `tasks.json` Hub config files](
#' https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).
#'
#' @return a named list of class `output_type_item` representing a `quantile`,
#' `cdf`, `pmf` or `sample` output type.
#' @export
#' @describeIn create_output_type_quantile Create a list representation of a `quantile`
#' output type.
#' @seealso [create_output_type()]
#' @examples
#' create_output_type_quantile(
#'   required = c(0.25, 0.5, 0.75),
#'   is_required = TRUE,
#'   value_type = "double",
#'   value_minimum = 0
#' )
#' create_output_type_cdf(
#'   required = c(10, 20),
#'   is_required = FALSE,
#'   value_type = "double"
#' )
#' create_output_type_cdf(
#'   required = c("EW202240", "EW202241", "EW202242"),
#'   is_required = TRUE,
#'   value_type = "double"
#' )
#' create_output_type_pmf(
#'   required = c("low", "moderate", "high", "extreme"),
#'   is_required = FALSE,
#'   value_type = "double"
#' )
#' create_output_type_sample(
#'   is_required = TRUE,
#'   output_type_id_type = "integer",
#'   min_samples_per_task = 70L, max_samples_per_task = 100L,
#'   value_type = "double",
#'   value_minimum = 0,
#'   value_maximum = 1
#' )
#' # Pre v4.0.0 schema output
#' create_output_type_quantile(
#'   required = c(0.25, 0.5, 0.75),
#'   optional = c(
#'     0.1, 0.2, 0.3, 0.4, 0.6,
#'     0.7, 0.8, 0.9
#'   ),
#'   value_type = "double",
#'   value_minimum = 0,
#'   schema_version = "v3.0.1"
#' )
#' # Set schema version for all subsequent calls
#' options(hubAdmin.schema_version = "v3.0.1")
#' create_output_type_quantile(
#'   required = c(0.25, 0.5, 0.75),
#'   optional = c(
#'     0.1, 0.2, 0.3, 0.4, 0.6,
#'     0.7, 0.8, 0.9
#'   ),
#'   value_type = "double",
#'   value_minimum = 0
#' )
#' create_output_type_cdf(
#'   required = c(10, 20),
#'   optional = NULL,
#'   value_type = "double"
#' )
#' create_output_type_cdf(
#'   required = NULL,
#'   optional = c("EW202240", "EW202241", "EW202242"),
#'   value_type = "double"
#' )
#' create_output_type_pmf(
#'   required = NULL,
#'   optional = c("low", "moderate", "high", "extreme"),
#'   value_type = "double"
#' )
#' options(hubAdmin.schema_version = "latest")
create_output_type_quantile <- function(required, optional,
                                        is_required, value_type,
                                        value_minimum = NULL,
                                        value_maximum = NULL,
                                        schema_version = getOption(
                                          "hubAdmin.schema_version",
                                          default = "latest"
                                        ),
                                        branch = getOption(
                                          "hubAdmin.branch",
                                          default = "main"
                                        )) {
  create_output_type_dist(
    output_type = "quantile", required = required, optional = optional,
    is_required = is_required, value_type = value_type, value_minimum = value_minimum,
    value_maximum = value_maximum, schema_version = schema_version,
    branch = branch
  )
}

#' @describeIn create_output_type_quantile Create a list representation of a `cdf`
#' output type.
#' @export
create_output_type_cdf <- function(required, optional, is_required,
                                   value_type,
                                   schema_version = getOption(
                                     "hubAdmin.schema_version",
                                     default = "latest"
                                   ),
                                   branch = getOption(
                                     "hubAdmin.branch",
                                     default = "main"
                                   )) {
  create_output_type_dist(
    output_type = "cdf", required = required, optional = optional,
    is_required = is_required,
    value_type = value_type, value_minimum = 0L,
    value_maximum = 1L, schema_version = schema_version,
    branch = branch
  )
}

#' @describeIn create_output_type_quantile Create a list representation of a `pmf`
#' output type.
#' @export
create_output_type_pmf <- function(required, optional, is_required,
                                   value_type, schema_version = getOption(
                                     "hubAdmin.schema_version",
                                     default = "latest"
                                   ),
                                   branch = getOption(
                                     "hubAdmin.branch",
                                     default = "main"
                                   )) {
  create_output_type_dist(
    output_type = "pmf", required = required, optional = optional,
    is_required = is_required,
    value_type = value_type, value_minimum = 0L,
    value_maximum = 1L, schema_version = schema_version,
    branch = branch
  )
}

#' @param is_required Logical. Is this sample output type required?
#' @param output_type_id_type Character string. The data type of the output_type_id.
#' One of "integer" or "character".
#' @param max_length Integer. Optional. The maximum length of the output_type_id
#' value if type is `"character"`.
#' @param min_samples_per_task Integer. The minimum number of samples per task.
#' Must be equal to or less than `max_samples_per_task`.
#' @param max_samples_per_task Integer. The maximum number of samples per task.
#' Must be equal to or greater than `min_samples_per_task`.
#' @param compound_taskid_set Character vector. Optional. The set of compound
#' task IDs that the sample each output type can be associated with.
#'
#' @describeIn create_output_type_quantile Create a list representation of a `sample`
#' output type.
#' @export
create_output_type_sample <- function(is_required, output_type_id_type,
                                      max_length = NULL,
                                      min_samples_per_task,
                                      max_samples_per_task,
                                      compound_taskid_set = NULL,
                                      value_type,
                                      value_minimum = NULL,
                                      value_maximum = NULL,
                                      schema_version = getOption(
                                        "hubAdmin.schema_version",
                                        default = "latest"
                                      ),
                                      branch = getOption(
                                        "hubAdmin.branch",
                                        default = "main"
                                      )) {
  rlang::check_required(is_required)
  rlang::check_required(output_type_id_type)
  rlang::check_required(min_samples_per_task)
  rlang::check_required(max_samples_per_task)
  rlang::check_required(value_type)
  call <- rlang::current_call()

  schema <- download_tasks_schema(schema_version, branch)
  pre_v4 <- hubUtils::version_lt("v4.0.0", schema_version = schema$`$id`)

  if (hubUtils::extract_schema_version(schema$`$id`) < "v3.0.0") {
    cli::cli_abort(
      "This function is only supported for schema versions {.val v3.0.0} and above."
    )
  }
  output_type_schema <- get_schema_output_type(schema, "sample")
  output_type_id_params_schema <- purrr::pluck(
    output_type_schema,
    "properties",
    "output_type_id_params",
    "properties"
  )
  type <- output_type_id_type # nolint: object_usage_linter

  if (pre_v4) {
    output_type_id_params <- list(
      output_type_id_params = list(
        is_required = is_required,
        type = type,
        max_length = max_length,
        min_samples_per_task = min_samples_per_task,
        max_samples_per_task = max_samples_per_task,
        compound_taskid_set = compound_taskid_set
      ) %>%
        purrr::compact()
    )
  } else {
    # check is required as it won't be checked against output_type_id_params
    # further down and easy enough to check quickly here.
    checkmate::assert_logical(is_required, len = 1L)
    output_type_id_params <- list(
      output_type_id_params = list(
        type = type,
        max_length = max_length,
        min_samples_per_task = min_samples_per_task,
        max_samples_per_task = max_samples_per_task,
        compound_taskid_set = compound_taskid_set
      ) %>%
        purrr::compact(),
      # separate `is_required` out from `output_type_id_params` in versions v4
      # and later.
      is_required = is_required
    )
  }

  check_properties_scalar(
    output_type_id_params$output_type_id_params,
    output_type_id_params_schema,
    call = call,
    parent_property = "output_type_id_params"
  )
  check_properties_array(
    output_type_id_params$output_type_id_params,
    output_type_id_params_schema,
    call = call,
    parent_property = "output_type_id_params"
  )

  if (min_samples_per_task > max_samples_per_task) {
    cli::cli_abort(
      "{.var min_samples_per_task} must be less than or equal to
      {.var max_samples_per_task}."
    )
  }

  # Check and create value
  value <- list(
    type = value_type,
    minimum = value_minimum,
    maximum = value_maximum
  ) %>%
    purrr::compact()

  value_schema <- purrr::pluck(
    output_type_schema,
    "properties",
    "value",
    "properties"
  )

  check_properties_scalar(value, value_schema,
    call = call,
    parent_property = "value"
  )

  structure(
    list(c(output_type_id_params, list(value = value))),
    class = c("output_type_item", "list"),
    names = "sample",
    schema_id = schema$`$id`,
    branch = branch
  )
}


create_output_type_dist <- function(
    output_type = c("quantile", "cdf", "pmf", "sample"),
    required, optional, is_required,
    value_type, value_minimum = NULL,
    value_maximum = NULL, schema_version = getOption(
      "hubAdmin.schema_version",
      default = "latest"
    ),
    branch = getOption(
      "hubAdmin.branch",
      default = "main"
    ),
    call = rlang::caller_env()) {
  rlang::check_required(value_type)
  rlang::check_required(required)
  output_type <- rlang::arg_match(output_type)
  # Get output type id property according to config schema version
  config_tid <- hubUtils::get_config_tid(
    config_version = hubUtils::get_schema_version_latest(
      schema_version, branch
    )
  )

  schema <- download_tasks_schema(schema_version, branch)
  pre_v4 <- hubUtils::version_lt("v4.0.0", schema_version = schema$`$id`)

  if (pre_v4) {
    rlang::check_required(optional)
    output_type_id_props <- c("required", "optional")
  } else {
    # Signal the deprecation to the user
    if (lifecycle::is_present(optional)) {
      cli::cli_warn(
        "The {.arg optional} argument of {.fn create_output_type_{output_type}}
        is deprecated as of schema version {.val v4.0.0} and above. Ignored."
      )
    }
    rlang::check_required(is_required)
    checkmate::assert_logical(is_required, len = 1L)
    output_type_id_props <- "required"
  }

  output_type_schema <- get_schema_output_type(schema, output_type)
  output_type_id_schema <- purrr::pluck(
    output_type_schema,
    "properties",
    config_tid,
    "properties"
  )

  # Check and create output_type_id
  if (output_type == "cdf") {
    purrr::walk(
      output_type_id_props,
      function(x) {
        check_oneof_input(
          input = get(x),
          property = x,
          output_type_id_schema,
          call = call
        )
      }
    )
  } else {
    purrr::walk(
      output_type_id_props,
      function(x) {
        check_input(
          input = get(x),
          property = x,
          output_type_id_schema,
          parent_property = config_tid,
          call = call
        )
      }
    )
  }

  if (pre_v4) {
    check_prop_not_all_null(required, optional)
    check_prop_type_const(required, optional)
    check_prop_dups(required, optional)

    output_type_id <- list(
      output_type_id = list(
        required = required,
        optional = optional
      )
    )
  } else {
    output_type_id <- list(
      output_type_id = list(
        required = required
      ),
      is_required = is_required
    )
  }

  if (hubUtils::version_lt("v2.0.0", schema_version = schema$`$id`)) {
    names(output_type_id) <- config_tid
  }

  # Check and create value
  value <- list(
    type = value_type,
    minimum = value_minimum,
    maximum = value_maximum
  ) %>%
    purrr::compact()

  value_schema <- purrr::pluck(
    output_type_schema,
    "properties",
    "value",
    "properties"
  )

  check_properties_scalar(value, value_schema,
    call = call,
    parent_property = "value"
  )

  structure(
    list(c(output_type_id, list(value = value))),
    class = c("output_type_item", "list"),
    names = output_type,
    schema_id = schema$`$id`,
    branch = branch
  )
}
