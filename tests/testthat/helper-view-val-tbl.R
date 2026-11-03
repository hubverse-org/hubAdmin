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

# Check the columns of an error table that `view_config_val_errors()` renders
# against the columns in `expected`.
expect_error_tbl <- function(object, expected) {
  expect_equal(
    object[names(expected)],
    expected,
    ignore_attr = c("path", "type", "loc_cols", "schema_version", "schema_url")
  )
}

# Check the attributes of an error table that describe the config and schema
# validated.
expect_error_tbl_attrs <- function(
  object,
  path,
  schema_version,
  schema_url,
  type = "file"
) {
  expect_equal(as.character(attr(object, "path")), as.character(path))
  expect_equal(attr(object, "type"), type)
  expect_equal(
    attr(object, "loc_cols"),
    switch(
      type,
      file = c("instancePath", "schemaPath"),
      directory = c("fileName", "instancePath", "schemaPath")
    )
  )
  expect_equal(attr(object, "schema_version"), schema_version)
  expect_equal(attr(object, "schema_url"), schema_url)
}

# Check a rendered `schema` value of a `oneOf` error: two numbered options,
# each with a type entry for every property in `props`.
# Note that the descriptions in the rendered value come from the remote schema,
# so they are not checked.
expect_oneof_schema <- function(object, props) {
  options <- strsplit(object, "\n\n ", fixed = TRUE)[[1]]
  expect_length(options, 2L)
  expect_true(all(startsWith(options, c("**1** \n ", "**2** \n "))))
  for (prop in props) {
    expect_match(options, paste0("**", prop, "-type:**"), fixed = TRUE)
  }
}
