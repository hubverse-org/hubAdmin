test_that("create_rounds functions work correctly", {
  skip_if_offline()
  model_tasks <- create_model_tasks(
    create_model_task(
      task_ids = create_task_ids(
        create_task_id("origin_date",
          required = NULL,
          optional = c(
            "2023-01-02",
            "2023-01-09",
            "2023-01-16"
          )
        ),
        create_task_id("location",
          required = "US",
          optional = c("01", "02", "04", "05", "06")
        ),
        create_task_id("horizon",
          required = 1L,
          optional = 2:4
        )
      ),
      output_type = create_output_type(
        create_output_type_mean(
          is_required = TRUE,
          value_type = "double",
          value_minimum = 0L
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
          time_unit = "week"
        )
      )
    )
  )
  expect_snapshot(
    create_rounds(
      create_round(
        round_id_from_variable = TRUE,
        round_id = "origin_date",
        model_tasks = model_tasks,
        submissions_due = list(
          relative_to = "origin_date",
          start = -4L,
          end = 2L
        )
      )
    ) |> verify_latest_schema_version()
  )
  expect_snapshot(
    create_rounds(
      create_round(
        round_id_from_variable = FALSE,
        round_id = "round_1",
        model_tasks =
          create_model_tasks(
            create_model_task(
              task_ids = create_task_ids(
                create_task_id("origin_date",
                  required = NULL,
                  optional = c(
                    "2023-01-09"
                  )
                ),
                create_task_id("location",
                  required = "US",
                  optional = c("01", "02", "04", "05", "06")
                ),
                create_task_id("horizon",
                  required = 1L,
                  optional = 2:4
                )
              ),
              output_type = create_output_type(
                create_output_type_mean(
                  is_required = TRUE,
                  value_type = "double",
                  value_minimum = 0L
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
                  time_unit = "week"
                )
              )
            )
          ),
        submissions_due = list(
          start = "2023-01-05",
          end = "2023-01-11"
        ),
        last_data_date = "2023-01-06"
      ),
      create_round(
        round_id_from_variable = FALSE,
        round_id = "round_2",
        model_tasks =
          create_model_tasks(
            create_model_task(
              task_ids = create_task_ids(
                create_task_id("origin_date",
                  required = NULL,
                  optional = c(
                    "2023-01-16"
                  )
                ),
                create_task_id("location",
                  required = "US",
                  optional = c("01", "02", "04", "05", "06")
                ),
                create_task_id("horizon",
                  required = 1L,
                  optional = 2:4
                )
              ),
              output_type = create_output_type(
                create_output_type_mean(
                  is_required = TRUE,
                  value_type = "double",
                  value_minimum = 0L
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
                  time_unit = "week"
                )
              )
            )
          ),
        submissions_due = list(
          start = "2023-01-12",
          end = "2023-01-18"
        ),
        last_data_date = "2023-01-13"
      )
    ) |> verify_latest_schema_version()
  )
})

test_that("create_round errors correctly", {
  skip_if_offline()
  model_tasks <- create_model_tasks(
    create_model_task(
      task_ids = create_task_ids(
        create_task_id("origin_date",
          required = NULL,
          optional = c(
            "2023-01-02",
            "2023-01-09",
            "2023-01-16"
          )
        ),
        create_task_id("location",
          required = "US",
          optional = c("01", "02", "04", "05", "06")
        ),
        create_task_id("horizon",
          required = 1L,
          optional = 2:4
        )
      ),
      output_type = create_output_type(
        create_output_type_mean(
          is_required = TRUE,
          value_type = "double",
          value_minimum = 0L
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
          time_unit = "week"
        )
      )
    )
  )
  round_1 <- create_round(
    round_id_from_variable = FALSE,
    round_id = "round_1",
    model_tasks = model_tasks,
    submissions_due = list(
      start = "2023-01-12",
      end = "2023-01-18"
    ),
    last_data_date = "2023-01-10"
  )
  expect_snapshot(
    create_rounds(
      round_1,
      round_1
    ),
    error = TRUE
  )
})
