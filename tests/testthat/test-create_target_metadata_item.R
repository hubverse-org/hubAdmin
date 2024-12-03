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
    schema_version = "v3.0.1"
  )

  withr::with_options(
    list(hubAdmin.schema_version = "v3.0.1"),
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
