# Write config class object to a JSON file.

Write a **tasks** `<config>` class object to a `tasks.json` JSON file.

## Usage

``` r
write_config(
  config,
  hub_path = ".",
  config_path = NULL,
  autobox = TRUE,
  box_extra_paths = NULL,
  overwrite = FALSE,
  silent = FALSE
)
```

## Arguments

- config:

  Object of class `<config>` to write to a JSON file.

- hub_path:

  Path to the hub directory. Defaults to the current working directory.
  Ignored if `config_path` is specified.

- config_path:

  Path to write the config object to. If `NULL` defaults to
  `hub-config/tasks.json` within `hub_path`. If specified, overrides
  `hub_path`.

- autobox:

  Logical. Whether to automatically box vectors of length `1L` that
  should be arrays in the JSON output according to the hubverse schema.
  See
  [`schema_autobox()`](https://hubverse-org.github.io/hubAdmin/dev/reference/schema_autobox.md)
  for more details.

- box_extra_paths:

  a list of character vectors of paths to elements in the `<config>`
  that can be arrays of vectors but are not covered by the schema.
  Elements in a path where arrays of objects are expected should be
  encoded as `"items"`. See output of
  [`get_array_schema_paths()`](https://hubverse-org.github.io/hubAdmin/dev/reference/get_array_schema_paths.md)
  for more details, especially the examples.

- overwrite:

  Logical. Whether to overwrite the file if it already exists.

- silent:

  Logical. Whether to suppress informational messages.

## Value

TRUE invisibly.

## Examples

``` r
# Create rounds object
rounds <- create_rounds(
  create_round(
    round_id_from_variable = TRUE,
    round_id = "origin_date",
    model_tasks = create_model_tasks(
      create_model_task(
        task_ids = create_task_ids(
          create_task_id("origin_date",
            required = NULL,
            optional = c(
              "2023-01-02",
              "2023-01-09",
              "2023-01-16"
            )
          ),
          create_task_id("location",
            required = "US",
            optional = c("01", "02", "04", "05", "06")
          ),
          create_task_id("horizon",
            required = 1L,
            optional = 2:4
          )
        ),
        output_type = create_output_type(
          create_output_type_mean(
            is_required = TRUE,
            value_type = "double",
            value_minimum = 0L
          )
        ),
        target_metadata = create_target_metadata(
          create_target_metadata_item(
            target_id = "inc hosp",
            target_name = "Weekly incident influenza hospitalizations",
            target_units = "rate per 100,000 population",
            target_keys = NULL,
            target_type = "discrete",
            is_step_ahead = TRUE,
            time_unit = "week"
          )
        )
      )
    ),
    submissions_due = list(
      relative_to = "origin_date",
      start = -4L,
      end = 2L
    )
  )
)

# Create config object
config <- create_config(rounds)

# Create temporary hub and write config
withr::with_tempdir({
  dir.create("hub-config")

  # Write config
  write_config(config, hub_path = ".")

  # Read and print tasks.json
  cat(readLines(file.path("hub-config", "tasks.json")), sep = "\n")

  # Validate config
  validate_config(hub_path = ".")

  # Add a custom additional property to the first round of the config
  rounds[[1]][[1]]$extra_array_property <- "length_1L_property"
  config <- create_config(rounds)

  write_config(
    config = config, hub_path = ".", overwrite = TRUE,
    box_extra_paths = list(c("rounds", "items", "extra_array_property"))
  )

  # Read and print tasks.json again
  cat(readLines(file.path("hub-config", "tasks.json")), sep = "\n")
})
#> ✔ `config` written out successfully.
#> {
#>   "schema_version": "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json",
#>   "rounds": [
#>     {
#>       "round_id_from_variable": true,
#>       "round_id": "origin_date",
#>       "model_tasks": [
#>         {
#>           "task_ids": {
#>             "origin_date": {
#>               "required": null,
#>               "optional": ["2023-01-02", "2023-01-09", "2023-01-16"]
#>             },
#>             "location": {
#>               "required": [
#>                 "US"
#>               ],
#>               "optional": ["01", "02", "04", "05", "06"]
#>             },
#>             "horizon": {
#>               "required": [
#>                 1
#>               ],
#>               "optional": [2, 3, 4]
#>             }
#>           },
#>           "output_type": {
#>             "mean": {
#>               "output_type_id": {
#>                 "required": null
#>               },
#>               "is_required": true,
#>               "value": {
#>                 "type": "double",
#>                 "minimum": 0
#>               }
#>             }
#>           },
#>           "target_metadata": [
#>             {
#>               "target_id": "inc hosp",
#>               "target_name": "Weekly incident influenza hospitalizations",
#>               "target_units": "rate per 100,000 population",
#>               "target_keys": null,
#>               "target_type": "discrete",
#>               "is_step_ahead": true,
#>               "time_unit": "week"
#>             }
#>           ]
#>         }
#>       ],
#>       "submissions_due": {
#>         "relative_to": "origin_date",
#>         "start": -4,
#>         "end": 2
#>       }
#>     }
#>   ]
#> }
#> ✔ `config` written out successfully.
#> {
#>   "schema_version": "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json",
#>   "rounds": [
#>     {
#>       "round_id_from_variable": true,
#>       "round_id": "origin_date",
#>       "model_tasks": [
#>         {
#>           "task_ids": {
#>             "origin_date": {
#>               "required": null,
#>               "optional": ["2023-01-02", "2023-01-09", "2023-01-16"]
#>             },
#>             "location": {
#>               "required": [
#>                 "US"
#>               ],
#>               "optional": ["01", "02", "04", "05", "06"]
#>             },
#>             "horizon": {
#>               "required": [
#>                 1
#>               ],
#>               "optional": [2, 3, 4]
#>             }
#>           },
#>           "output_type": {
#>             "mean": {
#>               "output_type_id": {
#>                 "required": null
#>               },
#>               "is_required": true,
#>               "value": {
#>                 "type": "double",
#>                 "minimum": 0
#>               }
#>             }
#>           },
#>           "target_metadata": [
#>             {
#>               "target_id": "inc hosp",
#>               "target_name": "Weekly incident influenza hospitalizations",
#>               "target_units": "rate per 100,000 population",
#>               "target_keys": null,
#>               "target_type": "discrete",
#>               "is_step_ahead": true,
#>               "time_unit": "week"
#>             }
#>           ]
#>         }
#>       ],
#>       "submissions_due": {
#>         "relative_to": "origin_date",
#>         "start": -4,
#>         "end": 2
#>       },
#>       "extra_array_property": [
#>         "length_1L_property"
#>       ]
#>     }
#>   ]
#> }
```
