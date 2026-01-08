#' Print a concise and informative version of validation errors table.
#'
#' @param x output of [validate_config()].
#'
#' @return prints the errors attribute of x in an informative format to the viewer. Only
#' available in interactive mode.
#' @export
#' @seealso [validate_config()]
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
  if (all(unlist(x))) {
    cli::cli_alert_success(c(
      "Validation of {.path {attr(x, 'config_path')}}",
      "{.path {attr(x, 'config_dir')}} was successful.",
      "
                             No validation errors to display."
    ))
    return(invisible(NULL))
  }
  error_df <- summarise_errors(x)
  render_errors_df(error_df)
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

render_errors_df <- function(error_df) {
  schema_version <- attr(error_df, "schema_version")
  schema_url <- attr(error_df, "schema_url")
  path <- attr(error_df, "path")
  type <- attr(error_df, "type")
  loc_cols <- attr(error_df, "loc_cols")

  title <- gt::md("**`hubAdmin` config validation error report**")
  subtitle <- gt::md(
    glue::glue(
      "Report for {type} **`{path}`** using
                   schema version [**{schema_version}**]({schema_url})"
    )
  )

  # format path and error message columns
  error_df[["schemaPath"]] <- purrr::map_chr(
    error_df[["schemaPath"]],
    path_to_tree
  )
  error_df[["instancePath"]] <- purrr::map_chr(
    error_df[["instancePath"]],
    path_to_tree
  )
  error_df[["message"]] <- paste("\u274c", error_df[["message"]])
  # Escape `$` characters to ensure regex pattern does not trigger equation
  # formatting in markdown
  error_df <- escape_pattern_dollar(error_df)

  # Create table ----
  gt::gt(error_df) |>
    gt::tab_header(
      title = title,
      subtitle = subtitle
    ) |>
    gt::tab_spanner(
      label = gt::md("**Error location**"),
      columns = loc_cols
    ) |>
    gt::tab_spanner(
      label = gt::md("**Schema details**"),
      columns = c(
        "keyword",
        "message",
        "schema"
      )
    ) |>
    gt::tab_spanner(
      label = gt::md("**Config**"),
      columns = "data"
    ) |>
    gt::fmt_markdown(
      columns = c(
        "instancePath",
        "schemaPath",
        "schema"
      )
    ) |>
    gt::tab_style(
      style = gt::cell_text(whitespace = "pre"),
      locations = gt::cells_body(
        columns = c(
          "instancePath",
          "schemaPath",
          "schema"
        )
      )
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
