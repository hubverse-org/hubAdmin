rounds <- create_rounds(
  create_round(
    round_id_from_variable = TRUE,
    round_id = "origin_date",
    model_tasks = create_model_tasks(
      create_model_task(
        task_ids = create_task_ids(
          create_task_id("origin_date",
            required = NULL,
            optional = c(
              "2023-01-02",
              "2023-01-09",
              "2023-01-16"
            )
          ),
          create_task_id("location",
            required = "US",
            optional = c("01", "02", "04", "05", "06")
          ),
          create_task_id("horizon",
            required = 1L,
            optional = 2:4
          )
        ),
        output_type = create_output_type(
          create_output_type_mean(
            is_required = TRUE,
            value_type = "double",
            value_minimum = 0L
          )
        ),
        target_metadata = create_target_metadata(
          create_target_metadata_item(
            target_id = "inc hosp",
            target_name = "Weekly incident influenza hospitalizations",
            target_units = "rate per 100,000 population",
            target_keys = NULL,
            target_type = "discrete",
            is_step_ahead = TRUE,
            time_unit = "week"
          )
        )
      )
    ),
    submissions_due = list(
      relative_to = "origin_date",
      start = -4L,
      end = 2L
    )
  )
)

test_that("create_config functions work correctly", {
  expect_snapshot(
    create_config(rounds)
  )
})


test_that("create_config functions error correctly", {
  expect_snapshot(
    create_config(list(a = 10)),
    error = TRUE
  )
})

test_that("create_config handles output_type_id_datatype correctly ", {
  test_rounds <- create_test_rounds()
  expect_null(
    create_config(test_rounds)$output_type_id_datatype
  )
  expect_snapshot(
    create_config(test_rounds, output_type_id_datatype = "character")
  )

  # Use older schema
  test_rounds_old <- test_rounds
  attr(test_rounds_old, "schema_id") <- "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json" # nolint line_length_linter
  expect_null(
    suppressMessages(
      create_config(test_rounds_old,
        output_type_id_datatype = "character"
      )$output_type_id_datatype
    )
  )
  expect_snapshot(
    create_config(test_rounds_old, output_type_id_datatype = "character")
  )
})
