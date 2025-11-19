# Validate Hub config files against hubverse schema

A continuous integration helper

## Usage

``` r
ci_validate_hub_config(
  hub_path = Sys.getenv("HUB_PATH"),
  gh_output = Sys.getenv("GITHUB_OUTPUT"),
  diff = stdout(),
  ...
)
```

## Arguments

- hub_path:

  path to the hub. Defaults to the value of the `HUB_PATH` environment
  variable.

- gh_output:

  path to a file that can record variables for use by other actions.
  This defaults to the value of the `GITHUB_OUTPUT` environment
  variable.

- diff:

  path to a file (defaults to
  [`stdout()`](https://rdrr.io/r/base/showConnections.html)) that will
  contain a user facing message with a time stamp that shows if the hub
  was correctly configured along with the output of
  [`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/dev/reference/view_config_val_errors.md)
  (if any).

- ...:

  Arguments passed on to
  [`validate_hub_config`](https://hubverse-org.github.io/hubAdmin/dev/reference/validate_hub_config.md)

  `schema_version`

  :   Character string specifying the json schema version to be used for
      validation. The default value `"from_config"` will use the version
      specified in the `schema_version` property of the config file.
      `"latest"` will use the latest version available in the hubverse
      [schemas repository](https://github.com/hubverse-org/schemas).
      Alternatively, a specific version of a schema (e.g. `"v0.0.1"`)
      can be specified.

  `branch`

  :   The branch of the hubverse [schemas
      repository](https://github.com/hubverse-org/schemas) from which to
      fetch schema. Defaults to `"main"`. Can be set through global
      option "hubAdmin.branch".

## Value

Returns a list of the results of validation, one for each `hub-config`
file validated. A value of `TRUE` for a given file indicates that
validation was successful. A value of `FALSE` for a given file indicates
that validation errors were detected. Details of errors will be appended
as a data.frame to an `errors` attribute. To access the errors table for
a given element use `attr(x, "errors")` where `x` is the any element of
the output of the function that is `FALSE`. You can print a more concise
and easier to view version of an errors table with
[`view_config_val_errors()`](https://hubverse-org.github.io/hubAdmin/dev/reference/view_config_val_errors.md).

## Details

This function is to be used within a continuous integration context. You
can find this used in the [`validate-config` hubverse
workflow](https://github.com/hubverse-org/hubverse-actions/tree/main/validate-config).
To use the workflow with your own hub, you can use
`hubCI::use_hub_github_action('validate-config')`

This function is intended to be used in a workflow that checks the
validity of a hub's configuration files. Below is an excerpt of steps on
GitHub Actions where the environment variables `PR_NUMBER` and
`HUB_PATH` have been defined:

         - uses: actions/checkout@v4
         - uses: r-lib/actions/setup-r@v2
           with:
             install-r: false
             use-public-rspm: true
             extra-repositories: 'https://hubverse-org.r-universe.dev'
         - uses: r-lib/actions/setup-r-dependencies@v2
           with:
             cache: 'always'
             packages: |
               any::hubAdmin
               any::sessioninfo
         - name: Run validations
           id: validate
           run: |
             diff_path <- file.path(Sys.getenv("HUB_PATH"), "diff.md")
             hubAdmin::ci_validate_config(diff = diff_path)
           shell: Rscript {0}
         - name: "Comment on PR"
           id: comment-diff
           if: ${{ github.event_name != 'workflow_dispatch' }}
           uses: carpentries/actions/comment-diff@main
           with:
             pr: ${{ env.PR_NUMBER }}
             path: ${{ env.HUB_PATH }}/diff.md
         - name: Error on Failure
           if: ${{ steps.validate.outputs.result == 'false' }}
           run: |
             echo "::error title=Invalid Configuration::Errors were detected"
             exit 1

## Note

This function is not intended for interactive use.

## Examples

``` r
# setup ------------
hubdir <- tempfile()
out <- tempfile()
diff <- tempfile()
on.exit({
  unlink(hubdir, recursive = TRUE)
  unlink(out)
  unlink(diff)
})
dir.create(hubdir)
# Results from a valid hub -----------------------------------------
file.copy(
  from = system.file("testhubs/simple/", package = "hubUtils"),
  to = hubdir,
  recursive = TRUE
)
#> [1] TRUE
hub <- file.path(hubdir, "simple")
ci_validate_hub_config(hub_path = hub, gh_output = out, diff = diff)
#> ✔ Hub correctly configured! 
#> tasks.json, admin.json, and model-metadata-schema.json all valid.
#> ℹ schema version v2.0.0
#> (<https://github.com/hubverse-org/schemas/tree/main/v2.0.0>)
#> 
#> ── $tasks 
#> [1] TRUE
#> ✔ ok:  hub-config/tasks.json (<file:///tmp/RtmpSw77WJ/file1aeb3bbc534f/simple/hub-config/tasks.json>) (via tasks-schema v2.0.0 (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
#> 
#> ── $admin 
#> [1] TRUE
#> ✔ ok:  hub-config/admin.json (<file:///tmp/RtmpSw77WJ/file1aeb3bbc534f/simple/hub-config/admin.json>) (via admin-schema v2.0.0 (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/admin-schema.json>))
#> 
#> ── $model-metadata-schema 
#> [1] TRUE
#> ✔ ok:  hub-config/model-metadata-schema.json (<file:///tmp/RtmpSw77WJ/file1aeb3bbc534f/simple/hub-config/model-metadata-schema.json>) (from default json schema  (<file:///tmp/RtmpSw77WJ/file1aeb3bbc534f/simple/hub-config/model-metadata-schema.json>))
# result is true
readLines(out)
#> [1] "result=true"
# message to user shows success and a timestamp
readLines(diff)
#> [1] ":white_check_mark: Hub correctly configured!"
#> [2] ""                                            
#> [3] "2025-11-19 08:22:34 UTC"                     

# Results from an invalid hub --------------------------------------
# reset output file
out <- tempfile()
# make the the simple hub invalid by adding a character where
# a number should be
tasks_path <- file.path(hub, "hub-config", "tasks.json")
tasks <- readLines(tasks_path)
writeLines(sub('minimum": 0', 'minimum": "0"', tasks), tasks_path)
# validate
ci_validate_hub_config(hub_path = hub, gh_output = out, diff = diff)
#> Warning: ✖ Errors detected in tasks.json config file.
#> ℹ Use `view_config_val_errors()` on the output of `validate_hub_config` to
#>   review errors.
#> ℹ schema version v2.0.0
#> (<https://github.com/hubverse-org/schemas/tree/main/v2.0.0>)
#> 
#> ── $tasks 
#> [1] FALSE
#> ! 4 schema errors: hub-config/tasks.json
#>   (<file:///tmp/RtmpSw77WJ/file1aeb3bbc534f/simple/hub-config/tasks.json>) (via
#>   tasks-schema v2.0.0
#>   (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
#> ℹ use `view_config_val_errors()` to view table of error details.
#> 
#> ── $admin 
#> [1] TRUE
#> ✔ ok:  hub-config/admin.json (<file:///tmp/RtmpSw77WJ/file1aeb3bbc534f/simple/hub-config/admin.json>) (via admin-schema v2.0.0 (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/admin-schema.json>))
#> 
#> ── $model-metadata-schema 
#> [1] TRUE
#> ✔ ok:  hub-config/model-metadata-schema.json (<file:///tmp/RtmpSw77WJ/file1aeb3bbc534f/simple/hub-config/model-metadata-schema.json>) (from default json schema  (<file:///tmp/RtmpSw77WJ/file1aeb3bbc534f/simple/hub-config/model-metadata-schema.json>))
# result is now false
readLines(out)
#> [1] "result=false"
# message to user now shows a table
head(readLines(diff))
#> [1] "## :x: Invalid Configuration"                                                                                                                                     
#> [2] ""                                                                                                                                                                 
#> [3] ""                                                                                                                                                                 
#> [4] "Errors were detected in one or more config files in `hub-config/`. Details about the exact locations of the errors can be found in the table below."              
#> [5] "<div id=\"efoodfieex\" style=\"padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;\">"
#> [6] "  "                                                                                                                                                               
tail(readLines(diff))
#> [1] "<a href=\"https://docs.hubverse.io/en/latest/\" style=\"margin-top: 0; margin-bottom: 0;\"><strong><code>hubDocs</code> documentation</strong>.</a></span></td>"
#> [2] "    </tr>"                                                                                                                                                      
#> [3] "  </tfoot>"                                                                                                                                                     
#> [4] "</table>"                                                                                                                                                       
#> [5] "</div>"                                                                                                                                                         
#> [6] "2025-11-19 08:22:35 UTC"                                                                                                                                        
```
