#' Check that inputs to create_* functions conform to hubverse schema.
#' Function used primarily to check that properties of inputs to the create_*
#' family of functions, used to create hub config programmatically, conform to
#' expectation defined in the hubverse schema.
#' @param input Vector. The value of the property of the input to be checked.
#' @param property Character string. The name of the property of the input to be checked.
#' @param parent_schema List representation of the schema of the parent object.
#' @param parent_property Character string. The name of the parent object of the property
#' to be checked.
#' @param scalar Logical. whether the property being checked is scalar.
#' @param call Name of the caller fn. For internal error signalling.
#'
#' @return Function used primarily for it's side effects of signalling errors when
#' input does not conform to schema.
#' @noRd
check_input <- function(input, property, parent_schema, # nolint: cyclocomp_linter
                        parent_property,
                        scalar = FALSE,
                        call = rlang::caller_env()) {
  property_name <- property # nolint: object_usage_linter
  if (!is.null(parent_property) && parent_property == "value") {
    property_name <- paste0("value_", property)
  }

  property_schema <- parent_schema[[property]]

  if (is.null(input)) {
    property_types <- property_schema[["type"]]
    if (!"null" %in% property_types) {
      cli::cli_abort(c("x" = "{.arg {property_name}} cannot be NULL."),
        call = call
      )
    } else {
      return()
    }
  }
  if (!is.atomic(input) || is.pairlist(input)) {
    cli::cli_abort(c("x" = "{.arg {property_name}} must be an atomic vector."),
      call = call
    )
  }

  if (is.factor(input)) {
    cli::cli_abort(c("x" = "{.arg {property_name}} cannot be of class
                     {.cls factor}."),
      call = call
    )
  }

  if (scalar) {
    if (length(input) != 1L) {
      cli::cli_abort(
        c(
          "x" = "{.arg {property_name}} must be length {.val {1}},
          not {.val {length(input)}}."
        ),
        call = call
      )
    }
  }

  if (any(names(property_schema) == "maxItems")) {
    if (scalar) {
      max_items <- 1
    } else {
      max_items <- property_schema[["maxItems"]]
    }
    is_invalid <- length(input) > max_items
    if (is_invalid) {
      cli::cli_abort(
        c(
          "x" = "{.arg {property_name}} must be of length equal to or less than
                {.val {max_items}} but is of length {.val {length(input)}}."
        ),
        call = call
      )
    }
  }
  if (any(names(property_schema) == "minItems")) {
    min_items <- property_schema[["minItems"]]
    is_invalid <- length(input) < min_items
    if (is_invalid) {
      cli::cli_abort(
        c(
          "x" = "{.arg {property_name}} must be of length equal to or greater
                than {.val {min_items}} but is of length {.val {length(input)}}."
        ),
        call = call
      )
    }
  }

  if (any(names(property_schema) == "uniqueItems")) {
    unique_items <- property_schema[["uniqueItems"]]
    if (unique_items && any(duplicated(input))) {
      duplicates <- input[duplicated(input)] # nolint: object_usage_linter
      cli::cli_abort(
        c(
          "!" = "All values in {.arg {property_name}} must be unique.",
          "x" = "{cli::qty(sum(duplicates))} Value{?s} {.val {duplicates}}
        {cli::qty(sum(duplicates))} {?is/are} duplicated."
        ),
        call = call
      )
    }
  }

  # Array item validation
  if (scalar) {
    value_schema <- property_schema
  } else {
    value_schema <- property_schema[["items"]]
  }

  input_type <- typeof(input)
  value_formats <- value_schema[["format"]]
  # Handle situation where type must be missing but can be inferred from `const` or
  # `enum` properties. Clunky but included for back compatibility.
  if (any(names(value_schema) == "type")) {
    value_types <- json_datatypes[value_schema[["type"]]]
  } else {
    if (any(names(value_schema) == "enum")) {
      value_types <- typeof(value_schema[["enum"]])
    } else if (any(names(value_schema) == "const")) {
      value_types <- typeof(value_schema[["const"]])
    } else {
      value_types <- NULL
      cli::cli_warn(
        c(
          "!" = "Cannot determine appropriate type for argument
        {.arg {property_name}}, type validation skipped.
         Schema may be invalid. Consult relevant schema and consider opening an issue at
        {.url https://github.com/hubverse-org/schemas/issues}"
        ),
        call = call
      )
    }
  }

  if (!is.null(value_formats) && value_formats == "date" && typeof(input) != "character") {
    cli::cli_abort(c("x" = "{cli::qty(length(input))} {.arg {property_name}}
                         value{?s} must be character string{?s} of date{?s} in valid
                         ISO 8601 format (YYYY-MM-DD). Date object format not accepted.
                         Consider using {.code as.character()} to convert to character."),
      call = call
    )
  }

  if (!is.null(value_formats) && value_formats == "date" && anyNA(as.Date(input, format = "%Y-%m-%d"))
  ) {
    cli::cli_abort(c("x" = "{cli::qty(length(input))} {.arg {property_name}}
                         value{?s} must be character string{?s} of date{?s} in valid
                         ISO 8601 format (YYYY-MM-DD)."),
      call = call
    )
  }

  if (!is.null(value_types) && !input_type %in% value_types) {
    cli::cli_abort(
      c(
        "x" = "{.arg {property_name}} is of type {.cls {input_type}}.",
        "!" = "Must be {?/one of} {.cls {value_types}}."
      ),
      call = call
    )
  }

  if (any(names(value_schema) == "maximum")) {
    value_max <- value_schema[["maximum"]]
    is_invalid <- input > value_max
    if (any(is_invalid)) {
      cli::cli_abort(
        c(
          "!" = "All values in {.arg {property_name}} must be equal to or less
                than {.val {value_max}}.",
          "x" = "{cli::qty(sum(is_invalid))} Value{?s} {.val {input[is_invalid]}}
                {cli::qty(sum(is_invalid))}{?is/are} greater."
        ),
        call = call
      )
    }
  }

  if (any(names(value_schema) == "minimum")) {
    value_min <- value_schema[["minimum"]]
    is_invalid <- input < value_min
    if (any(is_invalid)) {
      cli::cli_abort(
        c(
          "!" = "All values in {.arg {property_name}} must be equal to or greater
                than {.val {value_min}}.",
          "x" = "{cli::qty(sum(is_invalid))} Value{?s} {.val {input[is_invalid]}}
                {cli::qty(sum(is_invalid))}{?is/are} less."
        ),
        call = call
      )
    }
  }

  if (any(names(value_schema) == "enum")) {
    if (any(!input %in% value_schema[["enum"]])) {
      invalid_values <- input[!input %in% value_schema[["enum"]]] # nolint: object_usage_linter
      cli::cli_abort(
        c(
          "x" = "{.arg {property_name}} {cli::qty(length(invalid_values))}
        value{?s} {?is/are} invalid.",
          "!" = "Must be {cli::qty(if(scalar){1}else{2})} {?one of/member in}
        {.val {value_schema[['enum']]}}.",
          "i" = "Actual value{?s} {?is/are} {.val {invalid_values}}"
        ),
        call = call
      )
    }
  }

  if (any(names(value_schema) == "const")) {
    value_const <- value_schema[["const"]]
    if (any(input != value_const)) {
      cli::cli_abort(
        c(
          "x" = "{.arg {property_name}} value is invalid.",
          "!" = "Must be {.val {value_const}}.",
          "i" = "Actual value is {.val {input}}"
        ),
        call = call
      )
    }
  }

  if (any(names(value_schema) == "minLength")) {
    is_invalid <- stringr::str_length(input) < value_schema[["minLength"]]
    if (any(is_invalid)) {
      cli::cli_abort(
        c(
          "!" = "The minimum number of characters allowed for values in
                {.arg {property_name}} is {.val {value_schema[['minLength']]}}.",
          "x" = "Value{?s} {.val {input[is_invalid]}} {?has/have}
                fewer characters than allowed."
        ),
        call = call
      )
    }
  }

  if (any(names(value_schema) == "maxLength")) {
    is_invalid <- stringr::str_length(input) > value_schema[["maxLength"]]
    if (any(is_invalid)) {
      cli::cli_abort(
        c(
          "!" = "The maximum number of characters allowed for values in
                {.arg {property_name}} is {.val {value_schema[['maxLength']]}}.",
          "x" = "Value{?s} {.val {input[is_invalid]}} {?has/have}
                more characters than allowed"
        ),
        call = call
      )
    }
  }


  if (any(names(value_schema) == "multipleOf")) {
    is_invalid <- input %% value_schema[["multipleOf"]] != 0L
    if (any(is_invalid)) {
      cli::cli_abort(
        c(
          "!" = "Values in {.arg {property_name}} must be multiples of
                {.val {value_schema[['multipleOf']]}}.",
          "x" = "{cli::qty(sum(is_invalid))} Value{?s}
                {.val {input[is_invalid]}} {cli::qty(sum(is_invalid))} {?is/are} not."
        ),
        call = call
      )
    }
  }
}

# Used to check properties that contain oneOf schema properties.
check_oneof_input <- function(input, property = c("required", "optional"), # nolint: cyclocomp_linter
                              parent_schema,
                              call = rlang::caller_env()) {
  property_schema <- parent_schema[[property]]

  if (is.null(input)) {
    property_types <- property_schema[["type"]]
    if (!"null" %in% property_types) {
      cli::cli_abort(c("x" = "{.arg {property}} cannot be NULL."),
        call = call
      )
    } else {
      return()
    }
  }
  if (!is.atomic(input) || is.pairlist(input)) {
    cli::cli_abort(c("x" = "{.arg {property}} must be an atomic vector."),
      call = call
    )
  }

  if (is.factor(input)) {
    cli::cli_abort(c("x" = "{.arg {property}} cannot be of class {.cls factor}."),
      call = call
    )
  }

  oneof_schema <- property_schema[["items"]][["oneOf"]]

  oneof_schema <- purrr::map(
    oneof_schema,
    function(x) {
      type <- x$type
      if (length(type) > 1L) {
        x <- rep(list(x), length(type))
        names(x) <- json_datatypes[type]
        x
      } else {
        x <- list(x)
        names(x) <- json_datatypes[type]
        x
      }
    }
  ) %>%
    unlist(recursive = FALSE)

  value_types <- c("character", "double", "integer")
  input_type <- typeof(input)
  if (!input_type %in% value_types) {
    cli::cli_abort(
      c(
        "x" = "{.arg {property}} is of type {.cls {input_type}}.",
        "!" = "Must be {?/one of} {.cls {value_types}}."
      ),
      call = call
    )
  }

  if (typeof(input) == "character") {
    value_schema <- oneof_schema[["character"]]
    unmatched_values_exist <- !is.null(value_schema[["pattern"]]) &&
      !any(grepl(value_schema[["pattern"]], input))
    if (unmatched_values_exist) {
      cli::cli_abort(
        c(
          "x" = "Values of {.arg {property}} must match regex pattern
             {.val {value_schema[['pattern']]}}.",
          "!" = 'Values {.val {!(grepl(value_schema[["pattern"]], input))}} do not.'
        ),
        call = call
      )
    }

    is_too_long <- stringr::str_length(input) > value_schema[["maxLength"]]
    if (any(is_too_long)) {
      cli::cli_abort(
        c(
          "!" = "The maximum number of characters allowed for values in
                {.arg {property}} is {.val {value_schema[['maxLength']]}}.",
          "x" = "Value{?s} {.val {input[is_too_long]}} {?has/have}
                more characters than allowed"
        ),
        call = call
      )
    }

    is_too_short <- stringr::str_length(input) < value_schema[["minLength"]]
    if (any(is_too_short)) {
      cli::cli_abort(
        c(
          "!" = "The minimum number of characters allowed for values in
                {.arg {property}} is {.val {value_schema[['minLength']]}}.",
          "x" = "Value{?s} {.val {input[is_too_short]}} {?has/have}
                fewer characters than allowed."
        ),
        call = call
      )
    }
  }

  if (typeof(input) %in% c("double", "integer")) {
    value_schema <- oneof_schema[["double"]]
    value_min <- value_schema[["minimum"]]
    is_too_small <- input < value_min
    if (any(is_too_small)) {
      cli::cli_abort(
        c(
          "!" = "All values in {.arg {property}} must be greater
                than {.val {value_min}}.",
          "x" = "{cli::qty(sum(is_invalid))} Value{?s} {.val {input[is_invalid]}}
                {cli::qty(sum(is_invalid))}{?is/are} equal to or less."
        ),
        call = call
      )
    }
  }
}

# Subset tasks schema for the schema of a specific output type
get_schema_output_type <- function(schema, output_type) {
  purrr::pluck(
    schema,
    "properties", "rounds",
    "items", "properties", "model_tasks",
    "items", "properties", "output_type",
    "properties", output_type
  )
}
