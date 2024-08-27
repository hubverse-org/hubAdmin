test_that("ci_validate_hub creates message of success", {
  skip_if_offline()
  # generator to overwrite the `timestamp()` function with known stamps
  broken_clock <- function(when = "NOW") {
    function(path) {
      cat(when, "\n", file = path, append = TRUE)
    }
  }
  tmp <- withr::local_tempdir()
  fs::dir_copy(system.file("testhubs/simple/", package = "hubUtils"), tmp)
  out  <- withr::local_tempfile()
  simp <- fs::path(tmp, "simple")
  # the diff file should not exist
  expect_false(fs::file_exists(fs::path(simp, "diff.md")))
  # the results should be true
  local_mocked_bindings(timestamp = broken_clock("NOW"))
  expect_true(
    ci_validate_hub_config(hub_path = simp, gh_output = out) %>%
      unlist() %>%
      all() %>%
      suppressMessages()
  )

  # the output file exists and contains the
  expect_true(fs::file_exists(fs::path(simp, "diff.md")))
  diff1 <- readLines(fs::path(simp, "diff.md"))
  expect_match(diff1[1], "correct")
  expect_match(tail(diff1, 1), "NOW")
  expect_snapshot(writeLines(diff1))

  # Second run overwrites the file ------------------------------
  expect_true(fs::file_exists(fs::path(simp, "diff.md")))
  # the results should be true
  local_mocked_bindings(timestamp = broken_clock("LATER"))
  expect_true(
    ci_validate_hub_config(hub_path = simp, gh_output = out) %>%
      unlist() %>%
      all() %>%
      suppressMessages()
  )

  # the output file exists
  expect_true(fs::file_exists(fs::path(simp, "diff.md")))
  diff2 <- readLines(fs::path(simp, "diff.md"))
  expect_match(diff2[1], "correct")
  expect_match(tail(diff2, 1), "LATER")
  expect_snapshot(writeLines(diff2))

})

test_that("ci_validate_hub creates message of failure", {
  skip_if_offline()
  # generator to overwrite the `timestamp()` function with known stamps
  broken_clock <- function(when = "NOW") {
    function(path) {
      cat(when, "\n", file = path, append = TRUE)
    }
  }
  tmp <- withr::local_tempdir()
  fs::dir_copy(testthat::test_path("testdata", "error_hub"), tmp)
  out  <- withr::local_tempfile()
  err <- fs::path(tmp, "error_hub")
  # the diff file should not exist
  expect_false(fs::file_exists(fs::path(err, "diff.md")))
  # the results should be false
  local_mocked_bindings(timestamp = broken_clock("NOW"))
  expect_false(
    ci_validate_hub_config(hub_path = err, gh_output = out) %>%
      unlist() %>%
      all() %>%
      suppressMessages()
  )

  # the output file exists and contains the
  expect_true(fs::file_exists(fs::path(err, "diff.md")))
  diff1 <- readLines(fs::path(err, "diff.md"))
  expect_match(diff1[1], "Invalid Configuration")
  expect_match(tail(diff1, 1), "NOW")
  # NOTE: not attempting to snapshot the generated table because its ID and
  # the file path changes all the time and testthat's masking is flaky on CI
  # systems that tend to change their tempdir specifications.

  # the results should be false
  local_mocked_bindings(timestamp = broken_clock("LATER"))
  expect_false(
    ci_validate_hub_config(hub_path = err, gh_output = out) %>%
      unlist() %>%
      all() %>%
      suppressMessages()
  )

  # the output file exists
  expect_true(fs::file_exists(fs::path(err, "diff.md")))
  diff2 <- readLines(fs::path(err, "diff.md"))
  expect_match(diff2[1], "Invalid Configuration")
  expect_match(tail(diff2, 1), "LATER")

})
