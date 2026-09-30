# Render validation errors as an HTML report for GitHub

Render the validation errors recorded in the output of
[`validate_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_config.md)
or
[`validate_hub_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_hub_config.md)
as an HTML report using only the markup GitHub displays in a pull
request comment or job summary. The report is built from
[`tabulate_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/tabulate_config_val_errors.md)
and shows the same errors as
[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md).

## Usage

``` r
render_config_val_errors_html(x, max_bytes = Inf)
```

## Arguments

- x:

  output of
  [`validate_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_config.md)
  or
  [`validate_hub_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_hub_config.md).

- max_bytes:

  maximum size of the returned HTML in bytes. Rows are dropped from the
  end of the table until the report fits, and a note below the table
  gives the number dropped. GitHub rejects a pull request comment over
  65,536 characters.

## Value

A single string of HTML, or `NULL` if no errors were detected. The
report consists of a paragraph naming the validated path and the schema
version, followed by a table with one row per error. The attribute
`omitted` holds the number of error rows dropped to fit `max_bytes`.

## See also

[`tabulate_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/tabulate_config_val_errors.md),
[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md)

Other functions supporting config file validation:
[`tabulate_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/tabulate_config_val_errors.md),
[`validate_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_config.md),
[`validate_hub_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_hub_config.md),
[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md)

## Examples

``` r
if (FALSE) { # \dontrun{
config_path <- system.file("error-schema/tasks-errors.json",
  package = "hubUtils"
)
validate_config(config_path = config_path, config = "tasks") |>
  render_config_val_errors_html() |>
  cat()
} # }
```
