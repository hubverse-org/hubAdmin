test_that("extract_version_n works", {
  expect_equal(
    extract_version_n(
      "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v3.0.0/tasks-schema.json"
    ), "v3.0.0"
  )
})
