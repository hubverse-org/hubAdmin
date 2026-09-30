#' Validate Hub config files against hubverse schema
#'
#' @description
#' `r lifecycle::badge("superseded")`
#'
#' A continuous integration helper, superseded by the hubverse
#' [`validate-config`
#' action](https://github.com/hubverse-org/hubverse-actions/tree/main/validate-config),
#' which no longer calls it.
#'
#' @param hub_path path to the hub. Defaults to the value of the `HUB_PATH`
#'   environment variable.
#' @param gh_output path to a file that can record variables for use by other
#'   actions. This defaults to the value of the `GITHUB_OUTPUT` environment
#'   variable.
#' @param diff path to a file (defaults to `stdout()`) that will contain a user
#'   facing message with a time stamp that shows if the hub was correctly
#'   configured along with the errors table rendered by
#'   [render_config_val_errors_html()] (if any). The table is capped to fit a
#'   pull request comment and a note gives the number of errors left out.
#' @inheritDotParams validate_hub_config
#' @inherit validate_hub_config return
#'
#' @details
#' This function is to be used within a continuous integration context, in a
#' workflow that checks the validity of a hub's configuration files.
#'
#' The hubverse [`validate-config`
#' action](https://github.com/hubverse-org/hubverse-actions/tree/main/validate-config)
#' is the recommended way to validate a hub's config on pull requests. It posts
#' the report as a comment, writes it to the job summary as well and handles
#' pull requests from forks. To add it to a hub, use
#' `hubCI::use_hub_github_action('validate-config')`.
#'
#' Below is an excerpt of steps on GitHub Actions using this function directly,
#' where the environment variables `PR_NUMBER` and `HUB_PATH` have been
#' defined:
#'
#' ```yaml
#'      - uses: actions/checkout@v4
#'      - uses: r-lib/actions/setup-r@v2
#'        with:
#'          install-r: false
#'          use-public-rspm: true
#'          extra-repositories: 'https://hubverse-org.r-universe.dev'
#'      - uses: r-lib/actions/setup-r-dependencies@v2
#'        with:
#'          cache: 'always'
#'          packages: |
#'            any::hubAdmin
#'            any::sessioninfo
#'      - name: Run validations
#'        id: validate
#'        run: |
#'          diff_path <- file.path(Sys.getenv("HUB_PATH"), "diff.md")
#'          hubAdmin::ci_validate_hub_config(diff = diff_path)
#'        shell: Rscript {0}
#'      - name: "Comment on PR"
#'        id: comment-diff
#'        if: ${{ github.event_name != 'workflow_dispatch' }}
#'        uses: carpentries/actions/comment-diff@main
#'        with:
#'          pr: ${{ env.PR_NUMBER }}
#'          path: ${{ env.HUB_PATH }}/diff.md
#'      - name: Error on Failure
#'        if: ${{ steps.validate.outputs.result == 'false' }}
#'        run: |
#'          echo "::error title=Invalid Configuration::Errors were detected"
#'          exit 1
#' ```
#'
#' @note This function is not intended for interactive use.
#'
#' @keywords internal
#' @export
#' @examples
#' # setup ------------
#' hubdir <- tempfile()
#' out <- tempfile()
#' diff <- tempfile()
#' on.exit({
#'   unlink(hubdir, recursive = TRUE)
#'   unlink(out)
#'   unlink(diff)
#' })
#' dir.create(hubdir)
#' # Results from a valid hub -----------------------------------------
#' file.copy(
#'   from = system.file("testhubs/simple/", package = "hubUtils"),
#'   to = hubdir,
#'   recursive = TRUE
#' )
#' hub <- file.path(hubdir, "simple")
#' ci_validate_hub_config(hub_path = hub, gh_output = out, diff = diff)
#' # result is true
#' readLines(out)
#' # message to user shows success and a timestamp
#' readLines(diff)
#'
#' # Results from an invalid hub --------------------------------------
#' # reset output file
#' out <- tempfile()
#' # make the the simple hub invalid by adding a character where
#' # a number should be
#' tasks_path <- file.path(hub, "hub-config", "tasks.json")
#' tasks <- readLines(tasks_path)
#' writeLines(sub('minimum": 0', 'minimum": "0"', tasks), tasks_path)
#' # validate
#' ci_validate_hub_config(hub_path = hub, gh_output = out, diff = diff)
#' # result is now false
#' readLines(out)
#' # message to user now shows a table
#' head(readLines(diff))
#' tail(readLines(diff))
ci_validate_hub_config <- function(
  hub_path = Sys.getenv("HUB_PATH"),
  gh_output = Sys.getenv("GITHUB_OUTPUT"),
  diff = stdout(),
  ...
) {
  v <- validate_hub_config(hub_path = hub_path, ...)
  tbl <- render_config_val_errors_html(v, max_bytes = comment_max_bytes)
  if (is.null(tbl)) {
    cat("result=true", "\n", file = gh_output, sep = "", append = TRUE)
    writeLines(":white_check_mark: Hub correctly configured!\n", diff)
  } else {
    cat("result=false", "\n", file = gh_output, sep = "", append = TRUE)
    writeLines(invalid_config_report(tbl), diff)
  }
  timestamp(diff)
  v
}

# GitHub rejects a pull request comment over 65,536 characters, so a byte cap
# below that is always safe. The cap leaves room for the text written around
# the table.
comment_max_bytes <- 60000L

invalid_config_report <- function(tbl) {
  c(
    "## :x: Invalid Configuration",
    "",
    paste(
      "Errors were detected in one or more config files in `hub-config/`.",
      "Details about the exact locations of the errors can be found in the table below."
    ),
    "",
    tbl,
    if (attr(tbl, "omitted") > 0L) {
      paste(
        "Run `hubAdmin::validate_hub_config()` on the hub and pass the result",
        "to `hubAdmin::view_config_val_errors()` to see every error."
      )
    },
    "",
    paste(
      "For more information, please consult the",
      "[**`hubDocs` documentation**](https://docs.hubverse.io/en/latest/)."
    )
  )
}

timestamp <- function(outfile) {
  stamp <- format(Sys.time(), usetz = TRUE, tz = "UTC")
  cat(stamp, "\n", file = outfile, sep = "", append = TRUE)
}
