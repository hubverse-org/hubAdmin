# Create a point estimate output type object of class `output_type_item`

Create a representation of a `mean` or `median` output type as a list
object of class `output_type_item`. This can be combined with additional
`output_type_item` objects using function
[`create_output_type()`](https://hubverse-org.github.io/hubAdmin/reference/create_output_type.md)
to create an `output_type` object for a given model_task. This can be
combined with other building blocks which can then be written as or
appended to `tasks.json` Hub config files.

## Usage

``` r
create_output_type_mean(
  is_required,
  value_type,
  value_minimum = NULL,
  value_maximum = NULL,
  schema_version = getOption("hubAdmin.schema_version", default = "latest"),
  branch = getOption("hubAdmin.branch", default = "main")
)

create_output_type_median(
  is_required,
  value_type,
  value_minimum = NULL,
  value_maximum = NULL,
  schema_version = getOption("hubAdmin.schema_version", default = "latest"),
  branch = getOption("hubAdmin.branch", default = "main")
)
```

## Arguments

- is_required:

  Logical. Is the output type required?

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

## Value

a named list of class `output_type_item` representing a `mean` or
`median` output type.

## Details

For more details consult the [documentation on `tasks.json` Hub config
files](https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).

## Functions

- `create_output_type_mean()`: Create a list representation of a `mean`
  output type.

- `create_output_type_median()`: Create a list representation of a
  `median` output type.

## See also

[`create_output_type()`](https://hubverse-org.github.io/hubAdmin/reference/create_output_type.md)

## Examples

``` r
create_output_type_mean(
  is_required = TRUE,
  value_type = "double",
  value_minimum = 0L
)
#> $mean
#> $mean$output_type_id
#> $mean$output_type_id$required
#> NULL
#> 
#> 
#> $mean$is_required
#> [1] TRUE
#> 
#> $mean$value
#> $mean$value$type
#> [1] "double"
#> 
#> $mean$value$minimum
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
create_output_type_median(
  is_required = FALSE,
  value_type = "integer"
)
#> $median
#> $median$output_type_id
#> $median$output_type_id$required
#> NULL
#> 
#> 
#> $median$is_required
#> [1] FALSE
#> 
#> $median$value
#> $median$value$type
#> [1] "integer"
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
create_output_type_mean(
  is_required = TRUE,
  value_type = "double",
  value_minimum = 0L,
  schema_version = "v3.0.1"
)
#> $mean
#> $mean$output_type_id
#> $mean$output_type_id$required
#> [1] NA
#> 
#> $mean$output_type_id$optional
#> NULL
#> 
#> 
#> $mean$value
#> $mean$value$type
#> [1] "double"
#> 
#> $mean$value$minimum
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
create_output_type_mean(
  is_required = TRUE,
  value_type = "double",
  value_minimum = 0L,
  schema_version = "v3.0.1"
)
#> $mean
#> $mean$output_type_id
#> $mean$output_type_id$required
#> [1] NA
#> 
#> $mean$output_type_id$optional
#> NULL
#> 
#> 
#> $mean$value
#> $mean$value$type
#> [1] "double"
#> 
#> $mean$value$minimum
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
options(hubAdmin.schema_version = "latest")
```
