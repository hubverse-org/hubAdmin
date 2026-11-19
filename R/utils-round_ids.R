validate_round_id_pattern <- function(x) {
  stringr::str_detect(
    x,
    "^(\\d{4}-\\d{2}-\\d{2})$|^[A-Za-z0-9_]+$"
  )
}

# This function expects a list representation of the task ID variable values
# specified in `round_id` when `round_id_from_variable` is `true.`
# Returns a list with `required` and `optional` elements containg either the
# invalid values identified by the `validate_round_id_pattern` function or NULL.
invalid_round_id_var_patterns <- function(round_id_var_vals) {
  purrr::map(
    round_id_var_vals,
    \(.x) {
      if (is.null(.x)) {
        return(NULL)
      }
      valid <- validate_round_id_pattern(.x)
      invalid <- .x[!valid]
      if (length(invalid) == 0L) {
        return(NULL)
      }
      invalid
    }
  )
}

# Check whether a model task's sample compound_taskid_set leaves out the
# round_id variable. A model output file covers a single round, so samples
# cannot be joint across the round_id variable.
# Note that an absent compound_taskid_set defaults to all task IDs and so
# always includes it. `[]` is read as `list()`, not `NULL`, so it is checked.
compound_taskids_missing_round_id_var <- function(model_task, round_id_var) {
  comp_tids <- purrr::pluck(
    model_task,
    "output_type",
    "sample",
    "output_type_id_params",
    "compound_taskid_set"
  )
  !is.null(comp_tids) && !round_id_var %in% comp_tids
}
