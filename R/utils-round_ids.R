validate_round_id_pattern <- function(x) {
  stringr::str_detect(
    x,
    "^(\\d{4}-\\d{2}-\\d{2})$|^[A-Za-z0-9_]+$"
  )
}

invalid_round_id_var_patterns <- function(round_id_var_vals) {
  purrr::map(
    round_id_var_vals,
    \(.x) {
      if (is.null(.x)) {
        return(NULL)
      }
      valid <- validate_round_id_pattern(.x)
      invalid <- .x[!valid]
      if (length(invalid) == 0L) {
        return(NULL)
      }
      invalid
    }
  )
}
