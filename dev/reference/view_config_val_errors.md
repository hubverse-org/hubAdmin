# Print a concise and informative version of validation errors table.

Print a concise and informative version of validation errors table.

## Usage

``` r
view_config_val_errors(x)
```

## Arguments

- x:

  output of
  [`validate_config()`](https://hubverse-org.github.io/hubAdmin/dev/reference/validate_config.md)
  or
  [`validate_hub_config()`](https://hubverse-org.github.io/hubAdmin/dev/reference/validate_hub_config.md).

## Value

prints the errors attribute of x in an informative format to the viewer.
Only available in interactive mode. The data frame the table is built
from is returned by
[`tabulate_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/dev/reference/tabulate_config_val_errors.md).

## See also

[`validate_config()`](https://hubverse-org.github.io/hubAdmin/dev/reference/validate_config.md),
[`tabulate_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/dev/reference/tabulate_config_val_errors.md)

Other functions supporting config file validation:
[`render_config_val_errors_html()`](https://hubverse-org.github.io/hubAdmin/dev/reference/render_config_val_errors_html.md),
[`tabulate_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/dev/reference/tabulate_config_val_errors.md),
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
