test_that("write config works", {
  rounds <- create_rounds(
    create_round(
      round_id_from_variable = TRUE,
      round_id = "origin_date",
      model_tasks = create_model_tasks(
        create_model_task(
          task_ids = create_task_ids(
            create_task_id("origin_date",
              required = NULL,
              optional = c(
                "2023-01-02",
                "2023-01-09",
                "2023-01-16"
              )
            ),
            create_task_id("location",
              required = "US",
              optional = c("01", "02", "04", "05", "06")
            ),
            create_task_id("horizon",
              required = 1L,
              optional = 2:4
            )
          ),
          output_type = create_output_type(
            create_output_type_mean(
              is_required = TRUE,
              value_type = "double",
              value_minimum = 0L
            )
          ),
          target_metadata = create_target_metadata(
            create_target_metadata_item(
              target_id = "inc hosp",
              target_name = "Weekly incident influenza hospitalizations",
              target_units = "rate per 100,000 population",
              target_keys = NULL,
              target_type = "discrete",
              is_step_ahead = TRUE,
              time_unit = "week"
            )
          )
        )
      ),
      submissions_due = list(
        relative_to = "origin_date",
        start = -4L,
        end = 2L
      )
    )
  )
  # Create config object
  config <- create_config(rounds)

  # Create test hub directory
  dir <- withr::local_tempdir()
  temp_hub <- fs::dir_create(fs::path(dir, "hub"))

  # Non existent parent directory error
  expect_error(
    write_config(config = config, hub_path = temp_hub),
    regexp = "Can't write to a file in a non-existent directory"
  )

  # Create hub-config directory
  dir.create(file.path(temp_hub, "hub-config"))

  # Check config path correctly created with default settings
  orginal_wd <- getwd()
  setwd(temp_hub)
  result <- write_config(config = config, silent = TRUE)
  expect_true(result)
  file_contents <- readLines(file.path(temp_hub, "hub-config/tasks.json"))
  expect_snapshot(cat(file_contents, sep = "\n"))
  setwd(orginal_wd)

  # Check hub_path and overwrite setting works
  expect_error(
    write_config(config = config, hub_path = temp_hub),
    regexp = "already exists"
  )
  # Snapshot write message
  expect_snapshot(
    write_config(
      config = config,
      hub_path = temp_hub,
      overwrite = TRUE
    )
  )
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
  # Check config path correctly created with custom settings and overrides hub_path
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


  # Check hub_path and config_path length
  expect_error(
    write_config(config = config, hub_path = c(temp_hub, temp_hub)),
    regexp = "Assertion on 'hub_path' failed: Must have length 1."
  )
  expect_error(
    write_config(config = config, config_path = c(temp_hub, temp_hub)),
    regexp = "Assertion on 'config_path' failed: Must have length 1."
  )
})
