#' Extract the schema version from a schema `id` or config `schema_version` property
#' character string
#'
#' @param id A schema `id` or config `schema_version` property character string.
#'
#' @return The schema version number as a character string.
#' @export
#'
#' @examples
#' extract_version_n(
#'   "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/v3.0.0/tasks-schema.json"
#' )
extract_version_n <- function(id) {
  stringr::str_extract(id, "v([0-9]\\.){2}[0-9](\\.[0-9]+)?")
}
