% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ci_validate_hub_config.R
\name{ci_validate_hub_config}
\alias{ci_validate_hub_config}
\title{Validate Hub config files against hubverse schema}
\usage{
ci_validate_hub_config(
  hub_path = Sys.getenv("HUB_PATH"),
  gh_output = Sys.getenv("GITHUB_OUTPUT"),
  diff = stdout(),
  ...
)
}
\arguments{
\item{hub_path}{path to the hub. Defaults to the value of the \code{HUB_PATH}
environment variable.}

\item{gh_output}{path to a file that can record variables for use by other
actions. This defaults to the value of the \code{GITHUB_OUTPUT} environment
variable.}

\item{diff}{path to a file (defaults to \code{stdout()}) that will contain a user
facing message with a time stamp that shows if the hub was correctly
configured along with the output of \code{\link[=view_config_val_errors]{view_config_val_errors()}} (if any).}

\item{...}{
  Arguments passed on to \code{\link[=validate_hub_config]{validate_hub_config}}
  \describe{
    \item{\code{schema_version}}{Character string specifying the json schema version to
be used for validation. The default value \code{"from_config"} will use the
version specified in the \code{schema_version} property of the config file.
\code{"latest"} will use the latest version available in the hubverse
\href{https://github.com/hubverse-org/schemas}{schemas repository}.
Alternatively, a specific version of a schema (e.g. \code{"v0.0.1"})  can be
specified.}
    \item{\code{branch}}{The branch of the hubverse
\href{https://github.com/hubverse-org/schemas}{schemas repository}
from which to fetch schema. Defaults to \code{"main"}. Can be set through global
option "hubAdmin.branch".}
  }}
}
\value{
Returns a list of the results of validation, one for each \code{hub-config}
file validated. A value of \code{TRUE} for a given file indicates that validation
was successful.
A value of \code{FALSE} for a given file indicates that validation errors were
detected. Details of errors will be appended as a data.frame to an \code{errors} attribute.
To access the errors table for a given element use \code{attr(x, "errors")}
where \code{x} is the any element of the output of the function that is \code{FALSE}.
You can print a more concise and easier to view version of an errors table with
\code{\link[=view_config_val_errors]{view_config_val_errors()}}.
}
\description{
A continuous integration helper
}
\details{
This function is to be used within a continuous integration context. You can
find this used in the \href{https://github.com/hubverse-org/hubverse-actions/tree/main/validate-config}{\code{validate-config} hubverse workflow}.
To use the workflow with your own hub, you can use
\code{hubCI::use_hub_github_action('validate-config')}

This function is intended to be used in a workflow that checks the validity
of a hub's configuration files. Below is an excerpt of steps on GitHub
Actions where the environment variables \code{PR_NUMBER} and \code{HUB_PATH} have been
defined:

\if{html}{\out{<div class="sourceCode yaml">}}\preformatted{     - uses: actions/checkout@v4
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
       shell: Rscript \{0\}
     - name: "Comment on PR"
       id: comment-diff
       if: $\{\{ github.event_name != 'workflow_dispatch' \}\}
       uses: carpentries/actions/comment-diff@main
       with:
         pr: $\{\{ env.PR_NUMBER \}\}
         path: $\{\{ env.HUB_PATH \}\}/diff.md
     - name: Error on Failure
       if: $\{\{ steps.validate.outputs.result == 'false' \}\}
       run: |
         echo "::error title=Invalid Configuration::Errors were detected"
         exit 1
}\if{html}{\out{</div>}}
}
\note{
This function is not intended for interactive use.
}
\examples{
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
hub <- file.path(hubdir, "simple")
ci_validate_hub_config(hub_path = hub, gh_output = out, diff = diff)
# result is true
readLines(out)
# message to user shows success and a timestamp
readLines(diff)

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
# result is now false
readLines(out)
# message to user now shows a table
head(readLines(diff))
tail(readLines(diff))
}
\keyword{internal}
