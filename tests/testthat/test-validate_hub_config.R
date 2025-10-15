test_that("correct hub validates successfully", {
  skip_if_offline()
  expect_true(
    validate_hub_config(
      hub_path = system.file(
        "testhubs/simple/",
        package = "hubUtils"
      )
    ) %>%
      unlist() %>%
      all() %>%
      suppressMessages()
  )
})

test_that("Hub with config errors fails validation", {
  skip_if_offline()
  val <- validate_hub_config(
    hub_path = testthat::test_path(
      "testdata",
      "error_hub"
    )
  ) %>%
    suppressWarnings()

  expect_false(all(unlist(val)))

  expect_equal(
    attr(val, "config_dir"),
    fs::path("testdata/error_hub/hub-config")
  )

  expect_equal(
    attr(val, "schema_url"),
    "https://github.com/hubverse-org/schemas/tree/main/v2.0.0"
  )

  expect_equal(
    attr(val, "schema_version"),
    "v2.0.0"
  )
})

test_that("Target data files handled appropriately", {
  hub_path <- system.file("testhubs/v6/target_file/", package = "hubUtils")
  expect_message(
    hub_val <- validate_hub_config(
      hub_path = hub_path
    ),
    regexp = "target-data.json" # Ensure target-data.json is mentioned in message.
  )
  expect_s3_class(hub_val, "hubval")
  expect_named(
    hub_val,
    c("tasks", "admin", "target-data", "model-metadata-schema")
  )
  expect_true(all(unlist(hub_val)))
})

test_that("Hub with invalid target-data.json fails validation", {
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

  # Run validation and expect warnings about errors
  expect_warning(
    val <- validate_hub_config(
      hub_path = temp_hub
    ),
    regexp = "target-data.json"
  )

  # Verify overall validation failed
  expect_false(all(unlist(val)))

  # Verify that target-data validation specifically failed
  expect_false(val[["target-data"]])

  # Verify error attributes are present
  expect_true(nrow(attr(val[["target-data"]], "errors")) > 0)

  # Verify the validation object has expected structure
  expect_s3_class(val, "hubval")
  expect_named(
    val,
    c("tasks", "admin", "target-data", "model-metadata-schema")
  )
})
