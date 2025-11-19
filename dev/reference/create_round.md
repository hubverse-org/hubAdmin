# Create an object of class `round`

Create a representation of a round item as a list object of class
`round`. This can be combined with additional `round` objects using
function
[`create_rounds()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_rounds.md).
Such building blocks can ultimately be combined and then written out as
or appended to `tasks.json` Hub config files.

## Usage

``` r
create_round(
  round_id_from_variable,
  round_id,
  round_name = NULL,
  model_tasks,
  submissions_due,
  last_data_date = NULL,
  file_format = NULL,
  derived_task_ids = NULL,
  ...
)
```

## Arguments

- round_id_from_variable:

  logical. Whether `round_id` is inferred from the values of a `task_id`
  variable within the `model_tasks` `model_task` items.

- round_id:

  character string. The round identifier. If
  `round_id_from_variable = TRUE`, `round_id` should be the name of a
  `task_id` variable present in all `model_tasks` `model_task` items.

- round_name:

  character string. An optional round name. This can be useful for
  internal referencing of rounds, for examples, when a date is used as
  `round_id` but hub maintainers and teams also refer to rounds as
  round-1, round-2 etc.

- model_tasks:

  an object of class `model_tasks` created with function
  [`create_model_tasks()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_model_tasks.md).

- submissions_due:

  named list conforming to one of the two following structures:

  1.  Submission dates for round is determined relative to an origin
      date.

      - `relative_to`: character string of the name of the `task_id`
        variable containing origin dates in relation to which submission
        start and end dates are determined.

      - `start`: integer. Difference in days between start and origin
        date.

      - `end`: integer. Difference in days between end and origin date.

  2.  Submission dates for round are provided explicitly.

      - `start`: character. Submission start date in ISO 8601 format
        (YYYY-MM-DD).

      - `end`: character. Submission end date in ISO 8601 format
        (YYYY-MM-DD).

- last_data_date:

  character date in ISO 8601 format (YYYY-MM-DD). The last date with
  recorded data in the data set used as input to a model. Optional.

- file_format:

  character string. An optional specification of a file format for the
  round. This option in only available for some versions of the schema
  and is ignored if not allowed in the version of the schema used. It
  also overrides any specification of file format in `admin.json`. For
  more details on whether this argument can be used as well as available
  formats, please consult the [documentation on `tasks.json` Hub config
  files](https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).

- derived_task_ids:

  character vector of derived task id names (i.e. task IDs whose values
  are depended on the values of other task IDs). Only available for
  schema version v4.0.0 and later.

- ...:

  additional optional properties to add to the round list output. In
  schema versions greater or equal to v6.0.0, these properties are
  placed in the `additional_metadata` field.

## Value

a named list of class `round`.

## Details

For more details consult the [documentation on `tasks.json` Hub config
files](https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).

## See also

[`create_rounds()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_rounds.md)

## Examples

``` r
model_tasks <- create_model_tasks(
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
)
create_round(
  round_id_from_variable = TRUE,
  round_id = "origin_date",
  model_tasks = model_tasks,
  submissions_due = list(
    relative_to = "origin_date",
    start = -4L,
    end = 2L
  ),
  last_data_date = "2023-01-02"
)
#> $round_id_from_variable
#> [1] TRUE
#> 
#> $round_id
#> [1] "origin_date"
#> 
#> $model_tasks
#> $model_tasks[[1]]
#> $model_tasks[[1]]$task_ids
#> $model_tasks[[1]]$task_ids$origin_date
#> $model_tasks[[1]]$task_ids$origin_date$required
#> NULL
#> 
#> $model_tasks[[1]]$task_ids$origin_date$optional
#> [1] "2023-01-02" "2023-01-09" "2023-01-16"
#> 
#> 
#> $model_tasks[[1]]$task_ids$location
#> $model_tasks[[1]]$task_ids$location$required
#> [1] "US"
#> 
#> $model_tasks[[1]]$task_ids$location$optional
#> [1] "01" "02" "04" "05" "06"
#> 
#> 
#> $model_tasks[[1]]$task_ids$horizon
#> $model_tasks[[1]]$task_ids$horizon$required
#> [1] 1
#> 
#> $model_tasks[[1]]$task_ids$horizon$optional
#> [1] 2 3 4
#> 
#> 
#> 
#> $model_tasks[[1]]$output_type
#> $model_tasks[[1]]$output_type$mean
#> $model_tasks[[1]]$output_type$mean$output_type_id
#> $model_tasks[[1]]$output_type$mean$output_type_id$required
#> NULL
#> 
#> 
#> $model_tasks[[1]]$output_type$mean$is_required
#> [1] TRUE
#> 
#> $model_tasks[[1]]$output_type$mean$value
#> $model_tasks[[1]]$output_type$mean$value$type
#> [1] "double"
#> 
#> $model_tasks[[1]]$output_type$mean$value$minimum
#> [1] 0
#> 
#> 
#> 
#> 
#> $model_tasks[[1]]$target_metadata
#> $model_tasks[[1]]$target_metadata[[1]]
#> $model_tasks[[1]]$target_metadata[[1]]$target_id
#> [1] "inc hosp"
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$target_name
#> [1] "Weekly incident influenza hospitalizations"
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$target_units
#> [1] "rate per 100,000 population"
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$target_keys
#> NULL
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$target_type
#> [1] "discrete"
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
#> [1] TRUE
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$time_unit
#> [1] "week"
#> 
#> 
#> 
#> 
#> 
#> $submissions_due
#> $submissions_due$relative_to
#> [1] "origin_date"
#> 
#> $submissions_due$start
#> [1] -4
#> 
#> $submissions_due$end
#> [1] 2
#> 
#> 
#> $last_data_date
#> [1] "2023-01-02"
#> 
#> attr(,"class")
#> [1] "round" "list" 
#> attr(,"round_id")
#> [1] "origin_date"
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
# For schema version >= v6.0.0, example with an additional optional property
create_round(
  round_id_from_variable = TRUE,
  round_id = "origin_date",
  model_tasks = model_tasks,
  submissions_due = list(
    relative_to = "origin_date",
    start = -4L,
    end = 2L
  ),
  last_data_date = "2023-01-02",
  round_label = "Round 1",
  data_source = "https://example.com/data"
)
#> $round_id_from_variable
#> [1] TRUE
#> 
#> $round_id
#> [1] "origin_date"
#> 
#> $model_tasks
#> $model_tasks[[1]]
#> $model_tasks[[1]]$task_ids
#> $model_tasks[[1]]$task_ids$origin_date
#> $model_tasks[[1]]$task_ids$origin_date$required
#> NULL
#> 
#> $model_tasks[[1]]$task_ids$origin_date$optional
#> [1] "2023-01-02" "2023-01-09" "2023-01-16"
#> 
#> 
#> $model_tasks[[1]]$task_ids$location
#> $model_tasks[[1]]$task_ids$location$required
#> [1] "US"
#> 
#> $model_tasks[[1]]$task_ids$location$optional
#> [1] "01" "02" "04" "05" "06"
#> 
#> 
#> $model_tasks[[1]]$task_ids$horizon
#> $model_tasks[[1]]$task_ids$horizon$required
#> [1] 1
#> 
#> $model_tasks[[1]]$task_ids$horizon$optional
#> [1] 2 3 4
#> 
#> 
#> 
#> $model_tasks[[1]]$output_type
#> $model_tasks[[1]]$output_type$mean
#> $model_tasks[[1]]$output_type$mean$output_type_id
#> $model_tasks[[1]]$output_type$mean$output_type_id$required
#> NULL
#> 
#> 
#> $model_tasks[[1]]$output_type$mean$is_required
#> [1] TRUE
#> 
#> $model_tasks[[1]]$output_type$mean$value
#> $model_tasks[[1]]$output_type$mean$value$type
#> [1] "double"
#> 
#> $model_tasks[[1]]$output_type$mean$value$minimum
#> [1] 0
#> 
#> 
#> 
#> 
#> $model_tasks[[1]]$target_metadata
#> $model_tasks[[1]]$target_metadata[[1]]
#> $model_tasks[[1]]$target_metadata[[1]]$target_id
#> [1] "inc hosp"
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$target_name
#> [1] "Weekly incident influenza hospitalizations"
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$target_units
#> [1] "rate per 100,000 population"
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$target_keys
#> NULL
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$target_type
#> [1] "discrete"
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
#> [1] TRUE
#> 
#> $model_tasks[[1]]$target_metadata[[1]]$time_unit
#> [1] "week"
#> 
#> 
#> 
#> 
#> 
#> $submissions_due
#> $submissions_due$relative_to
#> [1] "origin_date"
#> 
#> $submissions_due$start
#> [1] -4
#> 
#> $submissions_due$end
#> [1] 2
#> 
#> 
#> $last_data_date
#> [1] "2023-01-02"
#> 
#> $additional_metadata
#> $additional_metadata$round_label
#> [1] "Round 1"
#> 
#> $additional_metadata$data_source
#> [1] "https://example.com/data"
#> 
#> 
#> attr(,"class")
#> [1] "round" "list" 
#> attr(,"round_id")
#> [1] "origin_date"
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
```
