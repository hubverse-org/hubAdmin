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
  expect_false(out)
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
  # TODO: remove branch argument when v4.0.0 is released.
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

test_that("v4.0.1 round_id pattern validation works", {
  skip_if_offline()
  # TODO: remove branch argument when v4.0.1 is released.
  schema <- download_tasks_schema("v4.0.1", branch = "br-v4.0.1")

  # Test that regex pattern matching for round_id properties in jsonvalidate
  # identifies expected errors (when round_id_from_variable: false).
  expect_false(
    res_round_id <- suppressMessages(
      validate_config(
        config_path = testthat::test_path(
          "testdata",
          "v4.0.1-tasks-fail-round-id-pattern.json"
        ),
        branch = "br-v4.0.1"
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
          "v4.0.1-tasks-fail-round-id-val-pattern.json"
        ),
        branch = "br-v4.0.1"
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
