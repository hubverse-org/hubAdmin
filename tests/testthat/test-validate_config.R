test_that("Config validated successfully", {
  skip_if_offline()
  expect_true(suppressMessages(validate_config(
    hub_path = system.file(
      "testhubs/simple/",
      package = "hubUtils"
    ),
    config = "tasks"
  )))
  # Test deprecated version
  expect_warning(suppressMessages(validate_config(
    hub_path = system.file(
      "testhubs/simple-dprc/",
      package = "hubUtils"
    ),
    config = "tasks"
  )))
  expect_true(suppressWarnings(suppressMessages(validate_config(
    hub_path = system.file(
      "testhubs/simple-dprc/",
      package = "hubUtils"
    ),
    config = "tasks"
  ))))
})


test_that("Config for samples handled succesfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "tasks-samples-pass.json")
  out <- suppressMessages(validate_config(
    config_path = config_path,
    schema_version = "v3.0.1"
  ))
  expect_snapshot(out)
  expect_true(out)
})
test_that("Missing files returns an invalid config with an immediate message", {
  skip_if_offline()
  tmp <- withr::local_tempdir()
  suppressMessages({
    expect_message(out <- validate_config(hub_path = tmp), "File does not exist")
  })
  expect_false(unclass(out))
})
test_that("Config for samples fail correctly", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "tasks-samples-error-range.json")
  out <- suppressWarnings(validate_config(
    config_path = config_path,
    schema_version = "v3.0.1"
  ))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)

  config_path <- testthat::test_path("testdata", "tasks-samples-error-task-ids.json")
  out <- suppressWarnings(validate_config(
    config_path = config_path,
    schema_version = "v3.0.1"
  ))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})



test_that("Config errors detected successfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "tasks-errors.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})


test_that("Dynamic config errors detected successfully by custom R validation", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "tasks-errors-rval.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})

test_that("Reserved hub variable task id name detected correctly", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "tasks-errors-rval-reserved.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})

test_that("NULL target keys validated successfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "tasks_null_rval.json")
  out <- suppressMessages(validate_config(config_path = config_path))
  expect_true(out)
})


test_that("Bad schema_version URL errors successfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "schema_version-errors.json")
  expect_error(validate_config(config_path = config_path))
})


test_that("Additional properties error successfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "tasks-addprop.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})


test_that("Duplicate values in individual array error successfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "dup-in-array.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})

test_that("Duplicate values across property error successfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "dup-in-property.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})

test_that("Inconsistent round ID variables across model tasks error successfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "round-id-inconsistent.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)

  config_path <- testthat::test_path("testdata", "round-id-inconsistent2.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})


test_that("Duplicate round ID values across rounds error successfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "dup-in-round-id.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})

test_that("All null task IDs error successfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "both_null_tasks_all.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})

test_that("Old orgname config validates successfully", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "task-old-orgname.json")
  out <- suppressMessages(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_true(out)
})

test_that("target keys error if arrays passed", {
  skip_if_offline()
  config_path <- testthat::test_path(
    "testdata",
    "tasks-target-key-array-v4.json"
  )
  out_v4 <- suppressMessages(validate_config(
    config_path = config_path,
    schema_version = "v4.0.0"
  ))
  expect_snapshot(out_v4)
  # latest schema should throw error with respect to target key type.
  expect_snapshot(attr(out_v4, "errors"))
  expect_false(out_v4)

  out_v3 <- suppressMessages(validate_config(
    config_path = config_path,
    schema_version = "v3.0.0"
  ))
  # v3.0.0 schema should throw error about missing optional property in pmf
  # but not about target keys.
  expect_snapshot(attr(out_v3, "errors"))
  expect_false(out_v3)
})

test_that("v4 validation works", {
  skip_if_offline()
  config_path <- testthat::test_path(
    "testdata",
    "v4-tasks.json"
  )
  expect_true(
    suppressMessages(
      validate_config(
        config_path = config_path
      )
    )
  )
  config_path <- testthat::test_path("testdata", "v4-tasks-fail.json")
  expect_false(
    suppressMessages(
      v4_fail <- validate_config(config_path = config_path)
    )
  )
  expect_snapshot(extract_error_tbl_cols(v4_fail))

  # Ensure dynamic validation works and catches invalid derived task IDs at config
  # and round level.
  config_path <- testthat::test_path("testdata", "v4-tasks-fail-dynamic.json")
  expect_false(
    suppressMessages(
      v4_fail_dynamic <- validate_config(config_path = config_path)
    )
  )
  expect_snapshot(
    extract_error_tbl_cols(v4_fail_dynamic, c(
      "message", "data"
    ))
  )
  expect_equal(
    extract_error_tbl_cols(v4_fail_dynamic, c("instancePath"))$instancePath,
    structure(
      c(
        "/rounds/0/derived_task_ids", "/rounds/0/derived_task_ids",
        "/derived_task_ids", "/derived_task_ids"
      ),
      class = c("glue", "character")
    )
  )
})


test_that("v5.0.0 target keys with 2 properties throws error", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "v5.0.0-tasks-2-target_keys.json")
  out <- suppressMessages(
    validate_config(
      config_path = config_path
    )
  )
  expect_false(out)

  expect_equal(
    unique(attr(out, "errors")$message),
    "must NOT have more than 1 items"
  )
  expect_equal(nrow(attr(out, "errors")), 2L)
})

test_that("v5.0.0 target keys with NULL properties passes", {
  # Ensure NULL target keys are still allowed.
  config_path <- testthat::test_path("testdata", "v5.0.0-tasks-null-target_keys.json")
  out <- suppressMessages(
    validate_config(
      config_path = config_path
    )
  )
  expect_true(out)
})

test_that("v5.0.0 round_id pattern validation works", {
  skip_if_offline()
  schema <- download_tasks_schema("v5.0.0")

  # Test that regex pattern matching for round_id properties in jsonvalidate
  # identifies expected errors (when round_id_from_variable: false).
  expect_false(
    res_round_id <- suppressMessages(
      validate_config(
        config_path = testthat::test_path(
          "testdata",
          "v5.0.0-tasks-fail-round-id-pattern.json"
        )
      )
    )
  )
  errors_id <- attr(res_round_id, "errors")
  expect_equal(nrow(errors_id), 2L)
  expect_equal(
    errors_id$message,
    c(
      "must match pattern \"^([0-9]{4}-[0-9]{2}-[0-9]{2})$|^[A-Za-z0-9_]+$\"",
      "must match \"then\" schema"
    )
  )
  expect_equal(
    errors_id$schema[[1]],
    "^([0-9]{4}-[0-9]{2}-[0-9]{2})$|^[A-Za-z0-9_]+$"
  )
  expect_equal(errors_id$data[[1]], "invalid-round-id")

  # Test that dynamic regex pattern matching for round_id variable values
  # identifies expected errors (when round_id_from_variable: true).
  expect_false(
    res_round_id_val <- suppressMessages(
      validate_config(
        config_path = testthat::test_path(
          "testdata",
          "v5.0.0-tasks-fail-round-id-val-pattern.json"
        )
      )
    )
  )

  errors_vals <- attr(res_round_id_val, "errors")
  expect_equal(nrow(errors_vals), 2L)
  expect_equal(
    unique(errors_vals$message),
    structure(
      "round_id variable 'round_id_var' values must be either ISO formatted\ndates or alphanumeric characters separated by '_'.", # nolint: line_length_linter
      class = c(
        "glue",
        "character"
      )
    )
  )
  expect_equal(
    unique(errors_vals$schema),
    "^([0-9]{4}-[0-9]{2}-[0-9]{2})$|^[A-Za-z0-9_]+$"
  )
  expect_equal(
    errors_vals$data,
    structure(c(
      "invalid values: 'invalid-round-id-in-var-req'",
      "invalid values: 'invalid-round-id-in-var-opt1' and 'invalid-round-id-in-var-opt2'"
    ), class = c("glue", "character"))
  )
})

test_that("Duplicate property names are flagged during validation", {
  val <- validate_config(config_path = test_path(
    "testdata",
    "v5.0.0-dup-prop-names.json"
  ))
  expect_false(val)
  errors_vals <- attr(val, "errors")
  expect_equal(nrow(errors_vals), 6L)
  expect_equal(
    unique(errors_vals$instancePath),
    c(
      "/rounds/0/model_tasks/0/target_metadata/0",
      "/rounds/0/model_tasks/0",
      "/rounds/0/model_tasks/0/task_ids",
      "/rounds/0/model_tasks/0/output_type",
      "/rounds/0",
      "/"
    )
  )
  expect_equal(
    unique(errors_vals$schemaPath),
    c(
      "#/properties/rounds/items/properties/model_tasks/items/properties/target_metadata",
      "#/properties/rounds/items/properties/model_tasks",
      "#/properties/rounds/items/properties/model_tasks/items/properties/task_ids",
      "#/properties/rounds/items/properties/model_tasks/items/properties/output_type",
      "#/properties/rounds",
      "#/"
    )
  )
  expect_equal(
    unique(errors_vals$keyword),
    c(
      "target_metadata uniqueNames", "model_task uniqueNames", "task_ids uniqueNames",
      "output_type uniqueNames", "round uniqueNames",
      "config uniqueNames"
    )
  )
  expect_equal(
    unique(errors_vals$message),
    c(
      "target_metadata objects must NOT contain\nproperties with duplicate names",
      "model_task objects must NOT contain\nproperties with duplicate names",
      "task_ids objects must NOT contain\nproperties with duplicate names",
      "output_type objects must NOT contain\nproperties with duplicate names",
      "round objects must NOT contain\nproperties with duplicate names",
      "config objects must NOT contain\nproperties with duplicate names"
    )
  )
  expect_equal(
    unique(errors_vals$data),
    c(
      "duplicate names: target_id", "duplicate names: target_metadata",
      "duplicate names: horizon", "duplicate names: quantile",
      "duplicate names: round_id", "duplicate names: schema_version"
    )
  )
})
