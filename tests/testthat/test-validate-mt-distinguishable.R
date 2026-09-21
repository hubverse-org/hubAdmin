schema <- hubUtils::get_schema(hubUtils::get_schema_url(version = "v6.0.0"))

test_that("distinguishable modeling tasks pass", {
  # A single modeling task has nothing to be distinguished from.
  single <- stub_round(
    stub_model_task(list(location = stub_task_id(required = "US")))
  )
  expect_null(validate_round_mts_distinguishable(single, 1L, schema))

  # A task ID whose values the two modeling tasks do not share.
  by_task_id <- stub_round(
    stub_model_task(list(target = stub_task_id(required = "inc hosp"))),
    stub_model_task(list(target = stub_task_id(required = "inc death")))
  )
  expect_null(validate_round_mts_distinguishable(by_task_id, 1L, schema))

  # A task ID only one modeling task defines. Model output data submitted to the
  # other carries NA in that column, which is a value the first does not accept.
  by_missing_task_id <- stub_round(
    stub_model_task(list(
      target = stub_task_id(required = "inc hosp"),
      horizon = stub_task_id(required = 1L, optional = 2L)
    )),
    stub_model_task(list(target = stub_task_id(required = "inc hosp")))
  )
  expect_null(validate_round_mts_distinguishable(
    by_missing_task_id,
    1L,
    schema
  ))

  # Same task ID values throughout, but no output type in common.
  by_output_type <- stub_round(
    stub_model_task(
      list(target = stub_task_id(required = "inc hosp")),
      output_type = stub_output_type_mean()
    ),
    stub_model_task(
      list(target = stub_task_id(required = "inc hosp")),
      output_type = stub_output_type_quantile()
    )
  )
  expect_null(validate_round_mts_distinguishable(by_output_type, 1L, schema))

  # The same output type, but none of its output type IDs in common.
  by_output_type_id <- stub_round(
    stub_model_task(
      list(target = stub_task_id(required = "inc hosp")),
      output_type = stub_output_type_quantile(required = c(0.25, 0.5))
    ),
    stub_model_task(
      list(target = stub_task_id(required = "inc hosp")),
      output_type = stub_output_type_quantile(required = c(0.75, 0.9))
    )
  )
  expect_null(validate_round_mts_distinguishable(by_output_type_id, 1L, schema))
})

test_that("modeling tasks that define the same value combinations are detected", {
  # `horizon` overlaps on 2 and every other task ID matches, so a row with
  # horizon 2 belongs to both modeling tasks.
  round <- stub_round(
    stub_model_task(list(
      target = stub_task_id(required = "inc hosp"),
      horizon = stub_task_id(required = 1L, optional = 2L)
    )),
    stub_model_task(list(
      target = stub_task_id(required = "inc hosp"),
      horizon = stub_task_id(required = 2L, optional = 3L)
    ))
  )

  errors <- validate_round_mts_distinguishable(round, 2L, schema)

  expect_equal(nrow(errors), 1L)
  expect_equal(errors$instancePath, "/rounds/1/model_tasks/1")
  expect_equal(
    errors$schemaPath,
    "#/properties/rounds/items/properties/model_tasks"
  )
  expect_equal(errors$keyword, "model_tasks distinguishable")
  expect_snapshot(cat(errors$message, errors$data, sep = "\n"))
})

test_that("every overlapping pair of modeling tasks is reported", {
  task_ids <- list(target = stub_task_id(required = "inc hosp"))
  round <- stub_round(
    stub_model_task(task_ids),
    stub_model_task(task_ids),
    stub_model_task(
      list(target = stub_task_id(required = "inc death"))
    ),
    stub_model_task(task_ids)
  )

  errors <- validate_round_mts_distinguishable(round, 1L, schema)

  expect_equal(nrow(errors), 3L)
  expect_equal(
    errors$instancePath,
    rep(c("/rounds/0/model_tasks/1", "/rounds/0/model_tasks/3"), c(1L, 2L))
  )
})

test_that("sample output type IDs cannot distinguish modeling tasks", {
  # The config gives the number of samples expected, not the output type IDs
  # themselves, so there is no value a sample modeling task rules out.
  round <- stub_round(
    stub_model_task(
      list(target = stub_task_id(required = "inc hosp")),
      output_type = stub_output_type_sample()
    ),
    stub_model_task(
      list(target = stub_task_id(required = "inc hosp")),
      output_type = stub_output_type_sample()
    )
  )

  errors <- validate_round_mts_distinguishable(round, 1L, schema)

  expect_equal(nrow(errors), 1L)
  expect_match(errors$data, "output types in common: sample")
})

test_that("only output types with output type IDs in common are reported", {
  # Both modeling tasks offer `quantile`, but with no quantile level in common,
  # so `quantile` distinguishes them and only `mean` is reported.
  round <- stub_round(
    stub_model_task(
      list(target = stub_task_id(required = "inc hosp")),
      output_type = c(
        stub_output_type_mean(),
        stub_output_type_quantile(required = 0.25)
      )
    ),
    stub_model_task(
      list(target = stub_task_id(required = "inc hosp")),
      output_type = c(
        stub_output_type_mean(),
        stub_output_type_quantile(required = 0.75)
      )
    )
  )

  errors <- validate_round_mts_distinguishable(round, 1L, schema)

  expect_equal(nrow(errors), 1L)
  expect_match(errors$data, "output types in common: mean$")
})

test_that("values in common are listed where the modeling tasks differ", {
  # `target` is identical so is not named. `horizon` and the quantile levels
  # differ, so the values in common are listed, at most five per dimension.
  round <- stub_round(
    stub_model_task(
      list(
        target = stub_task_id(required = "inc hosp"),
        horizon = stub_task_id(required = 1:6, optional = 7L)
      ),
      output_type = stub_output_type_quantile(required = c(0.25, 0.5))
    ),
    stub_model_task(
      list(
        target = stub_task_id(required = "inc hosp"),
        horizon = stub_task_id(required = 1:6, optional = 8L)
      ),
      output_type = stub_output_type_quantile(required = c(0.5, 0.75))
    )
  )

  errors <- validate_round_mts_distinguishable(round, 1L, schema)

  expect_equal(nrow(errors), 1L)
  expect_snapshot(cat(errors$data))

  # No task ID is identical, so none are described as such.
  round <- stub_round(
    stub_model_task(list(
      horizon = stub_task_id(required = 1L, optional = 2L)
    )),
    stub_model_task(list(
      horizon = stub_task_id(required = 2L, optional = 3L)
    ))
  )
  errors <- validate_round_mts_distinguishable(round, 1L, schema)
  expect_match(errors$data, "^overlap on horizon \\(2\\); ")
})

test_that("derived task IDs cannot distinguish modeling tasks", {
  # `target_date` is worked out from `origin_date` and `horizon`, which are
  # matched on themselves, so the two modeling tasks are left overlapping.
  round <- stub_round(
    stub_model_task(list(
      origin_date = stub_task_id(required = "2023-01-02"),
      horizon = stub_task_id(required = 1L),
      target_date = stub_task_id(required = "2023-01-09")
    )),
    stub_model_task(list(
      origin_date = stub_task_id(required = "2023-01-02"),
      horizon = stub_task_id(required = 1L),
      target_date = stub_task_id(required = "2023-01-16")
    ))
  )

  expect_null(
    validate_round_mts_distinguishable(round, 1L, schema)
  )

  errors <- validate_round_mts_distinguishable(
    round,
    1L,
    schema,
    derived_task_ids = "target_date"
  )
  expect_equal(nrow(errors), 1L)
  expect_match(errors$data, "^identical on every task ID; ")
})

test_that("round level derived_task_ids override the config level property", {
  config <- list(
    derived_task_ids = "target_date",
    rounds = list(
      stub_round(stub_model_task()),
      stub_round(stub_model_task(), derived_task_ids = "target_end_date")
    )
  )

  expect_equal(
    get_round_derived_task_ids(config$rounds[[1]], config),
    "target_date"
  )
  expect_equal(
    get_round_derived_task_ids(config$rounds[[2]], config),
    "target_end_date"
  )
})

test_that("validate_config() detects indistinguishable modeling tasks", {
  # Modeling tasks 1 and 2 overlap on horizon 2 and both offer `mean`. The
  # config is otherwise valid, so this is only reachable dynamically.
  validation <- validate_config(
    config_path = testthat::test_path(
      "testdata/tasks-mt-indistinguishable.json"
    ),
    config = "tasks"
  )

  expect_false(validation)
  errors <- attr(validation, "errors")
  expect_equal(nrow(errors), 1L)
  expect_equal(errors$keyword, "model_tasks distinguishable")
  expect_equal(errors$instancePath, "/rounds/0/model_tasks/1")
})
