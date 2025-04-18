test_that("create_target_metadata functions work correctly", {
  skip_if_offline()
  expect_snapshot(
    create_target_metadata(
      create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      ),
      create_target_metadata_item(
        target_id = "inc death",
        target_name = "Weekly incident influenza deaths",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc death"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      )
    ) |> verify_latest_schema_version()
  )
})


test_that("create_target_metadata functions error correctly", {
  skip_if_offline()
  expect_snapshot(
    create_target_metadata(
      create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      ),
      create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      )
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata(
      create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      ),
      create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza deaths",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      )
    ),
    error = TRUE
  )
  expect_snapshot(
    create_target_metadata(
      create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      ),
      list(a = 10),
      list(b = 10)
    ),
    error = TRUE
  )

  withr::with_options(
    list(
      hubAdmin.schema_version = "v4.0.0",
      hubAdmin.branch = "main"
    ),
    {
      item_1 <- create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      )
      attr(item_1, "schema_id") <- "invalid_schema"
      expect_snapshot(
        create_target_metadata(
          item_1,
          create_target_metadata_item(
            target_id = "inc death",
            target_name = "Weekly incident influenza deaths",
            target_units = "rate per 100,000 population",
            target_keys = list(target = "inc death"),
            target_type = "discrete",
            is_step_ahead = TRUE,
            time_unit = "week"
          )
        ),
        error = TRUE
      )
    }
  )
})
