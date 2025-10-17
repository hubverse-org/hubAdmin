# Tests for target-data.json dynamic validation
#
# Helper functions used in this file:
# - create_test_hub_with_target_data() from helper-target-data.R

test_that("Valid target-data config passes all dynamic checks", {
  hub_path <- system.file("testhubs/v6/target_file", package = "hubUtils")

  out <- suppressMessages(validate_config(
    hub_path = hub_path,
    config = "target-data"
  ))
  expect_true(out)
})

test_that("Invalid global observable_unit is detected", {
  # Config with invalid column in observable_unit
  target_data_config <- list(
    schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
    observable_unit = c(
      "target_end_date",
      "target",
      "location",
      "invalid_column"
    ),
    date_col = "target_end_date",
    versioned = TRUE
  )

  hub_path <- create_test_hub_with_target_data(target_data_config)

  out <- suppressMessages(validate_config(
    hub_path = hub_path,
    config = "target-data"
  ))
  expect_false(out)

  errors <- attr(out, "errors")
  expect_equal(nrow(errors), 1L)
  expect_match(errors$keyword, "observable_unit values")
  expect_match(
    errors$message,
    "observable_unit column\\(s\\) 'invalid_column' not valid"
  )
  expect_match(errors$instancePath, "/observable_unit")
})

test_that("Reserved columns in non_task_id_schema are detected", {
  # Config with reserved columns in non_task_id_schema
  target_data_config <- list(
    schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
    observable_unit = c(
      "target_end_date",
      "target",
      "location"
    ),
    date_col = "target_end_date",
    versioned = TRUE,
    `time-series` = list(
      non_task_id_schema = list(
        location_name = "character",
        as_of = "Date",
        output_type = "character"
      )
    )
  )

  hub_path <- create_test_hub_with_target_data(target_data_config)

  out <- suppressMessages(validate_config(
    hub_path = hub_path,
    config = "target-data"
  ))
  expect_false(out)

  errors <- attr(out, "errors")
  expect_equal(nrow(errors), 1L)
  expect_match(errors$keyword, "non_task_id_schema column names")
  expect_match(
    errors$message,
    "non_task_id_schema must NOT contain task ID columns, date_col, or reserved columns"
  )
  expect_match(errors$message, "as_of")
  expect_match(errors$message, "output_type")
  expect_match(errors$instancePath, "/time-series/non_task_id_schema")
})

test_that("observation column in non_task_id_schema is detected", {
  # Config with 'observation' column in non_task_id_schema
  target_data_config <- list(
    schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
    observable_unit = c(
      "target_end_date",
      "target",
      "location"
    ),
    date_col = "target_end_date",
    versioned = TRUE,
    `time-series` = list(
      non_task_id_schema = list(
        location_name = "character",
        observation = "double"
      )
    )
  )

  hub_path <- create_test_hub_with_target_data(target_data_config)

  out <- suppressMessages(validate_config(
    hub_path = hub_path,
    config = "target-data"
  ))
  expect_false(out)

  errors <- attr(out, "errors")
  expect_equal(nrow(errors), 1L)
  expect_match(errors$keyword, "non_task_id_schema column names")
  expect_match(
    errors$message,
    "non_task_id_schema must NOT contain task ID columns, date_col, or reserved columns"
  )
  expect_match(errors$message, "observation")
  expect_match(errors$data, "reserved column\\(s\\): observation")
  expect_match(errors$instancePath, "/time-series/non_task_id_schema")
})

test_that("Invalid dataset-level observable_unit is detected", {
  # Config with invalid column in dataset-level observable_unit
  target_data_config <- list(
    schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
    observable_unit = c(
      "target_end_date",
      "target",
      "location"
    ),
    date_col = "target_end_date",
    versioned = TRUE,
    `oracle-output` = list(
      has_output_type_ids = TRUE,
      observable_unit = c(
        "target_end_date",
        "target",
        "location",
        "bad_column"
      ),
      versioned = FALSE
    )
  )

  hub_path <- create_test_hub_with_target_data(target_data_config)

  out <- suppressMessages(validate_config(
    hub_path = hub_path,
    config = "target-data"
  ))
  expect_false(out)

  errors <- attr(out, "errors")
  expect_equal(nrow(errors), 1L)
  expect_match(errors$keyword, "oracle-output observable_unit values")
  expect_match(
    errors$message,
    "oracle-output observable_unit column\\(s\\) 'bad_column' not valid"
  )
  expect_match(errors$instancePath, "/oracle-output/observable_unit")
})

test_that("Missing tasks.json triggers error", {
  # Create a temporary directory with only target-data.json
  tmp <- withr::local_tempdir()
  dir.create(file.path(tmp, "hub-config"), recursive = TRUE)

  target_data <- list(
    schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
    observable_unit = c("origin_date", "location"),
    date_col = "origin_date",
    versioned = TRUE
  )

  jsonlite::write_json(
    target_data,
    file.path(tmp, "hub-config", "target-data.json"),
    auto_unbox = TRUE,
    pretty = TRUE
  )

  expect_error(
    validate_config(hub_path = tmp, config = "target-data"),
    "Cannot validate target-data\\.json: tasks\\.json not found"
  )
})

test_that("Task ID columns in non_task_id_schema are detected", {
  # Config with task ID column in non_task_id_schema
  target_data_config <- list(
    schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
    observable_unit = c(
      "target_end_date",
      "target",
      "location"
    ),
    date_col = "target_end_date",
    versioned = TRUE,
    `time-series` = list(
      non_task_id_schema = list(
        location = "character", # This is a task ID column
        extra_col = "integer"
      )
    )
  )

  hub_path <- create_test_hub_with_target_data(target_data_config)

  out <- suppressMessages(validate_config(
    hub_path = hub_path,
    config = "target-data"
  ))
  expect_false(out)

  errors <- attr(out, "errors")
  expect_match(
    errors$message,
    "non_task_id_schema must NOT contain task ID columns"
  )
  expect_match(errors$message, "location")
})

test_that("date_col in non_task_id_schema is detected", {
  # Config with date_col in non_task_id_schema (whether or not it's a task ID)
  target_data_config <- list(
    schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
    observable_unit = c(
      "target_end_date",
      "target",
      "location"
    ),
    date_col = "target_end_date",
    versioned = TRUE,
    `time-series` = list(
      non_task_id_schema = list(
        target_end_date = "Date", # This is the date_col
        extra_col = "integer"
      )
    )
  )

  hub_path <- create_test_hub_with_target_data(target_data_config)

  out <- suppressMessages(validate_config(
    hub_path = hub_path,
    config = "target-data"
  ))
  expect_false(out)

  errors <- attr(out, "errors")
  expect_match(
    errors$message,
    "non_task_id_schema must NOT contain task ID columns, date_col, or reserved columns"
  )
  expect_match(errors$message, "target_end_date")
  expect_match(errors$data, "date_col: target_end_date")
})

test_that("Duplicate property names are detected in target-data config", {
  hub_path <- create_test_hub_with_target_data(NULL)

  # Write target-data.json with duplicate property using raw JSON
  target_data_json <- '{
  "schema_version": "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
  "observable_unit": ["target", "target_end_date", "location"],
  "date_col": "target_end_date",
  "date_col": "target_end_date",
  "versioned": false
}'

  writeLines(
    target_data_json,
    fs::path(hub_path, "hub-config", "target-data.json")
  )

  out <- suppressMessages(validate_config(
    hub_path = hub_path,
    config = "target-data"
  ))
  expect_false(out)

  errors <- attr(out, "errors")
  expect_true(any(grepl("uniqueNames", errors$keyword)))
  expect_true(any(grepl("duplicate names", errors$data)))
})


test_that("Multiple validation errors are collected correctly", {
  # Config with multiple errors
  target_data_config <- list(
    schema_version = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/target-data-schema.json",
    observable_unit = c(
      "target_end_date",
      "target",
      "location",
      "invalid_global"
    ),
    date_col = "target_end_date",
    versioned = TRUE,
    `time-series` = list(
      non_task_id_schema = list(
        extra_col = "integer",
        location = "character",
        as_of = "Date"
      )
    ),
    `oracle-output` = list(
      has_output_type_ids = TRUE,
      versioned = FALSE,
      observable_unit = c(
        "target_end_date",
        "target",
        "location",
        "invalid_dataset"
      )
    )
  )

  hub_path <- create_test_hub_with_target_data(target_data_config)

  out <- suppressMessages(validate_config(
    hub_path = hub_path,
    config = "target-data"
  ))
  expect_false(out)

  errors <- attr(out, "errors")
  # Should have at least 3 errors: global OU, non_task_id_schema, dataset OU
  expect_true(nrow(errors) >= 3)

  # Check that all expected error types are present
  expect_equal(
    unclass(errors$message),
    c(
      "observable_unit column(s) 'invalid_global' not valid. Must be task ID column(s) or date_col.",
      "oracle-output observable_unit column(s) 'invalid_dataset' not valid. Must be task ID column(s) or date_col.",
      "non_task_id_schema must NOT contain task ID columns, date_col, or reserved columns. Invalid: location & as_of"
    )
  )

  expect_equal(
    sort(errors$instancePath),
    c(
      "/observable_unit",
      "/oracle-output/observable_unit",
      "/time-series/non_task_id_schema"
    )
  )
})
