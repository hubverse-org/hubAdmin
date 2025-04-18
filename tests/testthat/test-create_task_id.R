test_that("create_task_id works correctly", {
  skip_if_offline()
  expect_snapshot(
    create_task_id("horizon",
      required = 1L,
      optional = 2:4
    ) |> verify_latest_schema_version()
  )

  expect_snapshot(
    create_task_id("origin_date",
      required = NULL,
      optional = c(
        "2023-01-02",
        "2023-01-09",
        "2023-01-16"
      )
    ) |> verify_latest_schema_version()
  )

  expect_snapshot(
    create_task_id("scenario_id",
      required = NULL,
      optional = c(
        "A-2021-03-28",
        "B-2021-03-28"
      )
    ) |> verify_latest_schema_version()
  )

  expect_snapshot(
    create_task_id("scenario_id",
      required = NULL,
      optional = c(
        1L,
        2L
      )
    ) |> verify_latest_schema_version()
  )
  expect_snapshot(
    create_task_id("horizon",
      required = NULL,
      optional = NULL
    ) |> verify_latest_schema_version()
  )
})


test_that("create_task_id errors correctly", {
  skip_if_offline()
  expect_snapshot(
    create_task_id("origin_date",
      required = NULL,
      optional = c("01/20/2023")
    ),
    error = TRUE
  )
  expect_snapshot(
    create_task_id("scenario_id",
      required = NULL,
      optional = c(
        1L,
        1L
      )
    ),
    error = TRUE
  )
  expect_snapshot(
    create_task_id("horizon",
      required = c(TRUE, FALSE),
      optional = NULL
    ),
    error = TRUE
  )
})

test_that("create_task_id name matching works correctly", {
  skip_if_offline()
  local_mocked_bindings(
    askYesNo = function(...) TRUE
  )
  expect_equal(
    names(
      suppressMessages(
        create_task_id("scenario_ids",
          required = NULL,
          optional = c(
            "A-2021-03-28",
            "B-2021-03-28"
          )
        )
      )
    ),
    "scenario_id"
  )
  local_mocked_bindings(
    askYesNo = function(...) FALSE
  )
  expect_equal(
    match_element_name("scenario_ids", "scenario_id", "task_id"),
    "scenario_ids"
  )

  local_mocked_bindings(
    askYesNo = function(...) NA
  )
  expect_error(match_element_name("scenario_ids", "scenario_id", "task_id"))
})

test_that("schema version option works for create_task_id", {
  skip_if_offline()
  version_default <- create_task_id("horizon",
    required = 1L,
    optional = 2:4
  ) |> verify_latest_schema_version()

  arg_version <- create_task_id("horizon",
    required = 1L,
    optional = 2:4,
    schema_version = "v3.0.1",
    branch = "main"
  )

  withr::with_options(
    list(
      hubAdmin.schema_version = "v3.0.1",
      hubAdmin.branch = "main"
    ),
    {
      opt_version <- create_task_id("horizon",
        required = 1L,
        optional = 2:4
      )
    }
  )
  expect_equal(arg_version, opt_version)
  expect_snapshot(waldo::compare(opt_version, version_default))
})
