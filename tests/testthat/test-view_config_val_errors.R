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

  round_path <- "**rounds** \n └**1**"
  mt_path <- paste(round_path, "\n └─**model_tasks** \n └──**1**")
  round_schema_path <- "properties \n └**rounds** \n └─items \n └──properties"
  mt_schema_path <- paste(
    round_schema_path,
    "\n └───**model_tasks** \n └────items \n └─────properties"
  )
  expect_error_tbl(
    tbl$`_data`,
    tibble::tibble(
      instancePath = c(
        paste(
          mt_path,
          "\n └───**task_ids** \n └────**target** \n └─────**required**"
        ),
        paste(
          mt_path,
          "\n └───**output_type** \n └────**mean** \n └─────**type_id**"
        ),
        paste(round_path, "\n └─**submissions_due**")
      ),
      schemaPath = c(
        paste(
          mt_schema_path,
          "\n └──────**task_ids** \n └───────properties \n └────────**target**",
          "\n └─────────properties \n └──────────**required**",
          "\n └───────────**type**"
        ),
        paste(
          mt_schema_path,
          "\n └──────**output_type** \n └───────properties \n └────────**mean**",
          "\n └─────────properties \n └──────────**type_id**",
          "\n └───────────**oneOf**"
        ),
        paste(
          round_schema_path,
          "\n └───**submissions_due** \n └────**oneOf**"
        )
      ),
      keyword = c("type", "oneOf", "oneOf"),
      message = c(
        "❌ must be array,null",
        "❌ must match exactly one schema in oneOf",
        "❌ must match exactly one schema in oneOf"
      ),
      data = c(
        "wk inc flu hosp",
        "required: NA, optional: NA",
        "start: -6, end: 1"
      )
    )
  )
  expect_equal(tbl$`_data`$schema[1], "array, null")
  expect_oneof_schema(tbl$`_data`$schema[2], c("required", "optional"))
  expect_oneof_schema(
    tbl$`_data`$schema[3],
    c("relative_to", "start", "end")
  )
  expect_error_tbl_attrs(
    tbl$`_data`,
    path = config_path,
    schema_version = "v0.0.0.9",
    schema_url = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v0.0.0.9/tasks-schema.json"
  )
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
  tbl <- view_config_val_errors(validation)
  expect_error_tbl(
    tbl$`_data`,
    tibble::tibble(
      instancePath = c("**file_format** \n └**1**", "**timezone**"),
      schemaPath = c(
        "properties \n └**file_format** \n └─items \n └──**enum**",
        "properties \n └**timezone** \n └─**type**"
      ),
      keyword = c("enum", "type"),
      schema = c("csv, parquet, arrow", "string"),
      data = c("csvs", "US/Eastern")
    )
  )
})

test_that("Data column handled correctly when required property missing", {
  skip_if_offline()
  view_errors <- function(file) {
    view_config_val_errors(suppressWarnings(
      validate_config(config_path = testthat::test_path("testdata", file))
    ))
  }

  # One nested property missing, one type error
  tbl <- view_errors("tasks_required_missing.json")
  expect_error_tbl(
    tbl$`_data`,
    tibble::tibble(
      keyword = c("required", "type"),
      data = c("target_metadata", "0")
    )
  )

  # Only a single property missing
  tbl <- view_errors("tasks_required_missing_only.json")
  expect_error_tbl(
    tbl$`_data`,
    tibble::tibble(keyword = "required", data = "target_metadata")
  )

  # Two properties missing, only one nested
  tbl <- view_errors("tasks_required_missing_only2.json")
  expect_error_tbl(
    tbl$`_data`,
    tibble::tibble(
      keyword = "required",
      data = c("round_id_from_variable", "target_metadata")
    )
  )

  # Two properties missing, both nested
  tbl <- view_errors("tasks_required_missing_only2b.json")
  expect_error_tbl(
    tbl$`_data`,
    tibble::tibble(
      keyword = "required",
      data = c("output_type", "target_metadata")
    )
  )
})

test_that("Report handles additional property errors successfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "tasks-addprop.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  tbl <- view_config_val_errors(out)

  expect_error_tbl(
    tbl$`_data`,
    tibble::tibble(
      keyword = "additionalProperties",
      message = "❌ must NOT have additional properties",
      schema = "FALSE",
      data = "target_metadata"
    )
  )
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

  expect_error_tbl(
    tbl$`_data`,
    tibble::tibble(
      fileName = c(rep("tasks.json", 4), "model-metadata-schema.json"),
      keyword = c("required", "type", "oneOf", "oneOf", "required")
    )
  )
  expect_error_tbl_attrs(
    tbl$`_data`,
    path = fs::path(config_dir, "hub-config"),
    schema_version = "v2.0.0",
    schema_url = "https://github.com/hubverse-org/schemas/tree/main/v2.0.0",
    type = "directory"
  )
})

test_that("Report works correctly with invalid target-data.json", {
  skip_if_offline()
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
  tbl <- view_config_val_errors(val)

  # Verify the table is created correctly
  expect_s3_class(tbl, "gt_tbl")

  expect_error_tbl(
    tbl$`_data`,
    tibble::tibble(
      fileName = "target-data.json",
      keyword = c(
        "required",
        "additionalProperties",
        "type",
        "additionalProperties",
        "enum",
        "type",
        "additionalProperties",
        "type",
        "type"
      ),
      data = c(
        "date_col",
        "extra_top_level",
        "location",
        "unexpected_property",
        "text",
        "true",
        "notes",
        "false",
        "123"
      )
    )
  )
  expect_error_tbl_attrs(
    tbl$`_data`,
    path = fs::path(temp_hub, "hub-config"),
    schema_version = "v6.0.0",
    schema_url = "https://github.com/hubverse-org/schemas/tree/main/v6.0.0",
    type = "directory"
  )
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
  # Attributes are plain strings whatever class the validator gave them
  expect_identical(class(attr(error_df, "schema_url")), "character")
  # Display transformations are applied to the frame, not by the renderer
  expect_true(all(startsWith(error_df$message, "❌")))
  expect_true(all(grepl("└", error_df$schemaPath, fixed = TRUE)))

  tbl <- view_config_val_errors(validation)
  expect_identical(tbl$`_data`, error_df)
})

test_that("only the gt renderer escapes `$` in a pattern error", {
  skip_if_offline()
  validation <- suppressWarnings(
    validate_config(
      config_path = testthat::test_path(
        "testdata",
        "v5.0.0-tasks-fail-round-id-pattern.json"
      )
    )
  )
  error_df <- tabulate_config_val_errors(validation)
  expect_match(error_df$schema, "$", fixed = TRUE)
  expect_no_match(error_df$schema, "&#36;", fixed = TRUE)
  expect_match(
    view_config_val_errors(validation)$`_data`$schema,
    "&#36;",
    fixed = TRUE
  )
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
  expect_equal(
    attr(error_df, "path"),
    as.character(attr(validation, "config_dir"))
  )
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
