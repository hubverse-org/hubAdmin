#' Download hubverse tasks schema from the hubverse schema repository.
#'
#' @param schema_version the version required. Defaults to "latest".
#' @param branch the branch to download the schema from. Defaults to "main".
#' @param format the format to return the schema in. Defaults to "list". Can be "list" or "json".
#'
#' @return The requested version of the tasks hubverse schema in the specified format.
#' @export
#' @examplesIf curl::has_internet()
#' download_tasks_schema()
#' download_tasks_schema(format = "json")
#' download_tasks_schema(schema_version = "v2.0.1")
download_tasks_schema <- function(schema_version = "latest", branch = "main",
                                  format = c("list", "json")) { # nolint: indentation_linter
    format <- rlang::arg_match(format)

    # Get the latest version available in our GitHub schema repos
    if (schema_version == "latest") {
        schema_version <- hubUtils::get_schema_valid_versions(branch = branch) %>%
            sort() %>%
            utils::tail(1)
    }

    schema_url <- hubUtils::get_schema_url(
        config = "tasks",
        version = schema_version,
        branch = branch
    )

    schema_json <- hubUtils::get_schema(schema_url)

    switch(format,
           list = jsonlite::fromJSON(schema_json,
                                     simplifyDataFrame = FALSE
           ),
           json = schema_json
    )
}
