# Tabulate validation errors as a data frame

Compile the validation errors recorded in the output of
[`validate_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_config.md)
or
[`validate_hub_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_hub_config.md)
into a single data frame, processed for display.
[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md)
renders this data frame as a `gt` table. Other tools, for example a
GitHub Actions workflow posting a pull request comment, can render the
same errors in their own format from it.

## Usage

``` r
tabulate_config_val_errors(x)
```

## Arguments

- x:

  output of
  [`validate_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_config.md)
  or
  [`validate_hub_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_hub_config.md).

## Value

A tibble with one row per validation error, or `NULL` if no errors were
detected. It has the following columns:

- `fileName`: the config file the error was found in. Only present for
  [`validate_hub_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_hub_config.md)
  output.

- `instancePath`: location of the error in the config file.

- `schemaPath`: location of the violated rule in the schema.

- `keyword`: the schema keyword that was violated.

- `message`: description of the error, prefixed with a cross mark (❌).

- `schema`: the schema requirement that was violated.

- `data`: the value in the config file that failed validation.

A cell with nothing to show holds an empty string, not `NA`.

The `instancePath`, `schemaPath` and `schema` columns contain markdown.
Each path is laid out as a tree, one element per line, with property
names in bold and array indices converted from 0-based to 1-based.

The following attributes, all plain strings, are attached so that a
caller can reproduce the title and subtitle of the
[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md)
report:

- `path`: the path to the config file or `hub-config` directory
  validated.

- `type`: `"file"` for
  [`validate_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_config.md)
  output, `"directory"` for
  [`validate_hub_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_hub_config.md)
  output.

- `loc_cols`: the names of the columns locating each error.

- `schema_version`: the version of the schema the config was validated
  against.

- `schema_url`: the URL of that schema.

## See also

[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md)

Other functions supporting config file validation:
[`render_config_val_errors_html()`](https://hubverse-org.github.io/hubAdmin/reference/render_config_val_errors_html.md),
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
  tabulate_config_val_errors()
} # }
```
