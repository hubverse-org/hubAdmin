# Setup fixtures for creating test objects
create_test_rounds <- function(
    branch = "main",
    version = "v3.0.1") {
  create_rounds(
    create_round(
      round_id_from_variable = TRUE,
      round_id = "origin_date",
      model_tasks = create_model_tasks(
        create_model_task(
          task_ids = create_task_ids(
            create_task_id("origin_date",
              required = NULL,
              optional = c(
                "2023-01-02",
                "2023-01-09",
                "2023-01-16"
              ),
              branch = branch,
              schema_version = version
            ),
            create_task_id("location",
              required = "US",
              optional = c("01", "02", "04", "05", "06"),
              branch = branch,
              schema_version = version
            ),
            create_task_id("horizon",
              required = 1L,
              optional = 2:4,
              branch = branch,
              schema_version = version
            )
          ),
          output_type = create_output_type(
            create_output_type_mean(
              is_required = TRUE,
              value_type = "double",
              value_minimum = 0L,
              branch = branch,
              schema_version = version
            )
          ),
          target_metadata = create_target_metadata(
            create_target_metadata_item(
              target_id = "inc hosp",
              target_name = "Weekly incident influenza hospitalizations",
              target_units = "rate per 100,000 population",
              target_keys = NULL,
              target_type = "discrete",
              is_step_ahead = TRUE,
              time_unit = "week",
              branch = branch,
              schema_version = version
            )
          )
        )
      ),
      submissions_due = list(
        relative_to = "origin_date",
        start = -4L,
        end = 2L
      )
    )
  )
}

create_test_config <- function(rounds) {
  create_config(rounds)
}

setup_test_hub <- function() {
  dir <- withr::local_tempdir()
  temp_hub <- fs::dir_create(fs::path(dir, "hub"))
  return(temp_hub)
}

setup_test_hub_with_config_dir <- function(temp_hub) {
  fs::dir_create(file.path(temp_hub, "hub-config"))
}
