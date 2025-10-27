test_that("create_round functions work correctly", {
  skip_if_offline()
  model_tasks <- create_model_tasks(
    create_model_task(
      task_ids = create_task_ids(
        create_task_id(
          "origin_date",
          required = NULL,
          optional = c(
            "2023-01-02",
            "2023-01-09",
            "2023-01-16"
          )
        ),
        create_task_id(
          "location",
          required = "US",
          optional = c("01", "02", "04", "05", "06")
        ),
        create_task_id("horizon", required = 1L, optional = 2:4)
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
    ) |>
      verify_latest_schema_version()
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
    ) |>
      verify_latest_schema_version()
  )
})


test_that("create_round name matching works correctly", {
  skip_if_offline()
  model_tasks <- create_model_tasks(
    create_model_task(
      task_ids = create_task_ids(
        create_task_id(
          "origin_date",
          required = NULL,
          optional = c(
            "2023-01-02",
            "2023-01-09",
            "2023-01-16"
          )
        ),
        create_task_id(
          "location",
          required = "US",
          optional = c("01", "02", "04", "05", "06")
        ),
        create_task_id("horizon", required = 1L, optional = 2:4)
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
      hubAdmin.schema_version = "v5.0.0"
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
        create_task_id(
          "round_id_var",
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
        create_task_id(
          "round_id_var",
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
        create_task_id(
          "round_id_var",
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
        create_task_id(
          "round_id_var",
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
      hubAdmin.schema_version = "v5.0.0"
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
        create_task_id(
          "round_id_var",
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
        create_task_id(
          "round_id_var",
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

test_that("additional_metadata field for optional properties in v6.0.0+", {
  # Create shared model_tasks for tests
  model_tasks <- create_model_tasks(
    create_model_task(
      task_ids = create_task_ids(
        create_task_id(
          "origin_date",
          required = NULL,
          optional = c(
            "2023-01-02",
            "2023-01-09",
            "2023-01-16"
          )
        ),
        create_task_id(
          "location",
          required = "US",
          optional = c("01", "02", "04", "05", "06")
        ),
        create_task_id("horizon", required = 1L, optional = 2:4)
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

  # Test v6.0.0+ wraps additional properties in additional_metadata field
  withr::with_options(
    list(
      hubAdmin.schema_version = "v6.0.0"
    ),
    {
      v6_with_additional <- create_round(
        round_id_from_variable = TRUE,
        round_id = "origin_date",
        model_tasks = model_tasks,
        submissions_due = list(
          relative_to = "origin_date",
          start = -4L,
          end = 2L
        ),
        last_data_date = "2023-01-02",
        round_label = "Round 1",
        data_source = "https://example.com/data",
        custom_field = "custom_value"
      )

      # Check that additional_metadata field exists
      expect_true("additional_metadata" %in% names(v6_with_additional))

      # Check that additional properties are nested within additional_metadata
      expect_equal(
        v6_with_additional$additional_metadata,
        list(
          round_label = "Round 1",
          data_source = "https://example.com/data",
          custom_field = "custom_value"
        )
      )

      # Check that individual properties are NOT directly in the object
      expect_false("round_label" %in% names(v6_with_additional))
      expect_false("data_source" %in% names(v6_with_additional))
      expect_false("custom_field" %in% names(v6_with_additional))

      # Check the names attribute includes additional_metadata
      expect_true("additional_metadata" %in% attr(v6_with_additional, "names"))
    }
  )

  # Test v6.0.0+ without additional properties
  withr::with_options(
    list(
      hubAdmin.schema_version = "v6.0.0"
    ),
    {
      v6_no_additional <- create_round(
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

      # Should not have additional_metadata field when no additional properties
      expect_false("additional_metadata" %in% names(v6_no_additional))
    }
  )
})

test_that("additional properties pre-v6.0.0 are stored at tope level of object", {
  # Pre-v6.0.0 - properties added directly
  withr::with_options(
    list(
      hubAdmin.schema_version = "v3.0.1"
    ),
    {
      model_tasks_v3 <- create_model_tasks(
        create_model_task(
          task_ids = create_task_ids(
            create_task_id(
              "origin_date",
              required = NULL,
              optional = c(
                "2023-01-02",
                "2023-01-09",
                "2023-01-16"
              )
            ),
            create_task_id(
              "location",
              required = "US",
              optional = c("01", "02", "04", "05", "06")
            ),
            create_task_id("horizon", required = 1L, optional = 2:4)
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

      pre_v6_round <- create_round(
        round_id_from_variable = TRUE,
        round_id = "origin_date",
        model_tasks = model_tasks_v3,
        submissions_due = list(
          relative_to = "origin_date",
          start = -4L,
          end = 2L
        ),
        last_data_date = "2023-01-02",
        round_label = "Round 1",
        custom_field = "custom_value"
      )

      # In pre-v6.0.0, properties are directly in the object
      expect_true("round_label" %in% names(pre_v6_round))
      expect_true("custom_field" %in% names(pre_v6_round))
      expect_false("additional_metadata" %in% names(pre_v6_round))
      expect_equal(pre_v6_round$round_label, "Round 1")
      expect_equal(pre_v6_round$custom_field, "custom_value")
    }
  )
})
