# Validate that no task id names match reserved hub variable names
val_task_id_names <- function(model_task_grp, model_task_i, round_i, schema) {
  reserved_hub_vars <- c(
    "model_id", "output_type",
    "output_type_id", "value"
  )
  task_id_names <- names(model_task_grp$task_ids)
  check_task_id_names <- task_id_names %in% reserved_hub_vars

  if (any(check_task_id_names)) {
    invalid_task_id_values <- task_id_names[check_task_id_names]

    error_row <- data.frame(
      instancePath = paste0(
        glue::glue(
          get_error_path(schema, "task_ids", "instance")
        ), "/",
        names(invalid_task_id_values)
      ),
      schemaPath = get_error_path(schema, "task_ids", "schema"),
      keyword = "task_id names",
      message = glue::glue(
        "task_id name(s) '{invalid_task_id_values}'",
        " must not match reserved hub variable names."
      ),
      schema = "",
      data = glue::glue(
        'task_id names: {glue::glue_collapse(task_id_names, ", ", last = " & ")};
        reserved hub variable names:',
        ' {glue::glue_collapse(reserved_hub_vars, ", ", last = " & ")}'
      )
    )
    return(error_row)
  }

  return(NULL)
}

val_model_task_grp_target_metadata <- function(model_task_grp, model_task_i,
                                               round_i, schema) {
  grp_target_keys <- get_grp_target_keys(model_task_grp)

  # If all target keys are NULL, exit checks
  if (all(purrr::map_lgl(grp_target_keys, ~ is.null(.x)))) {
    return(NULL)
  }

  # Check that target key names across items in target metadata array are consistent.
  # If not returns error early as further checks may fail unexpectedly.
  errors_check_1 <- val_target_key_names_const(
    grp_target_keys, model_task_grp,
    model_task_i, round_i, schema
  )

  if (!is.null(errors_check_1)) {
    return(errors_check_1)
  }

  # Check whether target key names do not correspond to task_id properties
  invalid_target_key_names <- purrr::map(
    grp_target_keys,
    ~ find_invalid_target_keys(.x, model_task_grp)
  ) %>%
    unlist(use.names = FALSE)

  # If any do not correspond, run validation function to generate errors rows.
  # Otherwise assign NULL to errors_check_2
  if (any(invalid_target_key_names)) {
    errors_check_2 <- purrr::imap(
      grp_target_keys,
      ~ val_target_key_names(.x,
        target_key_i = .y,
        model_task_grp = model_task_grp,
        model_task_i = model_task_i,
        round_i = round_i,
        schema = schema
      )
    ) %>%
      purrr::list_rbind()
  } else {
    errors_check_2 <- NULL
  }
  # If none of the target key names match task id properties, return errors_check_2
  # early as further checks become redundant.
  if (all(invalid_target_key_names)) {
    return(errors_check_2)
  }

  # Check that the values of each target keys have matching values in the corresponding
  # task_id required & optional property arrays.
  errors_check_3 <- purrr::imap(
    grp_target_keys,
    ~ val_target_key_values(.x, model_task_grp,
      target_key_i = .y,
      model_task_i = model_task_i,
      round_i = round_i,
      schema = schema
    )
  ) %>%
    purrr::list_rbind()

  # Check that the unique values in the required & optional property arrays
  #  of each task_id identified as a target key have a matching
  #  value in the corresponding target key of at least one target metadata item.
  errors_check_4 <- val_target_key_task_id_values(grp_target_keys, model_task_grp,
    model_task_i = model_task_i,
    round_i = round_i,
    schema = schema
  )
  # Combine all error checks
  rbind(
    errors_check_2,
    errors_check_3,
    errors_check_4
  )
}

val_target_key_names_const <- function(grp_target_keys, model_task_grp,
                                       model_task_i, round_i, schema) {
  target_key_names <- purrr::map(grp_target_keys, ~ names(.x)) %>%
    purrr::map_if(~ !is.null(.x), ~.x, .else = ~"null")

  if (length(unique(target_key_names)) > 1) {
    error_row <- data.frame(
      instancePath = glue::glue(get_error_path(schema, "target_keys", "instance")),
      schemaPath = get_error_path(schema, "target_keys", "schema"),
      keyword = "target_keys names",
      message = glue::glue("target_key names not consistent across target_metadata array items"),
      schema = "",
      data = glue::glue("target_key_{seq_along(target_key_names)}: {purrr::map_chr(target_key_names,
        ~paste(.x, collapse = ','))}") %>%
        glue::glue_collapse(sep = ";  ")
    )
    return(error_row)
  }
  return(NULL)
}

val_target_key_names <- function(target_keys, model_task_grp,
                                 target_key_i, model_task_i,
                                 round_i, schema) {
  check <- find_invalid_target_keys(target_keys, model_task_grp)

  if (any(check)) {
    error_row <- data.frame(
      instancePath = paste0(
        glue::glue(get_error_path(schema, "target_keys", "instance")),
        "/", names(check[check])
      ),
      schemaPath = get_error_path(schema, "target_keys", "schema"),
      keyword = "target_keys names",
      message = glue::glue("target_key(s) '{names(check[check])}' not properties of modeling task group task IDs"),
      schema = "",
      data = glue::glue("task_id names: {glue::glue_collapse(get_grp_task_ids(model_task_grp), sep = ', ')};
            target_key names: {glue::glue_collapse(names(target_keys), sep = ', ')}")
    )

    return(error_row)
  } else {
    return(NULL)
  }
}

val_target_key_values <- function(target_keys, model_task_grp,
                                  target_key_i, model_task_i,
                                  round_i, schema) {
  check <- !find_invalid_target_keys(target_keys, model_task_grp)

  valid_target_keys <- target_keys[check]

  task_id_values <- purrr::map(
    names(valid_target_keys),
    ~ model_task_grp[["task_ids"]][[.x]] %>%
      unlist(recursive = TRUE, use.names = FALSE)
  ) %>%
    purrr::set_names(names(valid_target_keys))


  is_invalid_target_key <- purrr::map2_lgl(
    valid_target_keys, task_id_values,
    ~ !.x %in% .y
  )


  if (any(is_invalid_target_key)) {
    error_row <- data.frame(
      instancePath = paste0(
        glue::glue(get_error_path(schema, "target_keys", "instance")),
        "/", names(is_invalid_target_key)
      ),
      schemaPath = get_error_path(schema, "target_keys", "schema"),
      keyword = "target_keys values",
      message = glue::glue(
        "target_key value '{valid_target_keys[names(is_invalid_target_key[is_invalid_target_key])]}' does not match any values in corresponding modeling task group task_id"
      ),
      schema = "",
      data = glue::glue(
        "task_id.{names(is_invalid_target_key)} values: {purrr::map_chr(task_id_values, ~glue::glue_collapse(.x, sep = ', '))};
            target_key.{names(valid_target_keys)} value: {unlist(valid_target_keys)}"
      )
    )

    return(error_row)
  } else {
    return(NULL)
  }
}

val_target_key_task_id_values <- function(grp_target_keys,
                                          model_task_grp,
                                          model_task_i,
                                          round_i, schema) {
  # Get unique values of target key names
  target_key_names <- purrr::map(grp_target_keys, ~ names(.x)) %>%
    unique() %>%
    unlist()

  # Identify target_key_names that are valid task id properties
  val_target_key_names <- target_key_names[
    target_key_names %in% names(model_task_grp[["task_ids"]])
  ]


  # Get list of unique task id values across both required & optional arrays
  # for each valid target key.
  task_id_values <- model_task_grp[["task_ids"]][val_target_key_names] %>%
    purrr::map(~ unlist(.x, use.names = FALSE)) %>%
    unique() %>%
    purrr::set_names(val_target_key_names)

  # Get list of target key values for each valid target key.
  target_key_values <- purrr::map(
    purrr::set_names(val_target_key_names),
    ~ get_all_grp_target_key_values(.x, grp_target_keys) %>%
      unique()
  )

  # Identify task id values that do not have a match in any of the corresponding
  # target key definitions.
  invalid_task_id_values <- purrr::map2(
    .x = task_id_values,
    .y = target_key_values,
    ~ !.x %in% .y
  ) %>%
    purrr::map2(
      task_id_values,
      ~ .y[.x]
    ) %>%
    purrr::compact() %>%
    purrr::map_chr(~ paste(.x, collapse = ", "))


  if (length(invalid_task_id_values) != 0) {
    nms <- names(invalid_task_id_values)
    tk_unique_vals <- purrr::map_chr( # nolint: object_usage_linter
      target_key_values[nms],
      ~ paste(.x, collapse = ", ")
    )
    tid_unique_vals <- purrr::map_chr( # nolint: object_usage_linter
      task_id_values[nms],
      ~ glue::glue_collapse(.x, sep = ", ")
    )

    error_row <- data.frame(
      instancePath = paste0(glue::glue(get_error_path(schema, "task_ids", "instance")), "/", nms),
      schemaPath = get_error_path(schema, "task_ids", "schema"),
      keyword = "task_id values",
      message = glue::glue("task_id value(s) '{invalid_task_id_values}' not defined in any corresponding target_key."),
      schema = "",
      data = glue::glue("task_id.{nms} unique values: {tid_unique_vals};
            target_key.{nms} unique values: {tk_unique_vals}")
    )
    return(error_row)
  }

  return(NULL)
}


get_all_grp_target_key_values <- function(target, grp_target_keys) {
  purrr::map_chr(
    grp_target_keys,
    ~ .x[[target]]
  )
}


get_grp_target_keys <- function(model_task_grp) {
  purrr::map(
    model_task_grp[["target_metadata"]],
    ~ .x[["target_keys"]]
  )
}

get_grp_task_ids <- function(model_task_grp) {
  names(model_task_grp[["task_ids"]])
}

find_invalid_target_keys <- function(target_keys, model_task_grp) {
  !names(target_keys) %in% get_grp_task_ids(model_task_grp) %>%
    stats::setNames(names(target_keys))
}

# Validate the range (minimum & maximum) of acceptable sample numbers for a
# given modeling task group in a given round.
# Returns NULL if not applicable or check passes and error df row if check fails.
validate_mt_sample_range <- function(model_task_grp,
                                     model_task_i,
                                     round_i,
                                     schema) {
  sample_config <- purrr::pluck(
    model_task_grp,
    "output_type",
    "sample",
    "output_type_id_params"
  )

  if (is.null(sample_config)) {
    return(NULL)
  }

  check <- sample_config$max_samples_per_task < sample_config$min_samples_per_task

  if (check) {
    error_row <- data.frame(
      instancePath = glue::glue(
        get_error_path(
          schema,
          "output_type/sample/output_type_id_params",
          "instance"
        )
      ),
      schemaPath = paste(
        get_error_path(
          schema,
          "sample",
          "schema"
        ), "output_type_id_params",
        sep = "/"
      ),
      keyword = "Sample number range",
      message = glue::glue(
        "min_samples_per_task must be less or equal to max_samples_per_task."
      ),
      schema = "",
      data = glue::glue("min_samples_per_task: {sample_config$min_samples_per_task};
            max_samples_per_task: {sample_config$max_samples_per_task}")
    )
    return(error_row)
  }
  return(NULL)
}

# Validate that compound_taskid_set values are valid task ids for a
# given modeling task group in a given round.
# Returns NULL if not applicable or check passes and error df row if check fails.
validate_mt_sample_compound_taskids <- function(model_task_grp,
                                                model_task_i,
                                                round_i,
                                                schema) {
  sample_config <- purrr::pluck(
    model_task_grp,
    "output_type",
    "sample",
    "output_type_id_params"
  )

  comp_tids <- sample_config[["compound_taskid_set"]]

  if (is.null(comp_tids)) {
    return(NULL)
  }
  invalid_comp_tids <- setdiff(comp_tids, get_grp_task_ids(model_task_grp))

  check <- length(invalid_comp_tids) > 0L

  if (check) {
    error_row <- data.frame(
      instancePath = glue::glue(
        get_error_path(
          schema,
          "output_type/sample/output_type_id_params/compound_taskid_set",
          "instance"
        )
      ),
      schemaPath = paste(
        get_error_path(
          schema,
          "sample",
          "schema"
        ), "output_type_id_params", "compound_taskid_set",
        sep = "/"
      ),
      keyword = "compound_taskid_set values",
      message = glue::glue(
        "compound_taskid_set value(s) '{invalid_comp_tids}' not valid task id(s)."
      ),
      schema = "",
      data = glue::glue(
        "compound_taskid_set values: {glue::glue_collapse(comp_tids, sep = ', ')};
        task id values: {
          glue::glue_collapse(get_grp_task_ids(model_task_grp), sep = ', ')
        }"
      )
    )
    return(error_row)
  }
  return(NULL)
}

validate_mt_property_unique_vals <- function(model_task_grp,
                                             model_task_i,
                                             round_i,
                                             property = c(
                                               "task_ids",
                                               "output_type"
                                             ),
                                             schema) {
  property <- rlang::arg_match(property)
  property_text <- c(
    task_ids = "Task ID",
    output_type = "Output type IDs of output type"
  )[property]


  val_properties <- switch(property,
    task_ids = model_task_grp[["task_ids"]],
    output_type = model_task_grp[["output_type"]][
      c("quantile", "cdf", "pmf")
    ] %>%
      purrr::compact() %>%
      purrr::map(
        ~ if ("type_id" %in% names(.x)) {
          .x[["type_id"]]
        } else {
          .x[["output_type_id"]]
        }
      )
  )

  dup_properties <- purrr::map(
    val_properties,
    ~ {
      x <- unlist(.x, use.names = FALSE)
      dups <- x[duplicated(x)]
      if (length(dups) == 0L) {
        NULL
      } else {
        dups
      }
    }
  ) %>%
    purrr::compact()

  if (length(dup_properties) == 0L) {
    return(NULL)
  } else {
    purrr::imap(
      dup_properties,
      ~ data.frame(
        instancePath = glue::glue(get_error_path(schema, .y, "instance")),
        schemaPath = get_error_path(schema, .y, "schema"),
        keyword = glue::glue("{property} uniqueItems"),
        message = glue::glue("must NOT have duplicate items across 'required' and 'optional' properties. {property_text} '{.y}' contains duplicates."),
        schema = "",
        data = glue::glue("duplicate values: {paste(.x, collapse = ', ')}")
      )
    ) %>% purrr::list_rbind()
  }
}

## ROUND LEVEL VALIDATIONS ----
# Check that round id variables are consistent across modeling tasks
validate_round_ids_consistent <- function(round, round_i,
                                          schema) {
  n_mt <- length(round[["model_tasks"]])

  if (!round[["round_id_from_variable"]] || n_mt == 1L) {
    return(NULL)
  }

  round_id_var <- round[["round_id"]]

  mt <- purrr::map(
    round[["model_tasks"]],
    ~ purrr::pluck(.x, "task_ids", round_id_var)
  )

  checks <- purrr::map(
    .x = purrr::set_names(seq_along(mt)[-1]),
    ~ {
      check <- all.equal(mt[[1]], mt[[.x]])
      if (is.logical(check) && check) NULL else check
    }
  ) %>% purrr::compact()

  if (length(checks) == 0L) {
    return(NULL)
  }
  purrr::imap(
    checks,
    ~ tibble::tibble(
      instancePath = glue::glue_data(
        list(model_task_i = as.integer(.y)),
        get_error_path(schema, round_id_var, "instance")
      ),
      schemaPath = get_error_path(schema, round_id_var, "schema"),
      keyword = "round_id var",
      message = glue::glue(
        "round_id var '{round_id_var}' property MUST be",
        " consistent across modeling task items"
      ),
      schema = "",
      data = glue::glue("{.x} compared to first model task item")
    )
  ) %>%
    purrr::list_rbind() %>%
    as.data.frame()
}

## CONFIG LEVEL VALIDATIONS ----
# Validate that round IDs are unique across all rounds in config file
validate_round_ids_unique <- function(config_tasks, schema) {
  round_ids <- hubUtils::get_round_ids(config_tasks)

  if (!any(duplicated(round_ids))) {
    return(NULL)
  }

  dup_round_ids <- unique(round_ids[duplicated(round_ids)])

  purrr::map(
    purrr::set_names(dup_round_ids),
    ~ dup_round_id_error_df(
      .x,
      config_tasks = config_tasks,
      schema = schema
    )
  ) %>% purrr::list_rbind()
}

dup_round_id_error_df <- function(dup_round_id,
                                  config_tasks,
                                  schema) {
  dup_round_idx <- purrr::imap(
    hubUtils::get_round_ids(config_tasks, flatten = "model_task"),
    ~ {
      if (dup_round_id %in% .x) .y else NULL
    }
  ) %>%
    purrr::compact() %>%
    unlist() %>%
    `[`(-1L)

  dup_mt_idx <- purrr::map(
    dup_round_idx,
    ~ hubUtils::get_round_ids(config_tasks, flatten = "task_id")[[.x]] %>%
      purrr::imap_int(~ {
        if (dup_round_id %in% .x) .y else NULL
      }) %>%
      purrr::compact()
  )

  purrr::map2(
    .x = dup_round_idx,
    .y = dup_mt_idx,
    ~ tibble::tibble(
      instancePath = glue::glue_data(
        list(
          round_i = .x,
          model_task_i = .y
        ),
        get_error_path(schema, get_round_id_var(.x, config_tasks), "instance",
          append_item_n = TRUE
        )
      ),
      schemaPath = get_error_path(
        schema, get_round_id_var(.x, config_tasks),
        "schema"
      ),
      keyword = "round_id uniqueItems",
      message = glue::glue(
        "must NOT contains duplicate round ID values across rounds"
      ),
      schema = "",
      data = glue::glue("duplicate value: {dup_round_id}")
    )
  ) %>%
    purrr::list_rbind() %>%
    as.data.frame()
}

# Validate that task ids do not contain all null values across config file
validate_task_ids_not_all_null <- function(config_tasks, schema) {
  task_id_names <- hubUtils::get_task_id_names(config_tasks)

  check_task_id_vals <- purrr::map_lgl(
    purrr::set_names(task_id_names),
    ~ is_null_task_id(.x, config_tasks)
  )

  if (any(check_task_id_vals)) {
    invalid_task_ids <- names(check_task_id_vals[check_task_id_vals])

    error_row <- data.frame(
      instancePath = paste0(
        "/rounds/*/model_tasks/*/task_ids", "/",
        invalid_task_ids
      ),
      schemaPath = get_error_path(schema, "task_ids", "schema"),
      keyword = "task_id values",
      message = glue::glue(
        "task_id values cannot all be null across all modeling tasks."
      ),
      schema = "",
      data = "null"
    )
    return(error_row)
  }

  return(data.frame())
}



get_round_id_var <- function(idx, config_tasks) {
  if (config_tasks[["rounds"]][[idx]][["round_id_from_variable"]]) {
    config_tasks[["rounds"]][[idx]][["round_id"]]
  } else {
    "rounds"
  }
}

is_null_task_id <- function(task_id_name, config_tasks) {
  purrr::map(
    config_tasks[["rounds"]],
    ~ .x[["model_tasks"]]
  ) %>%
    purrr::map(~ .x %>%
      purrr::map(~ .x[["task_ids"]][[task_id_name]])) %>% # nolint: indentation_linter
    unlist(use.names = FALSE) %>%
    is.null()
}

#' @export
# nolint start
print.hubval <- function(x, ...) {
  cli::cli_div()
  config_dir <- unclass(attr(x, "config_dir"))
  schema_version <- attr(x, "schema_version") 
  schema_url <- attr(x, "schema_url") 
  cli::cli_text("{cli::symbol$i} {.href [schema version {schema_version}]({schema_url})}")
  lapply(names(x), function(i) {
    if (x[[i]]) {
      cli::cli_h3("${i}")
    } else {
      cli::cli_h3("{.strong ${i}}")
    }
    print(x[[i]])
  })
}
# nolint end


#' @export
print.conval <- function(x, ...) {
  # print the result
  print(as.vector(x))
  thing <- match.call()[["x"]]
  config_path <- unclass(attr(x, "config_path"))
  short_path <- trim_config_path(config_path) # nolint
  if (inherits(x, "error")) {
    cli::cli_bullets(
      c(
        "x" = "{.strong error} in parsing {.file {config_path}}",
        "i" = "({attr(x, 'message')})"
      )
    )
    return(invisible(x))
  }
  # nolint start
  schema_version <- attr(x, "schema_version") 
  schema_url <- attr(x, "schema_url") 
  if (!is.null(schema_url)) {
    via <- "via"
    name <- sub("([^.]+)\\.[[:alnum:]]+$", "\\1", basename(schema_url))
  } else {
    via <- "from"
    name <- "default json schema"
    schema_url <- paste0("file://", config_path)
  }

  if (isTRUE(x)) {
    cli::cli_alert_success(
      "ok:  {.href [{short_path}](file://{config_path})} ({via} {.href [{name} {schema_version}]({schema_url})})"
    )
  } else {
    errors <- attr(x, "errors")
    n <- nrow(errors)
    cli::cli_bullets(c(
      "!" = "{.strong {n} schema errors}:  {.href [{short_path}](file://{config_path})} ({via} {.href [{name} {schema_version}]({schema_url})})",
      # this doesn't work unless the user explicitly calls "print" :'(
      # https://hachyderm.io/@zkamvar/112933516988688350
      # "use {.run view_config_val_errors({thing})} to view the errors in a table."
      "i" = "use {.fn view_config_val_errors} to view the errors in a table."
    ))
  }
  # nolint end
}

trim_config_path <- function(path) {
  frag <- rev(fs::path_split(path)[[1]])[1:2]
  unclass(fs::path_join(rev(frag)))
}

assert_config_exists <- function(path) {
  validation <- checkmate::check_file_exists(path, extension = "json")
  if (!isTRUE(validation)) {
    validation <- make_config_error(path, validation)
  }
  return(validation)
}

make_config_error <- function(path, msg) {
  validation <- FALSE
  attr(validation, "message") <- msg
  attr(validation, "config_path") <- path
  attr(validation, "schema_version") <- NULL
  attr(validation, "schema_url") <- NULL
  class(validation) <- c("conval", "error")
  # so it doesn't print the actual value, just the message
  capture.output(print(validation))
  return(validation)
}
