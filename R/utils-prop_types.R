#' Get the names of properties that are of a certain type
#'
#' @param schema a list representation of a schema or sub-schema
#' @param invert logical, if TRUE, return the names of properties that are
#' not of the specified type. Default is FALSE.
#'
#' @return a character vector of property names
#' @noRd
# Get names of properties that are arrays
prop_type_array <- function(schema, invert = FALSE) {
  predicate <- function(.x) {
    if (is.list(.x)) {
      "array" %in% .x$type && .x$items$type != "object"
    } else {
      FALSE
    }
  }
  if (invert) {
    predicate <- Negate(predicate)
  }
  purrr::keep(schema, predicate) |> names()
}

# Get names of properties that are arrays of objects
prop_type_object_array <- function(schema, invert = FALSE) {
  predicate <- function(.x) {
    if (is.list(.x)) {
      "array" %in% .x$type && .x$items$type == "object"
    } else {
      FALSE
    }
  }
  if (invert) {
    predicate <- Negate(predicate)
  }
  purrr::keep(schema, predicate) |> names()
}

# Get names of properties that are objects
prop_type_object <- function(schema, invert = FALSE) {
  predicate <- function(.x) {
    if (is.list(.x)) {
      "object" %in% .x$type
    } else {
      FALSE
    }
  }
  if (invert) {
    predicate <- Negate(predicate)
  }
  purrr::keep(schema, predicate) |> names()
}

# Get names of properties that are scalars
prop_type_scalar <- function(schema, invert = FALSE) {
  predicate <- function(.x) {
    if (is.list(.x)) {
      any(is.element(
        .x$type,
        c("string", "integer", "number", "boolean")
      ))
    } else {
      FALSE
    }
  }
  if (invert) {
    predicate <- Negate(predicate)
  }
  purrr::keep(schema, predicate) |> names()
}
