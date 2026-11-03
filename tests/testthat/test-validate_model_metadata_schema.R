test_that("Missing files returns an invalid config with an immediate message", {
  withr::local_options(list(width = 120))
  tmp <- withr::local_tempdir()
  suppressMessages({
    expect_message(
      out <- validate_model_metadata_schema(hub_path = tmp),
      "File does not exist"
    )
  })
  # NOTE: this needs to be unclassed because otherwise testthat assumes it is
  # an error: https://github.com/hubverse-org/hubAdmin/pull/86/files#r1882552109
  expect_false(unclass(out))
})

test_that("validate_model_metadata_schema works", {
  expect_true(
    suppressMessages(
      validate_model_metadata_schema(
        hub_path = system.file(
          "testhubs/simple/",
          package = "hubUtils"
        )
      )
    )
  )

  out_error <- suppressWarnings(
    validate_model_metadata_schema(
      hub_path = testthat::test_path(
        "testdata",
        "error_hub"
      )
    )
  )
  # NOTE: this needs to be unclassed because otherwise testthat assumes it is
  # an error: https://github.com/hubverse-org/hubAdmin/pull/86/files#r1882552109
  expect_false(unclass(out_error))
  expect_snapshot(out_error) # prints .Last.value
  expect_snapshot(print(out_error)) # prints out_error
  expect_equal(
    attr(out_error, "errors"),
    data.frame(
      instancePath = "",
      schemaPath = "properties",
      keyword = "required",
      message = paste(
        "must have required properties: either 'model_id' or both",
        "'team_abbr' and 'model_abbr'."
      ),
      schema = "",
      data = paste(
        "team_name, model_name, model_abbr, model_version, model_contributors,",
        "website_url, repo_url, license, designated_model, citation,",
        "team_funding, data_inputs, methods, methods_long, ensemble_of_models,",
        "and ensemble_of_hub_models"
      )
    )
  )
})

test_that("validate_model_metadata_schema errors for imparsable json", {
  tmp <- withr::local_tempdir()
  testhub <- testthat::test_path(
    "testdata",
    "error_hub"
  )

  fs::dir_copy(testhub, tmp, overwrite = TRUE)
  # muck about
  cat(
    "!green crayon? {\n",
    file = fs::path(tmp, "hub-config", "model-metadata-schema.json"),
    append = TRUE
  )
  suppressMessages({
    expect_message(
      out <- validate_model_metadata_schema(hub_path = tmp),
      "SyntaxError"
    )
  })
  # NOTE: this needs to be unclassed because otherwise testthat assumes it is
  # an error: https://github.com/hubverse-org/hubAdmin/pull/86/files#r1882552109
  expect_false(unclass(out))
})
