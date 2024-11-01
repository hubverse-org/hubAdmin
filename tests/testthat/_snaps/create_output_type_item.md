# create_output_type_point functions work correctly with v3.0.1 schema

    Code
      create_output_type_mean(is_required = TRUE, value_type = "double",
        value_minimum = 0L, schema_version = "v3.0.1")
    Output
      $mean
      $mean$output_type_id
      $mean$output_type_id$required
      [1] NA
      
      $mean$output_type_id$optional
      NULL
      
      
      $mean$value
      $mean$value$type
      [1] "double"
      
      $mean$value$minimum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      attr(,"branch")
      [1] "main"

---

    Code
      create_output_type_mean(is_required = FALSE, value_type = "integer",
        value_maximum = 0L, schema_version = "v3.0.1")
    Output
      $mean
      $mean$output_type_id
      $mean$output_type_id$required
      NULL
      
      $mean$output_type_id$optional
      [1] NA
      
      
      $mean$value
      $mean$value$type
      [1] "integer"
      
      $mean$value$maximum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      attr(,"branch")
      [1] "main"

---

    Code
      create_output_type_median(is_required = FALSE, value_type = "double",
        schema_version = "v3.0.1")
    Output
      $median
      $median$output_type_id
      $median$output_type_id$required
      NULL
      
      $median$output_type_id$optional
      [1] NA
      
      
      $median$value
      $median$value$type
      [1] "double"
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      attr(,"branch")
      [1] "main"

# create_output_type_point functions error correctly

    Code
      create_output_type_mean(is_required = "TRUE", value_type = "double",
        schema_version = "v3.0.1")
    Condition
      Error in `create_output_type_point()`:
      x Argument `is_required` must be <logical> and have length 1.

---

    Code
      create_output_type_mean(is_required = TRUE, value_type = c("double", "integer"),
      schema_version = "v3.0.1")
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_output_type_mean()`:
      x `value_type` must be length 1, not 2.

---

    Code
      create_output_type_mean(is_required = FALSE, value_type = "character",
        value_maximum = 0L, schema_version = "v3.0.1")
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_output_type_mean()`:
      x `value_type` value is invalid.
      ! Must be one of "double" and "integer".
      i Actual value is "character"

---

    Code
      create_output_type_median(is_required = FALSE, schema_version = "v3.0.1")
    Condition
      Error in `create_output_type_point()`:
      ! `value_type` is absent but must be supplied.

# create_output_type_dist functions work correctly

    Code
      create_output_type_quantile(required = c(0.25, 0.5, 0.75), optional = c(0.1,
        0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 0.9), value_type = "double", value_minimum = 0,
      schema_version = "v3.0.1")
    Output
      $quantile
      $quantile$output_type_id
      $quantile$output_type_id$required
      [1] 0.25 0.50 0.75
      
      $quantile$output_type_id$optional
      [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
      
      
      $quantile$value
      $quantile$value$type
      [1] "double"
      
      $quantile$value$minimum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      attr(,"branch")
      [1] "main"

---

    Code
      create_output_type_cdf(required = c(10, 20), optional = NULL, value_type = "double",
      schema_version = "v3.0.1")
    Output
      $cdf
      $cdf$output_type_id
      $cdf$output_type_id$required
      [1] 10 20
      
      $cdf$output_type_id$optional
      NULL
      
      
      $cdf$value
      $cdf$value$type
      [1] "double"
      
      $cdf$value$minimum
      [1] 0
      
      $cdf$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      attr(,"branch")
      [1] "main"

---

    Code
      create_output_type_cdf(required = NULL, optional = c("EW202240", "EW202241",
        "EW202242"), value_type = "double", schema_version = "v3.0.1")
    Output
      $cdf
      $cdf$output_type_id
      $cdf$output_type_id$required
      NULL
      
      $cdf$output_type_id$optional
      [1] "EW202240" "EW202241" "EW202242"
      
      
      $cdf$value
      $cdf$value$type
      [1] "double"
      
      $cdf$value$minimum
      [1] 0
      
      $cdf$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      attr(,"branch")
      [1] "main"

---

    Code
      create_output_type_pmf(required = NULL, optional = c("low", "moderate", "high",
        "extreme"), value_type = "double", schema_version = "v3.0.1")
    Output
      $pmf
      $pmf$output_type_id
      $pmf$output_type_id$required
      NULL
      
      $pmf$output_type_id$optional
      [1] "low"      "moderate" "high"     "extreme" 
      
      
      $pmf$value
      $pmf$value$type
      [1] "double"
      
      $pmf$value$minimum
      [1] 0
      
      $pmf$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      attr(,"branch")
      [1] "main"

---

    Code
      create_output_type_quantile(required = c(0.25, 0.5, 0.75), optional = c(0.1,
        0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 0.9), value_type = "double", value_minimum = 0,
      schema_version = "v1.0.0")
    Condition
      Warning:
      Hub configured using schema version v1.0.0. Support for schema earlier than v2.0.0 was deprecated in hubUtils 0.0.0.9010.
      i Please upgrade Hub config files to conform to, at minimum, version v2.0.0 as soon as possible.
    Output
      $quantile
      $quantile$type_id
      $quantile$type_id$required
      [1] 0.25 0.50 0.75
      
      $quantile$type_id$optional
      [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
      
      
      $quantile$value
      $quantile$value$type
      [1] "double"
      
      $quantile$value$minimum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v1.0.0/tasks-schema.json"
      attr(,"branch")
      [1] "main"

# create_output_type_dist functions error correctly

    Code
      create_output_type_cdf(required = NULL, optional = c("EW202240", "EW202241",
        "EW2022423"), value_type = "double", schema_version = "v3.0.0")
    Condition
      Error in `map()`:
      i In index: 2.
      Caused by error in `create_output_type_cdf()`:
      ! The maximum number of characters allowed for values in `optional` is 8.
      x Value "EW2022423" has more characters than allowed

---

    Code
      create_output_type_quantile(required = c(0.25, 0.5, 0.6, 0.75), optional = c(
        0.1, 0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 0.9), value_type = "double",
      value_minimum = 0)
    Condition
      Error in `check_prop_dups()`:
      x Values across arguments `required` and `optional` must be unique.
      ! Provided value 0.6 is duplicated.

# create_output_type_sample works

    Code
      create_output_type_sample(is_required = TRUE, output_type_id_type = "integer",
        min_samples_per_task = 70L, max_samples_per_task = 100L, value_type = "double",
        value_minimum = 0L, value_maximum = 1L, branch = "br-v4.0.0")
    Output
      $sample
      $sample$output_type_id_params
      $sample$output_type_id_params$type
      [1] "integer"
      
      $sample$output_type_id_params$min_samples_per_task
      [1] 70
      
      $sample$output_type_id_params$max_samples_per_task
      [1] 100
      
      
      $sample$is_required
      [1] TRUE
      
      $sample$value
      $sample$value$type
      [1] "double"
      
      $sample$value$minimum
      [1] 0
      
      $sample$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
      attr(,"branch")
      [1] "br-v4.0.0"

---

    Code
      create_output_type_sample(is_required = TRUE, output_type_id_type = "integer",
        min_samples_per_task = 70L, max_samples_per_task = 100L, value_type = "double",
        value_minimum = 0L, value_maximum = 1L, schema_version = "v3.0.1")
    Output
      $sample
      $sample$output_type_id_params
      $sample$output_type_id_params$is_required
      [1] TRUE
      
      $sample$output_type_id_params$type
      [1] "integer"
      
      $sample$output_type_id_params$min_samples_per_task
      [1] 70
      
      $sample$output_type_id_params$max_samples_per_task
      [1] 100
      
      
      $sample$value
      $sample$value$type
      [1] "double"
      
      $sample$value$minimum
      [1] 0
      
      $sample$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      attr(,"branch")
      [1] "main"

---

    Code
      create_output_type_sample(is_required = FALSE, output_type_id_type = "character",
        max_length = 5L, min_samples_per_task = 70L, max_samples_per_task = 100L,
        compound_taskid_set = c("horizon", "target", "location"), value_type = "double",
        value_minimum = 0L, value_maximum = 1L, schema_version = "v3.0.1")
    Output
      $sample
      $sample$output_type_id_params
      $sample$output_type_id_params$is_required
      [1] FALSE
      
      $sample$output_type_id_params$type
      [1] "character"
      
      $sample$output_type_id_params$max_length
      [1] 5
      
      $sample$output_type_id_params$min_samples_per_task
      [1] 70
      
      $sample$output_type_id_params$max_samples_per_task
      [1] 100
      
      $sample$output_type_id_params$compound_taskid_set
      [1] "horizon"  "target"   "location"
      
      
      $sample$value
      $sample$value$type
      [1] "double"
      
      $sample$value$minimum
      [1] 0
      
      $sample$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      attr(,"branch")
      [1] "main"

# create_output_type_sample errors correctly

    Code
      create_output_type_sample(is_required = TRUE, output_type_id_type = "integer",
        min_samples_per_task = 10:11, max_samples_per_task = 100L, value_type = "character",
        value_minimum = 0L, value_maximum = 1L, schema_version = "v3.0.1")
    Condition
      Error in `map()`:
      i In index: 3.
      Caused by error in `create_output_type_sample()`:
      x `min_samples_per_task` must be length 1, not 2.

---

    Code
      create_output_type_sample(is_required = TRUE, output_type_id_type = "integer",
        min_samples_per_task = 110L, max_samples_per_task = 100L, value_type = "character",
        value_minimum = 0L, value_maximum = 1L, schema_version = "v3.0.1")
    Condition
      Error in `create_output_type_sample()`:
      ! `min_samples_per_task` must be less than or equal to `max_samples_per_task`.

---

    Code
      create_output_type_sample(is_required = TRUE, output_type_id_type = "integer",
        min_samples_per_task = 70L, max_samples_per_task = 100L, value_type = "character",
        value_minimum = 0L, value_maximum = 1L, schema_version = "v3.0.1")
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_output_type_sample()`:
      x `value_type` value is invalid.
      ! Must be one of "double" and "integer".
      i Actual value is "character"

---

    Code
      create_output_type_sample(is_required = FALSE, output_type_id_type = "character",
        max_length = 5L, min_samples_per_task = 70L, max_samples_per_task = 100L,
        compound_taskid_set = c(1, 2, 3), value_type = "double", value_minimum = 0L,
        value_maximum = 1L, schema_version = "v3.0.1")
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_output_type_sample()`:
      x `compound_taskid_set` is of type <double>.
      ! Must be <character>.

---

    Code
      create_output_type_sample(is_required = TRUE, output_type_id_type = "integer",
        min_samples_per_task = 70L, max_samples_per_task = 100L, value_type = "integer",
        value_minimum = 0L, value_maximum = 1L, schema_version = "v2.0.0")
    Condition
      Error in `create_output_type_sample()`:
      ! This function is only supported for schema versions "v3.0.0" and above.

# create_output_type_item is back-compatible

    Code
      create_output_type_median(is_required = FALSE, value_type = "double",
        schema_version = "v1.0.0")
    Condition
      Warning:
      Hub configured using schema version v1.0.0. Support for schema earlier than v2.0.0 was deprecated in hubUtils 0.0.0.9010.
      i Please upgrade Hub config files to conform to, at minimum, version v2.0.0 as soon as possible.
    Output
      $median
      $median$type_id
      $median$type_id$required
      NULL
      
      $median$type_id$optional
      [1] NA
      
      
      $median$value
      $median$value$type
      [1] "double"
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v1.0.0/tasks-schema.json"
      attr(,"branch")
      [1] "main"

# create_output_type_item works with v4 schema

    Code
      create_output_type_mean(is_required = TRUE, value_type = "double",
        value_minimum = 0L, schema_version = "v4.0.0", branch = "br-v4.0.0")
    Output
      $mean
      $mean$output_type_id
      $mean$output_type_id$required
      [1] NA
      
      
      $mean$is_required
      [1] TRUE
      
      $mean$value
      $mean$value$type
      [1] "double"
      
      $mean$value$minimum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
      attr(,"branch")
      [1] "br-v4.0.0"

---

    Code
      create_output_type_mean(is_required = FALSE, value_type = "integer",
        value_maximum = 0L, schema_version = "v4.0.0", branch = "br-v4.0.0")
    Output
      $mean
      $mean$output_type_id
      $mean$output_type_id$required
      [1] NA
      
      
      $mean$is_required
      [1] FALSE
      
      $mean$value
      $mean$value$type
      [1] "integer"
      
      $mean$value$maximum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
      attr(,"branch")
      [1] "br-v4.0.0"

---

    Code
      create_output_type_median(is_required = FALSE, value_type = "double",
        schema_version = "v4.0.0", branch = "br-v4.0.0")
    Output
      $median
      $median$output_type_id
      $median$output_type_id$required
      [1] NA
      
      
      $median$is_required
      [1] FALSE
      
      $median$value
      $median$value$type
      [1] "double"
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
      attr(,"branch")
      [1] "br-v4.0.0"

# create_output_type_dist fns support v4 schema

    Code
      create_output_type_quantile(required = c(0.25, 0.5, 0.75), is_required = TRUE,
      value_type = "double", value_minimum = 0, schema_version = "v4.0.0", branch = "br-v4.0.0")
    Output
      $quantile
      $quantile$output_type_id
      $quantile$output_type_id$required
      [1] 0.25 0.50 0.75
      
      
      $quantile$is_required
      [1] TRUE
      
      $quantile$value
      $quantile$value$type
      [1] "double"
      
      $quantile$value$minimum
      [1] 0
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
      attr(,"branch")
      [1] "br-v4.0.0"

---

    Code
      create_output_type_cdf(required = c("EW202240", "EW202241", "EW202242"),
      is_required = FALSE, value_type = "double", schema_version = "v4.0.0", branch = "br-v4.0.0")
    Output
      $cdf
      $cdf$output_type_id
      $cdf$output_type_id$required
      [1] "EW202240" "EW202241" "EW202242"
      
      
      $cdf$is_required
      [1] FALSE
      
      $cdf$value
      $cdf$value$type
      [1] "double"
      
      $cdf$value$minimum
      [1] 0
      
      $cdf$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
      attr(,"branch")
      [1] "br-v4.0.0"

---

    Code
      create_output_type_cdf(required = c("EW202240", "EW202241", "EW202242"),
      optional = c("EW202240", "EW202241", "EW202242"), is_required = FALSE,
      value_type = "double", schema_version = "v4.0.0", branch = "br-v4.0.0")
    Condition
      Warning:
      The `optional` argument of `create_output_type_cdf()` is deprecated as of schema version "v4.0.0" and above. Ignored.
    Output
      $cdf
      $cdf$output_type_id
      $cdf$output_type_id$required
      [1] "EW202240" "EW202241" "EW202242"
      
      
      $cdf$is_required
      [1] FALSE
      
      $cdf$value
      $cdf$value$type
      [1] "double"
      
      $cdf$value$minimum
      [1] 0
      
      $cdf$value$maximum
      [1] 1
      
      
      
      attr(,"class")
      [1] "output_type_item" "list"            
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
      attr(,"branch")
      [1] "br-v4.0.0"

---

    Code
      create_output_type_quantile(required = c(0.25, 0.5, 0.75), optional = c(0.1,
        0.2, 0.3, 0.4, 0.6, 0.7, 0.8, 0.9), value_type = "double", value_minimum = 0,
      schema_version = "v4.0.0", branch = "br-v4.0.0")
    Condition
      Warning:
      The `optional` argument of `create_output_type_quantile()` is deprecated as of schema version "v4.0.0" and above. Ignored.
      Error in `create_output_type_dist()`:
      ! `is_required` is absent but must be supplied.

---

    Code
      create_output_type_quantile(required = NULL, is_required = TRUE, value_type = "double",
        value_minimum = 0, schema_version = "v4.0.0", branch = "br-v4.0.0")
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error in `create_output_type_quantile()`:
      x `required` cannot be NULL.

