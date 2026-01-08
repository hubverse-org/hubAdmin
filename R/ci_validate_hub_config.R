#' Validate Hub config files against hubverse schema
#'
#' A continuous integration helper
#'
#' @param hub_path path to the hub. Defaults to the value of the `HUB_PATH`
#'   environment variable.
#' @param gh_output path to a file that can record variables for use by other
#'   actions. This defaults to the value of the `GITHUB_OUTPUT` environment
#'   variable.
#' @param diff path to a file (defaults to `stdout()`) that will contain a user
#'   facing message with a time stamp that shows if the hub was correctly
#'   configured along with the output of [view_config_val_errors()] (if any).
#' @inheritDotParams validate_hub_config
#' @inherit validate_hub_config return
#'
#' @details
#' This function is to be used within a continuous integration context. You can
#' find this used in the [`validate-config` hubverse
#' workflow](https://github.com/hubverse-org/hubverse-actions/tree/main/validate-config).
#' To use the workflow with your own hub, you can use
#' `hubCI::use_hub_github_action('validate-config')`
#'
#' This function is intended to be used in a workflow that checks the validity
#' of a hub's configuration files. Below is an excerpt of steps on GitHub
#' Actions where the environment variables `PR_NUMBER` and `HUB_PATH` have been
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
#'          hubAdmin::ci_validate_config(diff = diff_path)
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
  # check if there were any failures
  invalid <- any(vapply(v, isFALSE, logical(1)))
  if (invalid) {
    cat("result=false", "\n", file = gh_output, sep = "", append = TRUE)
    # write output to HTML
    tbl <- view_config_val_errors(v)
    writeLines("## :x: Invalid Configuration\n", diff)
    txt <- c(
      "\nErrors were detected in one or more config files in `hub-config/`. ",
      "Details about the exact locations of the errors can be found in the table below.\n"
    )
    cat(txt, file = diff, sep = "", append = TRUE)
    cat(gt::as_raw_html(tbl), "\n", file = diff, sep = "", append = TRUE)
    timestamp(diff)
  } else {
    cat("result=true", "\n", file = gh_output, sep = "", append = TRUE)
    writeLines(":white_check_mark: Hub correctly configured!\n", diff)
    timestamp(diff)
  }
  v
}

timestamp <- function(outfile) {
  stamp <- format(Sys.time(), usetz = TRUE, tz = "UTC")
  cat(stamp, "\n", file = outfile, sep = "", append = TRUE)
}
