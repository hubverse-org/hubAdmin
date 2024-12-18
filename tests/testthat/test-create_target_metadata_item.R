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
    )
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_type = "discrete",
      is_step_ahead = FALSE
    )
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
  )

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

test_that("Target_keys of length more than 1 are not allowed post v4.0.1", {
  skip_if_offline()
  withr::with_options(
    list(
      hubAdmin.schema_version = "v4.0.1",
      # TDOD: remove branch argument when v4.0.1 is released.
      hubAdmin.branch = "ak/v4.0.1/restrict-target-key-value-pair-n/117"
    ),
    {
      # One target_key is allowed in v4.0.1 and later versions.
      target_keys_n1 <- create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week",
        branch = "ak/v4.0.1/restrict-target-key-value-pair-n/117"
      )
      expect_s3_class(target_keys_n1, "target_metadata_item")
      expect_length(target_keys_n1$target_keys, 1L)

      # More than one target_key is NOT allowed in v4.0.1 and later versions
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
