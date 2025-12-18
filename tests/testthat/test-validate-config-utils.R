test_that("val_target_ids_match_target_key_values works", {
  # Ensure validation returns mismatches between target IDs and target keys
  # correctly when multiple target keys are present.
  grp_target_keys <- jsonlite::read_json(
    testthat::test_path(
      "testdata/target-metadata-target-id-target-key-mismatch.json"
    ),
    simplifyVector = TRUE,
    simplifyDataFrame = FALSE
  )$target_metadata
  model_task_i <- 1L
  round_i <- 1L

  schema <- hubUtils::get_schema(hubUtils::get_schema_url(version = "v5.0.0"))

  check <- val_target_ids_match_target_key_values(
    grp_target_keys,
    model_task_i,
    round_i,
    schema
  )
  expect_equal(
    check,
    structure(
      list(
        instancePath = structure(
          c(
            "/rounds/0/model_tasks/0/target_metadata/1/target_id",
            "/rounds/0/model_tasks/0/target_metadata/2/target_id"
          ),
          class = c(
            "glue",
            "character"
          )
        ),
        schemaPath = c(
          "#/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_id", # nolint: line_length_linter
          "#/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_id" # nolint: line_length_linter
        ),
        keyword = c("target_id value", "target_id value"),
        message = c(
          "target_id value does not match corresponding target key value",
          "target_id value does not match corresponding target key value"
        ),
        schema = c("", ""),
        data = structure(
          c(
            "target_id value: 'ili-ed-hosp';\ntarget_key.target value: 'ILI ED hospitalisation'",
            "target_id value: 'ili-ed-visits';\ntarget_key.target value: 'ILI ED visits'"
          ),
          class = c("glue", "character")
        )
      ),
      class = "data.frame",
      row.names = c(
        NA,
        -2L
      )
    )
  )

  # Ensure validation returns mismatches between target IDs and target keys
  # correctly when a single target keys are present.
  grp_target_keys <- grp_target_keys[2]
  check <- val_target_ids_match_target_key_values(
    grp_target_keys,
    model_task_i,
    round_i,
    schema
  )
  expect_equal(
    check,
    structure(
      list(
        instancePath = structure(
          "/rounds/0/model_tasks/0/target_metadata/0/target_id",
          class = c("glue", "character")
        ),
        schemaPath = "#/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_id", # nolint: line_length_linter
        keyword = "target_id value",
        message = "target_id value does not match corresponding target key value",
        schema = "",
        data = structure(
          "target_id value: 'ili-ed-hosp';\ntarget_key.target value: 'ILI ED hospitalisation'",
          class = c("glue", "character")
        )
      ),
      class = "data.frame",
      row.names = c(NA, -1L)
    )
  )

  # Ensure validation returns NULL when target keys are NULL
  grp_target_keys[[1]]$target_keys <- NULL
  check <- val_target_ids_match_target_key_values(
    grp_target_keys,
    model_task_i,
    round_i,
    schema
  )
  expect_null(check)

  # Ensure validation returns NULL when target keys are spread across multiple
  # task IDs
  schema <- hubUtils::get_schema(hubUtils::get_schema_url(version = "v3.0.0"))
  grp_target_keys[[1]]$target_keys <- list(
    target_variable = "ILI ED",
    target_outcome = "hospitalisation"
  )
  check <- val_target_ids_match_target_key_values(
    grp_target_keys,
    model_task_i,
    round_i,
    schema
  )
  expect_null(check)
})
