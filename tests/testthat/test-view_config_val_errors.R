test_that("Errors report launch successful", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "tasks-errors.json")
  validation <- suppressWarnings(
    validate_config(config_path = config_path)
  )
  set.seed(1)
  tbl <- view_config_val_errors(validation)

  expect_s3_class(tbl, "gt_tbl")
  expect_named(
    tbl$`_data`,
    c("instancePath", "schemaPath", "keyword", "message", "schema", "data")
  )
  expect_equal(
    vapply(tbl$`_spanners`$spanner_label, as.character, character(1)),
    c("**Error location**", "**Schema details**", "**Config**")
  )
  expect_equal(
    tbl$`_spanners`$vars,
    list(
      c("instancePath", "schemaPath"),
      c("keyword", "message", "schema"),
      "data"
    )
  )
  expect_snapshot(tbl$`_source_notes`)
  expect_snapshot(tbl$`_heading`)
  expect_snapshot(str(tbl$`_data`))
  expect_snapshot(tbl$`_styles`)
})

test_that("length 1 paths and related type & enum errors handled correctly", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "admin-errors2.json")
  validation <- suppressWarnings(
    validate_config(
      config_path = config_path,
      config = "admin",
      branch = "main",
      schema_version = "v1.0.0"
    )
  )
  set.seed(1)
  tbl <- view_config_val_errors(validation)
  expect_snapshot(str(tbl$`_data`))
})

test_that("Data column handled correctly when required property missing", {
  skip_if_offline()
  set.seed(1)
  # One nested property missing, one type error
  config_path <- testthat::test_path("testdata", "tasks_required_missing.json")
  tbl <- view_config_val_errors(suppressWarnings(
    validate_config(config_path = config_path)
  ))
  expect_snapshot(str(tbl$`_data`))

  # Only a single property missing
  config_path <- testthat::test_path(
    "testdata",
    "tasks_required_missing_only.json"
  )
  tbl <- view_config_val_errors(suppressWarnings(
    validate_config(config_path = config_path)
  ))

  expect_snapshot(str(tbl$`_data`))

  # Two properties missing, only one nested
  config_path <- testthat::test_path(
    "testdata",
    "tasks_required_missing_only2.json"
  )
  tbl <- view_config_val_errors(suppressWarnings(
    validate_config(config_path = config_path)
  ))
  expect_snapshot(str(tbl$`_data`))

  # Two properties missing, both nested
  config_path <- testthat::test_path(
    "testdata",
    "tasks_required_missing_only2b.json"
  )
  tbl <- view_config_val_errors(suppressWarnings(
    validate_config(config_path = config_path)
  ))

  expect_snapshot(str(tbl$`_data`))
})

test_that("Report handles additional property errors successfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "tasks-addprop.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  tbl <- view_config_val_errors(out)

  expect_snapshot(str(tbl$`_data`))
})

# validate_hub_config output ----

test_that("Report works corectly on validate_hub_config output", {
  skip_if_offline()
  config_dir <- system.file(
    "testhubs/simple/",
    package = "hubUtils"
  )

  tbl <- suppressMessages(
    view_config_val_errors(
      validate_hub_config(config_dir)
    )
  )
  expect_null(tbl)

  config_dir <- testthat::test_path(
    "testdata",
    "error_hub"
  )
  tbl <- suppressWarnings(
    view_config_val_errors(
      validate_hub_config(config_dir)
    )
  )

  expect_snapshot(str(tbl$`_data`))
})

test_that("Report works correctly with invalid target-data.json", {
  # Copy v6 test hub to temp directory
  hub_path <- system.file("testhubs/v6/target_file/", package = "hubUtils")
  temp_hub <- withr::local_tempdir()
  fs::dir_copy(hub_path, temp_hub, overwrite = TRUE)

  # Overwrite valid target-data.json with invalid one
  invalid_target_data <- testthat::test_path(
    "testdata",
    "v6-target-data-invalid.json"
  )
  fs::file_copy(
    invalid_target_data,
    fs::path(temp_hub, "hub-config", "target-data.json"),
    overwrite = TRUE
  )

  # Run validation
  val <- suppressWarnings(
    validate_hub_config(
      hub_path = temp_hub
    )
  )

  # View errors - should create a table
  set.seed(1)
  tbl <- view_config_val_errors(val)

  # Verify the table is created correctly
  expect_s3_class(tbl, "gt_tbl")

  # Normalize the path attribute to avoid snapshot issues with random temp dirs
  attr(tbl$`_data`, "path") <- fs::path("<temp_dir>", "hub-config")

  expect_snapshot(str(tbl$`_data`))

  # Verify the table contains information about target-data.json errors
  expect_true(any(grepl("target-data", tbl$`_data`$fileName)))
})


# validate_hub_config output ----
test_that("Error report throws no warnings (#79)", {
  skip_if_offline()
  config_path <- testthat::test_path(
    "testdata",
    "admin-v4-errors.json"
  )
  suppressMessages(
    vals <- validate_config(
      config_path = config_path,
      config = "admin"
    )
  )
  expect_no_warning(view_config_val_errors(vals))
})

# tabulate_config_val_errors ----

test_that("tabulate_config_val_errors returns the frame view_config_val_errors renders", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "tasks-errors.json")
  validation <- suppressWarnings(
    validate_config(config_path = config_path)
  )
  error_df <- tabulate_config_val_errors(validation)

  expect_s3_class(error_df, "tbl_df")
  expect_named(
    error_df,
    c("instancePath", "schemaPath", "keyword", "message", "schema", "data")
  )
  expect_equal(attr(error_df, "path"), config_path)
  expect_equal(attr(error_df, "type"), "file")
  expect_equal(attr(error_df, "loc_cols"), c("instancePath", "schemaPath"))
  expect_equal(
    attr(error_df, "schema_version"),
    attr(validation, "schema_version")
  )
  expect_equal(attr(error_df, "schema_url"), attr(validation, "schema_url"))
  # Display transformations are applied to the frame, not by the renderer
  expect_true(all(startsWith(error_df$message, "❌")))
  expect_true(all(grepl("└", error_df$schemaPath, fixed = TRUE)))

  tbl <- view_config_val_errors(validation)
  expect_identical(tbl$`_data`, error_df)
})

test_that("tabulate_config_val_errors works on validate_hub_config output", {
  skip_if_offline()
  validation <- suppressWarnings(
    validate_hub_config(testthat::test_path("testdata", "error_hub"))
  )
  error_df <- tabulate_config_val_errors(validation)

  expect_named(
    error_df,
    c(
      "fileName",
      "instancePath",
      "schemaPath",
      "keyword",
      "message",
      "schema",
      "data"
    )
  )
  expect_equal(attr(error_df, "path"), attr(validation, "config_dir"))
  expect_equal(attr(error_df, "type"), "directory")
  expect_equal(
    attr(error_df, "loc_cols"),
    c("fileName", "instancePath", "schemaPath")
  )
  expect_identical(
    suppressWarnings(view_config_val_errors(validation))$`_data`,
    error_df
  )
})

test_that("tabulate_config_val_errors returns NULL when validation passed", {
  skip_if_offline()
  validation <- suppressMessages(
    validate_hub_config(
      system.file("testhubs/simple/", package = "hubUtils")
    )
  )
  expect_null(tabulate_config_val_errors(validation))

  validation <- validate_config(
    config_path = testthat::test_path("testdata", "v4-tasks.json")
  )
  expect_null(tabulate_config_val_errors(validation))
})
