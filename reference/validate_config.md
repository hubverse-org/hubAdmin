# Validate a hub config file against a hubverse schema

This function validates a single hub config file against it's
corresponding schema. Note that, for `tasks.json` config files,
validation is performed in two stages:

1.  Initial validation against the schema is performed using the
    [`jsonvalidate`](https://docs.ropensci.org/jsonvalidate/) package
    which uses the `"ajv"` (Another JSON Schema Validator) validation
    engine.

2.  If the initial validation is successful, additional dynamic
    validations are performed. This means that only after the initial
    validation passes, will any dynamic validation errors be detected.

## Usage

``` r
validate_config(
  hub_path = ".",
  config = c("tasks", "admin", "target-data"),
  config_path = NULL,
  schema_version = "from_config",
  branch = getOption("hubAdmin.branch", default = "main")
)
```

## Arguments

- hub_path:

  Path to a local hub directory.

- config:

  Name of config file to validate. One of `"tasks"`, `"admin"` or
  `"target-data"`.

- config_path:

  Defaults to `NULL` which assumes all config files are in the
  `hub-config` directory in the root of hub directory. Argument
  `config_path` can be used to override default by providing a path to
  the config file to be validated.

- schema_version:

  Character string specifying the json schema version to be used for
  validation. The default value `"from_config"` will use the version
  specified in the `schema_version` property of the config file.
  `"latest"` will use the latest version available in the hubverse
  [schemas repository](https://github.com/hubverse-org/schemas).
  Alternatively, a specific version of a schema (e.g. `"v0.0.1"`) can be
  specified.

- branch:

  The branch of the hubverse [schemas
  repository](https://github.com/hubverse-org/schemas) from which to
  fetch schema. Defaults to `"main"`. Can be set through global option
  "hubAdmin.branch".

## Value

Returns the result of validation. If validation is successful, will
return `TRUE`. If any validation errors are detected, returns `FALSE`
with details of errors appended as a data.frame to an `errors`
attribute. To access the errors table use `attr(x, "errors")` where `x`
is the output of the function.

You can print a more concise and easier to view version of an errors
table with
[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md).

## See also

[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md)

Other functions supporting config file validation:
[`validate_hub_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_hub_config.md),
[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md)

## Examples

``` r
# Valid config file
validate_config(
  hub_path = system.file(
    "testhubs/simple/",
    package = "hubUtils"
  ),
  config = "tasks"
)
#> [1] TRUE
#> ✔ ok:  hub-config/tasks.json (<file:///home/runner/work/_temp/Library/hubUtils/testhubs/simple/hub-config/tasks.json>) (via tasks-schema v2.0.0 (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
# Config file with errors
config_path <- system.file("error-schema/tasks-errors.json",
  package = "hubUtils"
)
validate_config(config_path = config_path, config = "tasks")
#> Warning: Hub configured using schema version v0.0.0.9. Support for schema earlier than
#> v2.0.0 was deprecated in hubUtils 0.0.0.9010.
#> ℹ Please upgrade Hub config files to conform to, at minimum, version v2.0.0 as
#>   soon as possible.
#> [1] FALSE
#> ! 7 schema errors: error-schema/tasks-errors.json
#>   (<file:///home/runner/work/_temp/Library/hubUtils/error-schema/tasks-errors.json>)
#>   (via tasks-schema v0.0.0.9
#>   (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v0.0.0.9/tasks-schema.json>))
#> ℹ use `view_config_val_errors()` to view table of error details.
```
