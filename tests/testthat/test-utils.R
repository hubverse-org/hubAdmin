test_that("extract_version works", {
  expect_equal(
    extract_version(
      "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v3.0.0/tasks-schema.json"
    ), "v3.0.0"
  )
})
