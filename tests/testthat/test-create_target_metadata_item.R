test_that("create_target_metadata_item functions work correctly", {
  skip_if_offline()
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_keys = list(target = "inc hosp"),
      target_type = "discrete",
      is_step_ahead = TRUE,
      time_unit = "week"
    ) |> verify_latest_schema_version()
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_type = "discrete",
      is_step_ahead = FALSE
    ) |> verify_latest_schema_version()
  )
})



test_that("create_target_metadata_item functions error correctly", {
  skip_if_offline()
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_keys = list(target = "inc hosp"),
      target_type = "discrete",
      is_step_ahead = TRUE,
      time_unit = "weekly"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_keys = list(target = c("inc hosp", "inc death")),
      target_type = "discrete",
      is_step_ahead = TRUE,
      time_unit = "week"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_keys = c(target = "inc hosp"),
      target_type = "discrete",
      is_step_ahead = TRUE,
      time_unit = "week"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_type = "discrete",
      is_step_ahead = TRUE
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = 100000,
      target_type = "discrete",
      is_step_ahead = FALSE
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_type = "invalid_target_type",
      is_step_ahead = FALSE
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = c("rate per 100,000 population", "count"),
      target_type = "discrete",
      is_step_ahead = FALSE
    ),
    error = TRUE
  )
})

test_that("schema version option works for create_target_metadata_item", {
  skip_if_offline()
  version_default <- create_target_metadata_item(
    target_id = "inc hosp",
    target_name = "Weekly incident influenza hospitalizations",
    target_units = "rate per 100,000 population",
    target_keys = list(target = "inc hosp"),
    target_type = "discrete",
    is_step_ahead = TRUE,
    time_unit = "week"
  ) |> verify_latest_schema_version()

  arg_version <- create_target_metadata_item(
    target_id = "inc hosp",
    target_name = "Weekly incident influenza hospitalizations",
    target_units = "rate per 100,000 population",
    target_keys = list(target = "inc hosp"),
    target_type = "discrete",
    is_step_ahead = TRUE,
    time_unit = "week",
    schema_version = "v3.0.1",
    branch = "main"
  )

  withr::with_options(
    list(
      hubAdmin.schema_version = "v3.0.1",
      hubAdmin.branch = "main"
    ),
    {
      opt_version <- create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      )
    }
  )
  expect_equal(arg_version, opt_version)
  expect_snapshot(waldo::compare(opt_version, version_default))
})

test_that("Target_keys of length more than 1 are not allowed post v5.0.0", {
  skip_if_offline()
  withr::with_options(
    list(
      hubAdmin.schema_version = "v5.0.0"
    ),
    {
      # One target_key is allowed in v5.0.0 and later versions.
      target_keys_n1 <- create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      )
      expect_s3_class(target_keys_n1, "target_metadata_item")
      expect_length(target_keys_n1$target_keys, 1L)

      # More than one target_key is NOT allowed in v5.0.0 and later versions
      # and throws error.
      expect_snapshot(
        create_target_metadata_item(
          target_id = "flu inc hosp",
          target_name = "Weekly incident influenza hospitalizations",
          target_units = "rate per 100,000 population",
          target_keys = list(
            target = "flu",
            target_metric = "inc hosp"
          ),
          target_type = "discrete",
          is_step_ahead = TRUE,
          time_unit = "week"
        ),
        error = TRUE
      )
    }
  )
  # More than 1 target_keys still allowed in earlier versions to conform to
  # schema.
  withr::with_options(
    list(
      hubAdmin.schema_version = "v4.0.0"
    ),
    {
      target_keys_n2 <- create_target_metadata_item(
        target_id = "flu inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(
          target = "flu",
          target_metric = "inc hosp"
        ),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      )
      expect_s3_class(target_keys_n2, "target_metadata_item")
      expect_length(target_keys_n2$target_keys, 2L)
    }
  )
})

test_that("target_ids and target_key values mismatches detected correctly", {
  skip_if_offline()
  expect_error(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_keys = list(target = "inc hospitalizations"),
      target_type = "discrete",
      is_step_ahead = TRUE,
      time_unit = "week"
    ),
    regexp = ".*target_id.* value .* does not match corresponding .*target_keys.* value"
  )

  expect_s3_class(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_keys = NULL,
      target_type = "discrete",
      is_step_ahead = TRUE,
      time_unit = "week"
    ),
    "target_metadata_item"
  )

  withr::with_options(
    list(
      hubAdmin.schema_version = "v4.0.0"
    ),
    {
      target_metadata <- create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(
          target_variable = "inc",
          target_outcome = " hospitalizations"
        ),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      )
      expect_s3_class(target_metadata, "target_metadata_item")
    }
  )
})

test_that("possibility to add optional properties starting v5.1.0", {
  skip_if_offline()
  no_opt <- create_target_metadata_item(
    target_id = "inc hosp",
    target_name = "Weekly incident influenza hospitalizations",
    target_units = "rate per 100,000 population",
    target_keys = list(target = "inc hosp"),
    target_type = "discrete",
    is_step_ahead = TRUE,
    time_unit = "week"
  )

  withr::with_options(
    list(
      hubAdmin.schema_version = "v5.1.0"
    ),
    {
      opt_version <- create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week",
        uri = "https://ontobee.org/",
        alternative_name = "Incident Hospitalization"
      )
    }
  )
  expect_equal(c(names(no_opt), "uri", "alternative_name"), names(opt_version))

  withr::with_options(
    list(
      hubAdmin.schema_version = "v3.0.1"
    ),
    {
      expect_message(
        opt_version <- create_target_metadata_item(
          target_id = "inc hosp",
          target_name = "Weekly incident influenza hospitalizations",
          target_units = "rate per 100,000 population",
          target_keys = list(target = "inc hosp"),
          target_type = "discrete",
          is_step_ahead = TRUE,
          time_unit = "week",
          uri = "https://ontobee.org/",
          alternative_name = "Incident Hospitalization"
        )
      )
    }
  )
  expect_equal(names(no_opt), names(opt_version))
})
