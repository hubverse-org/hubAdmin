# Create a `task_ids` class object.

Create a `task_ids` class object.

## Usage

``` r
create_task_ids(...)
```

## Arguments

- ...:

  objects of class `task_id` created using function
  [`create_task_id()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_task_id.md)

## Value

a named list of class `task_ids`.

## Details

For more details consult the [documentation on `tasks.json` Hub config
files](https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).

## See also

[`create_task_id()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_task_id.md)

## Examples

``` r
create_task_ids(
  create_task_id("origin_date",
    required = NULL,
    optional = c(
      "2023-01-02",
      "2023-01-09",
      "2023-01-16"
    )
  ),
  create_task_id("scenario_id",
    required = NULL,
    optional = c(
      "A-2021-03-28",
      "B-2021-03-28"
    )
  ),
  create_task_id("location",
    required = "US",
    optional = c("01", "02", "04", "05", "06")
  ),
  create_task_id("target",
    required = "inc hosp",
    optional = NULL
  ),
  create_task_id("horizon",
    required = 1L,
    optional = 2:4
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
#> $task_ids$scenario_id
#> $task_ids$scenario_id$required
#> NULL
#> 
#> $task_ids$scenario_id$optional
#> [1] "A-2021-03-28" "B-2021-03-28"
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
#> $task_ids$target
#> $task_ids$target$required
#> [1] "inc hosp"
#> 
#> $task_ids$target$optional
#> NULL
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
#> attr(,"class")
#> [1] "task_ids" "list"    
#> attr(,"n")
#> [1] 5
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
```
