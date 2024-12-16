validate_round_id_pattern <- function(x) {
  stringr::str_detect(
    x,
    "^(\\d{4}-\\d{2}-\\d{2})$|^[A-Za-z0-9_]+$"
  )
}
