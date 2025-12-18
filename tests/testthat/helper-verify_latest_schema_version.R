verify_latest_schema_version <- function(x) {
  schema_id_version <- attr(x, "schema_id") |>
    hubUtils::extract_schema_version()
  latest_version <- hubUtils::get_schema_version_latest()
  is_latest <- schema_id_version == latest_version
  if (!is_latest) {
    cli::cli_abort(
      "{.var schema_id} version {.val {schema_id_version}} does not
                       match expected latest version {.val {latest_version}}."
    )
  }

  attr(x, "schema_id") <- "latest"
  if (!is.null(x$schema_version)) {
    x$schema_version <- "latest"
  }
  x
}
