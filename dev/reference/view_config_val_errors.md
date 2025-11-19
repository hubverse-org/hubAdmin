# Print a concise and informative version of validation errors table.

Print a concise and informative version of validation errors table.

## Usage

``` r
view_config_val_errors(x)
```

## Arguments

- x:

  output of
  [`validate_config()`](https://hubverse-org.github.io/hubAdmin/dev/reference/validate_config.md).

## Value

prints the errors attribute of x in an informative format to the viewer.
Only available in interactive mode.

## See also

[`validate_config()`](https://hubverse-org.github.io/hubAdmin/dev/reference/validate_config.md)

Other functions supporting config file validation:
[`validate_config()`](https://hubverse-org.github.io/hubAdmin/dev/reference/validate_config.md),
[`validate_hub_config()`](https://hubverse-org.github.io/hubAdmin/dev/reference/validate_hub_config.md)

## Examples

``` r
if (FALSE) { # \dontrun{
config_path <- system.file("error-schema/tasks-errors.json",
  package = "hubUtils"
)
validate_config(config_path = config_path, config = "tasks") |>
  view_config_val_errors()
} # }
```
