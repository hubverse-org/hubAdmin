#' Create a `target_metadata` class object.
#'
#' @param ... objects of class `target_metadata_item` created using function
#' [`create_target_metadata_item()`]
#'
#' @return a named list of class `target_metadata`.
#' @export
#' @seealso [create_target_metadata_item()]
#' @details For more details consult
#' the [documentation on `tasks.json` Hub config files](
#' https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html).
#'
#' @examples
#' create_target_metadata(
#'   create_target_metadata_item(
#'     target_id = "inc hosp",
#'     target_name = "Weekly incident influenza hospitalizations",
#'     target_units = "rate per 100,000 population",
#'     target_keys = list(target = "inc hosp"),
#'     target_type = "discrete",
#'     is_step_ahead = TRUE,
#'     time_unit = "week"
#'   ),
#'   create_target_metadata_item(
#'     target_id = "inc death",
#'     target_name = "Weekly incident influenza deaths",
#'     target_units = "rate per 100,000 population",
#'     target_keys = list(target = "inc death"),
#'     target_type = "discrete",
#'     is_step_ahead = TRUE,
#'     time_unit = "week"
#'   )
#' )
create_target_metadata <- function(...) {
  collect_items(
    ...,
    item_class = "target_metadata_item",
    output_class = "target_metadata",
    flatten = FALSE
  )
}


check_schema_id_attr <- function(
  items,
  attribute = c("schema_id", "branch"),
  call = rlang::caller_env()
) {
  attribute <- rlang::arg_match(attribute)
  schema_id_attr <- purrr::map_chr(
    items,
    ~ attr(.x, attribute)
  )

  unique_n <- schema_id_attr |>
    unique() |>
    length()

  if (unique_n > 1L) {
    # Check wether items are not of the same class (i.e. we're collecting task_ids,
    # output_types and target_metadata instead of e.g. a number of individual task ids)
    diff_classes <- !purrr::reduce(purrr::map(items, ~ class(.x)), identical)
    if (diff_classes) {
      item_names <- purrr::map_chr(items, ~ names(.x))
      schema_id_attr <- paste(item_names, ":", schema_id_attr)
      obj_ref <- "Argument" # nolint: object_usage_linter
    } else {
      schema_id_attr <- paste(
        "Item",
        seq_along(schema_id_attr),
        ":",
        schema_id_attr
      )
      obj_ref <- "Item"
    }
    names(schema_id_attr) <- rep("*", length(schema_id_attr))

    cli::cli_abort(
      c(
        "!" = "All {tolower(obj_ref)}s supplied must be created against the same Hub schema.",
        "x" = "{.arg {attribute}} attributes are not consistent across all {tolower(obj_ref)}s.",
        "{obj_ref} {.arg {attribute}} attributes:",
        schema_id_attr
      ),
      call = call
    )
  }

  unique(schema_id_attr)
}


check_item_classes <- function(items, class, call = rlang::caller_env()) {
  is_wrong_class <- purrr::map_lgl(
    items,
    ~ !inherits(.x, class)
  )

  if (any(is_wrong_class)) {
    cli::cli_abort(
      c(
        "!" = "All items supplied must inherit from class {.cls {class}}",
        "x" = "{cli::qty(sum(is_wrong_class))} Item{?s} {.val {which(is_wrong_class)}}
        {cli::qty(sum(is_wrong_class))} do{?es/} not."
      ),
      call = call
    )
  }
}

check_target_metadata_properties_unique <- function(
  items,
  property, # nolint: object_length_linter
  call = rlang::caller_env()
) {
  item_properties <- purrr::map(
    items,
    ~ .x[[property]]
  )

  if (any(duplicated(item_properties))) {
    duplicate_idx <- which(duplicated(item_properties)) # nolint: object_usage_linter

    cli::cli_abort(
      c(
        "!" = "{.arg {property}}s must be unique across all
          {.arg target_metadata_item}s.",
        "x" = "{cli::qty(length(duplicate_idx))} {.arg target_metadata_item}{?s}
          {.val {duplicate_idx}} with {.arg {property}} value {.val {item_properties[duplicate_idx]}}
          {cli::qty(length(duplicate_idx))} {?is/are} duplicate{?s}."
      ),
      call = call
    )
  }
}
