#' Check if target data config file exists in hub
#'
#' @inheritParams hubUtils::read_config
#'
#' @return Logical. `TRUE` if the target-data.json file exists in the `hub-config` directory of the hub, `FALSE` otherwise.
#' @export
#'
#' @examples
#' config_hub <- system.file("testhubs/v6/target_file/", package = "hubUtils")
#' has_target_data_config(config_hub)
#'
#' no_config_hub <- system.file("testhubs/v5/target_file/", package = "hubUtils")
#' has_target_data_config(no_config_hub)
has_target_data_config <- function(hub_path) {
  UseMethod("has_target_data_config")
}

#' @rdname has_target_data_config
#' @export
has_target_data_config.default <- function(hub_path) {
  fs::file_exists(
    fs::path(hub_path, "hub-config", "target-data.json")
  )
}

#' @rdname has_target_data_config
#' @export
has_target_data_config.SubTreeFileSystem <- function(hub_path) {
  config_path <- fs::path("hub-config", "target-data.json")
  hub_path$GetFileInfo(config_path)[[1]]$type != 0L
}
