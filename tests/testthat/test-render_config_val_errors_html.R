test_that("render_config_val_errors_html renders a single config's errors", {
  skip_if_offline()
  config_path <- testthat::test_path("testdata", "tasks-errors.json")
  validation <- suppressWarnings(
    validate_config(config_path = config_path)
  )
  html <- render_config_val_errors_html(validation)

  expect_type(html, "character")
  expect_length(html, 1L)
  # only the markup GitHub renders
  expect_no_match(html, "style=")
  expect_no_match(html, "<td><p>", fixed = TRUE)
  expect_snapshot(cat(html))
})

test_that("render_config_val_errors_html renders validate_hub_config output", {
  skip_if_offline()
  validation <- suppressWarnings(
    validate_hub_config(testthat::test_path("testdata", "error_hub"))
  )
  html <- render_config_val_errors_html(validation)

  expect_match(html, "^<p>Report for directory <code>")
  expect_match(html, "<th colspan=\"3\">Error location</th>", fixed = TRUE)
  expect_match(html, "<td>tasks.json</td>", fixed = TRUE)
})

test_that("render_config_val_errors_html returns NULL when validation passed", {
  skip_if_offline()
  validation <- suppressMessages(
    validate_hub_config(
      system.file("testhubs/simple/", package = "hubUtils")
    )
  )
  expect_null(render_config_val_errors_html(validation))
})

test_that("html_rows converts schema cells as markdown only for oneOf errors", {
  error_df <- tibble::tibble(
    instancePath = c("**rounds**", "**rounds**"),
    schemaPath = c("properties", "properties"),
    keyword = c("pattern", "oneOf"),
    message = c("m", "m"),
    schema = c("^\\d+_x_\\d+$", "**1** \n **a:** b"),
    data = c("d", "d")
  )
  rows <- html_rows(error_df)
  expect_match(rows[1], "<td>^\\d+_x_\\d+$</td>", fixed = TRUE)
  expect_match(
    rows[2],
    "<td><strong>1</strong><br><strong>a:</strong> b</td>",
    fixed = TRUE
  )
})

test_that("html_cell escapes HTML and converts markdown", {
  expect_equal(
    html_cell("a <b>raw</b> & tag"),
    "a &lt;b&gt;raw&lt;/b&gt; &amp; tag"
  )
  # A blank line inside the table would end the HTML block on GitHub
  expect_equal(html_cell("a\n\nb"), "a<br><br>b")
  expect_equal(
    html_cell("**rounds** \n └**1**", markdown = TRUE),
    "<strong>rounds</strong><br>└<strong>1</strong>"
  )
  expect_equal(
    html_cell("**1** \n **a:** x\n\n **2** \n **b:** y", markdown = TRUE),
    "<strong>1</strong><br><strong>a:</strong> x<br><br><strong>2</strong><br><strong>b:</strong> y"
  )
})
