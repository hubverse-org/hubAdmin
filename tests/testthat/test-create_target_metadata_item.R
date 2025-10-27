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
    ) |>
      verify_latest_schema_version()
  )
  expect_snapshot(
    create_target_metadata_item(
      target_id = "inc hosp",
      target_name = "Weekly incident influenza hospitalizations",
      target_units = "rate per 100,000 population",
      target_type = "discrete",
      is_step_ahead = FALSE
    ) |>
      verify_latest_schema_version()
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
  ) |>
    verify_latest_schema_version()

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
        uri = "http://purl.obolibrary.org/obo/IDO_0000463",
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
          uri = "http://purl.obolibrary.org/obo/IDO_0000463",
          alternative_name = "Incident Hospitalization"
        )
      )
    }
  )
  expect_equal(names(no_opt), names(opt_version))
})

test_that("additional_metadata field for optional properties in v6.0.0+", {
  # Test v6.0.0+ wraps additional properties in additional_metadata field
  withr::with_options(
    list(
      hubAdmin.schema_version = "v6.0.0"
    ),
    {
      v6_with_additional <- create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week",
        uri = "http://purl.obolibrary.org/obo/IDO_0000463",
        alternative_name = "Incident Hospitalization",
        custom_field = "custom_value"
      )

      # Check that additional_metadata field exists
      expect_true("additional_metadata" %in% names(v6_with_additional))

      # Check that additional properties are nested within additional_metadata
      expect_equal(
        v6_with_additional$additional_metadata,
        list(
          uri = "http://purl.obolibrary.org/obo/IDO_0000463",
          alternative_name = "Incident Hospitalization",
          custom_field = "custom_value"
        )
      )

      # Check that individual properties are NOT directly in the object
      expect_false("uri" %in% names(v6_with_additional))
      expect_false("alternative_name" %in% names(v6_with_additional))
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
      v6_no_additional <- create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week"
      )

      # Should not have additional_metadata field when no additional properties
      expect_false("additional_metadata" %in% names(v6_no_additional))
    }
  )
})

test_that("additional properties behavior differs between v5.1.0 and v6.0.0", {
  skip_if_offline()

  # v5.1.0 - properties added directly
  withr::with_options(
    list(
      hubAdmin.schema_version = "v5.1.0"
    ),
    {
      v5_item <- create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week",
        uri = "http://purl.obolibrary.org/obo/IDO_0000463",
        custom_field = "custom_value"
      )

      # In v5.1.0, properties are directly in the object
      expect_true("uri" %in% names(v5_item))
      expect_true("custom_field" %in% names(v5_item))
      expect_false("additional_metadata" %in% names(v5_item))
      expect_equal(v5_item$uri, "http://purl.obolibrary.org/obo/IDO_0000463")
      expect_equal(v5_item$custom_field, "custom_value")
    }
  )

  # v6.0.0 - properties wrapped in additional_metadata
  withr::with_options(
    list(
      hubAdmin.schema_version = "v6.0.0"
    ),
    {
      v6_item <- create_target_metadata_item(
        target_id = "inc hosp",
        target_name = "Weekly incident influenza hospitalizations",
        target_units = "rate per 100,000 population",
        target_keys = list(target = "inc hosp"),
        target_type = "discrete",
        is_step_ahead = TRUE,
        time_unit = "week",
        uri = "http://purl.obolibrary.org/obo/IDO_0000463",
        custom_field = "custom_value"
      )

      # In v6.0.0, properties are nested in additional_metadata
      expect_false("uri" %in% names(v6_item))
      expect_false("custom_field" %in% names(v6_item))
      expect_true("additional_metadata" %in% names(v6_item))
      expect_equal(
        v6_item$additional_metadata$uri,
        "http://purl.obolibrary.org/obo/IDO_0000463"
      )
      expect_equal(v6_item$additional_metadata$custom_field, "custom_value")
    }
  )
})
