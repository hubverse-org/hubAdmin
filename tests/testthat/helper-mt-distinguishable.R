# Minimal round and model task objects for testing
# `validate_round_mts_distinguishable()`. They hold only the properties the
# check reads, `task_ids` and `output_type`, so each test shows only the values
# that matter to it.
stub_round <- function(..., derived_task_ids = NULL) {
  list(model_tasks = list(...), derived_task_ids = derived_task_ids)
}

stub_model_task <- function(
  task_ids = list(),
  output_type = stub_output_type_mean()
) {
  list(task_ids = task_ids, output_type = output_type)
}

stub_task_id <- function(required = NULL, optional = NULL) {
  list(required = required, optional = optional)
}

stub_output_type_mean <- function() {
  list(mean = list(output_type_id = list(required = NULL)))
}

stub_output_type_quantile <- function(required = c(0.25, 0.5, 0.75)) {
  list(quantile = list(output_type_id = list(required = required)))
}

stub_output_type_sample <- function() {
  list(
    sample = list(
      output_type_id_params = list(
        min_samples_per_task = 10L,
        max_samples_per_task = 10L
      )
    )
  )
}
