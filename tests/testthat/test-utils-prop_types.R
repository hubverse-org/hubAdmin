test_that("prop_type_scalar works at top level", {
  skip_if_offline()
  schema <- download_tasks_schema("v3.0.1")

  expect_length(prop_type_scalar(schema), 0L)
  # Check that inverse works
  expect_equal(
    prop_type_scalar(schema, invert = TRUE),
    c(
      "$schema", "$id", "title", "description", "type", "properties",
      "required", "additionalProperties"
    )
  )

  schema_props <- schema$properties
  expect_equal(
    prop_type_scalar(schema_props),
    c("schema_version", "output_type_id_datatype")
  )
  # Check that inverse works
  expect_equal(prop_type_scalar(schema_props, invert = TRUE), "rounds")

  # Check that default + inverse calls return all schema property names
  combined_nms <- c(
    prop_type_scalar(schema_props),
    prop_type_scalar(schema_props, invert = TRUE)
  )
  expect_true(all(combined_nms %in% names(schema_props)))
})

test_that("prop_type_scalar works at round level", {
  skip_if_offline()
  schema <- download_tasks_schema("v3.0.1")
  round_schema <- get_schema_round(schema)
  expect_equal(
    prop_type_scalar(round_schema),
    c("round_id_from_variable", "round_id", "round_name", "last_data_date")
  )

  # Check that inverse works
  expect_equal(
    prop_type_scalar(round_schema, invert = TRUE),
    c("model_tasks", "submissions_due", "file_format")
  )
  # Check that default + inverse calls return all schema property names
  combined_nms <- c(
    prop_type_scalar(round_schema),
    prop_type_scalar(round_schema, invert = TRUE)
  )
  expect_true(all(combined_nms %in% names(round_schema)))
})

test_that("prop_type_array works at top level", {
  skip_if_offline()
  schema <- download_tasks_schema("v3.0.1")

  expect_length(prop_type_scalar(schema), 0L)
  # Check that inverse works
  expect_equal(
    prop_type_array(schema, invert = TRUE),
    c(
      "$schema", "$id", "title", "description", "type", "properties",
      "required", "additionalProperties"
    )
  )

  schema_props <- schema$properties
  expect_length(prop_type_array(schema_props), 0L)
  # Check that inverse works
  expect_equal(
    prop_type_array(schema_props, invert = TRUE),
    c("schema_version", "rounds", "output_type_id_datatype")
  )

  # Check that default + inverse calls return all schema property names
  combined_nms <- c(
    prop_type_array(schema_props),
    prop_type_array(schema_props, invert = TRUE)
  )
  expect_true(all(combined_nms %in% names(schema_props)))
})

test_that("prop_type_array works at round level", {
  skip_if_offline()
  schema <- download_tasks_schema("v3.0.1")
  round_schema <- get_schema_round(schema)
  expect_equal(prop_type_array(round_schema), "file_format")

  # Check that inverse works
  expect_equal(
    prop_type_array(round_schema, invert = TRUE),
    c(
      "round_id_from_variable", "round_id", "round_name", "model_tasks",
      "submissions_due", "last_data_date"
    )
  )
  # Check that default + inverse calls return all schema property names
  combined_nms <- c(
    prop_type_array(round_schema),
    prop_type_array(round_schema, invert = TRUE)
  )
  expect_true(all(combined_nms %in% names(round_schema)))
})

test_that("prop_type_object works at top level", {
  skip_if_offline()
  schema <- download_tasks_schema("v3.0.1")

  expect_length(prop_type_object(schema), 0L)
  # Check that inverse works
  expect_equal(
    prop_type_object(schema, invert = TRUE),
    c(
      "$schema", "$id", "title", "description", "type", "properties",
      "required", "additionalProperties"
    )
  )

  schema_props <- schema$properties
  expect_length(prop_type_object(schema_props), 0L)
  # Check that inverse works
  expect_equal(
    prop_type_object(schema_props, invert = TRUE),
    c("schema_version", "rounds", "output_type_id_datatype")
  )

  # Check that default + inverse calls return all schema property names
  combined_nms <- c(
    prop_type_object(schema_props),
    prop_type_object(schema_props, invert = TRUE)
  )
  expect_true(all(combined_nms %in% names(schema_props)))
})

test_that("prop_type_object works at round level", {
  skip_if_offline()
  schema <- download_tasks_schema("v3.0.1")
  round_schema <- get_schema_round(schema)
  expect_equal(prop_type_object(round_schema), "submissions_due")

  # Check that inverse works
  expect_equal(
    prop_type_object(round_schema, invert = TRUE),
    c(
      "round_id_from_variable", "round_id", "round_name", "model_tasks",
      "last_data_date", "file_format"
    )
  )
  # Check that default + inverse calls return all schema property names
  combined_nms <- c(
    prop_type_object(round_schema),
    prop_type_object(round_schema, invert = TRUE)
  )
  expect_true(all(combined_nms %in% names(round_schema)))
})

test_that("prop_type_object_array works at top level", {
  skip_if_offline()
  schema <- download_tasks_schema("v3.0.1")

  expect_length(prop_type_object_array(schema), 0L)
  # Check that inverse works
  expect_equal(
    prop_type_object_array(schema, invert = TRUE),
    c(
      "$schema", "$id", "title", "description", "type", "properties",
      "required", "additionalProperties"
    )
  )

  schema_props <- schema$properties
  expect_length(prop_type_object_array(schema_props), 1L)
  expect_equal(prop_type_object_array(schema_props), "rounds")

  # Check that inverse works
  expect_equal(
    prop_type_object_array(schema_props, invert = TRUE),
    c("schema_version", "output_type_id_datatype")
  )

  # Check that default + inverse calls return all schema property names
  combined_nms <- c(
    prop_type_object_array(schema_props),
    prop_type_object_array(schema_props, invert = TRUE)
  )
  expect_true(all(combined_nms %in% names(schema_props)))
})

test_that("prop_type_object_array works at round level", {
  skip_if_offline()
  schema <- download_tasks_schema("v3.0.1")
  round_schema <- get_schema_round(schema)
  expect_length(prop_type_object_array(round_schema), 1L)
  expect_equal(prop_type_object_array(round_schema), "model_tasks")

  # Check that inverse works
  expect_equal(
    prop_type_object_array(round_schema, invert = TRUE),
    c(
      "round_id_from_variable", "round_id", "round_name",
      "submissions_due", "last_data_date", "file_format"
    )
  )
  # Check that default + inverse calls return all schema property names
  combined_nms <- c(
    prop_type_object_array(round_schema),
    prop_type_object_array(round_schema, invert = TRUE)
  )
  expect_true(all(combined_nms %in% names(round_schema)))
})
