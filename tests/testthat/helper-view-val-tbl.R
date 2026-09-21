extract_error_tbl_cols <- function(
  x,
  cols = c(
    "message"
  )
) {
  attr(x, "errors")[cols] |>
    tibble::as_tibble()
}

recode_font <- function(tbl) {
  tbl_font_nm_idx <- which(tbl$`_options`$parameter == "table_font_names")
  tbl$`_options`$value[[tbl_font_nm_idx]] <- "test-font"

  tbl
}
