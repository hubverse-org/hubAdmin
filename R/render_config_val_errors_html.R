#' Render validation errors as an HTML report for GitHub
#'
#' Render the validation errors recorded in the output of [validate_config()]
#' or [validate_hub_config()] as an HTML report using only the markup GitHub
#' displays in a pull request comment or job summary. The report is built from
#' [tabulate_config_val_errors()] and shows the same errors as
#' [view_config_val_errors()].
#'
#' @param x output of [validate_config()] or [validate_hub_config()].
#'
#' @return A single string of HTML, or `NULL` if no errors were detected. The
#' report consists of a paragraph naming the validated path and the schema
#' version, followed by a table with one row per error.
#' @export
#' @seealso [tabulate_config_val_errors()], [view_config_val_errors()]
#' @family functions supporting config file validation
#' @examples
#' \dontrun{
#' config_path <- system.file("error-schema/tasks-errors.json",
#'   package = "hubUtils"
#' )
#' validate_config(config_path = config_path, config = "tasks") |>
#'   render_config_val_errors_html() |>
#'   cat()
#' }
render_config_val_errors_html <- function(x) {
  error_df <- tabulate_config_val_errors(x)
  if (is.null(error_df)) {
    return(NULL)
  }
  paste(
    c(
      html_subtitle(error_df),
      "<table>",
      html_thead(error_df),
      "<tbody>",
      html_rows(error_df),
      "</tbody>",
      "</table>"
    ),
    collapse = "\n"
  )
}

html_subtitle <- function(error_df) {
  sprintf(
    "<p>Report for %s <code>%s</code> using schema version <a href=\"%s\"><b>%s</b></a></p>",
    attr(error_df, "type"),
    html_escape(attr(error_df, "path")),
    html_escape(attr(error_df, "schema_url")),
    html_escape(attr(error_df, "schema_version"))
  )
}

# Two header rows: the column groups, then the column names.
html_thead <- function(error_df) {
  groups <- error_df_col_groups(error_df)
  spanners <- sprintf(
    "<th colspan=\"%d\">%s</th>",
    lengths(groups),
    names(groups)
  ) |>
    sub(pattern = " colspan=\"1\"", replacement = "", fixed = TRUE)
  labels <- sprintf("<th>%s</th>", names(error_df))
  c(
    "<thead>",
    paste0("<tr>", paste(spanners, collapse = ""), "</tr>"),
    paste0("<tr>", paste(labels, collapse = ""), "</tr>"),
    "</thead>"
  )
}

html_rows <- function(error_df) {
  cells <- purrr::imap(
    error_df,
    ~ html_cell(.x, markdown = .y %in% setdiff(markdown_cols, "schema"))
  )
  # See the note on markdown_cols: only the schema cell of a oneOf error holds
  # markdown. Converting a plain schema cell would alter it, for example by
  # reading the underscores of a regular expression as emphasis.
  is_oneof <- error_df[["keyword"]] == "oneOf"
  cells[["schema"]][is_oneof] <- html_cell(
    error_df[["schema"]][is_oneof],
    markdown = TRUE
  )
  paste0(
    "<tr><td>",
    do.call(paste, c(unname(cells), sep = "</td><td>")),
    "</td></tr>"
  )
}

# Convert a column of cell contents to HTML. Every cell is escaped first, since
# commonmark passes raw HTML through. Each newline becomes a line break: the
# sanitiser GitHub applies to comments drops the `white-space` rule that would
# otherwise preserve the lines of a path tree, and a blank line inside the
# table would end the HTML block and leave the remaining rows rendered as
# text. Markdown paragraphs are joined with blank lines rather than wrapped in
# `<p>`, which GitHub renders with margins inside a table cell.
html_cell <- function(x, markdown = FALSE) {
  x <- html_escape(x)
  if (!markdown) {
    return(gsub("\n", "<br>", x, fixed = TRUE))
  }
  purrr::map_chr(x, function(cell) {
    html <- commonmark::markdown_html(cell, hardbreaks = TRUE)
    html <- gsub("<br />\n", "<br>", html, fixed = TRUE)
    html <- gsub("</p>\n<p>", "<br><br>", html, fixed = TRUE)
    html <- sub("^<p>", "", html)
    sub("</p>\n$", "", html)
  })
}

html_escape <- function(x) {
  x <- gsub("&", "&amp;", x, fixed = TRUE)
  x <- gsub("<", "&lt;", x, fixed = TRUE)
  gsub(">", "&gt;", x, fixed = TRUE)
}
