#' Check input properties against the schema
#'
#' Iterate check_input function on each property of a specific type. Issue
#' appropriate warnings and errors if the input properties do not match
#' expected schema
#' @param properties a named list of input properties
#' @param schema a list representation of a schema or sub-schema
#' @param parent_property the name of the parent property, if any. Necessary when
#' checking output type `value` properties.
#' @param call the calling environment
#'
#' @return NULL. The functions are called for their side effects.
#' @noRd
# Check scalar properties against the schema
check_properties_scalar <- function(properties, schema, parent_property = NULL,
                                    call = rlang::caller_env()) {
  schema_names <- prop_type_scalar(schema)
  property_names <- intersect(schema_names, names(properties))

  purrr::walk(
    property_names,
    function(.x) {
      check_input(
        input = properties[[.x]],
        property = .x,
        schema,
        parent_property = parent_property,
        scalar = TRUE,
        call = call
      )
    }
  )
}

# Check array properties against the schema
check_properties_array <- function(properties, schema, parent_property = NULL,
                                   call = rlang::caller_env()) {
  schema_names <- prop_type_array(schema)
  property_names <- intersect(schema_names, names(properties))

  purrr::walk(
    property_names,
    function(.x) {
      check_input(
        input = properties[[.x]],
        property = .x,
        schema,
        parent_property = parent_property,
        scalar = FALSE,
        call = call
      )
    }
  )
}
