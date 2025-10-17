# Helper function to create a test hub with target-data.json

#' Create a test hub with custom target-data.json config
#'
#' @param target_data_config List representing the target-data.json config
#' @param base_hub Character name of base hub from hubUtils to use (default: "v6/target_file")
#' @param envir Environment for withr scoping (default: parent.frame())
#'
#' @return Path to the temporary hub directory
create_test_hub_with_target_data <- function(
  target_data_config,
  base_hub = "v6/target_file",
  envir = parent.frame()
) {
  # Copy base hub from hubUtils to temp location
  hub_path <- system.file(file.path("testhubs", base_hub), package = "hubUtils")

  # Create temp directory for this specific hub (scoped to test, not function)
  hub_dir <- withr::local_tempdir(.local_envir = envir)

  # Copy all contents from hub_path to hub_dir
  files <- list.files(hub_path, full.names = TRUE, all.files = FALSE)
  file.copy(files, hub_dir, recursive = TRUE)

  if (!is.null(target_data_config)) {
    # Write target-data.json
    write_config(
      as_config(target_data_config),
      config_path = file.path(
        hub_dir,
        "hub-config",
        "target-data.json"
      ),
      overwrite = TRUE,
      silent = TRUE
    )
  }

  hub_dir
}
