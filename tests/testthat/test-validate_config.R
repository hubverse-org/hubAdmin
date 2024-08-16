test_that("Config validated successfully", {
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
  config_path <- testthat::test_path("testdata", "tasks-samples-pass.json")
  out <- suppressMessages(validate_config(config_path = config_path,
                                          schema_version = "latest"))
  expect_snapshot(out)
  expect_true(out)
})
test_that("Missing files returns an invalid config with an immediate message", {
  tmp <- withr::local_tempdir()
  suppressMessages({
    expect_message(out <- validate_config(hub_path = tmp), "File does not exist")
  })
  expect_false(out)
})
test_that("Config for samples fail correctly", {
  config_path <- testthat::test_path("testdata", "tasks-samples-error-range.json")
  out <- suppressWarnings(validate_config(config_path = config_path,
                                          schema_version = "latest"))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)

  config_path <- testthat::test_path("testdata", "tasks-samples-error-task-ids.json")
  out <- suppressWarnings(validate_config(config_path = config_path,
                                          schema_version = "latest"))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})



test_that("Config errors detected successfully", {
  config_path <- testthat::test_path("testdata", "tasks-errors.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})



test_that("Dynamic config errors detected successfully by custom R validation", {
  config_path <- testthat::test_path("testdata", "tasks-errors-rval.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})

test_that("Reserved hub variable task id name detected correctly", {
  config_path <- testthat::test_path("testdata", "tasks-errors-rval-reserved.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})

test_that("NULL target keys validated successfully", {
  config_path <- testthat::test_path("testdata", "tasks_null_rval.json")
  out <- suppressMessages(validate_config(config_path = config_path))
  expect_true(out)
})


test_that("Bad schema_version URL errors successfully", {
  config_path <- testthat::test_path("testdata", "schema_version-errors.json")
  expect_error(validate_config(config_path = config_path))
})


test_that("Additional properties error successfully", {
  config_path <- testthat::test_path("testdata", "tasks-addprop.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})


test_that("Duplicate values in individual array error successfully", {
  config_path <- testthat::test_path("testdata", "dup-in-array.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})

test_that("Duplicate values across property error successfully", {
  config_path <- testthat::test_path("testdata", "dup-in-property.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})

test_that("Inconsistent round ID variables across model tasks error successfully", {
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
  config_path <- testthat::test_path("testdata", "dup-in-round-id.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})

test_that("All null task IDs error successfully", {
  config_path <- testthat::test_path("testdata", "both_null_tasks_all.json")
  out <- suppressWarnings(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_false(out)
})

test_that("Old orgname config validates successfully", {
  config_path <- testthat::test_path("testdata", "task-old-orgname.json")
  out <- suppressMessages(validate_config(config_path = config_path))
  expect_snapshot(out)
  expect_snapshot(attr(out, "errors"))
  expect_true(out)
})
