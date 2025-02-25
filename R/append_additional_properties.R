#' Append additional property config paths to a list of schema paths
#'
#' @param config a config class object
#' @param paths a list of schema paths of elements that should be treated as additional properties
#'
#' @return the `paths` list with any config paths identified as valid additional properties
#' from the schema appended to the end and any schema paths containing
#' `"additionalProperty"` elements removed.
#' Additional property config paths are also transformed to schema paths by inserting
#' "items" elements where appropriate.
#' @noRd
append_additional_properties <- function(config, paths) {
  additional_properties <- purrr::keep(
    paths,
    ~ is_additional_property(.x)
  )
  config_paths <- get_config_paths(config)

  additional_property_paths <- purrr::map(
    additional_properties,
    \(.x) keep_additional_property_config_paths(.x, config_paths)
  ) |>
    purrr::list_flatten()

  # Remove schema additional property paths
  paths <- purrr::keep(paths, ~ !is_additional_property(.x))

  # Append valid config additional property paths
  c(paths, additional_property_paths) |> unique()
}

is_additional_property <- function(schema_path) {
  purrr::has_element(schema_path, "additionalProperties") &&
    utils::tail(schema_path, 1L) != "additionalProperties"
}

# extract config paths from a config object
get_config_paths <- function(config) {
  config |>
    unlist(use.names = TRUE) |>
    names() |>
    stringr::str_remove("[0-9]+$") |>
    unique() |>
    stringr::str_split("\\.")
}

# Keep any config_paths that match an additional_property path. The "additionalProperty"
# element in the path is treated like a wildcard. Paths are also transformed to schema
# paths by adding "items" elements appropriately.
keep_additional_property_config_paths <- function(additional_property, config_paths) {
  purrr::keep(
    config_paths,
    ~ is_valid_additional_property(.x, additional_property)
  ) |> purrr::map(~ add_items(.x, additional_property))
}

# Given an additionalProperty schema path, detect whether a config path is a
# valid additional property that matches it. The "additionalProperty"
# element in the schema path is treated like a wildcard.
is_valid_additional_property <- function(x, additional_property) {
  x <- add_items(x, additional_property)
  if (length(x) == 0L || length(x) == 1L && is.na(x)) {
    return(FALSE)
  }

  idx <- which(additional_property == "additionalProperties")
  all(x[-idx] == additional_property[-idx])
}

# Given a config path and a schema path with "items" element, pad the config path
# with "items" elements so that it matches the length of the schema path.
add_items <- function(config_path, schema_path) {
  items_n <- sum(schema_path == "items")
  if (length(config_path) + items_n != length(schema_path)) {
    return(NA)
  }

  non_items_idx <- which(schema_path != "items")
  out <- schema_path
  out[non_items_idx] <- config_path
  out
}
