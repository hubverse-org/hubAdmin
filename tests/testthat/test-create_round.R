test_that("create_round functions work correctly", {
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
    create_round(
      round_id_from_variable = FALSE,
      round_id = "round_1",
      model_tasks = model_tasks,
      submissions_due = list(
        start = "2023-01-12",
        end = "2023-01-18"
      ),
      last_data_date = "2023-01-02"
    )
  )
  expect_snapshot(
    create_round(
      round_id_from_variable = TRUE,
      round_id = "origin_date",
      model_tasks = model_tasks,
      submissions_due = list(
        relative_to = "origin_date",
        start = -4L,
        end = 2L
      ),
      last_data_date = "2023-01-02"
    )
  )
})


test_that("create_round name matching works correctly", {
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
    create_round(
      round_id_from_variable = FALSE,
      round_id = "round_1",
      model_tasks = model_tasks,
      submissions_due = list(
        start = "01/12/2023",
        end = "2023-01-18"
      ),
      last_data_date = "2023-01-02"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_round(
      round_id_from_variable = FALSE,
      round_id = "round_1",
      model_tasks = model_tasks,
      submissions_due = list(
        start = -4L,
        end = 2
      ),
      last_data_date = "2023-01-02"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_round(
      round_id_from_variable = TRUE,
      round_id = "origin_dates",
      model_tasks = model_tasks,
      submissions_due = list(
        relative_to = "origin_date",
        start = -4L,
        end = 2L
      ),
      last_data_date = "2023-01-02"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_round(
      round_id_from_variable = TRUE,
      round_id = "origin_date",
      model_tasks = model_tasks,
      submissions_due = list(
        relative = "origin_date",
        start = -4L,
        end = 2L
      ),
      last_data_date = "2023-01-02"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_round(
      round_id_from_variable = TRUE,
      round_id = "origin_date",
      model_tasks = "model_tasks",
      submissions_due = list(
        relative_to = "origin_date",
        start = -4L,
        end = 2L
      ),
      last_data_date = "2023-01-02"
    ),
    error = TRUE
  )
})

test_that("create_round derived_task_ids argument", {
  skip_if_offline()
  expect_snapshot(
    create_derived_task_ids_round(
      version = "v4.0.0",
      derived_task_ids = "location"
    )
  )
  # Show that the derived_task_ids argument is removed when NULL
  expect_snapshot(
    waldo::compare(
      create_derived_task_ids_round(
        version = "v4.0.0",
        derived_task_ids = "location"
      ),
      create_derived_task_ids_round(
        version = "v4.0.0",
        derived_task_ids = NULL
      )
    )
  )
  expect_warning(
    create_derived_task_ids_round(
      version = "v3.0.0",
      derived_task_ids = c("random_task_id")
    ),
    regex = "argument is only available for schema version"
  )

  expect_snapshot(
    create_derived_task_ids_round(
      version = "v4.0.0",
      derived_task_ids = 1L
    ),
    error = TRUE
  )
  expect_snapshot(
    create_derived_task_ids_round(
      version = "v4.0.0",
      derived_task_ids = c("random_task_id")
    ),
    error = TRUE
  )
})

test_that("validating round_id patterns when round_id_from_var = TRUE works", {
  skip_if_offline()
  withr::with_options(
    list(
      hubAdmin.schema_version = "v4.0.1",
      hubAdmin.branch = "br-v4.0.1"
    ),
    {
      output_types <- create_output_type(
        create_output_type_mean(
          is_required = TRUE,
          value_type = "double",
          value_minimum = 0L
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
          time_unit = "week"
        )
      )
      # Check that valid round_id values are accepted
      task_ids <- create_task_ids(
        create_task_id("round_id_var",
          required = "2023-01-09",
          optional = c(
            "2023-01-02",
            "24_25_covid"
          )
        )
      )
      model_tasks <- create_model_tasks(
        create_model_task(
          task_ids = task_ids,
          output_type = output_types,
          target_metadata = target_metadata
        )
      )

      round <- create_round(
        round_id_from_variable = TRUE,
        round_id = "round_id_var",
        model_tasks = model_tasks,
        submissions_due = list(
          start = "2023-01-12",
          end = "2023-01-18"
        ),
        last_data_date = "2023-01-02"
      )
      expect_s3_class(round, "round")

      # Check that multiple invalid values in both required and optional values
      # reported correctly
      task_ids <- create_task_ids(
        create_task_id("round_id_var",
          required = "invalid-round-id-req",
          optional = c(
            "2023-01-02",
            "24_25_covid",
            "invalid-round-id-opt1",
            "invalid-round-id-opt2"
          )
        )
      )
      model_tasks <- create_model_tasks(
        create_model_task(
          task_ids = task_ids,
          output_type = output_types,
          target_metadata = target_metadata
        )
      )
      expect_snapshot(
        create_round(
          round_id_from_variable = TRUE,
          round_id = "round_id_var",
          model_tasks = model_tasks,
          submissions_due = list(
            start = "2023-01-12",
            end = "2023-01-18"
          ),
          last_data_date = "2023-01-02"
        ),
        error = TRUE
      )

      # Check that multiple invalid values in required or optional values
      # across multiple modeling tasks reported correctly
      task_ids_1 <- create_task_ids(
        create_task_id("round_id_var",
          required = NULL,
          optional = c(
            "2023-01-02",
            "24_25_covid",
            "invalid-round-id-opt1",
            "invalid-round-id-opt2"
          )
        )
      )
      task_ids_2 <- create_task_ids(
        create_task_id("round_id_var",
          required = c(
            "2023-01-02",
            "24_25_covid",
            "invalid-round-id-req1",
            "invalid-round-id-req2"
          ),
          optional = NULL,
        )
      )
      model_tasks <- create_model_tasks(
        create_model_task(
          task_ids = task_ids_1,
          output_type = output_types,
          target_metadata = target_metadata
        ),
        create_model_task(
          task_ids = task_ids_2,
          output_type = output_types,
          target_metadata = target_metadata
        )
      )
      expect_snapshot(
        create_round(
          round_id_from_variable = TRUE,
          round_id = "round_id_var",
          model_tasks = model_tasks,
          submissions_due = list(
            start = "2023-01-12",
            end = "2023-01-18"
          ),
          last_data_date = "2023-01-02"
        ),
        error = TRUE
      )
    }
  )
})

test_that("validating round_id pattern when round_id_from_var = FALSE works", {
  skip_if_offline()
  withr::with_options(
    list(
      hubAdmin.schema_version = "v4.0.1",
      hubAdmin.branch = "br-v4.0.1"
    ),
    {
      output_types <- create_output_type(
        create_output_type_mean(
          is_required = TRUE,
          value_type = "double",
          value_minimum = 0L
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
          time_unit = "week"
        )
      )
      # Check that valid round_id value is accepted while round_id_var invalid
      # values are ignored
      task_ids <- create_task_ids(
        create_task_id("round_id_var",
          required = "2023-01-09",
          optional = c(
            "2023-01-02",
            "24_25_covid"
          )
        )
      )
      model_tasks <- create_model_tasks(
        create_model_task(
          task_ids = task_ids,
          output_type = output_types,
          target_metadata = target_metadata
        )
      )

      round_alpha_num <- create_round(
        round_id_from_variable = FALSE,
        round_id = "round_id_var",
        model_tasks = model_tasks,
        submissions_due = list(
          start = "2023-01-12",
          end = "2023-01-18"
        ),
        last_data_date = "2023-01-02"
      )
      expect_s3_class(round_alpha_num, "round")

      round_iso_date <- create_round(
        round_id_from_variable = FALSE,
        round_id = "2023-01-15",
        model_tasks = model_tasks,
        submissions_due = list(
          start = "2023-01-12",
          end = "2023-01-18"
        ),
        last_data_date = "2023-01-02"
      )
      expect_s3_class(round_iso_date, "round")

      # Check that invalid `round_id` reported correctly
      task_ids <- create_task_ids(
        create_task_id("round_id_var",
          required = "invalid-round-id-req",
          optional = c(
            "2023-01-02",
            "24_25_covid",
            "invalid-round-id-opt1",
            "invalid-round-id-opt2"
          )
        )
      )
      model_tasks <- create_model_tasks(
        create_model_task(
          task_ids = task_ids,
          output_type = output_types,
          target_metadata = target_metadata
        )
      )
      expect_snapshot(
        create_round(
          round_id_from_variable = FALSE,
          round_id = "round-id-var",
          model_tasks = model_tasks,
          submissions_due = list(
            start = "2023-01-12",
            end = "2023-01-18"
          ),
          last_data_date = "2023-01-02"
        ),
        error = TRUE
      )
    }
  )
})
