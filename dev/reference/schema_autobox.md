# Box elements of a `<config>` class object that can be arrays

Due to inconsistencies between R and JSON data types, in particular the
fact that R has no concept of a scalar, when writing R list objects to
JSON with
[`write_config()`](https://hubverse-org.github.io/hubAdmin/dev/reference/write_config.md),
some properties in the output file may not conform to schema
expectations. In particular, list elements that are vectors of length
`1L` will be written as scalars, regardless of whether the schema
expects an array. This function uses the hubverse schema to identify
elements that can be arrays and "box" any such elements that exist in
the `<config>` object and have a length of 1. This ensures that they are
written out as arrays instead of scalars in JSON output files. The
transformation is also applied to any properties that should be arrays
covered by `additionalProperties` in the schema (e.g. custom task IDs).

## Usage

``` r
schema_autobox(config, box_extra_paths = NULL)
```

## Arguments

- config:

  a `<config>` class object.

- box_extra_paths:

  a list of character vectors of paths to elements in the `<config>`
  that can be arrays of vectors but are not covered by the schema.
  Elements in a path where arrays of objects are expected should be
  encoded as `"items"`. See output of
  [`get_array_schema_paths()`](https://hubverse-org.github.io/hubAdmin/dev/reference/get_array_schema_paths.md)
  for more details, especially the examples.

## Value

a `<config>` class object with list elements that can be arrays boxed.

## Examples

``` r
config <- create_config(
  create_rounds(
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
)
schema_autobox(config)
#> $schema_version
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> 
#> $rounds
#> $rounds[[1]]
#> $rounds[[1]]$round_id_from_variable
#> [1] TRUE
#> 
#> $rounds[[1]]$round_id
#> [1] "origin_date"
#> 
#> $rounds[[1]]$model_tasks
#> $rounds[[1]]$model_tasks[[1]]
#> $rounds[[1]]$model_tasks[[1]]$task_ids
#> $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date
#> $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$required
#> NULL
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$optional
#> [1] "2023-01-02" "2023-01-09" "2023-01-16"
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$location
#> $rounds[[1]]$model_tasks[[1]]$task_ids$location$required
#> $rounds[[1]]$model_tasks[[1]]$task_ids$location$required[[1]]
#> [1] "US"
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
#> [1] "01" "02" "04" "05" "06"
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required[[1]]
#> [1] 1
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$optional
#> [1] 2 3 4
#> 
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required
#> NULL
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$is_required
#> [1] TRUE
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$value
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$type
#> [1] "double"
#> 
#> $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$minimum
#> [1] 0
#> 
#> 
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_id
#> [1] "inc hosp"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
#> [1] "Weekly incident influenza hospitalizations"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
#> [1] "rate per 100,000 population"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
#> NULL
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
#> [1] "discrete"
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
#> [1] TRUE
#> 
#> $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
#> [1] "week"
#> 
#> 
#> 
#> 
#> 
#> $rounds[[1]]$submissions_due
#> $rounds[[1]]$submissions_due$relative_to
#> [1] "origin_date"
#> 
#> $rounds[[1]]$submissions_due$start
#> [1] -4
#> 
#> $rounds[[1]]$submissions_due$end
#> [1] 2
#> 
#> 
#> 
#> 
#> attr(,"class")
#> [1] "config" "list"  
#> attr(,"type")
#> [1] "tasks"
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
schema_autobox(config) |>
  jsonlite::toJSON(
    auto_unbox = TRUE, na = "string",
    null = "null", pretty = TRUE
  )
#> {
#>   "schema_version": "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json",
#>   "rounds": [
#>     {
#>       "round_id_from_variable": true,
#>       "round_id": "origin_date",
#>       "model_tasks": [
#>         {
#>           "task_ids": {
#>             "origin_date": {
#>               "required": null,
#>               "optional": ["2023-01-02", "2023-01-09", "2023-01-16"]
#>             },
#>             "location": {
#>               "required": [
#>                 "US"
#>               ],
#>               "optional": ["01", "02", "04", "05", "06"]
#>             },
#>             "horizon": {
#>               "required": [
#>                 1
#>               ],
#>               "optional": [2, 3, 4]
#>             }
#>           },
#>           "output_type": {
#>             "mean": {
#>               "output_type_id": {
#>                 "required": null
#>               },
#>               "is_required": true,
#>               "value": {
#>                 "type": "double",
#>                 "minimum": 0
#>               }
#>             }
#>           },
#>           "target_metadata": [
#>             {
#>               "target_id": "inc hosp",
#>               "target_name": "Weekly incident influenza hospitalizations",
#>               "target_units": "rate per 100,000 population",
#>               "target_keys": null,
#>               "target_type": "discrete",
#>               "is_step_ahead": true,
#>               "time_unit": "week"
#>             }
#>           ]
#>         }
#>       ],
#>       "submissions_due": {
#>         "relative_to": "origin_date",
#>         "start": -4,
#>         "end": 2
#>       }
#>     }
#>   ]
#> } 
```
