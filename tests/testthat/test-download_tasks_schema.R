test_that("download_tasks_schema defaults work", {
  skip_if_offline()
  expect_snapshot(
    str(download_tasks_schema(), 4L)
  )
})

test_that("download_tasks_schema json output work", {
  skip_if_offline()
  expect_snapshot(
    download_tasks_schema(format = "json")
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
