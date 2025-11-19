# Validate Hub config files against hubverse schema.

Validate the `admin.json`, `tasks.json`, `target-data.json` (if present)
and `model-metadata-schema.json` Hub config files in a single call. Note
that, for `tasks.json` and `model-metadata-schema.json` config files,
validation is performed in two stages:

1.  Initial validation against the schema is performed using the
    [`jsonvalidate`](https://docs.ropensci.org/jsonvalidate/) package
    which uses the `"ajv"` (Another JSON Schema Validator) validation
    engine. In the case of `model-metadata-schema.json`, `jsonvalidate`
    just checks that the file is valid JSON and can be parsed correctly.

2.  If the initial validation is successful, additional dynamic
    validations are performed. This means that only after the initial
    validation passes, will any dynamic validation errors be detected.

## Usage

``` r
validate_hub_config(
  hub_path = ".",
  schema_version = "from_config",
  branch = getOption("hubAdmin.branch", default = "main")
)
```

## Arguments

- hub_path:

  Path to a local hub directory.

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

Returns a list of the results of validation, one for each `hub-config`
file validated. A value of `TRUE` for a given file indicates that
validation was successful. A value of `FALSE` for a given file indicates
that validation errors were detected. Details of errors will be appended
as a data.frame to an `errors` attribute. To access the errors table for
a given element use `attr(x, "errors")` where `x` is the any element of
the output of the function that is `FALSE`. You can print a more concise
and easier to view version of an errors table with
[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md).

## See also

[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md)

Other functions supporting config file validation:
[`validate_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_config.md),
[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md)

## Examples

``` r
validate_hub_config(
  hub_path = system.file(
    "testhubs/simple/",
    package = "hubUtils"
  )
)
#> ✔ Hub correctly configured! 
#> tasks.json, admin.json, and model-metadata-schema.json all valid.
#> ℹ schema version v2.0.0
#> (<https://github.com/hubverse-org/schemas/tree/main/v2.0.0>)
#> 
#> ── $tasks 
#> [1] TRUE
#> ✔ ok:  hub-config/tasks.json (<file:///home/runner/work/_temp/Library/hubUtils/testhubs/simple/hub-config/tasks.json>) (via tasks-schema v2.0.0 (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
#> 
#> ── $admin 
#> [1] TRUE
#> ✔ ok:  hub-config/admin.json (<file:///home/runner/work/_temp/Library/hubUtils/testhubs/simple/hub-config/admin.json>) (via admin-schema v2.0.0 (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/admin-schema.json>))
#> 
#> ── $model-metadata-schema 
#> [1] TRUE
#> ✔ ok:  hub-config/model-metadata-schema.json (<file:///home/runner/work/_temp/Library/hubUtils/testhubs/simple/hub-config/model-metadata-schema.json>) (from default json schema  (<file:///home/runner/work/_temp/Library/hubUtils/testhubs/simple/hub-config/model-metadata-schema.json>))
```
