test_that("Missing files returns an invalid config with an immediate message", {
  withr::local_options(list(width = 120))
  tmp <- withr::local_tempdir()
  suppressMessages({
    expect_message(out <- validate_model_metadata_schema(hub_path = tmp),
      "File does not exist"
    )
  })
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
        "testdata", "error_hub"
      )
    )
  )
  expect_false(unclass(out_error))
  expect_snapshot(out_error) # prints .Last.value
  expect_snapshot(print(out_error)) # prints out_error
  expect_snapshot(str(attr(out_error, "errors")))
})

test_that("validate_model_metadata_schema errors for imparsable json", {
  tmp <- withr::local_tempdir()
  testhub <- testthat::test_path(
    "testdata", "error_hub"
  )

  fs::dir_copy(testhub, tmp, overwrite = TRUE)
  # muck about
  cat("!green crayon? {\n",
    file = fs::path(tmp, "hub-config", "model-metadata-schema.json"),
    append = TRUE
  )
  suppressMessages({
    expect_message(out <- validate_model_metadata_schema(hub_path = tmp),
      "SyntaxError"
    )
  })
  expect_false(unclass(out))

})
