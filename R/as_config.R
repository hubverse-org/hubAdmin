#' Coerce a config list to a config class object
#'
#' `r lifecycle::badge('deprecated')`
#'
#' The function has moved to the `hubUtils` package and will be removed from
#' `hubAdmin` in the next release. Please use `hubUtils::as_config()` instead.
#'
#' Note as well that [hubUtils::read_config()] and [hubUtils::read_config_file()]
#' call `as_config()` on their output by default from `hubUtils` `0.2.0`.
#' @param x a list representation of the contents a `tasks.json` config file.
#' Often the output of [hubUtils::read_config()] or
#' [hubUtils::read_config_file()].
#'
#' @return a config list object with superclass `<config>`.
#' @export
#'
#' @examples
#' config_tasks <- hubUtils::read_config(
#'   hub_path = system.file("testhubs/simple", package = "hubUtils")
#' )
#' hubUtils::as_config(config_tasks)
as_config <- function(x) {
  lifecycle::deprecate_soft(
    "1.3.0",
    "as_config()",
    "hubUtils::as_config()"
  )
  hubUtils::as_config(x)
}
