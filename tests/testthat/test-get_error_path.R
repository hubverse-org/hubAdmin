test_that("Creating schema paths works correctly", {
  skip_if_offline()
  schema <- hubUtils::get_schema(
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v1.0.0/tasks-schema.json"
  )
  expect_equal(
    get_error_path(schema, "mean", "schema"),
    "#/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/mean"
  )
  expect_equal(
    get_error_path(schema, "origin_date", "schema"),
    "#/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/origin_date"
  )
  expect_equal(
    get_error_path(schema, "horizon", "schema", append_item_n = TRUE),
    "#/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/horizon"
  )
  # Test that custom_task_id does not return schema path with version < v2.0.0
  expect_equal(
    get_error_path(schema, "custom_task_id", "schema"),
    NA
  )
  # Test that custom_task_id returns task_ids/additionalProperties schema path with version >= v2.0.0
  schema <- hubUtils::get_schema(
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json"
  )
  expect_equal(
    get_error_path(schema, "custom_task_id", "schema"),
    "#/properties/rounds/items/properties/model_tasks/items/properties/task_ids/additionalProperties"
  )

  # Test that output_type_id schema path returned correctly with version >= v2.0.0
  expect_equal(
    get_error_path(schema, "mean/properties/output_type_id", "schema"),
    "#/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/mean/properties/output_type_id" # nolint: line_length_linter
  )
})

test_that("Creating instance paths works correctly", {
  skip_if_offline()
  schema <- hubUtils::get_schema(
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v1.0.0/tasks-schema.json"
  )
  round_i <- 1L
  model_task_i <- 2L
  target_key_i <- 1L

  # Test that output type paths created correctly
  expect_equal(
    glue::glue(get_error_path(schema, "mean", "instance")),
    "/rounds/0/model_tasks/1/output_type/mean"
  )

  # Test that std tasks ID paths created correctly, including append_item_n value
  # not affecting the final output
  expect_equal(
    glue::glue(get_error_path(schema, "origin_date", "instance")),
    "/rounds/0/model_tasks/1/task_ids/origin_date"
  )
  expect_equal(
    glue::glue(get_error_path(schema, "origin_date", "instance",
      append_item_n = TRUE
    )),
    "/rounds/0/model_tasks/1/task_ids/origin_date"
  )

  # Test that appending item n works
  expect_equal(
    glue::glue(get_error_path(schema, "rounds", "instance")),
    "/rounds"
  )
  expect_equal(
    glue::glue(get_error_path(schema, "rounds", "instance",
      append_item_n = TRUE
    )),
    "/rounds/0"
  )
  expect_equal(
    glue::glue(get_error_path(schema, "model_tasks", "instance",
      append_item_n = TRUE
    )),
    "/rounds/0/model_tasks/1"
  )
  expect_equal(
    glue::glue(get_error_path(schema, "target_metadata", "instance",
      append_item_n = TRUE
    )),
    "/rounds/0/model_tasks/1/target_metadata/0"
  )

  # Test that custom tasks ID paths created correctly, including append_item_n value
  # not affecting the final output
  expect_equal(
    glue::glue(get_error_path(schema, "custom_task_id", "instance")),
    "/rounds/0/model_tasks/1/task_ids/custom_task_id"
  )
  expect_equal(
    glue::glue(get_error_path(schema, "custom_task_id", "instance",
      append_item_n = TRUE
    )),
    "/rounds/0/model_tasks/1/task_ids/custom_task_id"
  )

  # Test that custom tasks ID paths created correctly
  expect_equal(
    glue::glue(get_error_path(schema, "target_keys", "instance")),
    "/rounds/0/model_tasks/1/target_metadata/0/target_keys"
  )
})


test_that("Paths with miltiple potential matches at different depths created correctly", {
  skip_if_offline()
  schema <- hubUtils::get_schema(
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
  )
  # Top level match returned by default.
  expect_equal(
    get_error_path(
      schema, "rounds/items/properties/derived_task_ids",
      "schema"
    ),
    "#/properties/rounds/items/properties/derived_task_ids"
  )
  # Lower level match returned when fuller path provided.
  expect_equal(
    get_error_path(
      schema, "derived_task_ids",
      "schema"
    ),
    "#/properties/derived_task_ids"
  )
  # Top level match returned by default. `round_i` ignored
  expect_equal(
    glue::glue_data(
      list(round_i = 1L),
      get_error_path(
        schema,
        "derived_task_ids",
        "instance"
      )
    ),
    "/derived_task_ids"
  )
  # Lower level match returned when fuller path provided. `round_i` interpolated
  expect_equal(
    glue::glue_data(
      list(round_i = 1L),
      get_error_path(
        schema,
        "rounds/items/properties/derived_task_ids",
        "instance"
      )
    ),
    "/rounds/0/derived_task_ids"
  )
})


test_that("Instance path index interpolation overriding works", {
  skip_if_offline()
  schema <- hubUtils::get_schema(
    "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
  )
  model_task_i <- 1L
  round_i <- 2L
  # Return the instance path to the origin date task ID in the second modeling task
  # Create a non-interpolated path
  expect_equal(
    get_error_path(schema, "origin_date", "instance"),
    "/rounds/{round_i - 1}/model_tasks/{model_task_i - 1}/task_ids/origin_date"
  )

  # Create interpolated instance path using caller environment variables
  expect_equal(
    glue::glue(get_error_path(schema, "origin_date", "instance")),
    "/rounds/1/model_tasks/0/task_ids/origin_date"
  )

  # Create interoplated instance path to the second modeling task,
  # overriding the `model_task_i` value in the caller environment
  glue::glue_data(
    list(model_task_i = 2L),
    get_error_path(schema, "origin_date", "instance")
  )
})
