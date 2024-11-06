test_that("append_round works", {
  skip_if_offline()
  config <- hubUtils::read_config_file(
    config_path = test_path("testdata/tasks-append.json")
  )
  round <- create_new_round()

  # Adding one round works
  append_round(config, round)

  # Adding two round works
  add_2_rounds <- append_round(
    config = config, round,
    create_new_round("2024-09-25")
  )

  expect_length(add_2_rounds$rounds, 3)
  expect_s3_class(add_2_rounds, c("config", "list"))
})

test_that("append_round fails with duplicate round_ids", {
  skip_if_offline()
  config <- hubUtils::read_config_file(
    config_path = test_path("testdata/tasks-append.json")
  )

  expect_snapshot(
    append_round(config = config, create_new_round("2024-09-11")),
    error = TRUE
  )
})

test_that("append_round fails with schema_id mismatch", {
  skip_if_offline()
  config <- hubUtils::read_config_file(
    config_path = test_path("testdata/tasks-append.json")
  )
  round_with_mismatched_schema_id <- create_new_round()
  attr(round_with_mismatched_schema_id, "schema_id") <-
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json" # nolint: line_length_linter

  # Mismatch between config and round schema_id
  expect_snapshot(
    append_round(config = config, round_with_mismatched_schema_id),
    error = TRUE
  )

  # Mismatch between round schema_ids
  round <- create_new_round("2024-09-25")
  expect_snapshot(
    append_round(
      config,
      round_with_mismatched_schema_id,
      round
    ),
    error = TRUE
  )

  # Mismatch between config and consistent schema_id across multiple new rounds
  round_with_mismatched_schema_id_2 <- create_new_round("2024-09-25")
  attr(round_with_mismatched_schema_id_2, "schema_id") <-
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json" # nolint: line_length_linter
  expect_snapshot(
    append_round(
      config,
      round_with_mismatched_schema_id,
      round_with_mismatched_schema_id_2
    ),
    error = TRUE
  )
})
