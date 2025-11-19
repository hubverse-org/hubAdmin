# Create a `target_metadata` class object.

Create a `target_metadata` class object.

## Usage

``` r
create_target_metadata(...)
```

## Arguments

- ...:

  objects of class `target_metadata_item` created using function
  [`create_target_metadata_item()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_target_metadata_item.md)

## Value

a named list of class `target_metadata`.

## Details

For more details consult the [documentation on `tasks.json` Hub config
files](https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).

## See also

[`create_target_metadata_item()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_target_metadata_item.md)

## Examples

``` r
create_target_metadata(
  create_target_metadata_item(
    target_id = "inc hosp",
    target_name = "Weekly incident influenza hospitalizations",
    target_units = "rate per 100,000 population",
    target_keys = list(target = "inc hosp"),
    target_type = "discrete",
    is_step_ahead = TRUE,
    time_unit = "week"
  ),
  create_target_metadata_item(
    target_id = "inc death",
    target_name = "Weekly incident influenza deaths",
    target_units = "rate per 100,000 population",
    target_keys = list(target = "inc death"),
    target_type = "discrete",
    is_step_ahead = TRUE,
    time_unit = "week"
  )
)
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
#> $target_metadata[[1]]$target_keys$target
#> [1] "inc hosp"
#> 
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
#> $target_metadata[[2]]
#> $target_metadata[[2]]$target_id
#> [1] "inc death"
#> 
#> $target_metadata[[2]]$target_name
#> [1] "Weekly incident influenza deaths"
#> 
#> $target_metadata[[2]]$target_units
#> [1] "rate per 100,000 population"
#> 
#> $target_metadata[[2]]$target_keys
#> $target_metadata[[2]]$target_keys$target
#> [1] "inc death"
#> 
#> 
#> $target_metadata[[2]]$target_type
#> [1] "discrete"
#> 
#> $target_metadata[[2]]$is_step_ahead
#> [1] TRUE
#> 
#> $target_metadata[[2]]$time_unit
#> [1] "week"
#> 
#> 
#> 
#> attr(,"class")
#> [1] "target_metadata" "list"           
#> attr(,"n")
#> [1] 2
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
```
