# Create a distribution output type object of class `output_type_item`

Create a representation of a `quantile`, `cdf`, `pmf` or `sample` output
type as a list object of class `output_type_item`. This can be combined
with additional `output_type_item`s using function
[`create_output_type()`](https://hubverse-org.github.io/hubAdmin/reference/create_output_type.md)
to create an `output_type` object for a given model_task. This can be
combined with other building blocks which can then be written as or
appended to `tasks.json` Hub config files.

## Usage

``` r
create_output_type_quantile(
  required,
  optional,
  is_required,
  value_type,
  value_minimum = NULL,
  value_maximum = NULL,
  schema_version = getOption("hubAdmin.schema_version", default = "latest"),
  branch = getOption("hubAdmin.branch", default = "main")
)

create_output_type_cdf(
  required,
  optional,
  is_required,
  value_type,
  schema_version = getOption("hubAdmin.schema_version", default = "latest"),
  branch = getOption("hubAdmin.branch", default = "main")
)

create_output_type_pmf(
  required,
  optional,
  is_required,
  value_type,
  schema_version = getOption("hubAdmin.schema_version", default = "latest"),
  branch = getOption("hubAdmin.branch", default = "main")
)

create_output_type_sample(
  is_required,
  output_type_id_type,
  max_length = NULL,
  min_samples_per_task,
  max_samples_per_task,
  compound_taskid_set = NULL,
  value_type,
  value_minimum = NULL,
  value_maximum = NULL,
  schema_version = getOption("hubAdmin.schema_version", default = "latest"),
  branch = getOption("hubAdmin.branch", default = "main")
)
```

## Arguments

- required:

  Atomic vector of required `output_type_id` values. Can be NULL if all
  values are optional.

- optional:

  **\[deprecated\]** **(schema \>= v4.0.0)**. Atomic vector of optional
  `output_type_id` values. Can be NULL if all values are required.

- is_required:

  Logical. Is this sample output type required?

- value_type:

  Character string. The data type of the output_type values.

- value_minimum:

  Numeric. The inclusive minimum of output_type values.

- value_maximum:

  Numeric. The inclusive maximum of output_type values.

- schema_version:

  Character string specifying the json schema version to be used for
  validation. The default value `"latest"` will use the latest version
  available in the hubverse [schemas
  repository](https://github.com/hubverse-org/schemas). Alternatively, a
  specific version of a schema (e.g. `"v0.0.1"`) can be specified. Can
  be set through global option "hubAdmin.schema_version".

- branch:

  The branch of the hubverse [schemas
  repository](https://github.com/hubverse-org/schemas) from which to
  fetch schema. Defaults to `"main"`. Can be set through global option
  "hubAdmin.branch".

- output_type_id_type:

  Character string. The data type of the output_type_id. One of
  "integer" or "character".

- max_length:

  Integer. Optional. The maximum length of the output_type_id value if
  type is `"character"`.

- min_samples_per_task:

  Integer. The minimum number of samples per task. Must be equal to or
  less than `max_samples_per_task`.

- max_samples_per_task:

  Integer. The maximum number of samples per task. Must be equal to or
  greater than `min_samples_per_task`.

- compound_taskid_set:

  Character vector. Optional. The set of compound task IDs that the
  sample each output type can be associated with.

## Value

a named list of class `output_type_item` representing a `quantile`,
`cdf`, `pmf` or `sample` output type.

## Details

For more details consult the [documentation on `tasks.json` Hub config
files](https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).

## Functions

- `create_output_type_quantile()`: Create a list representation of a
  `quantile` output type.

- `create_output_type_cdf()`: Create a list representation of a `cdf`
  output type.

- `create_output_type_pmf()`: Create a list representation of a `pmf`
  output type.

- `create_output_type_sample()`: Create a list representation of a
  `sample` output type.

## See also

[`create_output_type()`](https://hubverse-org.github.io/hubAdmin/reference/create_output_type.md)

## Examples

``` r
create_output_type_quantile(
  required = c(0.25, 0.5, 0.75),
  is_required = TRUE,
  value_type = "double",
  value_minimum = 0
)
#> $quantile
#> $quantile$output_type_id
#> $quantile$output_type_id$required
#> [1] 0.25 0.50 0.75
#> 
#> 
#> $quantile$is_required
#> [1] TRUE
#> 
#> $quantile$value
#> $quantile$value$type
#> [1] "double"
#> 
#> $quantile$value$minimum
#> [1] 0
#> 
#> 
#> 
#> attr(,"class")
#> [1] "output_type_item" "list"            
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
create_output_type_cdf(
  required = c(10, 20),
  is_required = FALSE,
  value_type = "double"
)
#> $cdf
#> $cdf$output_type_id
#> $cdf$output_type_id$required
#> [1] 10 20
#> 
#> 
#> $cdf$is_required
#> [1] FALSE
#> 
#> $cdf$value
#> $cdf$value$type
#> [1] "double"
#> 
#> $cdf$value$minimum
#> [1] 0
#> 
#> $cdf$value$maximum
#> [1] 1
#> 
#> 
#> 
#> attr(,"class")
#> [1] "output_type_item" "list"            
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
create_output_type_cdf(
  required = c("EW202240", "EW202241", "EW202242"),
  is_required = TRUE,
  value_type = "double"
)
#> $cdf
#> $cdf$output_type_id
#> $cdf$output_type_id$required
#> [1] "EW202240" "EW202241" "EW202242"
#> 
#> 
#> $cdf$is_required
#> [1] TRUE
#> 
#> $cdf$value
#> $cdf$value$type
#> [1] "double"
#> 
#> $cdf$value$minimum
#> [1] 0
#> 
#> $cdf$value$maximum
#> [1] 1
#> 
#> 
#> 
#> attr(,"class")
#> [1] "output_type_item" "list"            
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
create_output_type_pmf(
  required = c("low", "moderate", "high", "extreme"),
  is_required = FALSE,
  value_type = "double"
)
#> $pmf
#> $pmf$output_type_id
#> $pmf$output_type_id$required
#> [1] "low"      "moderate" "high"     "extreme" 
#> 
#> 
#> $pmf$is_required
#> [1] FALSE
#> 
#> $pmf$value
#> $pmf$value$type
#> [1] "double"
#> 
#> $pmf$value$minimum
#> [1] 0
#> 
#> $pmf$value$maximum
#> [1] 1
#> 
#> 
#> 
#> attr(,"class")
#> [1] "output_type_item" "list"            
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
create_output_type_sample(
  is_required = TRUE,
  output_type_id_type = "integer",
  min_samples_per_task = 70L, max_samples_per_task = 100L,
  value_type = "double",
  value_minimum = 0,
  value_maximum = 1
)
#> $sample
#> $sample$output_type_id_params
#> $sample$output_type_id_params$type
#> [1] "integer"
#> 
#> $sample$output_type_id_params$min_samples_per_task
#> [1] 70
#> 
#> $sample$output_type_id_params$max_samples_per_task
#> [1] 100
#> 
#> 
#> $sample$is_required
#> [1] TRUE
#> 
#> $sample$value
#> $sample$value$type
#> [1] "double"
#> 
#> $sample$value$minimum
#> [1] 0
#> 
#> $sample$value$maximum
#> [1] 1
#> 
#> 
#> 
#> attr(,"class")
#> [1] "output_type_item" "list"            
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
# Pre v4.0.0 schema output
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
#> $quantile
#> $quantile$output_type_id
#> $quantile$output_type_id$required
#> [1] 0.25 0.50 0.75
#> 
#> $quantile$output_type_id$optional
#> [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
#> 
#> 
#> $quantile$value
#> $quantile$value$type
#> [1] "double"
#> 
#> $quantile$value$minimum
#> [1] 0
#> 
#> 
#> 
#> attr(,"class")
#> [1] "output_type_item" "list"            
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
# Set schema version for all subsequent calls
options(hubAdmin.schema_version = "v3.0.1")
create_output_type_quantile(
  required = c(0.25, 0.5, 0.75),
  optional = c(
    0.1, 0.2, 0.3, 0.4, 0.6,
    0.7, 0.8, 0.9
  ),
  value_type = "double",
  value_minimum = 0
)
#> $quantile
#> $quantile$output_type_id
#> $quantile$output_type_id$required
#> [1] 0.25 0.50 0.75
#> 
#> $quantile$output_type_id$optional
#> [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
#> 
#> 
#> $quantile$value
#> $quantile$value$type
#> [1] "double"
#> 
#> $quantile$value$minimum
#> [1] 0
#> 
#> 
#> 
#> attr(,"class")
#> [1] "output_type_item" "list"            
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
create_output_type_cdf(
  required = c(10, 20),
  optional = NULL,
  value_type = "double"
)
#> $cdf
#> $cdf$output_type_id
#> $cdf$output_type_id$required
#> [1] 10 20
#> 
#> $cdf$output_type_id$optional
#> NULL
#> 
#> 
#> $cdf$value
#> $cdf$value$type
#> [1] "double"
#> 
#> $cdf$value$minimum
#> [1] 0
#> 
#> $cdf$value$maximum
#> [1] 1
#> 
#> 
#> 
#> attr(,"class")
#> [1] "output_type_item" "list"            
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
create_output_type_cdf(
  required = NULL,
  optional = c("EW202240", "EW202241", "EW202242"),
  value_type = "double"
)
#> $cdf
#> $cdf$output_type_id
#> $cdf$output_type_id$required
#> NULL
#> 
#> $cdf$output_type_id$optional
#> [1] "EW202240" "EW202241" "EW202242"
#> 
#> 
#> $cdf$value
#> $cdf$value$type
#> [1] "double"
#> 
#> $cdf$value$minimum
#> [1] 0
#> 
#> $cdf$value$maximum
#> [1] 1
#> 
#> 
#> 
#> attr(,"class")
#> [1] "output_type_item" "list"            
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
create_output_type_pmf(
  required = NULL,
  optional = c("low", "moderate", "high", "extreme"),
  value_type = "double"
)
#> $pmf
#> $pmf$output_type_id
#> $pmf$output_type_id$required
#> NULL
#> 
#> $pmf$output_type_id$optional
#> [1] "low"      "moderate" "high"     "extreme" 
#> 
#> 
#> $pmf$value
#> $pmf$value$type
#> [1] "double"
#> 
#> $pmf$value$minimum
#> [1] 0
#> 
#> $pmf$value$maximum
#> [1] 1
#> 
#> 
#> 
#> attr(,"class")
#> [1] "output_type_item" "list"            
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
options(hubAdmin.schema_version = "latest")
```
