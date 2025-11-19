# Create an `output_type` class object.

Create an `output_type` class object.

## Usage

``` r
create_output_type(...)
```

## Arguments

- ...:

  objects of class `output_type_item` created using functions from the
  `create_output_type_*()` family of functions.

## Value

a named list of class `output_type`.

## Details

For more details consult the [documentation on `tasks.json` Hub config
files](https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).

## See also

[`create_output_type_mean()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_output_type_mean.md),
[`create_output_type_median()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_output_type_mean.md),
[`create_output_type_quantile()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_output_type_quantile.md),
[`create_output_type_cdf()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_output_type_quantile.md),
[`create_output_type_pmf()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_output_type_quantile.md),
[`create_output_type_sample()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_output_type_quantile.md)

## Examples

``` r
create_output_type(
  create_output_type_mean(
    is_required = TRUE,
    value_type = "double",
    value_minimum = 0L
  ),
  create_output_type_median(
    is_required = FALSE,
    value_type = "double"
  ),
  create_output_type_quantile(
    required = c(
      0.1, 0.2, 0.3, 0.4, 0.6,
      0.7, 0.8, 0.9
    ),
    is_required = TRUE,
    value_type = "double",
    value_minimum = 0
  )
)
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
#> $output_type$median
#> $output_type$median$output_type_id
#> $output_type$median$output_type_id$required
#> NULL
#> 
#> 
#> $output_type$median$is_required
#> [1] FALSE
#> 
#> $output_type$median$value
#> $output_type$median$value$type
#> [1] "double"
#> 
#> 
#> 
#> $output_type$quantile
#> $output_type$quantile$output_type_id
#> $output_type$quantile$output_type_id$required
#> [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
#> 
#> 
#> $output_type$quantile$is_required
#> [1] TRUE
#> 
#> $output_type$quantile$value
#> $output_type$quantile$value$type
#> [1] "double"
#> 
#> $output_type$quantile$value$minimum
#> [1] 0
#> 
#> 
#> 
#> 
#> attr(,"class")
#> [1] "output_type" "list"       
#> attr(,"n")
#> [1] 3
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
```
