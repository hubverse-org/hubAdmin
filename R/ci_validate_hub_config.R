#' Validate Hub config files against hubverse schema on Continuous Integration
#'
#' @param hub_path path to the hub. Defaults to the value of the `HUB_PATH`
#'   environment variable.
#' @param gh_output path to a file that can record variables for use by other
#'   actions. This defaults to the value of the `GITHUB_OUTPUT` environment
#'   variable.
#' @param arguments passed on to [validate_hub_config()].
#'
#' @return a logical value indicating if the hub config is valid or not. This
#' has the side-effect of creating a file called `diff.md` in the `hub_path`
#' directory. If running interactively, it will need to be cleaned up.
#'
#' @
ci_validate_hub_config <- function(hub_path = Sys.getenv("HUB_PATH"), gh_output = Sys.getenv("GITHUB_OUTPUT"), ...) {
  diff <- file.path(hub_path, "diff.md")
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
  return(v)
}

timestamp <- function(outfile) {
  stamp <- format(Sys.time(), usetz = TRUE, tz = "UTC")
  cat(stamp, "\n", file = outfile, sep = "", append = TRUE)
}
