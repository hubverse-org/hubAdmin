#' Print a concise and informative version of validation errors table.
#'
#' @param x output of [validate_config()] or [validate_hub_config()].
#'
#' @return prints the errors attribute of x in an informative format to the viewer. Only
#' available in interactive mode. The data frame the table is built from is
#' returned by [tabulate_config_val_errors()].
#' @export
#' @seealso [validate_config()], [tabulate_config_val_errors()]
#' @family functions supporting config file validation
#' @examples
#' \dontrun{
#' config_path <- system.file("error-schema/tasks-errors.json",
#'   package = "hubUtils"
#' )
#' validate_config(config_path = config_path, config = "tasks") |>
#'   view_config_val_errors()
#' }
view_config_val_errors <- function(x) {
  error_df <- tabulate_config_val_errors(x)
  if (is.null(error_df)) {
    cli::cli_alert_success(c(
      "Validation of {.path {attr(x, 'config_path')}}",
      "{.path {attr(x, 'config_dir')}} was successful.",
      "
                             No validation errors to display."
    ))
    return(invisible(NULL))
  }
  render_errors_df(error_df)
}

#' Tabulate validation errors as a data frame
#'
#' Compile the validation errors recorded in the output of [validate_config()]
#' or [validate_hub_config()] into a single data frame, processed for display.
#' [view_config_val_errors()] renders this data frame as a `gt` table. Other
#' tools, for example a GitHub Actions workflow posting a pull request comment,
#' can render the same errors in their own format from it.
#'
#' @param x output of [validate_config()] or [validate_hub_config()].
#'
#' @return A tibble with one row per validation error, or `NULL` if no errors
#' were detected. It has the following columns:
#' - `fileName`: the config file the error was found in. Only present for
#'   [validate_hub_config()] output.
#' - `instancePath`: location of the error in the config file.
#' - `schemaPath`: location of the violated rule in the schema.
#' - `keyword`: the schema keyword that was violated.
#' - `message`: description of the error, prefixed with a cross mark (❌).
#' - `schema`: the schema requirement that was violated.
#' - `data`: the value in the config file that failed validation.
#'
#' The `instancePath`, `schemaPath` and `schema` columns contain markdown.
#' Each path is laid out as a tree, one element per line, with property names
#' in bold and array indices converted from 0-based to 1-based.
#'
#' The following attributes are attached, so that a caller can reproduce the
#' title and subtitle of the [view_config_val_errors()] report:
#' - `path`: the path to the config file or `hub-config` directory validated.
#' - `type`: `"file"` for [validate_config()] output, `"directory"` for
#'   [validate_hub_config()] output.
#' - `loc_cols`: the names of the columns locating each error.
#' - `schema_version`: the version of the schema the config was validated
#'   against.
#' - `schema_url`: the URL of that schema.
#' @export
#' @seealso [view_config_val_errors()]
#' @family functions supporting config file validation
#' @examples
#' \dontrun{
#' config_path <- system.file("error-schema/tasks-errors.json",
#'   package = "hubUtils"
#' )
#' validate_config(config_path = config_path, config = "tasks") |>
#'   tabulate_config_val_errors()
#' }
tabulate_config_val_errors <- function(x) {
  if (all(unlist(x))) {
    return(NULL)
  }
  summarise_errors(x) |>
    format_errors_df()
}

# Columns whose cells hold markdown. Note that a schema cell holds markdown
# only for a oneOf error, where dataframe_to_markdown() lays out the
# alternatives. Every other schema cell is plain text, such as an enum list or
# a regular expression.
markdown_cols <- c("instancePath", "schemaPath", "schema")

# The column groups both renderers show above the column names.
error_df_col_groups <- function(error_df) {
  list(
    "Error location" = attr(error_df, "loc_cols"),
    "Schema details" = c("keyword", "message", "schema"),
    "Config" = "data"
  )
}

# Compile, clean and process validations errors attribute(s) into errors_df
# ready for rendering. Attach necessary metadata as attributes.
summarise_errors <- function(x) {
  if (length(x) > 1L) {
    # Process multiple config file error_tbls
    error_df <- purrr::map2(
      x,
      names(x),
      ~ compile_errors(.x, .y) |>
        clean_error_df()
    ) |>
      purrr::list_rbind()
    attr(error_df, "path") <- attr(x, "config_dir")
    attr(error_df, "type") <- "directory"
    attr(error_df, "loc_cols") <- c(
      "fileName",
      "instancePath",
      "schemaPath"
    )
  } else {
    # Process single config file error_tbl
    error_df <- attr(x, "errors") |>
      clean_error_df()
    attr(error_df, "path") <- attr(x, "config_path")
    attr(error_df, "type") <- "file"
    attr(error_df, "loc_cols") <- c(
      "instancePath",
      "schemaPath"
    )
  }
  attr(error_df, "schema_version") <- attr(x, "schema_version")
  attr(error_df, "schema_url") <- attr(x, "schema_url")

  error_df
}

# Compile errors from multiple config files into a single data.frame
compile_errors <- function(x, file_name) {
  errors_tbl <- attr(x, "errors")
  if (!is.null(errors_tbl)) {
    cbind(
      fileName = rep(fs::path(file_name, ext = "json"), nrow(errors_tbl)),
      errors_tbl
    )
  }
}

# Overall error_df processing to remove superfluous columns, extract pertinent
# information into more standard columns and formats.
clean_error_df <- function(errors_tbl) {
  if (is.null(errors_tbl)) {
    return(NULL)
  }

  # Move any custom error messages to the message column
  if (!is.null(purrr::pluck(errors_tbl, "parentSchema", "errorMessage"))) {
    error_msg <- !is.na(errors_tbl$parentSchema$errorMessage)
    errors_tbl$message[error_msg] <- errors_tbl$parentSchema$errorMessage[
      error_msg
    ]
  }

  errors_tbl[c("dataPath", "parentSchema")] <- NULL
  errors_tbl <- errors_tbl[!grepl("oneOf.+", errors_tbl$schemaPath), ]
  # remove superfluous if error. The "then" error is what we are interested in
  errors_tbl <- errors_tbl[!errors_tbl$keyword == "if", ]
  errors_tbl <- remove_superfluous_enum_rows(errors_tbl)

  # Get rid of unnecessarily verbose data entry when a data column is a data.frame
  if (inherits(errors_tbl$data, "data.frame")) {
    errors_tbl$data <- ""
  }

  # Extract missingProperties property names from params to the data column.
  if (any(errors_tbl$keyword == "required")) {
    errors_tbl <- extract_params_to_data(errors_tbl, "required")
  }

  # Extract additionalProperties property names to the data column.
  if (any(errors_tbl$keyword == "additionalProperties")) {
    errors_tbl <- extract_params_to_data(errors_tbl, "additionalProperties")
  }

  # Remove params column
  errors_tbl["params"] <- NULL

  # The error table output from jsonvalidate contains cells that are comprised of
  # single-element vectors, vectors, lists, and data.frames.
  # We want to collapse each cell into a single character string so that we can
  # create a clean summary table. We do so by processing each row and then each
  # cell in each row individually, collapsing and concatenating as required by
  # the contents of each cell.
  error_df <- split(errors_tbl, seq_len(nrow(errors_tbl))) |>
    purrr::map(~ flatten_error_tbl_row(.x)) |>
    purrr::list_rbind()
  # split long column names
  names(error_df) <- gsub("\\.", " ", names(error_df))

  error_df
}

flatten_error_tbl_row <- function(x) {
  unlist(x, recursive = FALSE) |>
    purrr::map(~ collapse_element(.x)) |>
    tibble::as_tibble()
}
# Collapse individual cell entries to a single string according to their type.
# - data.frames are processed with markdown formatting
# - vectors are collapsed to a comma-separated string
collapse_element <- function(x) {
  if (inherits(x, "data.frame")) {
    return(dataframe_to_markdown(x))
  }
  vector_to_character(x)
}
# Process and mark up data.frame cell entries (e.g. a `properties` df) with
# markdown formatting and collapse to a single string. Mainly applicable to
# oneOf schema column cell formatting.
dataframe_to_markdown <- function(x) {
  # Process data.frame row by row
  rows <- split(x, seq_len(nrow(x))) |>
    purrr::map(
      function(row) {
        row <- unlist(row, use.names = TRUE)
        names(row) <- gsub("properties\\.", "", names(row))
        names(row) <- gsub("\\.", "-", names(row))
        row <- remove_null_properties(row)
        paste0("**", names(row), ":** ", row) |>
          paste(collapse = " \n ")
      }
    ) |>
    unlist(use.names = TRUE)
  result <- paste0("**", names(rows), "** \n ", rows) |>
    paste(collapse = "\n\n ")
  gsub("[^']NA", "'NA'", result)
}

# Process vector error tbl cell entries into a single string
vector_to_character <- function(x) {
  # unlist and collapse list columns
  out <- unlist(x, recursive = TRUE, use.names = TRUE)

  if (length(names(out)) != 0L) {
    out <- paste0(names(out), ": ", out)
  }
  out |> paste(collapse = ", ")
}

# In oneOf validation of point estimate output type IDs,
# the maxItems and matching const property of one of the properties is not
# informative and can be removed. Only relevant to pre v4.0.0 schema versions
remove_null_properties <- function(x) {
  null_maxitem <- names(x[is.na(x) & grepl("maxItems", names(x))])
  x[
    !names(x) %in%
      c(
        null_maxitem,
        gsub(
          "maxItems",
          "const",
          null_maxitem
        )
      )
  ]
}

# Remove rows with duplicate instancePath values that are not informative. This affects
# enum schema deviations in particular
remove_superfluous_enum_rows <- function(errors_tbl) {
  dup_inst <- duplicated(errors_tbl$instancePath)

  if (any(dup_inst)) {
    dup_idx <- errors_tbl$instancePath[dup_inst] |>
      purrr::map(~ which(errors_tbl$instancePath == .x))

    dup_keywords <- purrr::map(dup_idx, ~ errors_tbl$keyword[.x])

    dup_unneccessary <- purrr::map_lgl(
      dup_keywords,
      ~ {
        setequal(.x, c("type", "enum")) || setequal(.x, c("type", "const"))
      }
    )

    if (any(dup_unneccessary)) {
      remove_idx <- purrr::map_int(
        dup_idx[dup_unneccessary],
        ~ .x[2]
      )
      errors_tbl <- errors_tbl[-remove_idx, ]
    }
  }

  errors_tbl
}

# Create tree representation of error (instance and schema) paths
path_to_tree <- function(x) {
  # Split up path and remove blank and root elements
  paths <- strsplit(x, "/") |>
    unlist() |>
    as.list()
  paths <- paths[!(paths == "" | paths == "#")]

  # Highlight property names and convert from 0 to 1 array index
  paths <- paths |>
    purrr::map_if(
      !is.na(as.numeric(paths)),
      ~ as.numeric(.x) + 1
    ) |>
    purrr::map_if(
      !paths %in% c("items", "properties"),
      ~ paste0("**", .x, "**")
    ) |>
    unlist() |>
    suppressWarnings()

  # build path tree
  if (length(paths) > 1L) {
    for (i in 2:length(paths)) {
      paths[i] <- paste0(
        "\u2514",
        paste(rep("\u2500", times = i - 2), collapse = ""),
        paths[i]
      )
    }
  }
  paste(paths, collapse = " \n ")
}

# Extract informative values from params data.frame and add it to the data column
extract_params_to_data <- function(
  errors_tbl,
  param = c(
    "additionalProperties",
    "required"
  )
) {
  param <- rlang::arg_match(param)
  which <- errors_tbl$keyword == param

  # If a params object is missing, replace data column with empty string as
  # the contents are too verbose to be informative and return early
  if (is.null(errors_tbl$params)) {
    errors_tbl$data[which] <- ""
    return(errors_tbl)
  }
  # Get names of missing/additional properties from params object
  at <- switch(
    param,
    required = "missingProperty",
    additionalProperties = "additionalProperty"
  )
  data_vals <- purrr::keep_at(errors_tbl$params, at) |> unlist()

  # Replace appropriate rows in data column with property names
  errors_tbl$data[which] <- data_vals[which]
  errors_tbl
}

escape_pattern_dollar <- function(error_df) {
  is_pattern <- grepl("pattern", error_df[["keyword"]])
  error_df[["schema"]][is_pattern] <- gsub(
    "$",
    "&#36;",
    error_df[["schema"]][is_pattern],
    fixed = TRUE
  )
  error_df
}

# Apply the display transformations every renderer of the errors table shares:
# paths laid out as markdown trees and the error marker on each message.
format_errors_df <- function(error_df) {
  error_df[["schemaPath"]] <- purrr::map_chr(
    error_df[["schemaPath"]],
    path_to_tree
  )
  error_df[["instancePath"]] <- purrr::map_chr(
    error_df[["instancePath"]],
    path_to_tree
  )
  error_df[["message"]] <- paste("\u274c", error_df[["message"]])
  error_df
}

# Render the data frame returned by tabulate_config_val_errors() as a gt table.
render_errors_df <- function(error_df) {
  # Escape `$` characters to ensure regex pattern does not trigger equation
  # formatting in markdown
  error_df <- escape_pattern_dollar(error_df)
  schema_version <- attr(error_df, "schema_version")
  schema_url <- attr(error_df, "schema_url")
  path <- attr(error_df, "path")
  type <- attr(error_df, "type")

  title <- gt::md("**`hubAdmin` config validation error report**")
  subtitle <- gt::md(
    glue::glue(
      "Report for {type} **`{path}`** using
                   schema version [**{schema_version}**]({schema_url})"
    )
  )

  # Create table ----
  tbl <- gt::gt(error_df) |>
    gt::tab_header(
      title = title,
      subtitle = subtitle
    )
  groups <- error_df_col_groups(error_df)
  for (label in names(groups)) {
    tbl <- gt::tab_spanner(
      tbl,
      label = gt::md(paste0("**", label, "**")),
      columns = groups[[label]]
    )
  }
  tbl |>
    gt::fmt_markdown(columns = markdown_cols) |>
    gt::tab_style(
      style = gt::cell_text(whitespace = "pre"),
      locations = gt::cells_body(columns = markdown_cols)
    ) |>
    gt::tab_style(
      style = gt::cell_text(whitespace = "pre-wrap"),
      locations = gt::cells_body(columns = "schema")
    ) |>
    gt::tab_style(
      style = list(
        gt::cell_fill(color = "#F9E3D6"),
        gt::cell_text(weight = "bold")
      ),
      locations = gt::cells_body(
        columns = c("message", "data")
      )
    ) |>
    gt::cols_width(
      "schema" ~ gt::pct(1.5 / 6 * 100),
      "data" ~ gt::pct(1 / 6 * 100),
      "message" ~ gt::pct(1 / 6 * 100)
    ) |>
    gt::cols_align(
      align = "center",
      columns = c(
        "keyword",
        "message",
        "data"
      )
    ) |>
    gt::tab_options(
      column_labels.font.weight = "bold",
      table.margin.left = gt::pct(2),
      table.margin.right = gt::pct(2),
      data_row.padding = gt::px(5),
      heading.background.color = "#F0F3F5",
      column_labels.background.color = "#F0F3F5"
    ) |>
    gt::tab_source_note(
      source_note = gt::md(
        "For more information, please consult the
                                 [**`hubDocs` documentation**.](https://docs.hubverse.io/en/latest/)"
      )
    )
}
