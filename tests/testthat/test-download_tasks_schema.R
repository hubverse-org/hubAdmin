test_that("download_tasks_schema defaults work", {
  skip_if_offline()
  latest_schema <- download_tasks_schema()
  schema_id_version <- latest_schema$`$id` |>
    hubUtils::extract_schema_version()
  expect_equal(schema_id_version, hubUtils::get_schema_version_latest())

  expect_equal(
    names(latest_schema),
    c(
      "$schema", "$id", "title", "description", "type", "properties",
      "required", "additionalProperties"
    )
  )
})

test_that("download_tasks_schema json output work", {
  skip_if_offline()
  expect_snapshot(
    download_tasks_schema(
      schema_version = "v4.0.0",
      format = "json"
    )
  )
})

test_that("download_tasks_schema schema version work", {
  skip_if_offline()
  expect_snapshot(
    str(download_tasks_schema(schema_version = "v2.0.1"), 4L)
  )
})

test_that("download_tasks_schema schema version work", {
  skip_if_offline()
  expect_error(
    download_tasks_schema(
      schema_version = "v1.0.1"
    ),
    regexp = "is not a valid schema version. Current valid schema version is"
  )
})

test_that("schema version option works for download_tasks_schema", {
  skip_if_offline()
  version_default <- download_tasks_schema()
  version_default$`$id` <- "latest"

  arg_version <- download_tasks_schema(
    schema_version = "v3.0.1",
    branch = "main"
  )

  withr::with_options(
    list(
      hubAdmin.schema_version = "v3.0.1",
      hubAdmin.branch = "main"
    ),
    {
      opt_version <- download_tasks_schema()
    }
  )
  expect_equal(arg_version, opt_version)
  expect_snapshot(waldo::compare(opt_version$`$id`, version_default$`$id`))
})
