# Check that derived task ID vectors are valid task IDs and applicable to
# the schema version.
check_derived_task_ids <- function(derived_task_ids, rounds, model_tasks,
                                   call = rlang::caller_env()) {
  rlang::check_exclusive(rounds, model_tasks)
  if (rlang::is_missing(rounds)) {
    schema_id <- attr(model_tasks, "schema_id")
    all_model_tasks <- model_tasks$model_tasks
    object <- "model_tasks" # nolint: object_usage_linter
  } else {
    schema_id <- attr(rounds, "schema_id")
    all_model_tasks <- purrr::map(rounds$rounds, ~ .x$model_tasks) |>
      purrr::flatten()
    object <- "rounds" # nolint: object_usage_linter
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
