# Download hubverse tasks schema from the hubverse schema repository.

Download hubverse tasks schema from the hubverse schema repository.

## Usage

``` r
download_tasks_schema(
  schema_version = getOption("hubAdmin.schema_version", default = "latest"),
  branch = getOption("hubAdmin.branch", default = "main"),
  format = c("list", "json")
)
```

## Arguments

- schema_version:

  the version required. Defaults to "latest". Can be set through global
  option "hubAdmin.schema_version".

- branch:

  the branch to download the schema from. Defaults to "main". Can be set
  through global option "hubAdmin.branch".

- format:

  the format to return the schema in. Defaults to "list". Can be "list"
  or "json".

## Value

The requested version of the tasks hubverse schema in the specified
format.

## Examples

``` r
download_tasks_schema()
#> $`$schema`
#> [1] "https://json-schema.org/draft/2020-12/schema"
#> 
#> $`$id`
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> 
#> $title
#> [1] "Schema for Modeling Hub model task definitions"
#> 
#> $description
#> [1] "This is the schema of the tasks.json configuration file that defines the tasks within a modeling hub."
#> 
#> $type
#> [1] "object"
#> 
#> $properties
#> $properties$schema_version
#> $properties$schema_version$description
#> [1] "URL to a version of the Modeling Hub schema tasks-schema.json file (see https://github.com/hubverse-org/schemas). Used to declare the schema version a 'tasks.json' file is written for and for config file validation. The URL provided should be the URL to the raw content of the schema file on GitHub."
#> 
#> $properties$schema_version$examples
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.0/tasks-schema.json"
#> 
#> $properties$schema_version$type
#> [1] "string"
#> 
#> $properties$schema_version$format
#> [1] "uri"
#> 
#> 
#> $properties$rounds
#> $properties$rounds$description
#> [1] "Array of modeling round properties"
#> 
#> $properties$rounds$type
#> [1] "array"
#> 
#> $properties$rounds$items
#> $properties$rounds$items$type
#> [1] "object"
#> 
#> $properties$rounds$items$description
#> [1] "Individual modeling round properties"
#> 
#> $properties$rounds$items$properties
#> $properties$rounds$items$properties$round_id_from_variable
#> $properties$rounds$items$properties$round_id_from_variable$description
#> [1] "Whether the round identifier is encoded by a task id variable in the data."
#> 
#> $properties$rounds$items$properties$round_id_from_variable$type
#> [1] "boolean"
#> 
#> 
#> $properties$rounds$items$properties$round_id
#> $properties$rounds$items$properties$round_id$description
#> [1] "Round identifier. If round_id_from_variable = true, round_id should be the name of a task id variable present in all sets of modeling task specifications"
#> 
#> $properties$rounds$items$properties$round_id$examples
#> [1] "round_1"     "2022-11-05"  "origin_date"
#> 
#> $properties$rounds$items$properties$round_id$type
#> [1] "string"
#> 
#> 
#> $properties$rounds$items$properties$round_name
#> $properties$rounds$items$properties$round_name$description
#> [1] "An optional round name. This can be useful for internal referencing of rounds, for examples, when a date is used as round_id but hub maintainers and teams also refer to rounds as round-1, round-2 etc."
#> 
#> $properties$rounds$items$properties$round_name$examples
#> [1] "round 1"
#> 
#> $properties$rounds$items$properties$round_name$type
#> [1] "string"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks
#> $properties$rounds$items$properties$model_tasks$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$description
#> [1] "Array defining round-specific modeling tasks. Can contain one or more groups of modeling tasks per round where each group is defined by a distinct combination of values of task id variables."
#> 
#> $properties$rounds$items$properties$model_tasks$items
#> $properties$rounds$items$properties$model_tasks$items$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$description
#> [1] "Group of valid values of task id variables. A set of valid tasks corresponding to this group is formed by taking all combinations of these values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$description
#> [1] "An object containing arrays of required and optional unique origin dates. Origin date defines the starting point that can be used for calculating a target_date via the formula target_date = origin_date + horizon x time_units_per_horizon (e.g., with weekly data, target_date is calculated as origin_date + horizon x 7 days)"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$examples[[1]]$optional
#> [1] "2022-11-05" "2022-11-12" "2022-11-19"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$description
#> [1] "Array of origin date unique identifiers that must be present for submission to be valid. Can be null if no origin dates are required and all valid origin dates are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$items$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$description
#> [1] "Array of valid but not required unique origin date identifiers. Can be null if all origin dates are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$items$format
#> [1] "date"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$required
#> [1] "required" "optional"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$description
#> [1] "An object containing arrays of required and optional unique forecast dates. Forecast date usually defines the date that a model is run to produce a forecast."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$examples[[1]]$optional
#> [1] "2022-11-05" "2022-11-12" "2022-11-19"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$description
#> [1] "Array of forecast date unique identifiers that must be present for submission to be valid. Can be null if no forecast dates are required and all valid forecast dates are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$items$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$description
#> [1] "Array of valid but not required unique forecast date identifiers. Can be null if all forecast dates are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$items$format
#> [1] "date"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$required
#> [1] "required" "optional"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$description
#> [1] "An object containing arrays of required and optional unique identifiers of each valid scenario."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[1]]$optional
#> [1] 1 2 3 4
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[2]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[2]]$optional
#> [1] "A-2021-03-28" "B-2021-03-28" "A-2021-04-05" "B-2021-04-05"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$description
#> [1] "Array of identifiers of scenarios that must be present in a valid submission. Can be null if no scenario ids are required and all valid ids are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$items$type
#> [1] "integer" "string" 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$description
#> [1] "Array of identifiers of valid but not required scenarios. Can be null if all scenarios are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$type
#> [1] "null"  "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$items$type
#> [1] "integer" "string" 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$required
#> [1] "required" "optional"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$description
#> [1] "An object containing arrays of required and optional unique identifiers for each valid location, e.g. country codes, FIPS state or county level code etc."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$examples[[1]]$required
#> [1] "US"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$examples[[1]]$optional
#>  [1] "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17" "18"
#> [16] "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33"
#> [31] "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48" "49"
#> [46] "50" "51" "53" "54" "55" "56"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$description
#> [1] "Array of location unique identifiers that must be present for submission to be valid. Can be null if no locations are required and all valid locations are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$description
#> [1] "Array of valid but not required unique location identifiers. Can be null if all locations are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$required
#> [1] "required" "optional"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$description
#> [1] "An object containing arrays of required and optional unique identifiers for each valid target. Usually represents a single task ID target key variable."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[1]]$optional
#> [1] "inc hosp"  "inc case"  "inc death"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[2]]$required
#> [1] "peak week inc hosp"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[2]]$optional
#> NULL
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$description
#> [1] "Array of target unique identifiers that must be present for submission to be valid. Can be null if no targets are required and all valid targets are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$description
#> [1] "Array of valid but not required unique target identifiers. Can be null if all targets are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$required
#> [1] "required" "optional"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$description
#> [1] "An object containing arrays of required and optional unique target dates. For short-term forecasts, the target_date specifies the date of occurrence of the outcome of interest. For instance, if models are requested to forecast the number of hospitalizations that will occur on 2022-07-15, the target_date is 2022-07-15"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$examples[[1]]$optional
#> [1] "2022-11-12" "2022-11-19" "2022-11-26"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$description
#> [1] "Array of target date unique identifiers that must be present for submission to be valid. Can be null if no target dates are required and all valid target dates are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$items$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$description
#> [1] "Array of valid but not required unique target date identifiers. Can be null if all target dates are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$items$format
#> [1] "date"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$required
#> [1] "required" "optional"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$description
#> [1] "An object containing arrays of required and optional unique target end dates. For short-term forecasts, the target_end_date specifies the date of occurrence of the outcome of interest. For instance, if models are requested to forecast the number of hospitalizations that will occur on 2022-07-15, the target_end_date is 2022-07-15"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$examples[[1]]$optional
#> [1] "2022-11-12" "2022-11-19" "2022-11-26"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$description
#> [1] "Array of target end date unique identifiers that must be present for submission to be valid. Can be null if no target end dates are required and all valid target end dates are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$items$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$description
#> [1] "Array of valid but not required unique target end date identifiers. Can be null if all target end dates are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$items$format
#> [1] "date"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$required
#> [1] "required" "optional"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$description
#> [1] "An object containing arrays of required and optional unique horizons. Horizons define the difference between the target_date and the origin_date in time units specified by the hub (e.g., may be days, weeks, or months)"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$examples[[1]]$optional
#> [1] 1 2 3 4
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$description
#> [1] "Array of horizon unique identifiers that must be present for submission to be valid. Can be null if no horizons are required and all valid horizons are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$items$type
#> [1] "integer" "string" 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$description
#> [1] "Array of valid but not required unique horizon identifiers. Can be null if all horizons are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$type
#> [1] "null"  "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$items$type
#> [1] "integer" "string" 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$required
#> [1] "required" "optional"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$description
#> [1] "An object containing arrays of required and optional unique identifiers for age groups"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$examples[[1]]$required
#> [1] "0-5"   "6-18"  "19-24" "25-64" "65+"  
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$examples[[1]]$optional
#> NULL
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$description
#> [1] "Array of age group unique identifiers that must be present for submission to be valid. Can be null if no age groups are required and all valid age groups are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$description
#> [1] "Array of valid but not required unique age group identifiers. Can be null if all age group are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$required
#> [1] "required" "optional"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$additionalProperties
#> [1] FALSE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$description
#> [1] "An object containing arrays of required and optional unique values for a custom Task ID"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$required$description
#> [1] "Array of custom Task ID unique values that must be present for submission to be valid. Can be null if no values are required and all valid values are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$required$uniqueItems
#> [1] TRUE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$optional$description
#> [1] "Array of valid but not required unique custom Task ID values. Can be null if all values are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$required
#> [1] "required" "optional"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$additionalProperties
#> [1] FALSE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$description
#> [1] "Object defining valid model output types for a given modeling task. The name of each property corresponds to valid values in column 'output_type' while the 'output_type_id' property of each output type defines the valid values of the 'output_type_id' column and the 'value' property defines the valid values of the 'value' column for a given output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$description
#> [1] "Object defining the mean of the predictive distribution output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$description
#> [1] "output_type_id is not meaningful for a point estimate output_type. Must have a single property named 'required' with the value null."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[1]]$required
#> NULL
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$properties$required$description
#> [1] "Not relevant for point estimate output types. Must be null."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$properties$required$type
#> [1] "null"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$required
#> [1] "required"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$description
#> [1] "Object defining the characteristics of valid mean values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$examples[[1]]$type
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$examples[[1]]$minimum
#> [1] 0
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$type$description
#> [1] "Data type of mean values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$type$enum
#> [1] "double"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid mean value"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$minimum$type
#> [1] "number"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$maximum$description
#> [1] "the maximum inclusive valid mean value"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$maximum$type
#> [1] "number"  "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$required
#> [1] "type"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$is_required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$is_required$description
#> [1] "Is output type required? When required, property should be set to 'true'. If output type is optional, set to 'false'."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$is_required$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$is_required$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$is_required$examples[[1]]$is_required
#> [1] TRUE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$is_required$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$is_required$examples[[2]]$is_required
#> [1] FALSE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$is_required$type
#> [1] "boolean"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$required
#> [1] "output_type_id" "value"          "is_required"   
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$description
#> [1] "Object defining the median of the predictive distribution output type"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$description
#> [1] "output_type_id is not meaningful for a point estimate output_type. Must have a single property named 'required' with the value null."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[1]]$required
#> NULL
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$properties$required$description
#> [1] "Not relevant for point estimate output types. Must be null."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$properties$required$type
#> [1] "null"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$required
#> [1] "required"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$description
#> [1] "Object defining the characteristics of valid median values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$examples[[1]]$type
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$examples[[1]]$minimum
#> [1] 0
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$type$description
#> [1] "Data type of median values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$type$enum
#> [1] "double"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid median value"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$minimum$type
#> [1] "number"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$maximum$description
#> [1] "the maximum inclusive valid median value"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$maximum$type
#> [1] "number"  "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$required
#> [1] "type"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$is_required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$is_required$description
#> [1] "Is output type required? When required, property should be set to 'true'. If output type is optional, set to 'false'."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$is_required$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$is_required$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$is_required$examples[[1]]$is_required
#> [1] TRUE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$is_required$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$is_required$examples[[2]]$is_required
#> [1] FALSE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$is_required$type
#> [1] "boolean"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$required
#> [1] "output_type_id" "value"          "is_required"   
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$description
#> [1] "Object defining the quantiles of the predictive distribution output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$description
#> [1] "Object containing arrays of required probability levels at which quantiles of the predictive distribution will be recorded."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$examples[[1]]$required
#>  [1] 0.10 0.20 0.25 0.30 0.40 0.50 0.60 0.70 0.75 0.80 0.90
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$description
#> [1] "Array of unique probability levels between 0 and 1 inclusive that must be present for submission to be valid."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$items$type
#> [1] "number"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$items$minimum
#> [1] 0
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$items$maximum
#> [1] 1
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$required
#> [1] "required"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$description
#> [1] "Object defining the characteristics of valid quantiles of the predictive distribution at a given probability level."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type$description
#> [1] "Data type of quantile values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type$examples
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type$enum
#> [1] "double"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid quantile value (optional)."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$minimum$examples
#> [1] 0
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$minimum$type
#> [1] "number"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$maximum$description
#> [1] "The maximum inclusive valid quantile value (optional)."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$maximum$type
#> [1] "number"  "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$required
#> [1] "type"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$is_required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$is_required$description
#> [1] "Is output type required? When required, property should be set to 'true'. If output type is optional, set to 'false'."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$is_required$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$is_required$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$is_required$examples[[1]]$is_required
#> [1] TRUE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$is_required$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$is_required$examples[[2]]$is_required
#> [1] FALSE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$is_required$type
#> [1] "boolean"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$required
#> [1] "output_type_id" "value"          "is_required"   
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$description
#> [1] "Object defining the cumulative distribution function of the predictive distribution output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$description
#> [1] "Object containing required arrays defining possible values of the target variable at which values of the cumulative distribution function of the predictive distribution will be recorded. These should be listed in order from low to high."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[1]]$required
#> [1] 10 20
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[2]]$required
#> [1] "EW202240" "EW202241" "EW202242" "EW202243" "EW202244" "EW202245" "EW202246"
#> [8] "EW202247"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$description
#> [1] "Array of unique target values that must be present for submission to be valid."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[1]]$type
#> [1] "number"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[2]]$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$required
#> [1] "required"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$description
#> [1] "Object defining the characteristics of valid values of the cumulative distribution function at a given target value."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$type$description
#> [1] "Data type of cumulative distribution function values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$type$examples
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$type$const
#> [1] "double"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid cumulative distribution function value. Must be 0."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$minimum$const
#> [1] 0
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$maximum$description
#> [1] "The maximum inclusive valid cumulative distribution function value. Must be 1."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$maximum$const
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$required
#> [1] "type"    "minimum" "maximum"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$is_required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$is_required$description
#> [1] "Is output type required? When required, property should be set to 'true'. If output type is optional, set to 'false'."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$is_required$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$is_required$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$is_required$examples[[1]]$is_required
#> [1] TRUE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$is_required$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$is_required$examples[[2]]$is_required
#> [1] FALSE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$is_required$type
#> [1] "boolean"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$required
#> [1] "output_type_id" "value"          "is_required"   
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$description
#> [1] "Object defining a probability mass function for a discrete variable output type. Includes nominal, binary and ordinal variable types."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$description
#> [1] "Object containing arrays of required values specifying valid categories of a discrete variable. Note that for ordinal variables, the category levels should be listed in order from low to high."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$examples[[1]]$required
#> [1] "low"      "moderate" "high"     "extreme" 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$description
#> [1] "Array of unique categories of a discrete variable that must be present for submission to be valid."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$required
#> [1] "required"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$description
#> [1] "Object defining valid values of the probability mass function of the predictive distribution for a given category of a discrete outcome variable."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples[[1]]$type
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples[[1]]$minimum
#> [1] 0
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples[[1]]$maximum
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$type$description
#> [1] "Data type of the probability mass function values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$type$const
#> [1] "double"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid probability mass function value. Must be 0."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$minimum$const
#> [1] 0
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$maximum$description
#> [1] "The maximum inclusive valid probability mass function value. Must be 1."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$maximum$const
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$required
#> [1] "type"    "minimum" "maximum"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$is_required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$is_required$description
#> [1] "Is output type required? When required, property should be set to 'true'. If output type is optional, set to 'false'."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$is_required$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$is_required$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$is_required$examples[[1]]$is_required
#> [1] TRUE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$is_required$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$is_required$examples[[2]]$is_required
#> [1] FALSE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$is_required$type
#> [1] "boolean"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$required
#> [1] "output_type_id" "value"          "is_required"   
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$description
#> [1] "Object defining a sample output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$description
#> [1] "Object containing parameters specifying how samples were drawn."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[1]]$output_type_id_params
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[1]]$output_type_id_params$type
#> [1] "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[1]]$output_type_id_params$min_samples_per_task
#> [1] 100
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[1]]$output_type_id_params$max_samples_per_task
#> [1] 100
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params$type
#> [1] "character"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params$max_length
#> [1] 6
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params$min_samples_per_task
#> [1] 100
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params$max_samples_per_task
#> [1] 500
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params$compound_taskid_set
#> [1] "origin_date" "horizon"     "location"    "variant"    
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$type$description
#> [1] "Data type of sample indices."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$type$enum
#> [1] "character" "integer"  
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_length
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_length$description
#> [1] "Required only if 'type' is 'character'. Positive integer representing the maximum number of characters in a sample index. Ignored if 'type' is 'integer'."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_length$type
#> [1] "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_length$minimum
#> [1] 1
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$min_samples_per_task
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$min_samples_per_task$description
#> [1] "The minimum number of samples per individual task."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$min_samples_per_task$type
#> [1] "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$min_samples_per_task$minimum
#> [1] 1
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_samples_per_task
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_samples_per_task$description
#> [1] "The maximum number of samples per individual task."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_samples_per_task$type
#> [1] "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_samples_per_task$minimum
#> [1] 1
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$compound_taskid_set
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$compound_taskid_set$description
#> [1] "Optional. Specifies whether validation should factor in the presence of a compound modeling task. Each item of the array must be a task id variable name. If unspecified, defaults to all task ID variables."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$compound_taskid_set$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$compound_taskid_set$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$compound_taskid_set$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$compound_taskid_set$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$required
#> [1] "type"                 "min_samples_per_task" "max_samples_per_task"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$`if`
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$`if`$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$`if`$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$`if`$properties$type$const
#> [1] "character"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$then
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$then$required
#> [1] "max_length"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$description
#> [1] "Object defining valid values of samples from the predictive distribution for a given sample index.  Depending on the Hub specification, samples with the same sample index (specified by the output_type_id) may be assumed to correspond to a joint distribution across multiple levels of the task id variables. See Hub documentation for details."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$description
#> [1] "Data type of sample value from the predictive distribution."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$examples[[1]]$type
#> [1] "double"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$enum
#> [1] "double"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid sample value from the predictive distribution."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$minimum$type
#> [1] "number"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$maximum$description
#> [1] "The maximum inclusive valid sample value from the predictive distribution."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$maximum$type
#> [1] "number"  "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$required
#> [1] "type"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$is_required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$is_required$description
#> [1] "Is output type required? When required, property should be set to 'true'. If output type is optional, set to 'false'."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$is_required$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$is_required$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$is_required$examples[[1]]$is_required
#> [1] TRUE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$is_required$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$is_required$examples[[2]]$is_required
#> [1] FALSE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$is_required$type
#> [1] "boolean"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$required
#> [1] "output_type_id_params" "value"                 "is_required"          
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$additionalProperties
#> [1] FALSE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$description
#> [1] "Array of objects containing metadata about each unique target, one object for each unique target value."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$description
#> [1] "Object containg metadata about a single unique target."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id$description
#> [1] "Short description that uniquely identifies the target."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id$examples
#> [1] "inc hosp"       "peak week hosp"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id$maxLength
#> [1] 30
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name$description
#> [1] "A longer human readable target description that could be used, for example, as a visualisation axis label."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name$examples
#> [1] "Weekly incident influenza hospitalizations"       
#> [2] "Peak week for incident influenza hospitalizations"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name$maxLength
#> [1] 100
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units$description
#> [1] "Unit of observation of the target."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units$examples
#> [1] "rate per 100,000 population" "count"                      
#> [3] "date"                       
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units$maxLength
#> [1] 100
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$description
#> [1] "Should be either null, in the case where the target is not specified as a task_id and is specified solely through the target_id target_metadata property or an object with a single property. The property name must match a task_id variable defined within the same model_tasks object and should have a single specified value, which matches one of the values in the associated task ID variable. This value defines a single target."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[1]]$target
#> [1] "inc hosp"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[2]]$target
#> [1] "peak week hosp"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[3]]
#> NULL
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$type
#> [1] "object" "null"  
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$minProperties
#> [1] 1
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$maxProperties
#> [1] 1
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$additionalProperties
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$additionalProperties$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$description
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$description$description
#> [1] "a verbose description of the target that might include information such as the target_measure above, or definitions of a 'rate' or similar."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$description$type
#> [1] "string"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type$description
#> [1] "Target statistical data type"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type$examples
#> [1] "discrete" "ordinal" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type$enum
#> [1] "continuous"    "discrete"      "date"          "binary"       
#> [5] "nominal"       "ordinal"       "compositional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$is_step_ahead
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$is_step_ahead$description
#> [1] "Whether the target is part of a sequence of values"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$is_step_ahead$examples
#> [1]  TRUE FALSE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$is_step_ahead$type
#> [1] "boolean"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit$description
#> [1] " if is_step_ahead is true, then this is required and defines the unit of time steps. if is_step_ahead is false, then this should be left out and/or will be ignored if present."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit$examples
#> [1] "week"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit$enum
#> [1] "day"   "week"  "month"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$additional_metadata
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$additional_metadata$description
#> [1] "Optional property in which any type of custom metadata can be stored."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$additional_metadata$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$additional_metadata$additionalProperties
#> [1] TRUE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$required
#> [1] "target_id"     "target_name"   "target_units"  "target_type"  
#> [5] "target_keys"   "is_step_ahead"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$additionalProperties
#> [1] FALSE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$`if`
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$`if`$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$`if`$properties$is_step_ahead
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$`if`$properties$is_step_ahead$const
#> [1] TRUE
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$then
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$then$required
#> [1] "time_unit"
#> 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$required
#> [1] "task_ids"        "output_type"     "target_metadata"
#> 
#> $properties$rounds$items$properties$model_tasks$items$additionalProperties
#> [1] FALSE
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due
#> $properties$rounds$items$properties$submissions_due$description
#> [1] "Object defining the dates by which model forecasts must be submitted to the hub."
#> 
#> $properties$rounds$items$properties$submissions_due$examples
#> $properties$rounds$items$properties$submissions_due$examples[[1]]
#> $properties$rounds$items$properties$submissions_due$examples[[1]]$start
#> [1] "2022-06-07"
#> 
#> $properties$rounds$items$properties$submissions_due$examples[[1]]$end
#> [1] "2022-07-20"
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$examples[[2]]
#> $properties$rounds$items$properties$submissions_due$examples[[2]]$relative_to
#> [1] "origin_date"
#> 
#> $properties$rounds$items$properties$submissions_due$examples[[2]]$start
#> [1] -4
#> 
#> $properties$rounds$items$properties$submissions_due$examples[[2]]$end
#> [1] 2
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$relative_to
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$relative_to$description
#> [1] "Name of task id variable in relation to which submission start and end dates are calculated."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$relative_to$type
#> [1] "string"
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$start
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$start$description
#> [1] "Difference in days between start and origin date."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$start$type
#> [1] "integer"
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$end
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$end$description
#> [1] "Difference in days between end and origin date."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$end$type
#> [1] "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$required
#> [1] "relative_to" "start"       "end"        
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$start
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$start$description
#> [1] "Submission start date."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$start$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$start$format
#> [1] "date"
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$end
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$end$description
#> [1] "Submission end date."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$end$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$end$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$required
#> [1] "start" "end"  
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$additionalProperties
#> [1] FALSE
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$required
#> [1] "start" "end"  
#> 
#> 
#> $properties$rounds$items$properties$last_data_date
#> $properties$rounds$items$properties$last_data_date$description
#> [1] "The last date with recorded data in the data set used as input to a model."
#> 
#> $properties$rounds$items$properties$last_data_date$examples
#> [1] "2022-07-18"
#> 
#> $properties$rounds$items$properties$last_data_date$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$last_data_date$format
#> [1] "date"
#> 
#> 
#> $properties$rounds$items$properties$file_format
#> $properties$rounds$items$properties$file_format$description
#> [1] "Accepted file formats of model output files for the round. Overrides the file formats provided in admin.json."
#> 
#> $properties$rounds$items$properties$file_format$examples
#> $properties$rounds$items$properties$file_format$examples[[1]]
#> [1] "arrow"   "parquet"
#> 
#> $properties$rounds$items$properties$file_format$examples[[2]]
#> [1] "csv"
#> 
#> 
#> $properties$rounds$items$properties$file_format$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$file_format$items
#> $properties$rounds$items$properties$file_format$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$file_format$items$enum
#> [1] "csv"     "parquet" "arrow"  
#> 
#> 
#> 
#> $properties$rounds$items$properties$derived_task_ids
#> $properties$rounds$items$properties$derived_task_ids$description
#> [1] "Names of derived task IDs, i.e. task IDs whose values are derived from (and therefore dependent on) the values of other variables. Use this property to override the global setting for a specific round."
#> 
#> $properties$rounds$items$properties$derived_task_ids$examples
#>      [,1]             
#> [1,] "target_end_date"
#> 
#> $properties$rounds$items$properties$derived_task_ids$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$derived_task_ids$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$derived_task_ids$items
#> $properties$rounds$items$properties$derived_task_ids$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$additional_metadata
#> $properties$rounds$items$properties$additional_metadata$description
#> [1] "Optional property in which any type of custom metadata can be stored."
#> 
#> $properties$rounds$items$properties$additional_metadata$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$additional_metadata$additionalProperties
#> [1] TRUE
#> 
#> 
#> 
#> $properties$rounds$items$`if`
#> $properties$rounds$items$`if`$properties
#> $properties$rounds$items$`if`$properties$round_id_from_variable
#> $properties$rounds$items$`if`$properties$round_id_from_variable$const
#> [1] FALSE
#> 
#> 
#> 
#> 
#> $properties$rounds$items$then
#> $properties$rounds$items$then$properties
#> $properties$rounds$items$then$properties$round_id
#> $properties$rounds$items$then$properties$round_id$pattern
#> [1] "^([0-9]{4}-[0-9]{2}-[0-9]{2})$|^[A-Za-z0-9_]+$"
#> 
#> $properties$rounds$items$then$properties$round_id$errorMessage
#> [1] "The 'round_id' must match either an ISO date format (YYYY-MM-DD) or alphanumeric characters separated by underscores."
#> 
#> 
#> 
#> 
#> $properties$rounds$items$required
#> [1] "round_id_from_variable" "round_id"               "model_tasks"           
#> [4] "submissions_due"       
#> 
#> $properties$rounds$items$additionalProperties
#> [1] FALSE
#> 
#> 
#> 
#> $properties$output_type_id_datatype
#> $properties$output_type_id_datatype$description
#> [1] "The hub level data type of the output_type_id column. This data type must be shared across all files in the hub and be able to represent all output type ID values across all hub output types and rounds. If not provided or set to 'auto', hub defaults to autodetecting the simplest hub level data type."
#> 
#> $properties$output_type_id_datatype$default
#> [1] "auto"
#> 
#> $properties$output_type_id_datatype$examples
#> [1] "character"
#> 
#> $properties$output_type_id_datatype$type
#> [1] "string"
#> 
#> $properties$output_type_id_datatype$enum
#> [1] "auto"      "character" "double"    "integer"   "logical"   "Date"     
#> 
#> 
#> $properties$derived_task_ids
#> $properties$derived_task_ids$description
#> [1] "Names of derived task IDs, i.e. task IDs whose values are derived from (and therefore dependent on) the values of other variables."
#> 
#> $properties$derived_task_ids$examples
#>      [,1]             
#> [1,] "target_end_date"
#> 
#> $properties$derived_task_ids$type
#> [1] "array" "null" 
#> 
#> $properties$derived_task_ids$uniqueItems
#> [1] TRUE
#> 
#> $properties$derived_task_ids$items
#> $properties$derived_task_ids$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $required
#> [1] "rounds"         "schema_version"
#> 
#> $additionalProperties
#> [1] FALSE
#> 
download_tasks_schema(format = "json")
#> {
#>     "$schema": "https://json-schema.org/draft/2020-12/schema",
#>     "$id": "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json",
#>     "title": "Schema for Modeling Hub model task definitions",
#>     "description": "This is the schema of the tasks.json configuration file that defines the tasks within a modeling hub.",
#>     "type": "object",
#>     "properties": {
#>         "schema_version": {
#>             "description": "URL to a version of the Modeling Hub schema tasks-schema.json file (see https://github.com/hubverse-org/schemas). Used to declare the schema version a 'tasks.json' file is written for and for config file validation. The URL provided should be the URL to the raw content of the schema file on GitHub.",
#>             "examples": [
#>                 "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.0/tasks-schema.json"
#>             ],
#>             "type": "string",
#>             "format": "uri"
#>         },
#>         "rounds": {
#>             "description": "Array of modeling round properties",
#>             "type": "array",
#>             "items": {
#>                 "type": "object",
#>                 "description": "Individual modeling round properties",
#>                 "properties": {
#>                     "round_id_from_variable": {
#>                         "description": "Whether the round identifier is encoded by a task id variable in the data.",
#>                         "type": "boolean"
#>                     },
#>                     "round_id": {
#>                         "description": "Round identifier. If round_id_from_variable = true, round_id should be the name of a task id variable present in all sets of modeling task specifications",
#>                         "examples": [
#>                             "round_1",
#>                             "2022-11-05",
#>                             "origin_date"
#>                         ],
#>                         "type": "string"
#>                     },
#>                     "round_name": {
#>                         "description": "An optional round name. This can be useful for internal referencing of rounds, for examples, when a date is used as round_id but hub maintainers and teams also refer to rounds as round-1, round-2 etc.",
#>                         "examples": [
#>                             "round 1"
#>                         ],
#>                         "type": "string"
#>                     },
#>                     "model_tasks": {
#>                         "type": "array",
#>                         "description": "Array defining round-specific modeling tasks. Can contain one or more groups of modeling tasks per round where each group is defined by a distinct combination of values of task id variables.",
#>                         "items": {
#>                             "type": "object",
#>                             "properties": {
#>                                 "task_ids": {
#>                                     "description": "Group of valid values of task id variables. A set of valid tasks corresponding to this group is formed by taking all combinations of these values.",
#>                                     "type": "object",
#>                                     "properties": {
#>                                         "origin_date": {
#>                                             "description": "An object containing arrays of required and optional unique origin dates. Origin date defines the starting point that can be used for calculating a target_date via the formula target_date = origin_date + horizon x time_units_per_horizon (e.g., with weekly data, target_date is calculated as origin_date + horizon x 7 days)",
#>                                             "examples": [
#>                                                 {
#>                                                     "required": null,
#>                                                     "optional": [
#>                                                         "2022-11-05",
#>                                                         "2022-11-12",
#>                                                         "2022-11-19"
#>                                                     ]
#>                                                 }
#>                                             ],
#>                                             "type": "object",
#>                                             "properties": {
#>                                                 "required": {
#>                                                     "description": "Array of origin date unique identifiers that must be present for submission to be valid. Can be null if no origin dates are required and all valid origin dates are specified in the optional property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string",
#>                                                         "format": "date"
#>                                                     }
#>                                                 },
#>                                                 "optional": {
#>                                                     "description": "Array of valid but not required unique origin date identifiers. Can be null if all origin dates are required and are specified in the required property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string",
#>                                                         "format": "date"
#>                                                     }
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "required",
#>                                                 "optional"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "forecast_date": {
#>                                             "description": "An object containing arrays of required and optional unique forecast dates. Forecast date usually defines the date that a model is run to produce a forecast.",
#>                                             "examples": [
#>                                                 {
#>                                                     "required": null,
#>                                                     "optional": [
#>                                                         "2022-11-05",
#>                                                         "2022-11-12",
#>                                                         "2022-11-19"
#>                                                     ]
#>                                                 }
#>                                             ],
#>                                             "type": "object",
#>                                             "properties": {
#>                                                 "required": {
#>                                                     "description": "Array of forecast date unique identifiers that must be present for submission to be valid. Can be null if no forecast dates are required and all valid forecast dates are specified in the optional property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string",
#>                                                         "format": "date"
#>                                                     }
#>                                                 },
#>                                                 "optional": {
#>                                                     "description": "Array of valid but not required unique forecast date identifiers. Can be null if all forecast dates are required and are specified in the required property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string",
#>                                                         "format": "date"
#>                                                     }
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "required",
#>                                                 "optional"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "scenario_id": {
#>                                             "description": "An object containing arrays of required and optional unique identifiers of each valid scenario.",
#>                                             "examples": [
#>                                                 {
#>                                                     "required": null,
#>                                                     "optional": [
#>                                                         1,
#>                                                         2,
#>                                                         3,
#>                                                         4
#>                                                     ]
#>                                                 },
#>                                                 {
#>                                                     "required": null,
#>                                                     "optional": [
#>                                                         "A-2021-03-28",
#>                                                         "B-2021-03-28",
#>                                                         "A-2021-04-05",
#>                                                         "B-2021-04-05"
#>                                                     ]
#>                                                 }
#>                                             ],
#>                                             "type": "object",
#>                                             "properties": {
#>                                                 "required": {
#>                                                     "description": "Array of identifiers of scenarios that must be present in a valid submission. Can be null if no scenario ids are required and all valid ids are specified in the optional property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": [
#>                                                             "integer",
#>                                                             "string"
#>                                                         ]
#>                                                     }
#>                                                 },
#>                                                 "optional": {
#>                                                     "description": "Array of identifiers of valid but not required scenarios. Can be null if all scenarios are required and are specified in the required property.",
#>                                                     "type": [
#>                                                         "null",
#>                                                         "array"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": [
#>                                                             "integer",
#>                                                             "string"
#>                                                         ]
#>                                                     }
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "required",
#>                                                 "optional"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "location": {
#>                                             "description": "An object containing arrays of required and optional unique identifiers for each valid location, e.g. country codes, FIPS state or county level code etc.",
#>                                             "examples": [
#>                                                 {
#>                                                     "required": [
#>                                                         "US"
#>                                                     ],
#>                                                     "optional": [
#>                                                         "01",
#>                                                         "02",
#>                                                         "04",
#>                                                         "05",
#>                                                         "06",
#>                                                         "08",
#>                                                         "09",
#>                                                         "10",
#>                                                         "11",
#>                                                         "12",
#>                                                         "13",
#>                                                         "15",
#>                                                         "16",
#>                                                         "17",
#>                                                         "18",
#>                                                         "19",
#>                                                         "20",
#>                                                         "21",
#>                                                         "22",
#>                                                         "23",
#>                                                         "24",
#>                                                         "25",
#>                                                         "26",
#>                                                         "27",
#>                                                         "28",
#>                                                         "29",
#>                                                         "30",
#>                                                         "31",
#>                                                         "32",
#>                                                         "33",
#>                                                         "34",
#>                                                         "35",
#>                                                         "36",
#>                                                         "37",
#>                                                         "38",
#>                                                         "39",
#>                                                         "40",
#>                                                         "41",
#>                                                         "42",
#>                                                         "44",
#>                                                         "45",
#>                                                         "46",
#>                                                         "47",
#>                                                         "48",
#>                                                         "49",
#>                                                         "50",
#>                                                         "51",
#>                                                         "53",
#>                                                         "54",
#>                                                         "55",
#>                                                         "56"
#>                                                     ]
#>                                                 }
#>                                             ],
#>                                             "type": "object",
#>                                             "properties": {
#>                                                 "required": {
#>                                                     "description": "Array of location unique identifiers that must be present for submission to be valid. Can be null if no locations are required and all valid locations are specified in the optional property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string"
#>                                                     }
#>                                                 },
#>                                                 "optional": {
#>                                                     "description": "Array of valid but not required unique location identifiers. Can be null if all locations are required and are specified in the required property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string"
#>                                                     }
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "required",
#>                                                 "optional"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "target": {
#>                                             "description": "An object containing arrays of required and optional unique identifiers for each valid target. Usually represents a single task ID target key variable.",
#>                                             "type": "object",
#>                                             "examples": [
#>                                                 {
#>                                                     "required": null,
#>                                                     "optional": [
#>                                                         "inc hosp",
#>                                                         "inc case",
#>                                                         "inc death"
#>                                                     ]
#>                                                 },
#>                                                 {
#>                                                     "required": [
#>                                                         "peak week inc hosp"
#>                                                     ],
#>                                                     "optional": null
#>                                                 }
#>                                             ],
#>                                             "properties": {
#>                                                 "required": {
#>                                                     "description": "Array of target unique identifiers that must be present for submission to be valid. Can be null if no targets are required and all valid targets are specified in the optional property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string"
#>                                                     }
#>                                                 },
#>                                                 "optional": {
#>                                                     "description": "Array of valid but not required unique target identifiers. Can be null if all targets are required and are specified in the required property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string"
#>                                                     }
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "required",
#>                                                 "optional"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "target_date": {
#>                                             "description": "An object containing arrays of required and optional unique target dates. For short-term forecasts, the target_date specifies the date of occurrence of the outcome of interest. For instance, if models are requested to forecast the number of hospitalizations that will occur on 2022-07-15, the target_date is 2022-07-15",
#>                                             "examples": [
#>                                                 {
#>                                                     "required": null,
#>                                                     "optional": [
#>                                                         "2022-11-12",
#>                                                         "2022-11-19",
#>                                                         "2022-11-26"
#>                                                     ]
#>                                                 }
#>                                             ],
#>                                             "type": "object",
#>                                             "properties": {
#>                                                 "required": {
#>                                                     "description": "Array of target date unique identifiers that must be present for submission to be valid. Can be null if no target dates are required and all valid target dates are specified in the optional property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string",
#>                                                         "format": "date"
#>                                                     }
#>                                                 },
#>                                                 "optional": {
#>                                                     "description": "Array of valid but not required unique target date identifiers. Can be null if all target dates are required and are specified in the required property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string",
#>                                                         "format": "date"
#>                                                     }
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "required",
#>                                                 "optional"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "target_end_date": {
#>                                             "description": "An object containing arrays of required and optional unique target end dates. For short-term forecasts, the target_end_date specifies the date of occurrence of the outcome of interest. For instance, if models are requested to forecast the number of hospitalizations that will occur on 2022-07-15, the target_end_date is 2022-07-15",
#>                                             "examples": [
#>                                                 {
#>                                                     "required": null,
#>                                                     "optional": [
#>                                                         "2022-11-12",
#>                                                         "2022-11-19",
#>                                                         "2022-11-26"
#>                                                     ]
#>                                                 }
#>                                             ],
#>                                             "type": "object",
#>                                             "properties": {
#>                                                 "required": {
#>                                                     "description": "Array of target end date unique identifiers that must be present for submission to be valid. Can be null if no target end dates are required and all valid target end dates are specified in the optional property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string",
#>                                                         "format": "date"
#>                                                     }
#>                                                 },
#>                                                 "optional": {
#>                                                     "description": "Array of valid but not required unique target end date identifiers. Can be null if all target end dates are required and are specified in the required property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string",
#>                                                         "format": "date"
#>                                                     }
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "required",
#>                                                 "optional"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "horizon": {
#>                                             "description": "An object containing arrays of required and optional unique horizons. Horizons define the difference between the target_date and the origin_date in time units specified by the hub (e.g., may be days, weeks, or months)",
#>                                             "examples": [
#>                                                 {
#>                                                     "required": null,
#>                                                     "optional": [
#>                                                         1,
#>                                                         2,
#>                                                         3,
#>                                                         4
#>                                                     ]
#>                                                 }
#>                                             ],
#>                                             "type": "object",
#>                                             "properties": {
#>                                                 "required": {
#>                                                     "description": "Array of horizon unique identifiers that must be present for submission to be valid. Can be null if no horizons are required and all valid horizons are specified in the optional property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": [
#>                                                             "integer",
#>                                                             "string"
#>                                                         ]
#>                                                     }
#>                                                 },
#>                                                 "optional": {
#>                                                     "description": "Array of valid but not required unique horizon identifiers. Can be null if all horizons are required and are specified in the required property.",
#>                                                     "type": [
#>                                                         "null",
#>                                                         "array"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": [
#>                                                             "integer",
#>                                                             "string"
#>                                                         ]
#>                                                     }
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "required",
#>                                                 "optional"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "age_group": {
#>                                             "type": "object",
#>                                             "description": "An object containing arrays of required and optional unique identifiers for age groups",
#>                                             "examples": [
#>                                                 {
#>                                                     "required": [
#>                                                         "0-5",
#>                                                         "6-18",
#>                                                         "19-24",
#>                                                         "25-64",
#>                                                         "65+"
#>                                                     ],
#>                                                     "optional": null
#>                                                 }
#>                                             ],
#>                                             "properties": {
#>                                                 "required": {
#>                                                     "description": "Array of age group unique identifiers that must be present for submission to be valid. Can be null if no age groups are required and all valid age groups are specified in the optional property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string"
#>                                                     }
#>                                                 },
#>                                                 "optional": {
#>                                                     "description": "Array of valid but not required unique age group identifiers. Can be null if all age group are required and are specified in the required property.",
#>                                                     "type": [
#>                                                         "array",
#>                                                         "null"
#>                                                     ],
#>                                                     "uniqueItems": true,
#>                                                     "items": {
#>                                                         "type": "string"
#>                                                     }
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "required",
#>                                                 "optional"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         }
#>                                     },
#>                                     "additionalProperties": {
#>                                         "type": "object",
#>                                         "description": "An object containing arrays of required and optional unique values for a custom Task ID",
#>                                         "properties": {
#>                                             "required": {
#>                                                 "description": "Array of custom Task ID unique values that must be present for submission to be valid. Can be null if no values are required and all valid values are specified in the optional property.",
#>                                                 "type": [
#>                                                     "array",
#>                                                     "null"
#>                                                 ],
#>                                                 "uniqueItems": true
#>                                             },
#>                                             "optional": {
#>                                                 "description": "Array of valid but not required unique custom Task ID values. Can be null if all values are required and are specified in the required property.",
#>                                                 "type": [
#>                                                     "array",
#>                                                     "null"
#>                                                 ],
#>                                                 "uniqueItems": true
#>                                             }
#>                                         },
#>                                         "required": [
#>                                             "required",
#>                                             "optional"
#>                                         ],
#>                                         "additionalProperties": false
#>                                     }
#>                                 },
#>                                 "output_type": {
#>                                     "type": "object",
#>                                     "description": "Object defining valid model output types for a given modeling task. The name of each property corresponds to valid values in column 'output_type' while the 'output_type_id' property of each output type defines the valid values of the 'output_type_id' column and the 'value' property defines the valid values of the 'value' column for a given output type.",
#>                                     "properties": {
#>                                         "mean": {
#>                                             "type": "object",
#>                                             "description": "Object defining the mean of the predictive distribution output type.",
#>                                             "properties": {
#>                                                 "output_type_id": {
#>                                                     "description": "output_type_id is not meaningful for a point estimate output_type. Must have a single property named 'required' with the value null.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "required": null
#>                                                         }
#>                                                     ],
#>                                                     "type": "object",
#>                                                     "properties": {
#>                                                         "required": {
#>                                                             "description": "Not relevant for point estimate output types. Must be null.",
#>                                                             "type": "null"
#>                                                         }
#>                                                     },
#>                                                     "required": [
#>                                                         "required"
#>                                                     ],
#>                                                     "additionalProperties": false
#>                                                 },
#>                                                 "value": {
#>                                                     "type": "object",
#>                                                     "description": "Object defining the characteristics of valid mean values.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "type": "double",
#>                                                             "minimum": 0
#>                                                         }
#>                                                     ],
#>                                                     "properties": {
#>                                                         "type": {
#>                                                             "description": "Data type of mean values.",
#>                                                             "type": "string",
#>                                                             "enum": [
#>                                                                 "double",
#>                                                                 "integer"
#>                                                             ]
#>                                                         },
#>                                                         "minimum": {
#>                                                             "description": "The minimum inclusive valid mean value",
#>                                                             "type": [
#>                                                                 "number",
#>                                                                 "integer"
#>                                                             ]
#>                                                         },
#>                                                         "maximum": {
#>                                                             "description": "the maximum inclusive valid mean value",
#>                                                             "type": [
#>                                                                 "number",
#>                                                                 "integer"
#>                                                             ]
#>                                                         }
#>                                                     },
#>                                                     "required": [
#>                                                         "type"
#>                                                     ],
#>                                                     "additionalProperties": false
#>                                                 },
#>                                                 "is_required": {
#>                                                     "description": "Is output type required? When required, property should be set to 'true'. If output type is optional, set to 'false'.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "is_required": true
#>                                                         },
#>                                                         {
#>                                                             "is_required": false
#>                                                         }
#>                                                     ],
#>                                                     "type": "boolean"
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "output_type_id",
#>                                                 "value",
#>                                                 "is_required"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "median": {
#>                                             "type": "object",
#>                                             "description": "Object defining the median of the predictive distribution output type",
#>                                             "properties": {
#>                                                 "output_type_id": {
#>                                                     "description": "output_type_id is not meaningful for a point estimate output_type. Must have a single property named 'required' with the value null.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "required": null
#>                                                         }
#>                                                     ],
#>                                                     "type": "object",
#>                                                     "properties": {
#>                                                         "required": {
#>                                                             "description": "Not relevant for point estimate output types. Must be null.",
#>                                                             "type": "null"
#>                                                         }
#>                                                     },
#>                                                     "required": [
#>                                                         "required"
#>                                                     ],
#>                                                     "additionalProperties": false
#>                                                 },
#>                                                 "value": {
#>                                                     "type": "object",
#>                                                     "description": "Object defining the characteristics of valid median values.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "type": "double",
#>                                                             "minimum": 0
#>                                                         }
#>                                                     ],
#>                                                     "properties": {
#>                                                         "type": {
#>                                                             "description": "Data type of median values.",
#>                                                             "type": "string",
#>                                                             "enum": [
#>                                                                 "double",
#>                                                                 "integer"
#>                                                             ]
#>                                                         },
#>                                                         "minimum": {
#>                                                             "description": "The minimum inclusive valid median value",
#>                                                             "type": [
#>                                                                 "number",
#>                                                                 "integer"
#>                                                             ]
#>                                                         },
#>                                                         "maximum": {
#>                                                             "description": "the maximum inclusive valid median value",
#>                                                             "type": [
#>                                                                 "number",
#>                                                                 "integer"
#>                                                             ]
#>                                                         }
#>                                                     },
#>                                                     "required": [
#>                                                         "type"
#>                                                     ],
#>                                                     "additionalProperties": false
#>                                                 },
#>                                                 "is_required": {
#>                                                     "description": "Is output type required? When required, property should be set to 'true'. If output type is optional, set to 'false'.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "is_required": true
#>                                                         },
#>                                                         {
#>                                                             "is_required": false
#>                                                         }
#>                                                     ],
#>                                                     "type": "boolean"
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "output_type_id",
#>                                                 "value",
#>                                                 "is_required"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "quantile": {
#>                                             "description": "Object defining the quantiles of the predictive distribution output type.",
#>                                             "type": "object",
#>                                             "properties": {
#>                                                 "output_type_id": {
#>                                                     "description": "Object containing arrays of required probability levels at which quantiles of the predictive distribution will be recorded.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "required": [
#>                                                                 0.1,
#>                                                                 0.2,
#>                                                                 0.25,
#>                                                                 0.3,
#>                                                                 0.4,
#>                                                                 0.5,
#>                                                                 0.6,
#>                                                                 0.7,
#>                                                                 0.75,
#>                                                                 0.8,
#>                                                                 0.9
#>                                                             ]
#>                                                         }
#>                                                     ],
#>                                                     "type": "object",
#>                                                     "properties": {
#>                                                         "required": {
#>                                                             "description": "Array of unique probability levels between 0 and 1 inclusive that must be present for submission to be valid.",
#>                                                             "type": "array",
#>                                                             "uniqueItems": true,
#>                                                             "items": {
#>                                                                 "type": "number",
#>                                                                 "minimum": 0,
#>                                                                 "maximum": 1
#>                                                             }
#>                                                         }
#>                                                     },
#>                                                     "required": [
#>                                                         "required"
#>                                                     ],
#>                                                     "additionalProperties": false
#>                                                 },
#>                                                 "value": {
#>                                                     "type": "object",
#>                                                     "description": "Object defining the characteristics of valid quantiles of the predictive distribution at a given probability level.",
#>                                                     "properties": {
#>                                                         "type": {
#>                                                             "description": "Data type of quantile values.",
#>                                                             "examples": [
#>                                                                 "double"
#>                                                             ],
#>                                                             "type": "string",
#>                                                             "enum": [
#>                                                                 "double",
#>                                                                 "integer"
#>                                                             ]
#>                                                         },
#>                                                         "minimum": {
#>                                                             "description": "The minimum inclusive valid quantile value (optional).",
#>                                                             "examples": [
#>                                                                 0
#>                                                             ],
#>                                                             "type": [
#>                                                                 "number",
#>                                                                 "integer"
#>                                                             ]
#>                                                         },
#>                                                         "maximum": {
#>                                                             "description": "The maximum inclusive valid quantile value (optional).",
#>                                                             "type": [
#>                                                                 "number",
#>                                                                 "integer"
#>                                                             ]
#>                                                         }
#>                                                     },
#>                                                     "required": [
#>                                                         "type"
#>                                                     ],
#>                                                     "additionalProperties": false
#>                                                 },
#>                                                 "is_required": {
#>                                                     "description": "Is output type required? When required, property should be set to 'true'. If output type is optional, set to 'false'.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "is_required": true
#>                                                         },
#>                                                         {
#>                                                             "is_required": false
#>                                                         }
#>                                                     ],
#>                                                     "type": "boolean"
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "output_type_id",
#>                                                 "value",
#>                                                 "is_required"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "cdf": {
#>                                             "description": "Object defining the cumulative distribution function of the predictive distribution output type.",
#>                                             "type": "object",
#>                                             "properties": {
#>                                                 "output_type_id": {
#>                                                     "description": "Object containing required arrays defining possible values of the target variable at which values of the cumulative distribution function of the predictive distribution will be recorded. These should be listed in order from low to high.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "required": [
#>                                                                 10,
#>                                                                 20
#>                                                             ]
#>                                                         },
#>                                                         {
#>                                                             "required": [
#>                                                                 "EW202240",
#>                                                                 "EW202241",
#>                                                                 "EW202242",
#>                                                                 "EW202243",
#>                                                                 "EW202244",
#>                                                                 "EW202245",
#>                                                                 "EW202246",
#>                                                                 "EW202247"
#>                                                             ]
#>                                                         }
#>                                                     ],
#>                                                     "type": "object",
#>                                                     "properties": {
#>                                                         "required": {
#>                                                             "description": "Array of unique target values that must be present for submission to be valid.",
#>                                                             "type": "array",
#>                                                             "uniqueItems": true,
#>                                                             "items": {
#>                                                                 "oneOf": [
#>                                                                     {
#>                                                                         "type": [
#>                                                                             "number",
#>                                                                             "integer"
#>                                                                         ]
#>                                                                     },
#>                                                                     {
#>                                                                         "type": "string"
#>                                                                     }
#>                                                                 ]
#>                                                             }
#>                                                         }
#>                                                     },
#>                                                     "required": [
#>                                                         "required"
#>                                                     ],
#>                                                     "additionalProperties": false
#>                                                 },
#>                                                 "value": {
#>                                                     "type": "object",
#>                                                     "description": "Object defining the characteristics of valid values of the cumulative distribution function at a given target value.",
#>                                                     "properties": {
#>                                                         "type": {
#>                                                             "description": "Data type of cumulative distribution function values.",
#>                                                             "examples": [
#>                                                                 "double"
#>                                                             ],
#>                                                             "const": "double"
#>                                                         },
#>                                                         "minimum": {
#>                                                             "description": "The minimum inclusive valid cumulative distribution function value. Must be 0.",
#>                                                             "const": 0
#>                                                         },
#>                                                         "maximum": {
#>                                                             "description": "The maximum inclusive valid cumulative distribution function value. Must be 1.",
#>                                                             "const": 1
#>                                                         }
#>                                                     },
#>                                                     "required": [
#>                                                         "type",
#>                                                         "minimum",
#>                                                         "maximum"
#>                                                     ],
#>                                                     "additionalProperties": false
#>                                                 },
#>                                                 "is_required": {
#>                                                     "description": "Is output type required? When required, property should be set to 'true'. If output type is optional, set to 'false'.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "is_required": true
#>                                                         },
#>                                                         {
#>                                                             "is_required": false
#>                                                         }
#>                                                     ],
#>                                                     "type": "boolean"
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "output_type_id",
#>                                                 "value",
#>                                                 "is_required"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "pmf": {
#>                                             "description": "Object defining a probability mass function for a discrete variable output type. Includes nominal, binary and ordinal variable types.",
#>                                             "type": "object",
#>                                             "properties": {
#>                                                 "output_type_id": {
#>                                                     "description": "Object containing arrays of required values specifying valid categories of a discrete variable. Note that for ordinal variables, the category levels should be listed in order from low to high.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "required": [
#>                                                                 "low",
#>                                                                 "moderate",
#>                                                                 "high",
#>                                                                 "extreme"
#>                                                             ]
#>                                                         }
#>                                                     ],
#>                                                     "type": "object",
#>                                                     "properties": {
#>                                                         "required": {
#>                                                             "description": "Array of unique categories of a discrete variable that must be present for submission to be valid.",
#>                                                             "type": "array",
#>                                                             "uniqueItems": true,
#>                                                             "items": {
#>                                                                 "type": "string"
#>                                                             }
#>                                                         }
#>                                                     },
#>                                                     "required": [
#>                                                         "required"
#>                                                     ],
#>                                                     "additionalProperties": false
#>                                                 },
#>                                                 "value": {
#>                                                     "type": "object",
#>                                                     "description": "Object defining valid values of the probability mass function of the predictive distribution for a given category of a discrete outcome variable.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "type": "double",
#>                                                             "minimum": 0,
#>                                                             "maximum": 1
#>                                                         }
#>                                                     ],
#>                                                     "properties": {
#>                                                         "type": {
#>                                                             "description": "Data type of the probability mass function values.",
#>                                                             "const": "double"
#>                                                         },
#>                                                         "minimum": {
#>                                                             "description": "The minimum inclusive valid probability mass function value. Must be 0.",
#>                                                             "const": 0
#>                                                         },
#>                                                         "maximum": {
#>                                                             "description": "The maximum inclusive valid probability mass function value. Must be 1.",
#>                                                             "const": 1
#>                                                         }
#>                                                     },
#>                                                     "required": [
#>                                                         "type",
#>                                                         "minimum",
#>                                                         "maximum"
#>                                                     ],
#>                                                     "additionalProperties": false
#>                                                 },
#>                                                 "is_required": {
#>                                                     "description": "Is output type required? When required, property should be set to 'true'. If output type is optional, set to 'false'.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "is_required": true
#>                                                         },
#>                                                         {
#>                                                             "is_required": false
#>                                                         }
#>                                                     ],
#>                                                     "type": "boolean"
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "output_type_id",
#>                                                 "value",
#>                                                 "is_required"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         },
#>                                         "sample": {
#>                                             "description": "Object defining a sample output type.",
#>                                             "type": "object",
#>                                             "properties": {
#>                                                 "output_type_id_params": {
#>                                                     "description": "Object containing parameters specifying how samples were drawn.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "output_type_id_params": {
#>                                                                 "type": "integer",
#>                                                                 "min_samples_per_task": 100,
#>                                                                 "max_samples_per_task": 100
#>                                                             }
#>                                                         },
#>                                                         {
#>                                                             "output_type_id_params": {
#>                                                                 "type": "character",
#>                                                                 "max_length": 6,
#>                                                                 "min_samples_per_task": 100,
#>                                                                 "max_samples_per_task": 500,
#>                                                                 "compound_taskid_set": [
#>                                                                     "origin_date",
#>                                                                     "horizon",
#>                                                                     "location",
#>                                                                     "variant"
#>                                                                 ]
#>                                                             }
#>                                                         }
#>                                                     ],
#>                                                     "type": "object",
#>                                                     "properties": {
#>                                                         "type": {
#>                                                             "description": "Data type of sample indices.",
#>                                                             "type": "string",
#>                                                             "enum": [
#>                                                                 "character",
#>                                                                 "integer"
#>                                                             ]
#>                                                         },
#>                                                         "max_length": {
#>                                                             "description": "Required only if 'type' is 'character'. Positive integer representing the maximum number of characters in a sample index. Ignored if 'type' is 'integer'.",
#>                                                             "type": "integer",
#>                                                             "minimum": 1
#>                                                         },
#>                                                         "min_samples_per_task": {
#>                                                             "description": "The minimum number of samples per individual task.",
#>                                                             "type": "integer",
#>                                                             "minimum": 1
#>                                                         },
#>                                                         "max_samples_per_task": {
#>                                                             "description": "The maximum number of samples per individual task.",
#>                                                             "type": "integer",
#>                                                             "minimum": 1
#>                                                         },
#>                                                         "compound_taskid_set": {
#>                                                             "description": "Optional. Specifies whether validation should factor in the presence of a compound modeling task. Each item of the array must be a task id variable name. If unspecified, defaults to all task ID variables.",
#>                                                             "type": [
#>                                                                 "array"
#>                                                             ],
#>                                                             "uniqueItems": true,
#>                                                             "items": {
#>                                                                 "type": "string"
#>                                                             }
#>                                                         }
#>                                                     },
#>                                                     "required": [
#>                                                         "type",
#>                                                         "min_samples_per_task",
#>                                                         "max_samples_per_task"
#>                                                     ],
#>                                                     "if": {
#>                                                         "properties": {
#>                                                             "type": {
#>                                                                 "const": "character"
#>                                                             }
#>                                                         }
#>                                                     },
#>                                                     "then": {
#>                                                         "required": [
#>                                                             "max_length"
#>                                                         ]
#>                                                     },
#>                                                     "additionalProperties": false
#>                                                 },
#>                                                 "value": {
#>                                                     "type": "object",
#>                                                     "description": "Object defining valid values of samples from the predictive distribution for a given sample index.  Depending on the Hub specification, samples with the same sample index (specified by the output_type_id) may be assumed to correspond to a joint distribution across multiple levels of the task id variables. See Hub documentation for details.",
#>                                                     "properties": {
#>                                                         "type": {
#>                                                             "description": "Data type of sample value from the predictive distribution.",
#>                                                             "examples": [
#>                                                                 {
#>                                                                     "type": "double"
#>                                                                 }
#>                                                             ],
#>                                                             "type": "string",
#>                                                             "enum": [
#>                                                                 "double",
#>                                                                 "integer"
#>                                                             ]
#>                                                         },
#>                                                         "minimum": {
#>                                                             "description": "The minimum inclusive valid sample value from the predictive distribution.",
#>                                                             "type": [
#>                                                                 "number",
#>                                                                 "integer"
#>                                                             ]
#>                                                         },
#>                                                         "maximum": {
#>                                                             "description": "The maximum inclusive valid sample value from the predictive distribution.",
#>                                                             "type": [
#>                                                                 "number",
#>                                                                 "integer"
#>                                                             ]
#>                                                         }
#>                                                     },
#>                                                     "required": [
#>                                                         "type"
#>                                                     ],
#>                                                     "additionalProperties": false
#>                                                 },
#>                                                 "is_required": {
#>                                                     "description": "Is output type required? When required, property should be set to 'true'. If output type is optional, set to 'false'.",
#>                                                     "examples": [
#>                                                         {
#>                                                             "is_required": true
#>                                                         },
#>                                                         {
#>                                                             "is_required": false
#>                                                         }
#>                                                     ],
#>                                                     "type": "boolean"
#>                                                 }
#>                                             },
#>                                             "required": [
#>                                                 "output_type_id_params",
#>                                                 "value",
#>                                                 "is_required"
#>                                             ],
#>                                             "additionalProperties": false
#>                                         }
#>                                     },
#>                                     "additionalProperties": false
#>                                 },
#>                                 "target_metadata": {
#>                                     "description": "Array of objects containing metadata about each unique target, one object for each unique target value.",
#>                                     "type": "array",
#>                                     "items": {
#>                                         "type": "object",
#>                                         "description": "Object containg metadata about a single unique target.",
#>                                         "properties": {
#>                                             "target_id": {
#>                                                 "description": "Short description that uniquely identifies the target.",
#>                                                 "examples": [
#>                                                     "inc hosp",
#>                                                     "peak week hosp"
#>                                                 ],
#>                                                 "type": "string",
#>                                                 "maxLength": 30
#>                                             },
#>                                             "target_name": {
#>                                                 "description": "A longer human readable target description that could be used, for example, as a visualisation axis label.",
#>                                                 "examples": [
#>                                                     "Weekly incident influenza hospitalizations",
#>                                                     "Peak week for incident influenza hospitalizations"
#>                                                 ],
#>                                                 "type": "string",
#>                                                 "maxLength": 100
#>                                             },
#>                                             "target_units": {
#>                                                 "description": "Unit of observation of the target.",
#>                                                 "examples": [
#>                                                     "rate per 100,000 population",
#>                                                     "count",
#>                                                     "date"
#>                                                 ],
#>                                                 "type": "string",
#>                                                 "maxLength": 100
#>                                             },
#>                                             "target_keys": {
#>                                                 "description": "Should be either null, in the case where the target is not specified as a task_id and is specified solely through the target_id target_metadata property or an object with a single property. The property name must match a task_id variable defined within the same model_tasks object and should have a single specified value, which matches one of the values in the associated task ID variable. This value defines a single target.",
#>                                                 "examples": [
#>                                                     {
#>                                                         "target": "inc hosp"
#>                                                     },
#>                                                     {
#>                                                         "target": "peak week hosp"
#>                                                     },
#>                                                     null
#>                                                 ],
#>                                                 "type": [
#>                                                     "object",
#>                                                     "null"
#>                                                 ],
#>                                                 "minProperties": 1,
#>                                                 "maxProperties": 1,
#>                                                 "additionalProperties": {
#>                                                     "type": "string"
#>                                                 }
#>                                             },
#>                                             "description": {
#>                                                 "description": "a verbose description of the target that might include information such as the target_measure above, or definitions of a 'rate' or similar.",
#>                                                 "type": "string"
#>                                             },
#>                                             "target_type": {
#>                                                 "description": "Target statistical data type",
#>                                                 "examples": [
#>                                                     "discrete",
#>                                                     "ordinal"
#>                                                 ],
#>                                                 "type": "string",
#>                                                 "enum": [
#>                                                     "continuous",
#>                                                     "discrete",
#>                                                     "date",
#>                                                     "binary",
#>                                                     "nominal",
#>                                                     "ordinal",
#>                                                     "compositional"
#>                                                 ]
#>                                             },
#>                                             "is_step_ahead": {
#>                                                 "description": "Whether the target is part of a sequence of values",
#>                                                 "examples": [
#>                                                     true,
#>                                                     false
#>                                                 ],
#>                                                 "type": "boolean"
#>                                             },
#>                                             "time_unit": {
#>                                                 "description": " if is_step_ahead is true, then this is required and defines the unit of time steps. if is_step_ahead is false, then this should be left out and/or will be ignored if present.",
#>                                                 "examples": [
#>                                                     "week"
#>                                                 ],
#>                                                 "type": "string",
#>                                                 "enum": [
#>                                                     "day",
#>                                                     "week",
#>                                                     "month"
#>                                                 ]
#>                                             },
#>                                             "additional_metadata": {
#>                                                 "description": "Optional property in which any type of custom metadata can be stored.",
#>                                                 "type": "object",
#>                                                 "additionalProperties": true
#>                                             }
#>                                         },
#>                                         "required": [
#>                                             "target_id",
#>                                             "target_name",
#>                                             "target_units",
#>                                             "target_type",
#>                                             "target_keys",
#>                                             "is_step_ahead"
#>                                         ],
#>                                         "additionalProperties": false,
#>                                         "if": {
#>                                             "properties": {
#>                                                 "is_step_ahead": {
#>                                                     "const": true
#>                                                 }
#>                                             }
#>                                         },
#>                                         "then": {
#>                                             "required": [
#>                                                 "time_unit"
#>                                             ]
#>                                         }
#>                                     }
#>                                 }
#>                             },
#>                             "required": [
#>                                 "task_ids",
#>                                 "output_type",
#>                                 "target_metadata"
#>                             ],
#>                             "additionalProperties": false
#>                         }
#>                     },
#>                     "submissions_due": {
#>                         "description": "Object defining the dates by which model forecasts must be submitted to the hub.",
#>                         "examples": [
#>                             {
#>                                 "start": "2022-06-07",
#>                                 "end": "2022-07-20"
#>                             },
#>                             {
#>                                 "relative_to": "origin_date",
#>                                 "start": -4,
#>                                 "end": 2
#>                             }
#>                         ],
#>                         "type": "object",
#>                         "oneOf": [
#>                             {
#>                                 "properties": {
#>                                     "relative_to": {
#>                                         "description": "Name of task id variable in relation to which submission start and end dates are calculated.",
#>                                         "type": "string"
#>                                     },
#>                                     "start": {
#>                                         "description": "Difference in days between start and origin date.",
#>                                         "type": "integer"
#>                                     },
#>                                     "end": {
#>                                         "description": "Difference in days between end and origin date.",
#>                                         "type": "integer"
#>                                     }
#>                                 },
#>                                 "required": [
#>                                     "relative_to",
#>                                     "start",
#>                                     "end"
#>                                 ],
#>                                 "additionalProperties": false
#>                             },
#>                             {
#>                                 "properties": {
#>                                     "start": {
#>                                         "description": "Submission start date.",
#>                                         "type": "string",
#>                                         "format": "date"
#>                                     },
#>                                     "end": {
#>                                         "description": "Submission end date.",
#>                                         "type": "string",
#>                                         "format": "date"
#>                                     }
#>                                 },
#>                                 "required": [
#>                                     "start",
#>                                     "end"
#>                                 ],
#>                                 "additionalProperties": false
#>                             }
#>                         ],
#>                         "required": [
#>                             "start",
#>                             "end"
#>                         ]
#>                     },
#>                     "last_data_date": {
#>                         "description": "The last date with recorded data in the data set used as input to a model.",
#>                         "examples": [
#>                             "2022-07-18"
#>                         ],
#>                         "type": "string",
#>                         "format": "date"
#>                     },
#>                     "file_format": {
#>                         "description": "Accepted file formats of model output files for the round. Overrides the file formats provided in admin.json.",
#>                         "examples": [
#>                             [
#>                                 "arrow",
#>                                 "parquet"
#>                             ],
#>                             [
#>                                 "csv"
#>                             ]
#>                         ],
#>                         "type": "array",
#>                         "items": {
#>                             "type": "string",
#>                             "enum": [
#>                                 "csv",
#>                                 "parquet",
#>                                 "arrow"
#>                             ]
#>                         }
#>                     },
#>                     "derived_task_ids": {
#>                         "description": "Names of derived task IDs, i.e. task IDs whose values are derived from (and therefore dependent on) the values of other variables. Use this property to override the global setting for a specific round.",
#>                         "examples": [
#>                             [
#>                                 "target_end_date"
#>                             ]
#>                         ],
#>                         "type": [
#>                             "array",
#>                             "null"
#>                         ],
#>                         "uniqueItems": true,
#>                         "items": {
#>                             "type": "string"
#>                         }
#>                     },
#>                     "additional_metadata": {
#>                         "description": "Optional property in which any type of custom metadata can be stored.",
#>                         "type": "object",
#>                         "additionalProperties": true
#>                     }
#>                 },
#>                 "if": {
#>                     "properties": {
#>                         "round_id_from_variable": {
#>                             "const": false
#>                         }
#>                     }
#>                 },
#>                 "then": {
#>                     "properties": {
#>                         "round_id": {
#>                             "pattern": "^([0-9]{4}-[0-9]{2}-[0-9]{2})$|^[A-Za-z0-9_]+$",
#>                             "errorMessage": "The 'round_id' must match either an ISO date format (YYYY-MM-DD) or alphanumeric characters separated by underscores."
#>                         }
#>                     }
#>                 },
#>                 "required": [
#>                     "round_id_from_variable",
#>                     "round_id",
#>                     "model_tasks",
#>                     "submissions_due"
#>                 ],
#>                 "additionalProperties": false
#>             }
#>         },
#>         "output_type_id_datatype": {
#>             "description": "The hub level data type of the output_type_id column. This data type must be shared across all files in the hub and be able to represent all output type ID values across all hub output types and rounds. If not provided or set to 'auto', hub defaults to autodetecting the simplest hub level data type.",
#>             "default": "auto",
#>             "examples": [
#>                 "character"
#>             ],
#>             "type": "string",
#>             "enum": [
#>                 "auto",
#>                 "character",
#>                 "double",
#>                 "integer",
#>                 "logical",
#>                 "Date"
#>             ]
#>         },
#>         "derived_task_ids": {
#>             "description": "Names of derived task IDs, i.e. task IDs whose values are derived from (and therefore dependent on) the values of other variables.",
#>             "examples": [
#>                 [
#>                     "target_end_date"
#>                 ]
#>             ],
#>             "type": [
#>                 "array",
#>                 "null"
#>             ],
#>             "uniqueItems": true,
#>             "items": {
#>                 "type": "string"
#>             }
#>         }
#>     },
#>     "required": [
#>         "rounds",
#>         "schema_version"
#>     ],
#>     "additionalProperties": false
#> }
#>  
download_tasks_schema(schema_version = "v2.0.1")
#> $`$schema`
#> [1] "https://json-schema.org/draft/2020-12/schema"
#> 
#> $`$id`
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.1/tasks-schema.json"
#> 
#> $title
#> [1] "Schema for Modeling Hub model task definitions"
#> 
#> $description
#> [1] "This is the schema of the tasks.json configuration file that defines the tasks within a modeling hub."
#> 
#> $type
#> [1] "object"
#> 
#> $properties
#> $properties$schema_version
#> $properties$schema_version$description
#> [1] "URL to a version of the Modeling Hub schema tasks-schema.json file (see https://github.com/hubverse-org/schemas). Used to declare the schema version a 'tasks.json' file is written for and for config file validation. The URL provided should be the URL to the raw content of the schema file on GitHub."
#> 
#> $properties$schema_version$examples
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v0.0.1/tasks-schema.json"
#> 
#> $properties$schema_version$type
#> [1] "string"
#> 
#> $properties$schema_version$format
#> [1] "uri"
#> 
#> 
#> $properties$rounds
#> $properties$rounds$description
#> [1] "Array of modeling round properties"
#> 
#> $properties$rounds$type
#> [1] "array"
#> 
#> $properties$rounds$items
#> $properties$rounds$items$type
#> [1] "object"
#> 
#> $properties$rounds$items$description
#> [1] "Individual modeling round properties"
#> 
#> $properties$rounds$items$properties
#> $properties$rounds$items$properties$round_id_from_variable
#> $properties$rounds$items$properties$round_id_from_variable$description
#> [1] "Whether the round identifier is encoded by a task id variable in the data."
#> 
#> $properties$rounds$items$properties$round_id_from_variable$type
#> [1] "boolean"
#> 
#> 
#> $properties$rounds$items$properties$round_id
#> $properties$rounds$items$properties$round_id$description
#> [1] "Round identifier. If round_id_from_variable = true, round_id should be the name of a task id variable present in all sets of modeling task specifications"
#> 
#> $properties$rounds$items$properties$round_id$examples
#> [1] "round-1"     "2022-11-05"  "origin_date"
#> 
#> $properties$rounds$items$properties$round_id$type
#> [1] "string"
#> 
#> 
#> $properties$rounds$items$properties$round_name
#> $properties$rounds$items$properties$round_name$description
#> [1] "An optional round name. This can be useful for internal referencing of rounds, for examples, when a date is used as round_id but hub maintainers and teams also refer to rounds as round-1, round-2 etc."
#> 
#> $properties$rounds$items$properties$round_name$examples
#> [1] "round-1"
#> 
#> $properties$rounds$items$properties$round_name$type
#> [1] "string"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks
#> $properties$rounds$items$properties$model_tasks$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$description
#> [1] "Array defining round-specific modeling tasks. Can contain one or more groups of modeling tasks per round where each group is defined by a distinct combination of values of task id variables."
#> 
#> $properties$rounds$items$properties$model_tasks$items
#> $properties$rounds$items$properties$model_tasks$items$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$description
#> [1] "Group of valid values of task id variables. A set of valid tasks corresponding to this group is formed by taking all combinations of these values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$description
#> [1] "An object containing arrays of required and optional unique origin dates. Origin date defines the starting point that can be used for calculating a target_date via the formula target_date = origin_date + horizon x time_units_per_horizon (e.g., with weekly data, target_date is calculated as origin_date + horizon x 7 days)"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$examples[[1]]$optional
#> [1] "2022-11-05" "2022-11-12" "2022-11-19"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$description
#> [1] "Array of origin date unique identifiers that must be present for submission to be valid. Can be null if no origin dates are required and all valid origin dates are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$items$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$description
#> [1] "Array of valid but not required unique origin date identifiers. Can be null if all origin dates are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$items$format
#> [1] "date"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$description
#> [1] "An object containing arrays of required and optional unique forecast dates. Forecast date usually defines the date that a model is run to produce a forecast."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$examples[[1]]$optional
#> [1] "2022-11-05" "2022-11-12" "2022-11-19"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$description
#> [1] "Array of forecast date unique identifiers that must be present for submission to be valid. Can be null if no forecast dates are required and all valid forecast dates are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$items$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$description
#> [1] "Array of valid but not required unique forecast date identifiers. Can be null if all forecast dates are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$items$format
#> [1] "date"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$description
#> [1] "An object containing arrays of required and optional unique identifiers of each valid scenario."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[1]]$optional
#> [1] 1 2 3 4
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[2]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[2]]$optional
#> [1] "A-2021-03-28" "B-2021-03-28" "A-2021-04-05" "B-2021-04-05"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$description
#> [1] "Array of identifiers of scenarios that must be present in a valid submission. Can be null if no scenario ids are required and all valid ids are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$items$type
#> [1] "integer" "string" 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$description
#> [1] "Array of identifiers of valid but not required scenarios. Can be null if all scenarios are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$type
#> [1] "null"  "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$items$type
#> [1] "integer" "string" 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$description
#> [1] "An object containing arrays of required and optional unique identifiers for each valid location, e.g. country codes, FIPS state or county level code etc."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$examples[[1]]$required
#> [1] "US"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$examples[[1]]$optional
#>  [1] "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17" "18"
#> [16] "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33"
#> [31] "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48" "49"
#> [46] "50" "51" "53" "54" "55" "56"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$description
#> [1] "Array of location unique identifiers that must be present for submission to be valid. Can be null if no locations are required and all valid locations are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$description
#> [1] "Array of valid but not required unique location identifiers. Can be null if all locations are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$description
#> [1] "An object containing arrays of required and optional unique identifiers for each valid target. Usually represents a single task ID target key variable."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[1]]$optional
#> [1] "inc hosp"  "inc case"  "inc death"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[2]]$required
#> [1] "peak week inc hosp"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[2]]$optional
#> NULL
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$description
#> [1] "Array of target unique identifiers that must be present for submission to be valid. Can be null if no targets are required and all valid targets are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$description
#> [1] "Array of valid but not required unique target identifiers. Can be null if all targets are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$description
#> [1] "An object containing arrays of required and optional unique identifiers for each valid target variable. Usually forms part of a pair of task ID target key variables (along with target_outcome) which combine to define individual targets."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples[[1]]$optional
#> [1] "hosp"  "death" "case" 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples[[2]]$required
#> [1] "hosp"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples[[2]]$optional
#> [1] "case"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$required$description
#> [1] "Array of target variable unique identifiers that must be present for submission to be valid. Can be null if no target variables are required and all valid target variables are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$optional$description
#> [1] "Array of valid but not required unique target variable identifiers. Can be null if all target variables are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$description
#> [1] "An object containing arrays of required and optional unique identifiers for each valid target outcome. Usually forms part of a pair of task ID target key variables (along with target_variable) which combine to define individual targets."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples[[1]]$required
#> [1] "inc"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples[[1]]$optional
#> NULL
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples[[2]]$required
#> [1] "inc"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples[[2]]$optional
#> [1] "cum"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$required$description
#> [1] "Array of target outcome unique identifiers that must be present for submission to be valid. Can be null if no target outcomes are required and all valid target outcomes are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$optional$description
#> [1] "Array of valid but not required unique target outcome identifiers. Can be null if all target outcomes are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$description
#> [1] "An object containing arrays of required and optional unique target dates. For short-term forecasts, the target_date specifies the date of occurrence of the outcome of interest. For instance, if models are requested to forecast the number of hospitalizations that will occur on 2022-07-15, the target_date is 2022-07-15"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$examples[[1]]$optional
#> [1] "2022-11-12" "2022-11-19" "2022-11-26"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$description
#> [1] "Array of target date unique identifiers that must be present for submission to be valid. Can be null if no target dates are required and all valid target dates are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$items$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$description
#> [1] "Array of valid but not required unique target date identifiers. Can be null if all target dates are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$items$format
#> [1] "date"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$description
#> [1] "An object containing arrays of required and optional unique target end dates. For short-term forecasts, the target_end_date specifies the date of occurrence of the outcome of interest. For instance, if models are requested to forecast the number of hospitalizations that will occur on 2022-07-15, the target_end_date is 2022-07-15"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$examples[[1]]$optional
#> [1] "2022-11-12" "2022-11-19" "2022-11-26"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$description
#> [1] "Array of target end date unique identifiers that must be present for submission to be valid. Can be null if no target end dates are required and all valid target end dates are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$items$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$description
#> [1] "Array of valid but not required unique target end date identifiers. Can be null if all target end dates are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$items$format
#> [1] "date"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$description
#> [1] "An object containing arrays of required and optional unique horizons. Horizons define the difference between the target_date and the origin_date in time units specified by the hub (e.g., may be days, weeks, or months)"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$examples[[1]]$optional
#> [1] 1 2 3 4
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$description
#> [1] "Array of horizon unique identifiers that must be present for submission to be valid. Can be null if no horizons are required and all valid horizons are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$items$type
#> [1] "integer" "string" 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$description
#> [1] "Array of valid but not required unique horizon identifiers. Can be null if all horizons are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$type
#> [1] "null"  "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$items$type
#> [1] "integer" "string" 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$description
#> [1] "An object containing arrays of required and optional unique identifiers for age groups"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$examples[[1]]$required
#> [1] "0-5"   "6-18"  "19-24" "25-64" "65+"  
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$examples[[1]]$optional
#> NULL
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$description
#> [1] "Array of age group unique identifiers that must be present for submission to be valid. Can be null if no age groups are required and all valid age groups are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$description
#> [1] "Array of valid but not required unique age group identifiers. Can be null if all age group are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$required
#> [1] "required" "optional"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$description
#> [1] "An object containing arrays of required and optional unique values for a custom Task ID"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$required$description
#> [1] "Array of custom Task ID unique values that must be present for submission to be valid. Can be null if no values are required and all valid values are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$required$uniqueItems
#> [1] TRUE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$optional$description
#> [1] "Array of valid but not required unique custom Task ID values. Can be null if all values are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$required
#> [1] "required" "optional"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$description
#> [1] "Object defining valid model output types for a given modeling task. The name of each property corresponds to valid values in column 'output_type' while the 'output_type_id' property of each output type defines the valid values of the 'output_type_id' column and the 'value' property defines the valid values of the 'value' column for a given output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$description
#> [1] "Object defining the mean of the predictive distribution output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$description
#> [1] "output_type_id is not meaningful for a mean output_type. The property is primarily used to determine whether mean is a required or optional output type through properties required and optional. If mean is a required output type, the required property must be an array containing the single string element 'NA' and the optional property must be set to null. If mean is an optional output type, the optional property must be an array containing the single string element 'NA' and the required property must be set to null"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[1]]$required
#> [1] NA
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[1]]$optional
#> NULL
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[2]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[2]]$optional
#> [1] NA
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$required$description
#> [1] "When mean is required, property set to single element 'NA' array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$required$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$required$items$const
#> [1] "NA"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$required$items$maxItems
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$optional$description
#> [1] "When mean is required, property set to null"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$optional$type
#> [1] "null"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$required$description
#> [1] "When mean is optional, property set to null"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$required$type
#> [1] "null"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$optional$description
#> [1] "When mean is optional, property set to single element 'NA' array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$optional$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$optional$items$const
#> [1] "NA"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$optional$items$maxItems
#> [1] 1
#> 
#> 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$description
#> [1] "Object defining the characteristics of valid mean values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$examples[[1]]$type
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$examples[[1]]$minimum
#> [1] 0
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$type$description
#> [1] "Data type of mean values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$type$enum
#> [1] "double"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid mean value"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$minimum$type
#> [1] "number"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$maximum$description
#> [1] "the maximum inclusive valid mean value"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$maximum$type
#> [1] "number"  "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$required
#> [1] "type"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$required
#> [1] "output_type_id" "value"         
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$description
#> [1] "Object defining the median of the predictive distribution output type"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$description
#> [1] "output_type_id is not meaningful for a median output_type. The property is primarily used to determine whether median is a required or optional output type through properties required and optional. If median is a required output type, the required property must be an array containing the single string element 'NA' and the optional property must be set to null. If median is an optional output type, the optional property must be an array containing the single string element 'NA' and the required property must be set to null"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[1]]$required
#> [1] NA
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[1]]$optional
#> NULL
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[2]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[2]]$optional
#> [1] NA
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$required$description
#> [1] "When median is required, property set to single element 'NA' array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$required$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$required$items$const
#> [1] "NA"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$required$items$maxItems
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$optional$description
#> [1] "When median is required, property set to null"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$optional$type
#> [1] "null"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$required$description
#> [1] "When median is optional, property set to null"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$required$type
#> [1] "null"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$optional$description
#> [1] "When median is optional, property set to single element 'NA' array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$optional$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$optional$items$const
#> [1] "NA"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$optional$items$maxItems
#> [1] 1
#> 
#> 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$description
#> [1] "Object defining the characteristics of valid median values"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$examples[[1]]$type
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$examples[[1]]$minimum
#> [1] 0
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$type$description
#> [1] "Data type of median values"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$type$enum
#> [1] "double"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid median value"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$minimum$type
#> [1] "number"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$maximum$description
#> [1] "the maximum inclusive valid median value"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$maximum$type
#> [1] "number"  "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$required
#> [1] "type"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$required
#> [1] "output_type_id" "value"         
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$description
#> [1] "Object defining the quantiles of the predictive distribution output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$description
#> [1] "Object containing required and optional arrays defining the probability levels at which quantiles of the predictive distribution will be recorded."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$examples[[1]]$required
#> [1] 0.25 0.50 0.75
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$examples[[1]]$optional
#> [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$description
#> [1] "Array of unique probability levels between 0 and 1 that must be present for submission to be valid. Can be null if no probability levels are required and all valid probability levels are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$items$type
#> [1] "number"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$items$minimum
#> [1] 0
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$items$maximum
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$description
#> [1] "Array of valid but not required unique probability levels. Can be null if all probability levels are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$items$type
#> [1] "number"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$items$minimum
#> [1] 0
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$items$maximum
#> [1] 1
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$description
#> [1] "Object defining the characteristics of valid quantiles of the predictive distribution at a given probability level."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type$description
#> [1] "Data type of quantile values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type$examples
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type$enum
#> [1] "double"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid quantile value (optional)."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$minimum$examples
#> [1] 0
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$minimum$type
#> [1] "number"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$maximum$description
#> [1] "The maximum inclusive valid quantile value (optional)."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$maximum$type
#> [1] "number"  "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$required
#> [1] "type"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$required
#> [1] "output_type_id" "value"         
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$description
#> [1] "Object defining the cumulative distribution function of the predictive distribution output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$description
#> [1] "Object containing required and optional arrays defining possible values of the target variable at which values of the cumulative distribution function of the predictive distribution will be recorded."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[1]]$required
#> [1] 10 20
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[1]]$optional
#> NULL
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[2]]$required
#> [1] "EW202240" "EW202241" "EW202242" "EW202243" "EW202244" "EW202245" "EW202246"
#> [8] "EW202247"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[2]]$optional
#> NULL
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$description
#> [1] "Array of unique target values that must be present for submission to be valid. Can be null if no target values are required and all valid target values are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[1]]$type
#> [1] "number"  "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[1]]$minimum
#> [1] 0
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[2]]$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[2]]$pattern
#> [1] "^EW[0-9]{6}"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[2]]$minLength
#> [1] 8
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[2]]$maxLength
#> [1] 8
#> 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$description
#> [1] "Array of valid but not required unique target values. Can be null if all target values are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[1]]$type
#> [1] "number"  "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[1]]$minimum
#> [1] 0
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[2]]$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[2]]$pattern
#> [1] "^EW[0-9]{6}"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[2]]$minLength
#> [1] 8
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[2]]$maxLength
#> [1] 8
#> 
#> 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$description
#> [1] "Object defining the characteristics of valid values of the cumulative distribution function at a given target value."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$type$description
#> [1] "Data type of cumulative distribution function values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$type$examples
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$type$const
#> [1] "double"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid cumulative distribution function value. Must be 0."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$minimum$const
#> [1] 0
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$maximum$description
#> [1] "The maximum inclusive valid cumulative distribution function value. Must be 1."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$maximum$const
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$required
#> [1] "type"    "minimum" "maximum"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$required
#> [1] "output_type_id" "value"         
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$description
#> [1] "Object defining a probability mass function for a discrete variable output type. Includes nominal, binary and ordinal variable types."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$description
#> [1] "Object containing required and optional arrays specifying valid categories of a discrete variable."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$examples[[1]]$optional
#> [1] "low"      "moderate" "high"     "extreme" 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$description
#> [1] "Array of unique categories of a discrete variable that must be present for submission to be valid. Can be null if no categories are required and all valid categories are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$optional$description
#> [1] "Array of valid but not required unique categories of a discrete variable. Can be null if all categories are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$description
#> [1] "Object defining valid values of the probability mass function of the predictive distribution for a given category of a discrete outcome variable."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples[[1]]$type
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples[[1]]$minimum
#> [1] 0
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples[[1]]$maximum
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$type$description
#> [1] "Data type of the probability mass function values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$type$const
#> [1] "double"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid probability mass function value. Must be 0."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$minimum$const
#> [1] 0
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$maximum$description
#> [1] "The maximum inclusive valid probability mass function value. Must be 1."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$maximum$const
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$required
#> [1] "type"    "minimum" "maximum"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$required
#> [1] "output_type_id" "value"         
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$description
#> [1] "Object defining a sample output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$description
#> [1] "Object containing required and optional arrays specifying valid sample values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$examples[[1]]$required
#>  [1]  1  2  3  4  5  6  7  8  9 10
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$examples[[1]]$optional
#> [1] 11 12 13 14 15
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$required$description
#> [1] "Array of unique sample indexes that must be present for submission to be valid. Can be null if no sample indexes are required and all valid sample indexes are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$required$items$type
#> [1] "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$required$items$minimum
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$optional$description
#> [1] "Array of valid but not required unique sample indexes. Can be null if all sample indexes are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$optional$items$type
#> [1] "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$properties$optional$items$minimum
#> [1] 1
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$description
#> [1] "Object defining valid values of samples from the predictive distribution for a given sample index.  Depending on the Hub specification, samples with the same sample index (specified by the output_type_id) may be assumed to correspond to a joint distribution across multiple levels of the task id variables. See Hub documentation for details."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$description
#> [1] "Data type of sample value from the predictive distribution."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$examples[[1]]$type
#> [1] "double"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$enum
#> [1] "double"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid sample value from the predictive distribution"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$maximum$description
#> [1] "The maximum inclusive valid sample value from the predictive distribution"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$required
#> [1] "type"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$required
#> [1] "output_type_id" "value"         
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$description
#> [1] "Array of objects containing metadata about each unique target, one object for each unique target value."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$description
#> [1] "Object containg metadata about a single unique target."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id$description
#> [1] "Short description that uniquely identifies the target."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id$examples
#> [1] "inc hosp"       "peak week hosp"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id$maxLength
#> [1] 30
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name$description
#> [1] "A longer human readable target description that could be used, for example, as a visualisation axis label."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name$examples
#> [1] "Weekly incident influenza hospitalizations"       
#> [2] "Peak week for incident influenza hospitalizations"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name$maxLength
#> [1] 100
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units$description
#> [1] "Unit of observation of the target."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units$examples
#> [1] "rate per 100,000 population" "count"                      
#> [3] "date"                       
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units$maxLength
#> [1] 100
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$description
#> [1] "Should be either null, in the case where the target is not specified as a task_id and is specified solely through the target_id target_metadata property or an object with one or more properties, the names of which match task_id variable(s) named within the same model_tasks object. Each property should have one specified value. Each value, or the combination of values if multiple keys are specified, define a single target value."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[1]]$target
#> [1] "inc hosp"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[2]]$target
#> [1] "peak week hosp"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[3]]
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[3]]$target_variable
#> [1] "hosp"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[3]]$target_outcome
#> [1] "inc"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[4]]
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[4]]$target_variable
#> [1] "case"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[4]]$target_outcome
#> [1] "peak week"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[5]]
#> NULL
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$type
#> [1] "object" "null"  
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$description
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$description$description
#> [1] "a verbose description of the target that might include information such as the target_measure above, or definitions of a 'rate' or similar."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$description$type
#> [1] "string"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type$description
#> [1] "Target statistical data type"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type$examples
#> [1] "discrete" "ordinal" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type$enum
#> [1] "continuous"    "discrete"      "date"          "binary"       
#> [5] "nominal"       "ordinal"       "compositional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$is_step_ahead
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$is_step_ahead$description
#> [1] "Whether the target is part of a sequence of values"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$is_step_ahead$examples
#> [1]  TRUE FALSE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$is_step_ahead$type
#> [1] "boolean"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit$description
#> [1] " if is_step_ahead is true, then this is required and defines the unit of time steps. if is_step_ahead is false, then this should be left out and/or will be ignored if present."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit$examples
#> [1] "week"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit$enum
#> [1] "day"   "week"  "month"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$required
#> [1] "target_id"     "target_name"   "target_units"  "target_type"  
#> [5] "target_keys"   "is_step_ahead"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$additionalProperties
#> [1] FALSE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$`if`
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$`if`$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$`if`$properties$is_step_ahead
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$`if`$properties$is_step_ahead$const
#> [1] TRUE
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$then
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$then$required
#> [1] "time_unit"
#> 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$required
#> [1] "task_ids"        "output_type"     "target_metadata"
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due
#> $properties$rounds$items$properties$submissions_due$description
#> [1] "Object defining the dates by which model forecasts must be submitted to the hub."
#> 
#> $properties$rounds$items$properties$submissions_due$examples
#> $properties$rounds$items$properties$submissions_due$examples[[1]]
#> $properties$rounds$items$properties$submissions_due$examples[[1]]$start
#> [1] "2022-06-07"
#> 
#> $properties$rounds$items$properties$submissions_due$examples[[1]]$end
#> [1] "2022-07-20"
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$examples[[2]]
#> $properties$rounds$items$properties$submissions_due$examples[[2]]$relative_to
#> [1] "origin_date"
#> 
#> $properties$rounds$items$properties$submissions_due$examples[[2]]$start
#> [1] -4
#> 
#> $properties$rounds$items$properties$submissions_due$examples[[2]]$end
#> [1] 2
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$relative_to
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$relative_to$description
#> [1] "Name of task id variable in relation to which submission start and end dates are calculated."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$relative_to$type
#> [1] "string"
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$start
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$start$description
#> [1] "Difference in days between start and origin date."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$start$type
#> [1] "integer"
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$end
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$end$description
#> [1] "Difference in days between end and origin date."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$end$type
#> [1] "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$required
#> [1] "relative_to" "start"       "end"        
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$start
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$start$description
#> [1] "Submission start date."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$start$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$start$format
#> [1] "date"
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$end
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$end$description
#> [1] "Submission end date."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$end$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$end$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$required
#> [1] "start" "end"  
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$required
#> [1] "start" "end"  
#> 
#> 
#> $properties$rounds$items$properties$last_data_date
#> $properties$rounds$items$properties$last_data_date$description
#> [1] "The last date with recorded data in the data set used as input to a model."
#> 
#> $properties$rounds$items$properties$last_data_date$examples
#> [1] "2022-07-18"
#> 
#> $properties$rounds$items$properties$last_data_date$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$last_data_date$format
#> [1] "date"
#> 
#> 
#> $properties$rounds$items$properties$file_format
#> $properties$rounds$items$properties$file_format$description
#> [1] "Accepted file formats of model output files for the round. Overrides the file formats provided in admin.json."
#> 
#> $properties$rounds$items$properties$file_format$examples
#> $properties$rounds$items$properties$file_format$examples[[1]]
#> [1] "arrow"   "parquet"
#> 
#> $properties$rounds$items$properties$file_format$examples[[2]]
#> [1] "csv"
#> 
#> 
#> $properties$rounds$items$properties$file_format$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$file_format$items
#> $properties$rounds$items$properties$file_format$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$file_format$items$enum
#> [1] "csv"     "parquet" "arrow"  
#> 
#> 
#> 
#> 
#> $properties$rounds$items$required
#> [1] "round_id_from_variable" "round_id"               "model_tasks"           
#> [4] "submissions_due"       
#> 
#> $properties$rounds$items$additionalProperties
#> [1] FALSE
#> 
#> 
#> 
#> 
#> $required
#> [1] "rounds"         "schema_version"
#> 
#> $additionalProperties
#> [1] FALSE
#> 
options(hubAdmin.schema_version = "v3.0.1")
download_tasks_schema()
#> $`$schema`
#> [1] "https://json-schema.org/draft/2020-12/schema"
#> 
#> $`$id`
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
#> 
#> $title
#> [1] "Schema for Modeling Hub model task definitions"
#> 
#> $description
#> [1] "This is the schema of the tasks.json configuration file that defines the tasks within a modeling hub."
#> 
#> $type
#> [1] "object"
#> 
#> $properties
#> $properties$schema_version
#> $properties$schema_version$description
#> [1] "URL to a version of the Modeling Hub schema tasks-schema.json file (see https://github.com/hubverse-org/schemas). Used to declare the schema version a 'tasks.json' file is written for and for config file validation. The URL provided should be the URL to the raw content of the schema file on GitHub."
#> 
#> $properties$schema_version$examples
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.0/tasks-schema.json"
#> 
#> $properties$schema_version$type
#> [1] "string"
#> 
#> $properties$schema_version$format
#> [1] "uri"
#> 
#> 
#> $properties$rounds
#> $properties$rounds$description
#> [1] "Array of modeling round properties"
#> 
#> $properties$rounds$type
#> [1] "array"
#> 
#> $properties$rounds$items
#> $properties$rounds$items$type
#> [1] "object"
#> 
#> $properties$rounds$items$description
#> [1] "Individual modeling round properties"
#> 
#> $properties$rounds$items$properties
#> $properties$rounds$items$properties$round_id_from_variable
#> $properties$rounds$items$properties$round_id_from_variable$description
#> [1] "Whether the round identifier is encoded by a task id variable in the data."
#> 
#> $properties$rounds$items$properties$round_id_from_variable$type
#> [1] "boolean"
#> 
#> 
#> $properties$rounds$items$properties$round_id
#> $properties$rounds$items$properties$round_id$description
#> [1] "Round identifier. If round_id_from_variable = true, round_id should be the name of a task id variable present in all sets of modeling task specifications"
#> 
#> $properties$rounds$items$properties$round_id$examples
#> [1] "round-1"     "2022-11-05"  "origin_date"
#> 
#> $properties$rounds$items$properties$round_id$type
#> [1] "string"
#> 
#> 
#> $properties$rounds$items$properties$round_name
#> $properties$rounds$items$properties$round_name$description
#> [1] "An optional round name. This can be useful for internal referencing of rounds, for examples, when a date is used as round_id but hub maintainers and teams also refer to rounds as round-1, round-2 etc."
#> 
#> $properties$rounds$items$properties$round_name$examples
#> [1] "round-1"
#> 
#> $properties$rounds$items$properties$round_name$type
#> [1] "string"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks
#> $properties$rounds$items$properties$model_tasks$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$description
#> [1] "Array defining round-specific modeling tasks. Can contain one or more groups of modeling tasks per round where each group is defined by a distinct combination of values of task id variables."
#> 
#> $properties$rounds$items$properties$model_tasks$items
#> $properties$rounds$items$properties$model_tasks$items$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$description
#> [1] "Group of valid values of task id variables. A set of valid tasks corresponding to this group is formed by taking all combinations of these values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$description
#> [1] "An object containing arrays of required and optional unique origin dates. Origin date defines the starting point that can be used for calculating a target_date via the formula target_date = origin_date + horizon x time_units_per_horizon (e.g., with weekly data, target_date is calculated as origin_date + horizon x 7 days)"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$examples[[1]]$optional
#> [1] "2022-11-05" "2022-11-12" "2022-11-19"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$description
#> [1] "Array of origin date unique identifiers that must be present for submission to be valid. Can be null if no origin dates are required and all valid origin dates are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$required$items$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$description
#> [1] "Array of valid but not required unique origin date identifiers. Can be null if all origin dates are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$properties$optional$items$format
#> [1] "date"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$origin_date$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$description
#> [1] "An object containing arrays of required and optional unique forecast dates. Forecast date usually defines the date that a model is run to produce a forecast."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$examples[[1]]$optional
#> [1] "2022-11-05" "2022-11-12" "2022-11-19"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$description
#> [1] "Array of forecast date unique identifiers that must be present for submission to be valid. Can be null if no forecast dates are required and all valid forecast dates are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$required$items$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$description
#> [1] "Array of valid but not required unique forecast date identifiers. Can be null if all forecast dates are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$properties$optional$items$format
#> [1] "date"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$forecast_date$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$description
#> [1] "An object containing arrays of required and optional unique identifiers of each valid scenario."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[1]]$optional
#> [1] 1 2 3 4
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[2]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$examples[[2]]$optional
#> [1] "A-2021-03-28" "B-2021-03-28" "A-2021-04-05" "B-2021-04-05"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$description
#> [1] "Array of identifiers of scenarios that must be present in a valid submission. Can be null if no scenario ids are required and all valid ids are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$required$items$type
#> [1] "integer" "string" 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$description
#> [1] "Array of identifiers of valid but not required scenarios. Can be null if all scenarios are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$type
#> [1] "null"  "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$properties$optional$items$type
#> [1] "integer" "string" 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$scenario_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$description
#> [1] "An object containing arrays of required and optional unique identifiers for each valid location, e.g. country codes, FIPS state or county level code etc."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$examples[[1]]$required
#> [1] "US"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$examples[[1]]$optional
#>  [1] "01" "02" "04" "05" "06" "08" "09" "10" "11" "12" "13" "15" "16" "17" "18"
#> [16] "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30" "31" "32" "33"
#> [31] "34" "35" "36" "37" "38" "39" "40" "41" "42" "44" "45" "46" "47" "48" "49"
#> [46] "50" "51" "53" "54" "55" "56"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$description
#> [1] "Array of location unique identifiers that must be present for submission to be valid. Can be null if no locations are required and all valid locations are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$description
#> [1] "Array of valid but not required unique location identifiers. Can be null if all locations are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$location$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$description
#> [1] "An object containing arrays of required and optional unique identifiers for each valid target. Usually represents a single task ID target key variable."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[1]]$optional
#> [1] "inc hosp"  "inc case"  "inc death"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[2]]$required
#> [1] "peak week inc hosp"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$examples[[2]]$optional
#> NULL
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$description
#> [1] "Array of target unique identifiers that must be present for submission to be valid. Can be null if no targets are required and all valid targets are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$description
#> [1] "Array of valid but not required unique target identifiers. Can be null if all targets are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$description
#> [1] "An object containing arrays of required and optional unique identifiers for each valid target variable. Usually forms part of a pair of task ID target key variables (along with target_outcome) which combine to define individual targets."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples[[1]]$optional
#> [1] "hosp"  "death" "case" 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples[[2]]$required
#> [1] "hosp"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$examples[[2]]$optional
#> [1] "case"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$required$description
#> [1] "Array of target variable unique identifiers that must be present for submission to be valid. Can be null if no target variables are required and all valid target variables are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$optional$description
#> [1] "Array of valid but not required unique target variable identifiers. Can be null if all target variables are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_variable$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$description
#> [1] "An object containing arrays of required and optional unique identifiers for each valid target outcome. Usually forms part of a pair of task ID target key variables (along with target_variable) which combine to define individual targets."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples[[1]]$required
#> [1] "inc"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples[[1]]$optional
#> NULL
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples[[2]]$required
#> [1] "inc"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$examples[[2]]$optional
#> [1] "cum"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$required$description
#> [1] "Array of target outcome unique identifiers that must be present for submission to be valid. Can be null if no target outcomes are required and all valid target outcomes are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$optional$description
#> [1] "Array of valid but not required unique target outcome identifiers. Can be null if all target outcomes are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_outcome$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$description
#> [1] "An object containing arrays of required and optional unique target dates. For short-term forecasts, the target_date specifies the date of occurrence of the outcome of interest. For instance, if models are requested to forecast the number of hospitalizations that will occur on 2022-07-15, the target_date is 2022-07-15"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$examples[[1]]$optional
#> [1] "2022-11-12" "2022-11-19" "2022-11-26"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$description
#> [1] "Array of target date unique identifiers that must be present for submission to be valid. Can be null if no target dates are required and all valid target dates are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$required$items$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$description
#> [1] "Array of valid but not required unique target date identifiers. Can be null if all target dates are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$properties$optional$items$format
#> [1] "date"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_date$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$description
#> [1] "An object containing arrays of required and optional unique target end dates. For short-term forecasts, the target_end_date specifies the date of occurrence of the outcome of interest. For instance, if models are requested to forecast the number of hospitalizations that will occur on 2022-07-15, the target_end_date is 2022-07-15"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$examples[[1]]$optional
#> [1] "2022-11-12" "2022-11-19" "2022-11-26"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$description
#> [1] "Array of target end date unique identifiers that must be present for submission to be valid. Can be null if no target end dates are required and all valid target end dates are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$required$items$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$description
#> [1] "Array of valid but not required unique target end date identifiers. Can be null if all target end dates are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$properties$optional$items$format
#> [1] "date"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$target_end_date$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$description
#> [1] "An object containing arrays of required and optional unique horizons. Horizons define the difference between the target_date and the origin_date in time units specified by the hub (e.g., may be days, weeks, or months)"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$examples[[1]]$optional
#> [1] 1 2 3 4
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$description
#> [1] "Array of horizon unique identifiers that must be present for submission to be valid. Can be null if no horizons are required and all valid horizons are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$required$items$type
#> [1] "integer" "string" 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$description
#> [1] "Array of valid but not required unique horizon identifiers. Can be null if all horizons are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$type
#> [1] "null"  "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$properties$optional$items$type
#> [1] "integer" "string" 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$horizon$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$description
#> [1] "An object containing arrays of required and optional unique identifiers for age groups"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$examples[[1]]$required
#> [1] "0-5"   "6-18"  "19-24" "25-64" "65+"  
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$examples[[1]]$optional
#> NULL
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$description
#> [1] "Array of age group unique identifiers that must be present for submission to be valid. Can be null if no age groups are required and all valid age groups are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$description
#> [1] "Array of valid but not required unique age group identifiers. Can be null if all age group are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$properties$age_group$required
#> [1] "required" "optional"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$description
#> [1] "An object containing arrays of required and optional unique values for a custom Task ID"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$required$description
#> [1] "Array of custom Task ID unique values that must be present for submission to be valid. Can be null if no values are required and all valid values are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$required$uniqueItems
#> [1] TRUE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$optional$description
#> [1] "Array of valid but not required unique custom Task ID values. Can be null if all values are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$task_ids$additionalProperties$required
#> [1] "required" "optional"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$description
#> [1] "Object defining valid model output types for a given modeling task. The name of each property corresponds to valid values in column 'output_type' while the 'output_type_id' property of each output type defines the valid values of the 'output_type_id' column and the 'value' property defines the valid values of the 'value' column for a given output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$description
#> [1] "Object defining the mean of the predictive distribution output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$description
#> [1] "output_type_id is not meaningful for a mean output_type. The property is primarily used to determine whether mean is a required or optional output type through properties required and optional. If mean is a required output type, the required property must be an array containing the single string element 'NA' and the optional property must be set to null. If mean is an optional output type, the optional property must be an array containing the single string element 'NA' and the required property must be set to null"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[1]]$required
#> [1] NA
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[1]]$optional
#> NULL
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[2]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$examples[[2]]$optional
#> [1] NA
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$required$description
#> [1] "When mean is required, property set to single element 'NA' array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$required$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$required$items$const
#> [1] "NA"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$required$items$maxItems
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$optional$description
#> [1] "When mean is required, property set to null"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[1]]$properties$optional$type
#> [1] "null"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$required$description
#> [1] "When mean is optional, property set to null"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$required$type
#> [1] "null"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$optional$description
#> [1] "When mean is optional, property set to single element 'NA' array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$optional$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$optional$items$const
#> [1] "NA"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$oneOf[[2]]$properties$optional$items$maxItems
#> [1] 1
#> 
#> 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$output_type_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$description
#> [1] "Object defining the characteristics of valid mean values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$examples[[1]]$type
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$examples[[1]]$minimum
#> [1] 0
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$type$description
#> [1] "Data type of mean values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$type$enum
#> [1] "double"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid mean value"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$minimum$type
#> [1] "number"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$maximum$description
#> [1] "the maximum inclusive valid mean value"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$properties$maximum$type
#> [1] "number"  "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$properties$value$required
#> [1] "type"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$mean$required
#> [1] "output_type_id" "value"         
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$description
#> [1] "Object defining the median of the predictive distribution output type"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$description
#> [1] "output_type_id is not meaningful for a median output_type. The property is primarily used to determine whether median is a required or optional output type through properties required and optional. If median is a required output type, the required property must be an array containing the single string element 'NA' and the optional property must be set to null. If median is an optional output type, the optional property must be an array containing the single string element 'NA' and the required property must be set to null"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[1]]$required
#> [1] NA
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[1]]$optional
#> NULL
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[2]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$examples[[2]]$optional
#> [1] NA
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$required$description
#> [1] "When median is required, property set to single element 'NA' array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$required$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$required$items$const
#> [1] "NA"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$required$items$maxItems
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$optional$description
#> [1] "When median is required, property set to null"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[1]]$properties$optional$type
#> [1] "null"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$required$description
#> [1] "When median is optional, property set to null"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$required$type
#> [1] "null"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$optional$description
#> [1] "When median is optional, property set to single element 'NA' array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$optional$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$optional$items$const
#> [1] "NA"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$oneOf[[2]]$properties$optional$items$maxItems
#> [1] 1
#> 
#> 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$output_type_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$description
#> [1] "Object defining the characteristics of valid median values"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$examples[[1]]$type
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$examples[[1]]$minimum
#> [1] 0
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$type$description
#> [1] "Data type of median values"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$type$enum
#> [1] "double"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid median value"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$minimum$type
#> [1] "number"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$maximum$description
#> [1] "the maximum inclusive valid median value"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$properties$maximum$type
#> [1] "number"  "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$properties$value$required
#> [1] "type"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$median$required
#> [1] "output_type_id" "value"         
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$description
#> [1] "Object defining the quantiles of the predictive distribution output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$description
#> [1] "Object containing required and optional arrays defining the probability levels at which quantiles of the predictive distribution will be recorded."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$examples[[1]]$required
#> [1] 0.25 0.50 0.75
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$examples[[1]]$optional
#> [1] 0.1 0.2 0.3 0.4 0.6 0.7 0.8 0.9
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$description
#> [1] "Array of unique probability levels between 0 and 1 that must be present for submission to be valid. Can be null if no probability levels are required and all valid probability levels are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$items$type
#> [1] "number"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$items$minimum
#> [1] 0
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$required$items$maximum
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$description
#> [1] "Array of valid but not required unique probability levels. Can be null if all probability levels are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$items$type
#> [1] "number"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$items$minimum
#> [1] 0
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$properties$optional$items$maximum
#> [1] 1
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$output_type_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$description
#> [1] "Object defining the characteristics of valid quantiles of the predictive distribution at a given probability level."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type$description
#> [1] "Data type of quantile values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type$examples
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$type$enum
#> [1] "double"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid quantile value (optional)."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$minimum$examples
#> [1] 0
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$minimum$type
#> [1] "number"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$maximum$description
#> [1] "The maximum inclusive valid quantile value (optional)."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$properties$maximum$type
#> [1] "number"  "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$properties$value$required
#> [1] "type"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$quantile$required
#> [1] "output_type_id" "value"         
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$description
#> [1] "Object defining the cumulative distribution function of the predictive distribution output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$description
#> [1] "Object containing required and optional arrays defining possible values of the target variable at which values of the cumulative distribution function of the predictive distribution will be recorded. These should be listed in order from low to high."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[1]]$required
#> [1] 10 20
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[1]]$optional
#> NULL
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[2]]$required
#> [1] "EW202240" "EW202241" "EW202242" "EW202243" "EW202244" "EW202245" "EW202246"
#> [8] "EW202247"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$examples[[2]]$optional
#> NULL
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$description
#> [1] "Array of unique target values that must be present for submission to be valid. Can be null if no target values are required and all valid target values are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[1]]$type
#> [1] "number"  "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[1]]$minimum
#> [1] 0
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$required$items$oneOf[[2]]$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$description
#> [1] "Array of valid but not required unique target values. Can be null if all target values are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[1]]$type
#> [1] "number"  "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[1]]$minimum
#> [1] 0
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$properties$optional$items$oneOf[[2]]$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$output_type_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$description
#> [1] "Object defining the characteristics of valid values of the cumulative distribution function at a given target value."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$type$description
#> [1] "Data type of cumulative distribution function values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$type$examples
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$type$const
#> [1] "double"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid cumulative distribution function value. Must be 0."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$minimum$const
#> [1] 0
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$maximum$description
#> [1] "The maximum inclusive valid cumulative distribution function value. Must be 1."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$properties$maximum$const
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$properties$value$required
#> [1] "type"    "minimum" "maximum"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$cdf$required
#> [1] "output_type_id" "value"         
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$description
#> [1] "Object defining a probability mass function for a discrete variable output type. Includes nominal, binary and ordinal variable types."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$description
#> [1] "Object containing required and optional arrays specifying valid categories of a discrete variable. Note that for ordinal variables, the category levels should be listed in order from low to high."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$examples[[1]]$required
#> NULL
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$examples[[1]]$optional
#> [1] "low"      "moderate" "high"     "extreme" 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$description
#> [1] "Array of unique categories of a discrete variable that must be present for submission to be valid. Can be null if no categories are required and all valid categories are specified in the optional property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$required$items$type
#> [1] "string"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$optional
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$optional$description
#> [1] "Array of valid but not required unique categories of a discrete variable. Can be null if all categories are required and are specified in the required property."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$optional$type
#> [1] "array" "null" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$optional$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$optional$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$properties$optional$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$output_type_id$required
#> [1] "required" "optional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$description
#> [1] "Object defining valid values of the probability mass function of the predictive distribution for a given category of a discrete outcome variable."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples[[1]]$type
#> [1] "double"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples[[1]]$minimum
#> [1] 0
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$examples[[1]]$maximum
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$type$description
#> [1] "Data type of the probability mass function values."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$type$const
#> [1] "double"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid probability mass function value. Must be 0."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$minimum$const
#> [1] 0
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$maximum$description
#> [1] "The maximum inclusive valid probability mass function value. Must be 1."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$properties$maximum$const
#> [1] 1
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$properties$value$required
#> [1] "type"    "minimum" "maximum"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$pmf$required
#> [1] "output_type_id" "value"         
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$description
#> [1] "Object defining a sample output type."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$description
#> [1] "Object containing parameters specifying how samples were drawn."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[1]]$output_type_id_params
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[1]]$output_type_id_params$is_required
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[1]]$output_type_id_params$type
#> [1] "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[1]]$output_type_id_params$min_samples_per_task
#> [1] 100
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[1]]$output_type_id_params$max_samples_per_task
#> [1] 100
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params$is_required
#> [1] FALSE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params$type
#> [1] "character"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params$max_length
#> [1] 6
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params$min_samples_per_task
#> [1] 100
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params$max_samples_per_task
#> [1] 500
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$examples[[2]]$output_type_id_params$compound_taskid_set
#> [1] "origin_date" "horizon"     "location"    "variant"    
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$is_required
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$is_required$description
#> [1] "Boolean. Whether inclusion of samples is required for the submission to be valid"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$is_required$type
#> [1] "boolean"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$type$description
#> [1] "Data type of sample indices."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$type$enum
#> [1] "character" "integer"  
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_length
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_length$description
#> [1] "Required only if 'type' is 'character'. Positive integer representing the maximum number of characters in a sample index. Ignored if 'type' is 'integer'."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_length$type
#> [1] "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_length$minimum
#> [1] 1
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$min_samples_per_task
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$min_samples_per_task$description
#> [1] "The minimum number of samples per individual task."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$min_samples_per_task$type
#> [1] "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$min_samples_per_task$minimum
#> [1] 1
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_samples_per_task
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_samples_per_task$description
#> [1] "The maximum number of samples per individual task."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_samples_per_task$type
#> [1] "integer"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$max_samples_per_task$minimum
#> [1] 1
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$compound_taskid_set
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$compound_taskid_set$description
#> [1] "Optional. Specifies whether validation should factor in the presence of a compound modeling task. Each item of the array must be a task id variable name. If unspecified, defaults to all task ID variables."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$compound_taskid_set$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$compound_taskid_set$uniqueItems
#> [1] TRUE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$compound_taskid_set$items
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$properties$compound_taskid_set$items$type
#> [1] "string"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$required
#> [1] "is_required"          "type"                 "min_samples_per_task"
#> [4] "max_samples_per_task"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$`if`
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$`if`$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$`if`$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$`if`$properties$type$const
#> [1] "character"
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$then
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$output_type_id_params$then$required
#> [1] "max_length"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$description
#> [1] "Object defining valid values of samples from the predictive distribution for a given sample index.  Depending on the Hub specification, samples with the same sample index (specified by the output_type_id) may be assumed to correspond to a joint distribution across multiple levels of the task id variables. See Hub documentation for details."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$description
#> [1] "Data type of sample value from the predictive distribution."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$examples[[1]]$type
#> [1] "double"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$type$enum
#> [1] "double"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$minimum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$minimum$description
#> [1] "The minimum inclusive valid sample value from the predictive distribution."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$minimum$type
#> [1] "number"  "integer"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$maximum
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$maximum$description
#> [1] "The maximum inclusive valid sample value from the predictive distribution."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$properties$maximum$type
#> [1] "number"  "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$properties$value$required
#> [1] "type"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$properties$sample$required
#> [1] "output_type_id_params" "value"                
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$output_type$additionalProperties
#> [1] FALSE
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$description
#> [1] "Array of objects containing metadata about each unique target, one object for each unique target value."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$description
#> [1] "Object containg metadata about a single unique target."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id$description
#> [1] "Short description that uniquely identifies the target."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id$examples
#> [1] "inc hosp"       "peak week hosp"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_id$maxLength
#> [1] 30
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name$description
#> [1] "A longer human readable target description that could be used, for example, as a visualisation axis label."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name$examples
#> [1] "Weekly incident influenza hospitalizations"       
#> [2] "Peak week for incident influenza hospitalizations"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_name$maxLength
#> [1] 100
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units$description
#> [1] "Unit of observation of the target."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units$examples
#> [1] "rate per 100,000 population" "count"                      
#> [3] "date"                       
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_units$maxLength
#> [1] 100
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$description
#> [1] "Should be either null, in the case where the target is not specified as a task_id and is specified solely through the target_id target_metadata property or an object with one or more properties, the names of which match task_id variable(s) named within the same model_tasks object. Each property should have one specified value. Each value, or the combination of values if multiple keys are specified, define a single target value."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[1]]
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[1]]$target
#> [1] "inc hosp"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[2]]
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[2]]$target
#> [1] "peak week hosp"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[3]]
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[3]]$target_variable
#> [1] "hosp"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[3]]$target_outcome
#> [1] "inc"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[4]]
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[4]]$target_variable
#> [1] "case"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[4]]$target_outcome
#> [1] "peak week"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$examples[[5]]
#> NULL
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_keys$type
#> [1] "object" "null"  
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$description
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$description$description
#> [1] "a verbose description of the target that might include information such as the target_measure above, or definitions of a 'rate' or similar."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$description$type
#> [1] "string"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type$description
#> [1] "Target statistical data type"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type$examples
#> [1] "discrete" "ordinal" 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$target_type$enum
#> [1] "continuous"    "discrete"      "date"          "binary"       
#> [5] "nominal"       "ordinal"       "compositional"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$is_step_ahead
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$is_step_ahead$description
#> [1] "Whether the target is part of a sequence of values"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$is_step_ahead$examples
#> [1]  TRUE FALSE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$is_step_ahead$type
#> [1] "boolean"
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit$description
#> [1] " if is_step_ahead is true, then this is required and defines the unit of time steps. if is_step_ahead is false, then this should be left out and/or will be ignored if present."
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit$examples
#> [1] "week"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$properties$time_unit$enum
#> [1] "day"   "week"  "month"
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$required
#> [1] "target_id"     "target_name"   "target_units"  "target_type"  
#> [5] "target_keys"   "is_step_ahead"
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$additionalProperties
#> [1] FALSE
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$`if`
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$`if`$properties
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$`if`$properties$is_step_ahead
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$`if`$properties$is_step_ahead$const
#> [1] TRUE
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$then
#> $properties$rounds$items$properties$model_tasks$items$properties$target_metadata$items$then$required
#> [1] "time_unit"
#> 
#> 
#> 
#> 
#> 
#> $properties$rounds$items$properties$model_tasks$items$required
#> [1] "task_ids"        "output_type"     "target_metadata"
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due
#> $properties$rounds$items$properties$submissions_due$description
#> [1] "Object defining the dates by which model forecasts must be submitted to the hub."
#> 
#> $properties$rounds$items$properties$submissions_due$examples
#> $properties$rounds$items$properties$submissions_due$examples[[1]]
#> $properties$rounds$items$properties$submissions_due$examples[[1]]$start
#> [1] "2022-06-07"
#> 
#> $properties$rounds$items$properties$submissions_due$examples[[1]]$end
#> [1] "2022-07-20"
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$examples[[2]]
#> $properties$rounds$items$properties$submissions_due$examples[[2]]$relative_to
#> [1] "origin_date"
#> 
#> $properties$rounds$items$properties$submissions_due$examples[[2]]$start
#> [1] -4
#> 
#> $properties$rounds$items$properties$submissions_due$examples[[2]]$end
#> [1] 2
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$type
#> [1] "object"
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$relative_to
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$relative_to$description
#> [1] "Name of task id variable in relation to which submission start and end dates are calculated."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$relative_to$type
#> [1] "string"
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$start
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$start$description
#> [1] "Difference in days between start and origin date."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$start$type
#> [1] "integer"
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$end
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$end$description
#> [1] "Difference in days between end and origin date."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$properties$end$type
#> [1] "integer"
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[1]]$required
#> [1] "relative_to" "start"       "end"        
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$start
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$start$description
#> [1] "Submission start date."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$start$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$start$format
#> [1] "date"
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$end
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$end$description
#> [1] "Submission end date."
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$end$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$properties$end$format
#> [1] "date"
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$oneOf[[2]]$required
#> [1] "start" "end"  
#> 
#> 
#> 
#> $properties$rounds$items$properties$submissions_due$required
#> [1] "start" "end"  
#> 
#> 
#> $properties$rounds$items$properties$last_data_date
#> $properties$rounds$items$properties$last_data_date$description
#> [1] "The last date with recorded data in the data set used as input to a model."
#> 
#> $properties$rounds$items$properties$last_data_date$examples
#> [1] "2022-07-18"
#> 
#> $properties$rounds$items$properties$last_data_date$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$last_data_date$format
#> [1] "date"
#> 
#> 
#> $properties$rounds$items$properties$file_format
#> $properties$rounds$items$properties$file_format$description
#> [1] "Accepted file formats of model output files for the round. Overrides the file formats provided in admin.json."
#> 
#> $properties$rounds$items$properties$file_format$examples
#> $properties$rounds$items$properties$file_format$examples[[1]]
#> [1] "arrow"   "parquet"
#> 
#> $properties$rounds$items$properties$file_format$examples[[2]]
#> [1] "csv"
#> 
#> 
#> $properties$rounds$items$properties$file_format$type
#> [1] "array"
#> 
#> $properties$rounds$items$properties$file_format$items
#> $properties$rounds$items$properties$file_format$items$type
#> [1] "string"
#> 
#> $properties$rounds$items$properties$file_format$items$enum
#> [1] "csv"     "parquet" "arrow"  
#> 
#> 
#> 
#> 
#> $properties$rounds$items$required
#> [1] "round_id_from_variable" "round_id"               "model_tasks"           
#> [4] "submissions_due"       
#> 
#> $properties$rounds$items$additionalProperties
#> [1] TRUE
#> 
#> 
#> 
#> $properties$output_type_id_datatype
#> $properties$output_type_id_datatype$description
#> [1] "The hub level data type of the output_type_id column. This data type must be shared across all files in the hub and be able to represent all output type ID values across all hub output types and rounds. If not provided or set to 'auto', hub defaults to autodetecting the simplest hub level data type."
#> 
#> $properties$output_type_id_datatype$default
#> [1] "auto"
#> 
#> $properties$output_type_id_datatype$examples
#> [1] "character"
#> 
#> $properties$output_type_id_datatype$type
#> [1] "string"
#> 
#> $properties$output_type_id_datatype$enum
#> [1] "auto"      "character" "double"    "integer"   "logical"   "Date"     
#> 
#> 
#> 
#> $required
#> [1] "rounds"         "schema_version"
#> 
#> $additionalProperties
#> [1] FALSE
#> 
options(hubAdmin.schema_version = "latest")
```
