test_that("check_properties_scalar works", {
  properties <- create_example_properties()
  schema <- download_tasks_schema("v3.0.1")
  round_schema <- get_schema_round(schema)

  expect_no_condition(check_properties_scalar(properties, round_schema))

  # Test that the round_id is character, not integer
  properties$round_id <- 1L
  expect_snapshot(
    check_properties_scalar(properties, round_schema),
    error = TRUE
  )

  # Test that the round_id has length 1 not more
  properties$round_id <- c("origin_date", "location")
  expect_snapshot(
    check_properties_scalar(properties, round_schema),
    error = TRUE
  )
})

test_that("check_properties_array works", {
    properties <- create_example_properties()
    schema <- download_tasks_schema("v3.0.1")
    round_schema <- get_schema_round(schema)

    expect_no_condition(check_properties_array(properties, round_schema))

    # Test that the file_format is character, not integer
    properties$file_format <- 1L
    expect_snapshot(
        check_properties_array(properties, round_schema),
        error = TRUE
    )
})
