# Actual test cases
test_that("write_config handles non-existent directory", {
  skip_if_offline()
  rounds <- create_test_rounds()
  config <- create_test_config(rounds)
  temp_hub <- setup_test_hub()

  expect_error(
    write_config(config = config, hub_path = temp_hub),
    regexp = "Can't write to a file in a non-existent directory"
  )
})

test_that("write_config creates config path with default settings", {
  skip_if_offline()
  rounds <- create_test_rounds()
  config <- create_test_config(rounds)
  temp_hub <- setup_test_hub()
  setup_test_hub_with_config_dir(temp_hub)

  # Move to temp hub working directory to use default hub_path "." setting.
  original_wd <- getwd()
  setwd(temp_hub)
  result <- write_config(config = config, silent = TRUE)
  expect_true(result)
  expect_true(suppressMessages(validate_config()))
  file_contents <- readLines(file.path(temp_hub, "hub-config/tasks.json"))
  expect_snapshot(cat(file_contents, sep = "\n"))
  setwd(original_wd)
})

test_that("write_config handles overwrite settings correctly", {
  skip_if_offline()
  rounds <- create_test_rounds()
  config <- create_test_config(rounds)
  temp_hub <- setup_test_hub()
  setup_test_hub_with_config_dir(temp_hub)

  # Initial write
  write_config(config = config, hub_path = temp_hub, silent = TRUE)

  # Expect error when trying to overwrite without overwrite flag
  expect_error(
    write_config(config = config, hub_path = temp_hub),
    regexp = "already exists"
  )

  # Snapshot write message with overwrite flag
  expect_snapshot(
    write_config(
      config = config,
      hub_path = temp_hub,
      overwrite = TRUE
    )
  )

  # Actual overwrite
  file_contents <- readLines(file.path(temp_hub, "hub-config/tasks.json"))
  overwrite_result <- write_config(
    config = config,
    hub_path = temp_hub,
    overwrite = TRUE,
    silent = TRUE
  )
  expect_true(overwrite_result)
  expect_equal(
    file_contents,
    readLines(file.path(temp_hub, "hub-config/tasks.json"))
  )
})

test_that("write_config handles custom config path", {
  skip_if_offline()
  rounds <- create_test_rounds()
  config <- create_test_config(rounds)
  temp_hub <- setup_test_hub()
  setup_test_hub_with_config_dir(temp_hub)

  # Initial write
  write_config(config = config, hub_path = temp_hub, silent = TRUE)
  file_contents <- readLines(file.path(temp_hub, "hub-config/tasks.json"))

  config_path_result <- write_config(
    hub_path = "random_path",
    config = config,
    config_path = file.path(temp_hub, "custom_file_name.json"),
    silent = TRUE
  )
  expect_true(config_path_result)
  expect_equal(
    file_contents,
    readLines(file.path(temp_hub, "custom_file_name.json"))
  )
})

test_that("write_config validates length of hub_path and config_path", {
  skip_if_offline()
  rounds <- create_test_rounds()
  config <- create_test_config(rounds)
  temp_hub <- setup_test_hub()

  expect_error(
    write_config(config = config, hub_path = c(temp_hub, temp_hub)),
    regexp = "Assertion on 'hub_path' failed: Must have length 1."
  )
  expect_error(
    write_config(config = config, config_path = c(temp_hub, temp_hub)),
    regexp = "Assertion on 'config_path' failed: Must have length 1."
  )
})

test_that("write_config autoboxing works", {
  skip_if_offline()
  temp_hub <- setup_test_hub()
  setup_test_hub_with_config_dir(temp_hub)
  config <- hubUtils::read_config_file(
    config_path = test_path("testdata/tasks-append.json")
  ) |> as_config()

  # Move to temp hub working directory to use default hub_path "." setting.
  original_wd <- getwd()
  setwd(temp_hub)
  # Check that autoboxing causes invalid schema to be written
  write_config(config = config, silent = TRUE, autobox = FALSE)
  expect_false(suppressMessages(validate_config()))

  write_config(config = config, overwrite = TRUE, silent = TRUE)
  expect_true(suppressMessages(validate_config()))
  file_contents <- readLines(file.path(temp_hub, "hub-config/tasks.json"))
  expect_snapshot(cat(file_contents, sep = "\n"))

  # Re-reading and appending a new round to the config also works
  config <- hubUtils::read_config(".") |> as_config()
  config_plus_new_round <- append_round(config = config, create_new_round())

  write_config(config_plus_new_round,
    silent = TRUE,
    autobox = FALSE, overwrite = TRUE
  )
  expect_false(suppressMessages(validate_config()))

  write_config(config_plus_new_round, overwrite = TRUE, silent = TRUE)
  expect_true(suppressMessages(validate_config()))
  file_contents <- readLines(file.path(temp_hub, "hub-config/tasks.json"))
  expect_snapshot(cat(file_contents, sep = "\n"))

  setwd(original_wd)
})

test_that("write_config with autobox = FALSE does not box and issues warning", {
  skip_if_offline()
  rounds <- create_test_rounds()
  config <- create_test_config(rounds)
  temp_hub <- setup_test_hub()
  setup_test_hub_with_config_dir(temp_hub)

  # Move to temp hub working directory to use default hub_path "." setting.
  withr::with_dir(temp_hub, {
    expect_snapshot(
      write_config(
        config = config,
        hub_path = temp_hub,
        autobox = FALSE
      )
    )
    result <- write_config(
      config = config, silent = TRUE,
      autobox = FALSE, overwrite = TRUE
    )
    expect_false(suppressMessages(validate_config()))
  })
})


test_that("write_config with box_extra_paths works", {
  skip_if_offline()
  rounds <- create_test_rounds()
  rounds[[1]][[1]]$extra_array_property <- "length_1L_property"
  config <- create_test_config(rounds)
  temp_hub <- setup_test_hub()
  setup_test_hub_with_config_dir(temp_hub)

  # Move to temp hub working directory to use default hub_path "." setting.
  withr::with_dir(temp_hub, {
    write_config(
      config = config,
      hub_path = temp_hub,
      silent = TRUE,
      box_extra_paths = list(c("rounds", "items", "extra_array_property"))
    )
    file_contents <- readLines(file.path(temp_hub, "hub-config/tasks.json"))
    expect_snapshot(cat(file_contents, sep = "\n"))
    expect_true(suppressMessages(validate_config()))
  })
})
