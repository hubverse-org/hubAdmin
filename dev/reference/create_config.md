# Create a `config` class object.

Create a representation of a complete `"tasks"` config file as a list
object of class `config`. This can be written out to a `tasks.json`
file.

## Usage

``` r
create_config(rounds, output_type_id_datatype = NULL, derived_task_ids = NULL)
```

## Arguments

- rounds:

  An object of class `rounds` created using function
  [`create_rounds()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_rounds.md)

- output_type_id_datatype:

  A character string specifying the value of the
  `output_type_id_datatype` property. Only available since [hubverse
  schema
  v3.0.1](https://github.com/hubverse-org/schemas/releases/tag/v3.0.1).
  Ignored if NULL (default) and throws a warning if a value is provided
  and the schema version used for the config is \<= v3.0.1. This
  property is used to set the data type of the `output_type_id` column
  in model outputs and can take values of `"auto"`, `"character"`,
  `"double"`, `"integer"`, `"logical"`, or `"Date"`. For more details
  consult the [hubDocs documentation on model output
  datatypes](https://docs.hubverse.io/en/latest/user-guide/model-output.html#the-importance-of-a-stable-model-output-file-schema)

- derived_task_ids:

  character vector of derived task id names (i.e. task IDs whose values
  are depended on the values of other task IDs). Only available for
  schema version v4.0.0 and later.

## Value

a named list of class `config`.

## Details

For more details consult the [documentation on `tasks.json` Hub config
files](https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).

## See also

[`create_rounds()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_rounds.md)

## Examples

``` r
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
create_config(rounds)
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
#> [1] "US"
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
#> [1] "01" "02" "04" "05" "06"
#> 
#> 
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
#> $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
#> [1] 1
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
```
