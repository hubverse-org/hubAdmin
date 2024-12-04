create_derived_task_ids_round <- function(version,
                                          branch = getOption(
                                            "hubAdmin.branch",
                                            default = "main"
                                          ),
                                          derived_task_ids = NULL) {
  task_ids <- create_task_ids(
    create_task_id("origin_date",
      required = NULL,
      optional = c(
        "2023-01-02",
        "2023-01-09",
        "2023-01-16"
      ),
      schema_version = version,
      branch = branch
    ),
    create_task_id("location",
      required = "US",
      optional = c("01", "02", "04", "05", "06"),
      schema_version = version,
      branch = branch
    ),
    create_task_id("horizon",
      required = 1L,
      optional = 2:4,
      schema_version = version,
      branch = branch
    )
  )

  target_metadata <- create_target_metadata(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_keys = NULL,
      target_type = "discrete",
      is_step_ahead = TRUE,
      time_unit = "week",
      schema_version = version,
      branch = branch
    )
  )
  output_type <- create_output_type(
    create_output_type_mean(
      is_required = TRUE,
      value_type = "double",
      value_minimum = 0L,
      branch = branch,
      schema_version = version
    )
  )
  model_tasks <- create_model_tasks(
    create_model_task(
      task_ids,
      output_type,
      target_metadata
    )
  )

  create_round(
    round_id_from_variable = TRUE,
    round_id = "origin_date",
    model_tasks = model_tasks,
    submissions_due = list(
      relative_to = "origin_date",
      start = -4L,
      end = 2L
    ),
    derived_task_ids = derived_task_ids
  )
}
