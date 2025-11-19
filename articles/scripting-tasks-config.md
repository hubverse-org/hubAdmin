# Scripting task configuration files

## Introduction

The `tasks.json` configuration file is a formal representation of a
collaborative forecasting challenge. This configuration file sets a
clear standard for model outputs in a hub, which enables validations of
model output submissions to ensure that they are correctly formatted.
Configuration settings in the tasks configuration file also contain
structured information about modeling tasks that can be used for
downstream applications like evaluations and visualizations of model
outputs.

JSON files are easy for a computer to read, but not so easy for a human
to read and write. The hard part of creating a `tasks.json` file should
be what model parameters to use, not constantly looking at JSON syntax
or hunting down a missing comma. To make this process easier, **we
provide the `create_*()` family of functions for creating `tasks.json`
files programmatically**. These can be useful for creating your initial
`task.json` file, amending an existing file’s configurations or even
appending new rounds programmatically. By making use of this
functionality, hubs can even automate the process of updating their
files through Github Actions. For example, the [variant nowcast
hub](https://github.com/reichlab/variant-nowcast-hub/tree/main) uses a
[GitHub Action
workflow](https://github.com/reichlab/variant-nowcast-hub/blob/29a9265d0b30f385fc47195d3d7f65ecda7a41d2/.github/workflows/create-modeling-round.yaml#L47)
that [runs a
script](https://github.com/reichlab/variant-nowcast-hub/blob/main/src/make_round_config.R)
to append a new round with updated variants to model on a weekly
schedule!

In this vignette, we will use the config creation functions in
`hubAdmin` to create a `tasks.json` file that represents two rounds of a
modeling effort to predict influenza hospitalizations and optionally
deaths 1 to 4 weeks ahead with mean, median, and quantile predictions in
the US, and optionally 5 states.

Before getting to the scripting, it’s important to get a general look at
what a `tasks.json` file looks like structurally.

## Structure of a `tasks.json` configuration file

The structure of a `tasks.json` configuration file roughly looks like
the diagram below:

    tasks.json
    ├─schema_version: "https://.../v5.0.0/tasks-schema.json"
    ├─rounds:
    │ ├─round_id_from_variable: true
    │ ├─round_id: origin_date
    │ ├─model_tasks:
    │ │ ├─task_ids:
    │ │ │ └─[...]
    │ │ ├─output_type:
    │ │ │ └─[...]
    │ │ └─target_metadata:
    │ │   └─[...]
    │ └─submissions_due:
    │   └─[...]
    ├─output_type_id_datatype: "auto"
    └─derived_task_ids:
      └─[...]

The first property in a `tasks.json` file is the `schema_version`, which
provides a URL to the [hubverse
schema](https://github.com/hubverse-org/schemas) version the config file
is built against. The schema is used to validate the structure and
contents of the config file. The next property defined is the list of
**rounds** which sets the identifier (`round_id_from_variable`,
`round_id`), expected contents of model submissions (`model_tasks`), and
schedule (`submissions_due`) for each round.

There are two ways to define the number of rounds in a hub: 1) One round
object that uses a date task ID variable (most common) or 2) Several
round objects with unique round IDs (least common). In our example, we
will be using the first method by using a variable called `origin_date`
to define our rounds on a weekly basis. To make this work, we set
`round_id_from_variable: true` so that the schema knows that `round_id`
is actually a reference to the `origin_date` variable in `task_ids` so
it can validate that the round IDs are unique.

These rounds contain one or more [**modeling
tasks**](https://docs.hubverse.io/en/latest/user-guide/tasks.html) that
define the expected content of a model submission against one or more
modeling targets. Each modeling task includes three properties:

- `task_ids`: a collection of variables that can be used for modeling
  efforts. Examples of task ids include `location` and `origin_date`.
  **Each unique combination of task ID values represents a single
  modeling task**.
- `output_type`: the expected model output representation
- `target_metadata`: characteristics for each target (an example of a
  modeling target is “Daily incident Flu Hospitalizations”)

## Creation of a `tasks.json` file

To create the `tasks.json` file, we will start from the inside out. This
means that we will create the `target_metadata`, `task_ids`,
`output_type`s first. We will then use those to create two `model_task`
objects and then bundle them into two `round` objects, which will be
inserted into a `config` object.

Before we start, the first thing we need to do is to set the correct
version of [the hubverse
schemas](https://github.com/hubverse-org/schemas). By default, the
`create_*()` family of functions use the latest schema release. To make
sure we can always reproduce the task or append new tasks at a later
date, even if a new schema version is released in the meantime, it’s a
good idea to explicitly set the schema version. We can do this by
setting the `hubAdmin.schema_version` option. In this example, we will
use the `v5.0.0` schema:

``` r
library(hubAdmin)
options(hubAdmin.schema_version = "v5.0.0")
```

### Creating the `target_metadata` objects

The `target_metadata` provides both human-readable (`target_name` and
`target_units`) and machine-readable (e.g. `target_type` and
`is_step_ahead`) information about the targets.

``` r
target_metadata_hosp <- create_target_metadata_item(
  target_id = "inc hosp",
  target_name = "Weekly incident influenza hospitalizations",
  target_units = "rate per 100,000 population",
  target_keys = list(target = "inc hosp"),
  target_type = "discrete",
  is_step_ahead = TRUE,
  time_unit = "week"
)

target_metadata_death <- create_target_metadata_item(
  target_id = "inc death",
  target_name = "Weekly incident influenza deaths",
  target_units = "rate per 100,000 population",
  target_keys = list(target = "inc death"),
  target_type = "discrete",
  is_step_ahead = TRUE,
  time_unit = "week"
)

target_metadata <- create_target_metadata(target_metadata_hosp, target_metadata_death)
```

If you inspect the `target_metadata_hosp` object, you will see that it
appears as a class `target_metadata_item` with additional attributes
about the schema that created it:

``` r
str(target_metadata_hosp)
#> List of 7
#>  $ target_id    : chr "inc hosp"
#>  $ target_name  : chr "Weekly incident influenza hospitalizations"
#>  $ target_units : chr "rate per 100,000 population"
#>  $ target_keys  :List of 1
#>   ..$ target: chr "inc hosp"
#>  $ target_type  : chr "discrete"
#>  $ is_step_ahead: logi TRUE
#>  $ time_unit    : chr "week"
#>  - attr(*, "class")= chr [1:2] "target_metadata_item" "list"
#>  - attr(*, "schema_id")= chr "https://raw.githubusercontent.com/hubverse-org/schemas/main/v5.0.0/tasks-schema.json"
#>  - attr(*, "branch")= chr "main"
```

Likewise, `target_metadata` is a combination of `target_metadata_hosp`,
and `target_metadata_death`:

``` r
str(target_metadata)
#> List of 1
#>  $ target_metadata:List of 2
#>   ..$ :List of 7
#>   .. ..$ target_id    : chr "inc hosp"
#>   .. ..$ target_name  : chr "Weekly incident influenza hospitalizations"
#>   .. ..$ target_units : chr "rate per 100,000 population"
#>   .. ..$ target_keys  :List of 1
#>   .. .. ..$ target: chr "inc hosp"
#>   .. ..$ target_type  : chr "discrete"
#>   .. ..$ is_step_ahead: logi TRUE
#>   .. ..$ time_unit    : chr "week"
#>   ..$ :List of 7
#>   .. ..$ target_id    : chr "inc death"
#>   .. ..$ target_name  : chr "Weekly incident influenza deaths"
#>   .. ..$ target_units : chr "rate per 100,000 population"
#>   .. ..$ target_keys  :List of 1
#>   .. .. ..$ target: chr "inc death"
#>   .. ..$ target_type  : chr "discrete"
#>   .. ..$ is_step_ahead: logi TRUE
#>   .. ..$ time_unit    : chr "week"
#>  - attr(*, "class")= chr [1:2] "target_metadata" "list"
#>  - attr(*, "n")= int 2
#>  - attr(*, "schema_id")= chr "https://raw.githubusercontent.com/hubverse-org/schemas/main/v5.0.0/tasks-schema.json"
#>  - attr(*, "branch")= chr "main"
```

If this process just creates lists with metadata, then why bother using
`hubAdmin` functions at all to create them? The benefit is that
`hubAdmin` `create_*()` functions provide some basic validation of
objects when creating them, helping you catch some potential mistakes
sooner. For example, some of the values are interdependent and if you
accidentally leave one out, the function will provide a helpful error:

``` r
create_target_metadata_item(
  target_id = "inc hosp",
  target_name = "Weekly incident influenza hospitalizations",
  target_units = "rate per 100,000 population",
  target_keys = list(target = "inc hosp"),
  target_type = "discrete",
  is_step_ahead = TRUE
)
#> Error in `create_target_metadata_item()`:
#> ! A value must be provided for `time_unit` when `is_step_ahead` is TRUE
```

Now that we have defined the targets in `target_metadata`, we can move
on to defining the task ID objects, which will define what the modeling
parameters will be.

### Creating the `task_id` objects

In this modeling effort, we want to **require** modelers to provide
week-ahead predictions for the “weekly incident influenza
hospitalizations” target (`inc hosp`) at the national level (`location`
= `"US"`). Model submissions can optionally include five states, provide
up to 4-week-ahead predictions, and also provide predictions for the
“weekly incident influenza deaths” target (`inc death`).

``` r
origin_date <- create_task_id(
  "origin_date",
  required = NULL,
  optional = c("2023-01-02", "2023-01-09", "2023-01-16")
)

location <- create_task_id(
  "location",
  required = "US",
  optional = c("01", "02", "04", "05", "06")
)

horizon <- create_task_id("horizon", required = 1L, optional = 2:4)

target <- create_task_id("target", required = "inc hosp", optional = "inc death")

task_ids_example <- create_task_ids(origin_date, location, horizon, target)
```

Now that we’ve created the task IDs that specify the modeling tasks, we
can define the outputs we expect from the models.

### Creating the `output_type` objects

For this example, we want to have three output type objects:

1.  a required `"mean"` output type with a “double” value
2.  a required `"quantile"` output type with a “double” value
3.  an optional `"median"` output type with an “integer” value

Additionally, our two targets will accept a different combination of
output types. Specifically, target `"inc hosp"` will only accept
`"mean"` and `"median"` output types while `"inc death"` will only
accept `"mean"` and `"quantile"` output types.

``` r
mean_out_type <- create_output_type_mean(
  is_required = TRUE,
  value_type = "double",
  value_minimum = 0
)

median_out_type <- create_output_type_median(
  is_required = FALSE,
  value_type = "integer",
  value_minimum = 0L

)

quantile_out_type <- create_output_type_quantile(
  required = c(0.25, 0.5, 0.75),
  is_required = TRUE,
  value_type = "double",
  value_minimum = 0
)
```

Now that we have our base `output_type_item` class objects, we can
combine them to create `output_type` class objects that we want to use
for each particular target.

``` r
output_type_mean_median <- create_output_type(mean_out_type, median_out_type)

output_type_mean_quantile <- create_output_type(mean_out_type, quantile_out_type)
```

### Creating the `model_task` objects

As previously discussed, we want to require a “mean” output for both
tasks, but we want a “quantile” output type for the `inc death` target
and an optional “median” for the `inc hosp` target.

``` r
model_task_hosp <- create_model_task(
  task_ids = task_ids_example,
  output_type = output_type_mean_median,
  target_metadata = target_metadata
)

model_task_death <- create_model_task(
  task_ids = task_ids_example,
  output_type = output_type_mean_quantile,
  target_metadata = target_metadata
)

model_task_example <- create_model_tasks(model_task_hosp, model_task_death)
```

Now that we have a set of model tasks, we can create rounds for them.

### Creating the `round` objects

While the model tasks define what a model output submission should look
like, the round additionally defines the schedule of submissions and the
timeframe under which a submission is considered valid.

The most common way to create rounds is to create a single `round`
object that and specify a date task ID whose values will act as the
round IDs for each round. These round IDs are used to calculate the
submission window for each modeling round. In our example, we specify
`"origin_date"` as the source variable for round IDs. We also specify
that the submission window for a given round is a period of one week,
where the beginning of the window is 4 days before the origin date and
the end of the submission window is 2 days after the origin date. This
means if you have an origin date of Monday 2023-01-02, then valid
submission dates for that round are from Thursday 2022-12-29 to
Wednesday 2023-01-04

``` r
round1 <- create_round(
  round_id_from_variable = TRUE,
  round_id = "origin_date",
  round_name = "Round 1",
  model_tasks = model_task_example,
  submissions_due = list(
    relative_to = "origin_date",
    start = -4L,
    end = 2L
  )
)

rounds <- create_rounds(round1)
```

### Creating and saving the `tasks` config file

And the penultimate step is to create a config file and write it out to
your hub. At this point, you can specify the data type you expect the
resulting column of a model submission output type id should be. This is
important for downstream analysis and visualization of the data. This is
automatically determined by default, but **it is [important to maintain
a stable output type ID column data
type](https://docs.hubverse.io/en/latest/user-guide/model-output.html#the-importance-of-a-stable-model-output-file-schema)
throughout the life of your hub.** The consequences of not doing so
could lead to an inability to evaluate past submissions. For example,
this hub has quantile values, so the default would set the value of the
`output_type_id` column to be a “double.” However, if we expect to
include sample or PMF data submissions in the future, the default would
likely change to “character.” In this case, we do not plan to include
sample or PMF outputs into our hub, so we will set the data type to
“double”

``` r
config <- create_config(rounds, output_type_id_datatype = "double")

write_config(config)
```

    #> ✔ `config` written out successfully.

contents of `hub-config/tasks.json`

``` json
{
  "schema_version": "https://raw.githubusercontent.com/hubverse-org/schemas/main/v5.0.0/tasks-schema.json",
  "rounds": [
    {
      "round_id_from_variable": true,
      "round_id": "origin_date",
      "round_name": "Round 1",
      "model_tasks": [
        {
          "task_ids": {
            "origin_date": {
              "required": null,
              "optional": ["2023-01-02", "2023-01-09", "2023-01-16"]
            },
            "location": {
              "required": [
                "US"
              ],
              "optional": ["01", "02", "04", "05", "06"]
            },
            "horizon": {
              "required": [
                1
              ],
              "optional": [2, 3, 4]
            },
            "target": {
              "required": [
                "inc hosp"
              ],
              "optional": [
                "inc death"
              ]
            }
          },
          "output_type": {
            "mean": {
              "output_type_id": {
                "required": null
              },
              "is_required": true,
              "value": {
                "type": "double",
                "minimum": 0
              }
            },
            "median": {
              "output_type_id": {
                "required": null
              },
              "is_required": false,
              "value": {
                "type": "integer",
                "minimum": 0
              }
            }
          },
          "target_metadata": [
            {
              "target_id": "inc hosp",
              "target_name": "Weekly incident influenza hospitalizations",
              "target_units": "rate per 100,000 population",
              "target_keys": {
                "target": "inc hosp"
              },
              "target_type": "discrete",
              "is_step_ahead": true,
              "time_unit": "week"
            },
            {
              "target_id": "inc death",
              "target_name": "Weekly incident influenza deaths",
              "target_units": "rate per 100,000 population",
              "target_keys": {
                "target": "inc death"
              },
              "target_type": "discrete",
              "is_step_ahead": true,
              "time_unit": "week"
            }
          ]
        },
        {
          "task_ids": {
            "origin_date": {
              "required": null,
              "optional": ["2023-01-02", "2023-01-09", "2023-01-16"]
            },
            "location": {
              "required": [
                "US"
              ],
              "optional": ["01", "02", "04", "05", "06"]
            },
            "horizon": {
              "required": [
                1
              ],
              "optional": [2, 3, 4]
            },
            "target": {
              "required": [
                "inc hosp"
              ],
              "optional": [
                "inc death"
              ]
            }
          },
          "output_type": {
            "mean": {
              "output_type_id": {
                "required": null
              },
              "is_required": true,
              "value": {
                "type": "double",
                "minimum": 0
              }
            },
            "quantile": {
              "output_type_id": {
                "required": [0.25, 0.5, 0.75]
              },
              "is_required": true,
              "value": {
                "type": "double",
                "minimum": 0
              }
            }
          },
          "target_metadata": [
            {
              "target_id": "inc hosp",
              "target_name": "Weekly incident influenza hospitalizations",
              "target_units": "rate per 100,000 population",
              "target_keys": {
                "target": "inc hosp"
              },
              "target_type": "discrete",
              "is_step_ahead": true,
              "time_unit": "week"
            },
            {
              "target_id": "inc death",
              "target_name": "Weekly incident influenza deaths",
              "target_units": "rate per 100,000 population",
              "target_keys": {
                "target": "inc death"
              },
              "target_type": "discrete",
              "is_step_ahead": true,
              "time_unit": "week"
            }
          ]
        }
      ],
      "submissions_due": {
        "relative_to": "origin_date",
        "start": -4,
        "end": 2
      }
    }
  ],
  "output_type_id_datatype": "double"
}
```

## Validating your config file

One of the strengths of specifying configuration in a JSON format is
that it’s machine-readable, which means that no matter how complex a
JSON file gets, **it can be easily and rapidly validated**. All hubverse
configuration files are validated against a central set of [hubverse
schemas](https://github.com/hubverse-org/schemas/) that specify *how* a
configuration file is constructed. This allows any tool to be able to
read a JSON file and validate it against the schema to ensure it’s
valid.

To check that your configuration file is valid, you can use the
[`validate_config()`](https://hubverse-org.github.io/hubAdmin/reference/validate_config.md)
function from the root directory of your hub:

``` r
validate_config(config = "tasks")
```

    #> Loading required namespace: jsonvalidate
    #> [1] TRUE
    #> ✔ ok:  hub-config/tasks.json (<file:///path/to/hub/hub-config/tasks.json>) (via tasks-schema v5.0.0 (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v5.0.0/tasks-schema.json>))
