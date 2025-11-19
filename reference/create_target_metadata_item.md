# Create an object of class `target_metadata_item`

Create a representation of a target_metadata item as a list object of
class `target_metadata_item`. This can be combined with additional
target_metadata items using function
[`create_target_metadata()`](https://hubverse-org.github.io/hubAdmin/reference/create_target_metadata.md)
to create a target_metadata object for a given model_task. Such building
blocks can ultimately be combined and then written out as or appended to
`tasks.json` Hub config files.

## Usage

``` r
create_target_metadata_item(
  target_id,
  target_name,
  target_units,
  target_keys = NULL,
  description = NULL,
  target_type,
  is_step_ahead,
  time_unit = NULL,
  schema_version = getOption("hubAdmin.schema_version", default = "latest"),
  branch = getOption("hubAdmin.branch", default = "main"),
  ...
)
```

## Arguments

- target_id:

  character string. Short description that uniquely identifies the
  target.

- target_name:

  character string. A longer human readable target description that
  could be used, for example, as a visualisation axis label.

- target_units:

  character string. Unit of observation of the target.

- target_keys:

  named list or `NULL`. The `target_keys` value defines a single target.
  Should be a named list containing a single character string element.
  The name of the element should match a `task_id` variable name within
  the same `model_tasks` object and the value should match a single
  value of that variable as described in [target metadata section of the
  official hubverse
  documentation](https://docs.hubverse.io/en/latest/user-guide/tasks.html#target-metadata).
  \# nolint: line_length_linter Otherwise, `NULL` in the case where the
  target is not specified as a task_id but is specified solely through
  the `target_id` argument.

- description:

  character string (optional). An optional verbose description of the
  target that might include information such as definitions of a 'rate'
  or similar.

- target_type:

  character string. Target statistical data type. Consult the
  [appropriate version of the hub
  schema](https://docs.hubverse.io/en/latest/format/hub-metadata.html#model-tasks-tasks-json-interactive-schema)
  for potential values.

- is_step_ahead:

  logical. Whether the target is part of a sequence of values

- time_unit:

  character string. If `is_step_ahead` is `TRUE`, then this argument is
  required and defines the unit of time steps. if `is_step_ahead` is
  `FALSE`, then this argument is not required and will be ignored if
  given.

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

- ...:

  additional optional properties to add to the target metadata list
  output. Only available for schema version equal or greater than
  v5.1.0, ignored for past version. In schema versions greater or equal
  to v6.0.0, these properties are placed in the `additional_properties`
  field.

## Value

a named list of class `target_metadata_item`.

## Details

For more details consult the [documentation on `tasks.json` Hub config
files](https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).

## See also

[`create_target_metadata()`](https://hubverse-org.github.io/hubAdmin/reference/create_target_metadata.md)

## Examples

``` r
create_target_metadata_item(
  target_id = "inc hosp",
  target_name = "Weekly incident influenza hospitalizations",
  target_units = "rate per 100,000 population",
  target_keys = list(target = "inc hosp"),
  target_type = "discrete",
  is_step_ahead = TRUE,
  time_unit = "week"
)
#> $target_id
#> [1] "inc hosp"
#> 
#> $target_name
#> [1] "Weekly incident influenza hospitalizations"
#> 
#> $target_units
#> [1] "rate per 100,000 population"
#> 
#> $target_keys
#> $target_keys$target
#> [1] "inc hosp"
#> 
#> 
#> $target_type
#> [1] "discrete"
#> 
#> $is_step_ahead
#> [1] TRUE
#> 
#> $time_unit
#> [1] "week"
#> 
#> attr(,"class")
#> [1] "target_metadata_item" "list"                
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
# For schema version >= v.5.1.0, example with an additional optional property
create_target_metadata_item(
  target_id = "inc hosp",
  target_name = "Weekly incident influenza hospitalizations",
  target_units = "rate per 100,000 population",
  target_keys = list(target = "inc hosp"),
  target_type = "discrete",
  is_step_ahead = TRUE,
  time_unit = "week",
  uri = "http://purl.obolibrary.org/obo/IDO_0000463"
)
#> $target_id
#> [1] "inc hosp"
#> 
#> $target_name
#> [1] "Weekly incident influenza hospitalizations"
#> 
#> $target_units
#> [1] "rate per 100,000 population"
#> 
#> $target_keys
#> $target_keys$target
#> [1] "inc hosp"
#> 
#> 
#> $target_type
#> [1] "discrete"
#> 
#> $is_step_ahead
#> [1] TRUE
#> 
#> $time_unit
#> [1] "week"
#> 
#> $additional_metadata
#> $additional_metadata$uri
#> [1] "http://purl.obolibrary.org/obo/IDO_0000463"
#> 
#> 
#> attr(,"class")
#> [1] "target_metadata_item" "list"                
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
options(hubAdmin.schema_version = "v3.0.1")
create_target_metadata_item(
  target_id = "inc hosp",
  target_name = "Weekly incident influenza hospitalizations",
  target_units = "rate per 100,000 population",
  target_keys = list(target = "inc hosp"),
  target_type = "discrete",
  is_step_ahead = TRUE,
  time_unit = "week"
)
#> $target_id
#> [1] "inc hosp"
#> 
#> $target_name
#> [1] "Weekly incident influenza hospitalizations"
#> 
#> $target_units
#> [1] "rate per 100,000 population"
#> 
#> $target_keys
#> $target_keys$target
#> [1] "inc hosp"
#> 
#> 
#> $target_type
#> [1] "discrete"
#> 
#> $is_step_ahead
#> [1] TRUE
#> 
#> $time_unit
#> [1] "week"
#> 
#> attr(,"class")
#> [1] "target_metadata_item" "list"                
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
options(hubAdmin.schema_version = "latest")
```
