test_that("create_output_type functions work correctly", {
  skip_if_offline()
  expect_snapshot(
    create_output_type(
      create_output_type_mean(
        is_required = TRUE,
        value_type = "double",
        value_minimum = 0L
      ),
      create_output_type_median(
        is_required = FALSE,
        value_type = "double"
      ),
      create_output_type_quantile(
        required = c(
          0.1, 0.2, 0.3, 0.4, 0.6,
          0.7, 0.8, 0.9
        ),
        is_required = TRUE,
        value_type = "double",
        value_minimum = 0
      )
    )
  )
})


test_that("create_output_type functions error correctly", {
  skip_if_offline()
  expect_snapshot(
    create_output_type(
      create_output_type_mean(
        is_required = TRUE,
        value_type = "double",
        value_minimum = 0L
      ),
      create_output_type_mean(
        is_required = TRUE,
        value_type = "double",
        value_minimum = 0L
      )
    ),
    error = TRUE
  )
  expect_snapshot(
    create_output_type(
      create_output_type_mean(
        is_required = TRUE,
        value_type = "double",
        value_minimum = 0L
      ),
      list(a = "b")
    ),
    error = TRUE
  )
})
