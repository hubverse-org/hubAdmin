## code to prepare `json_datatypes` dataset goes here
json_datatypes <- c(
  string = "character",
  boolean = "logical",
  integer = "integer",
  number = "double"
)
## code to prepare `sysdata` dataset goes here

usethis::use_data(json_datatypes, overwrite = TRUE, internal = TRUE)
