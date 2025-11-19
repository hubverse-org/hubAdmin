# Create an object of class `model_task`

Create an object of class `model_task` representing a model task.
Multiple model tasks can be combined using function
[`create_model_tasks()`](https://hubverse-org.github.io/hubAdmin/reference/create_model_tasks.md).

## Usage

``` r
create_model_task(task_ids, output_type, target_metadata)
```

## Arguments

- task_ids:

  object of class `model_task`.

- output_type:

  object of class `output_type`.

- target_metadata:

  object of class `target_metadata`.

## Value

a named list of class `model_task`.

## See also

[`create_task_ids()`](https://hubverse-org.github.io/hubAdmin/reference/create_task_ids.md),
[`create_output_type()`](https://hubverse-org.github.io/hubAdmin/reference/create_output_type.md),
[`create_target_metadata()`](https://hubverse-org.github.io/hubAdmin/reference/create_target_metadata.md),
[`create_model_tasks()`](https://hubverse-org.github.io/hubAdmin/reference/create_model_tasks.md)

## Examples

``` r
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
#> $task_ids
#> $task_ids$origin_date
#> $task_ids$origin_date$required
#> NULL
#> 
#> $task_ids$origin_date$optional
#> [1] "2023-01-02" "2023-01-09" "2023-01-16"
#> 
#> 
#> $task_ids$location
#> $task_ids$location$required
#> [1] "US"
#> 
#> $task_ids$location$optional
#> [1] "01" "02" "04" "05" "06"
#> 
#> 
#> $task_ids$horizon
#> $task_ids$horizon$required
#> [1] 1
#> 
#> $task_ids$horizon$optional
#> [1] 2 3 4
#> 
#> 
#> 
#> $output_type
#> $output_type$mean
#> $output_type$mean$output_type_id
#> $output_type$mean$output_type_id$required
#> NULL
#> 
#> 
#> $output_type$mean$is_required
#> [1] TRUE
#> 
#> $output_type$mean$value
#> $output_type$mean$value$type
#> [1] "double"
#> 
#> $output_type$mean$value$minimum
#> [1] 0
#> 
#> 
#> 
#> 
#> $target_metadata
#> $target_metadata[[1]]
#> $target_metadata[[1]]$target_id
#> [1] "inc hosp"
#> 
#> $target_metadata[[1]]$target_name
#> [1] "Weekly incident influenza hospitalizations"
#> 
#> $target_metadata[[1]]$target_units
#> [1] "rate per 100,000 population"
#> 
#> $target_metadata[[1]]$target_keys
#> NULL
#> 
#> $target_metadata[[1]]$target_type
#> [1] "discrete"
#> 
#> $target_metadata[[1]]$is_step_ahead
#> [1] TRUE
#> 
#> $target_metadata[[1]]$time_unit
#> [1] "week"
#> 
#> 
#> 
#> attr(,"class")
#> [1] "model_task" "list"      
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
```
