test_that("schema autobox boxes length 1L vectors correctly", {
  skip_if_offline()
  config <- create_config(
    create_rounds(
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
  )

  # Compare list representations of the config and the schema autoboxed config
  expect_snapshot(waldo::compare(config, schema_autobox(config)))

  # Compare JSON representations of the config and the schema autoboxed config
  expect_snapshot(
    schema_autobox(config) |>
      jsonlite::toJSON(
        auto_unbox = TRUE, na = "string",
        null = "null", pretty = TRUE
      )
  )
  expect_snapshot(
    waldo::compare(
      config$rounds[[1]]$model_tasks[[1]]$task_ids$location$required |>
        jsonlite::toJSON(
          auto_unbox = TRUE, na = "string",
          null = "null", pretty = TRUE
        ),
      schema_autobox(config)$rounds[[1]]$model_tasks[[1]]$task_ids$location$required |>
        jsonlite::toJSON(
          auto_unbox = TRUE, na = "string",
          null = "null", pretty = TRUE
        )
    )
  )

  expect_snapshot(
    waldo::compare(
      config$rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required |>
        jsonlite::toJSON(
          auto_unbox = TRUE, na = "string",
          null = "null", pretty = TRUE
        ),
      schema_autobox(config)$rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required |>
        jsonlite::toJSON(
          auto_unbox = TRUE, na = "string",
          null = "null", pretty = TRUE
        )
    )
  )

  expect_snapshot(
    waldo::compare(
      config$rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required |>
        jsonlite::toJSON(
          auto_unbox = TRUE, na = "string",
          null = "null", pretty = TRUE
        ),
      schema_autobox(config)$rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required |>
        jsonlite::toJSON(
          auto_unbox = TRUE, na = "string",
          null = "null", pretty = TRUE
        )
    )
  )
})

test_that("schema autobox errors correctly", {
  # Test that schema_autobox errors when the config is not a <config> class object
  expect_error(schema_autobox(1))
  expect_error(schema_autobox(list(rounds = list(a = 1))))
})

test_that("get_array_paths identifies potential arrays correctly", {
  skip_if_offline()
  schema <- download_tasks_schema("v3.0.1")
  expect_snapshot(
    get_array_paths(schema)
  )
})
