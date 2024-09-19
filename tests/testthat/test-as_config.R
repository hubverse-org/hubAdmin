test_that("as_config succeeds with valid config", {
  skip_if_offline()
  config_tasks <- hubUtils::read_config_file(
    config_path = test_path("testdata/tasks-append.json")
  )
  expect_snapshot(as_config(config_tasks))
})

test_that("invalid schema_id flagged", {
  skip_if_offline()
  config_tasks <- hubUtils::read_config_file(
    config_path = test_path("testdata/tasks-append.json")
  )
  # URL prefix incorrect
  config_tasks$schema_version <- "random_schema_id"
  expect_snapshot(as_config(config_tasks), error = TRUE)

  # Version number invalid
  config_tasks$schema_version <- "https://raw.githubusercontent.com/hubverse-org/schemas/main/v0.0.0/tasks-schema.json" # nolint: line_length_linter
  expect_error(
    as_config(config_tasks),
    regexp = "is not a valid schema version. Current valid schema version is:"
  )
})

test_that("invalid config_tasks properties flagged", {
  skip_if_offline()
  config_tasks <- hubUtils::read_config_file(
    config_path = test_path("testdata/tasks-append.json")
  )
  config_tasks$random_property <- "random_value"

  expect_snapshot(as_config(config_tasks), error = TRUE)
})
