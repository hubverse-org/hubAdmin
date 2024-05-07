get_config_file_schema_version <- function(config_path, config) {
  config_schema_version <- jsonlite::read_json(config_path)$schema_version

  if (is.null(config_schema_version)) {
    cli::cli_abort(c("x" = "Property {.code schema_version} not found in config file."))
  }

  check_config_schema_version(config_schema_version,
    config = config
  )

  version <- extract_schema_version(config_schema_version)

  if (length(version) == 0L) {
    cli::cli_abort(
      c(
        "x" = "Valid {.field version} could not be extracted from config
            file {.file {config_path}}",
        "!" = "Please check property {.val schema_version} is correctly formatted."
      )
    )
  }

  version
}


check_config_schema_version <- function(schema_version, config = c("tasks", "admin")) {
  config <- rlang::arg_match(config)

  check_filename <- grepl(
    glue::glue("/{config}-schema.json$"),
    schema_version
  )
  if (!check_filename) {
    cli::cli_abort(c(
      "x" = "{.code schema_version} property {.url {schema_version}}
                     does not point to appropriate schema file.",
      "i" = "{.code schema_version} basename should be
                     {.file {config}-schema.json} but is {.file {basename(schema_version)}}"
    ))
  }

  check_prefix <- grepl(
    "https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/",
    schema_version,
    fixed = TRUE
  )

  if (!check_prefix) {
    cli::cli_abort(c(
      "x" = "Invalid {.code schema_version} property.",
      "i" = "Valid {.code schema_version} properties should start with
                         {.val https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/}
                         and resolve to the schema file's raw contents on GitHub."
    ))
  }
}


validate_schema_version_property <- function(validation, config = c("tasks", "admin")) {
  config <- rlang::arg_match(config)
  schema_version <- jsonlite::read_json(attr(validation, "config_path"),
    simplifyVector = TRUE,
    simplifyDataFrame = FALSE
  )$schema_version
  schema <- hubUtils::get_schema(attr(validation, "schema_url"))


  errors_tbl <- NULL
  check_filename <- grepl(
    glue::glue("/{config}-schema.json$"),
    schema_version
  )
  if (!check_filename) {
    errors_tbl <- rbind(
      errors_tbl,
      data.frame(
        instancePath = get_error_path(schema, "schema_version", "instance"),
        schemaPath = get_error_path(schema, "schema_version", "schema"),
        keyword = "schema_version file name",
        message = glue::glue(
          "'schema_version' property does not point to corresponding schema file for config '{config}'. ",
          "Should be '{config}-schema.json' but is '{basename(schema_version)}'"
        ),
        schema = "",
        data = schema_version
      )
    )
  }

  check_prefix <- grepl("https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/",
    schema_version,
    fixed = TRUE
  )

  if (!check_prefix) {
    errors_tbl <- rbind(
      errors_tbl,
      data.frame(
        instancePath = get_error_path(schema, "schema_version", "instance"),
        schemaPath = get_error_path(schema, "schema_version", "schema"),
        keyword = "schema_version prefix",
        message = paste(
          "Invalid 'schema_version' property. Should start with",
          "'https://raw.githubusercontent.com/Infectious-Disease-Modeling-Hubs/schemas/main/'"
        ),
        schema = "",
        data = schema_version
      )
    )
  }

  if (!is.null(errors_tbl)) {
    # assign FALSE without loosing attributes
    validation[] <- FALSE
    attr(validation, "errors") <- rbind(
      attr(validation, "errors"),
      errors_tbl
    )
  }

  return(validation)
}
