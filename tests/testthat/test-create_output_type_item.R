test_that("create_output_type_point functions work correctly with v3.0.1 schema", {
  expect_snapshot(
    create_output_type_mean(
      is_required = TRUE,
      value_type = "double",
      value_minimum = 0L,
      schema_version = "v3.0.1"
    )
  )
  expect_snapshot(
    create_output_type_mean(
      is_required = FALSE,
      value_type = "integer",
      value_maximum = 0L,
      schema_version = "v3.0.1"
    )
  )
  expect_snapshot(
    create_output_type_median(
      is_required = FALSE,
      value_type = "double",
      schema_version = "v3.0.1"
    )
  )
})

test_that("create_output_type_point functions error correctly", {
  expect_snapshot(
    create_output_type_mean(
      is_required = "TRUE",
      value_type = "double",
      schema_version = "v3.0.1"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_output_type_mean(
      is_required = TRUE,
      value_type = c("double", "integer"),
      schema_version = "v3.0.1"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_output_type_mean(
      is_required = FALSE,
      value_type = "character",
      value_maximum = 0L,
      schema_version = "v3.0.1"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_output_type_median(
      is_required = FALSE,
      schema_version = "v3.0.1"
    ),
    error = TRUE
  )
})

test_that("create_output_type_dist functions work correctly", {
  expect_snapshot(
    create_output_type_quantile(
      required = c(0.25, 0.5, 0.75),
      optional = c(
        0.1, 0.2, 0.3, 0.4, 0.6,
        0.7, 0.8, 0.9
      ),
      value_type = "double",
      value_minimum = 0,
      schema_version = "v3.0.1"
    )
  )
  expect_snapshot(
    create_output_type_cdf(
      required = c(10, 20),
      optional = NULL,
      value_type = "double",
      schema_version = "v3.0.1"
    )
  )
  expect_snapshot(
    create_output_type_cdf(
      required = NULL,
      optional = c(
        "EW202240",
        "EW202241",
        "EW202242"
      ),
      value_type = "double",
      schema_version = "v3.0.1"
    )
  )
  expect_snapshot(
    create_output_type_pmf(
      required = NULL,
      optional = c(
        "low", "moderate",
        "high", "extreme"
      ),
      value_type = "double",
      schema_version = "v3.0.1"
    )
  )

  # Test back-compatibility
  expect_snapshot(
    create_output_type_quantile(
      required = c(0.25, 0.5, 0.75),
      optional = c(
        0.1, 0.2, 0.3, 0.4, 0.6,
        0.7, 0.8, 0.9
      ),
      value_type = "double",
      value_minimum = 0,
      schema_version = "v1.0.0"
    )
  )
})


test_that("create_output_type_dist functions error correctly", {
  expect_snapshot(
    create_output_type_cdf(
      required = NULL,
      optional = c(
        "EW202240",
        "EW202241",
        "EW2022423"
      ),
      value_type = "double",
      schema_version = "v3.0.0"
    ),
    error = TRUE
  )
  expect_snapshot(
    create_output_type_quantile(
      required = c(0.25, 0.5, 0.6, 0.75),
      optional = c(
        0.1, 0.2, 0.3, 0.4, 0.6,
        0.7, 0.8, 0.9
      ),
      value_type = "double",
      value_minimum = 0
    ),
    error = TRUE
  )
})


test_that("create_output_type_sample works", {
  expect_snapshot(
    create_output_type_sample(
      is_required = TRUE,
      output_type_id_type = "integer",
      min_samples_per_task = 70L, max_samples_per_task = 100L,
      value_type = "double",
      value_minimum = 0L,
      value_maximum = 1L,
      branch = "br-v4.0.0"
    )
  )
  expect_snapshot(
    create_output_type_sample(
      is_required = TRUE,
      output_type_id_type = "integer",
      min_samples_per_task = 70L, max_samples_per_task = 100L,
      value_type = "double",
      value_minimum = 0L,
      value_maximum = 1L,
      schema_version = "v3.0.1"
    )
  )
  expect_snapshot(
    create_output_type_sample(
      is_required = FALSE,
      output_type_id_type = "character",
      max_length = 5L,
      min_samples_per_task = 70L, max_samples_per_task = 100L,
      compound_taskid_set = c("horizon", "target", "location"),
      value_type = "double",
      value_minimum = 0L,
      value_maximum = 1L,
      schema_version = "v3.0.1"
    )
  )
})

test_that("create_output_type_sample errors correctly", {
  # TODO: Remove branches when v4.0.0 is released
  # v4 type fails correctly
  expect_error(
    create_output_type_sample(
      is_required = TRUE,
      output_type_id_type = "Date",
      min_samples_per_task = 70L, max_samples_per_task = 100L,
      value_type = "double",
      value_minimum = 0L,
      value_maximum = 1L,
      branch = "br-v4.0.0"
    ),
    regexp = 'Must be one of .*character.* and .*integer'
  )
  # v4 is_required fails correctly
  expect_error(
    create_output_type_sample(
      is_required = 1L,
      output_type_id_type = "Date",
      min_samples_per_task = 70L, max_samples_per_task = 100L,
      value_type = "double",
      value_minimum = 0L,
      value_maximum = 1L,
      branch = "br-v4.0.0"
    ),
    regexp =
      "Assertion on 'is_required' failed: Must be of type 'logical', not 'integer'"
  )
  # min_samples_per_task vector instead of scalar fails
  expect_snapshot(
    create_output_type_sample(
      is_required = TRUE,
      output_type_id_type = "integer",
      min_samples_per_task = 10:11, max_samples_per_task = 100L,
      value_type = "character",
      value_minimum = 0L,
      value_maximum = 1L,
      schema_version = "v3.0.1"
    ),
    error = TRUE
  )
  # min_samples_per_task greater than max_samples_per_task fails
  expect_snapshot(
    create_output_type_sample(
      is_required = TRUE,
      output_type_id_type = "integer",
      min_samples_per_task = 110L, max_samples_per_task = 100L,
      value_type = "character",
      value_minimum = 0L,
      value_maximum = 1L,
      schema_version = "v3.0.1"
    ),
    error = TRUE
  )
  # value_type as character fails
  expect_snapshot(
    create_output_type_sample(
      is_required = TRUE,
      output_type_id_type = "integer",
      min_samples_per_task = 70L, max_samples_per_task = 100L,
      value_type = "character",
      value_minimum = 0L,
      value_maximum = 1L,
      schema_version = "v3.0.1"
    ),
    error = TRUE
  )

  # Integer compound_taskid_set fails
  expect_snapshot(
    create_output_type_sample(
      is_required = FALSE,
      output_type_id_type = "character",
      max_length = 5L,
      min_samples_per_task = 70L, max_samples_per_task = 100L,
      compound_taskid_set = c(1, 2, 3),
      value_type = "double",
      value_minimum = 0L,
      value_maximum = 1L,
      schema_version = "v3.0.1"
    ),
    error = TRUE
  )
  # Earlier schema version fails
  expect_snapshot(
    create_output_type_sample(
      is_required = TRUE,
      output_type_id_type = "integer",
      min_samples_per_task = 70L, max_samples_per_task = 100L,
      value_type = "integer",
      value_minimum = 0L,
      value_maximum = 1L,
      schema_version = "v2.0.0"
    ),
    error = TRUE
  )
})


test_that("create_output_type_item is back-compatible", {
  # Test back-compatibility
  expect_snapshot(
    create_output_type_median(
      is_required = FALSE,
      value_type = "double",
      schema_version = "v1.0.0"
    )
  )
})

test_that("create_output_type_item works with v4 schema", {
  # TODO: Remove branch argument when v4.0.0 is released
  expect_snapshot(
    create_output_type_mean(
      is_required = TRUE,
      value_type = "double",
      value_minimum = 0L,
      schema_version = "v4.0.0",
      branch = "br-v4.0.0"
    )
  )
  expect_snapshot(
    create_output_type_mean(
      is_required = FALSE,
      value_type = "integer",
      value_maximum = 0L,
      schema_version = "v4.0.0",
      branch = "br-v4.0.0"
    )
  )
  expect_snapshot(
    create_output_type_median(
      is_required = FALSE,
      value_type = "double",
      schema_version = "v4.0.0",
      branch = "br-v4.0.0"
    )
  )
})


test_that("create_output_type_dist fns support v4 schema", {
  # TODO: Remove branch argument when v4.0.0 is released

  expect_snapshot(
    create_output_type_quantile(
      required = c(0.25, 0.5, 0.75),
      is_required = TRUE,
      value_type = "double",
      value_minimum = 0,
      schema_version = "v4.0.0",
      branch = "br-v4.0.0"
    )
  )
  expect_snapshot(
    create_output_type_cdf(
      required = c(
        "EW202240",
        "EW202241",
        "EW202242"
      ),
      is_required = FALSE,
      value_type = "double",
      schema_version = "v4.0.0",
      branch = "br-v4.0.0"
    )
  )

  # Show that optional values are ignored and warning issued
  expect_equal(
    suppressWarnings(
      create_output_type_quantile(
        required = c(0.25, 0.5, 0.75),
        optional = c(
          0.1, 0.2, 0.3, 0.4, 0.6,
          0.7, 0.8, 0.9
        ),
        is_required = TRUE,
        value_type = "double",
        value_minimum = 0,
        schema_version = "v4.0.0",
        branch = "br-v4.0.0"
      )$quantile$output_type_id$required
    ), c(0.25, 0.5, 0.75)
  )
  expect_snapshot(
    create_output_type_cdf(
      required = c(
        "EW202240",
        "EW202241",
        "EW202242"
      ),
      optional = c(
        "EW202240",
        "EW202241",
        "EW202242"
      ),
      is_required = FALSE,
      value_type = "double",
      schema_version = "v4.0.0",
      branch = "br-v4.0.0"
    )
  )
  expect_warning(
    create_output_type_quantile(
      required = c(0.25, 0.5, 0.75),
      optional = c(
        0.1, 0.2, 0.3, 0.4, 0.6,
        0.7, 0.8, 0.9
      ),
      is_required = TRUE,
      value_type = "double",
      value_minimum = 0,
      schema_version = "v4.0.0",
      branch = "br-v4.0.0"
    ),
    regexp = "is deprecated as of schema version"
  )

  # Show that function errors if is_required is missing
  expect_snapshot(
    create_output_type_quantile(
      required = c(0.25, 0.5, 0.75),
      optional = c(
        0.1, 0.2, 0.3, 0.4, 0.6,
        0.7, 0.8, 0.9
      ),
      value_type = "double",
      value_minimum = 0,
      schema_version = "v4.0.0",
      branch = "br-v4.0.0"
    ),
    error = TRUE
  )
})
