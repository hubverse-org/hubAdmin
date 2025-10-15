test_that("has_target_data_config works on local hubs", {
  config_hub <- system.file("testhubs/v6/target_file/", package = "hubUtils")
  expect_true(has_target_data_config(config_hub))

  no_config_hub <- system.file("testhubs/v5/target_file/", package = "hubUtils")
  expect_false(has_target_data_config(no_config_hub))
})

test_that("has_target_data_config works on S3 hubs", {
  no_config_hub <- hubData::s3_bucket("hubverse/hubutils/testhubs/simple/")
  expect_false(has_target_data_config(no_config_hub))
})
