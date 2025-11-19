# Validate model-metadata-schema config file

Validate model-metadata-schema config file

## Usage

``` r
validate_model_metadata_schema(hub_path = ".")
```

## Arguments

- hub_path:

  Path to a local hub directory.

## Value

Returns the result of validation. If validation is successful, will
return `TRUE`. If any validation errors are detected, returns `FALSE`
with details of errors appended as a data.frame to an `errors`
attribute. To access the errors table use `attr(x, "errors")` where `x`
is the output of the function.

You can print a more concise and easier to view version of an errors
table with
[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/reference/view_config_val_errors.md).

## Details

Checks that a `model-metadata-schema.json` config file exists in
`hub-config`, can be successfully parsed and contains at least either a
`model_id` property or both `team_abbr` and `model_abbr` properties.

## Examples

``` r
validate_model_metadata_schema(
  hub_path = system.file(
    "testhubs/simple/",
    package = "hubUtils"
  )
)
#> [1] TRUE
#> ✔ ok:  hub-config/model-metadata-schema.json (<file:///home/runner/work/_temp/Library/hubUtils/testhubs/simple/hub-config/model-metadata-schema.json>) (from default json schema  (<file:///home/runner/work/_temp/Library/hubUtils/testhubs/simple/hub-config/model-metadata-schema.json>))
```
