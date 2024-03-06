#' Available US locations
#'
#' Data set with available locations for a US hub
#'
#' @format A data frame with 3202 rows and 5 columns:
#' \describe{
#'   \item{fips}{FIPS code}
#'   \item{location_name}{Location name}
#'   \item{geo_type}{Type of location for compatibility with
#'      \href{https://cmu-delphi.github.io/delphi-epidata/api/covidcast_geography.html
#'          }{EpiData API geographic codings}
#'      }
#'   \item{geo_value}{Location abbreviation or FIPS code for compatibility with
#'      \href{https://cmu-delphi.github.io/delphi-epidata/api/covidcast_geography.html
#'          }{EpiData API geographic codings}}
#'   \item{abbreviation}{Corresponding state abbrevaition}
#' }
"hub_locations_us"


#' Available European locations
#'
#' Data set with available European locations used in ECDC hubs
#'
#' @format A data frame with 32 rows and 2 columns:
#' \describe{
#'   \item{location_name}{Name of the location}
#'   \item{location}{Location abbreviation}
#' }
"hub_locations_eu"
