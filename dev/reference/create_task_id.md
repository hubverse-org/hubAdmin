# Create an object of class `task_id`

Create a representation of a task ID item as a list object of class
`task_id`. This can be combined with additional `task_id` objects using
function
[`create_task_ids()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_task_ids.md)
to create a `task_ids` class object for a given model_task. Such
building blocks can ultimately be combined and then written out as or
appended to `tasks.json` Hub config files.

## Usage

``` r
create_task_id(
  name,
  required,
  optional,
  schema_version = getOption("hubAdmin.schema_version", default = "latest"),
  branch = getOption("hubAdmin.branch", default = "main")
)
```

## Arguments

- name:

  character string, Name of task_id to create.

- required:

  Atomic vector of required task_id values. Can be `NULL` if all values
  are optional.

- optional:

  Atomic vector of optional task_id values. Can be `NULL` if all values
  are required.

- schema_version:

  Character string specifying the json schema version to be used for
  validation. The default value `"latest"` will use the latest version
  available in the hubverse [schemas
  repository](https://github.com/hubverse-org/schemas). Alternatively, a
  specific version of a schema (e.g. `"v0.0.1"`) can be specified. Can
  be set through global option "hubAdmin.schema_version".

- branch:

  The branch of the hubverse [schemas
  repository](https://github.com/hubverse-org/schemas) from which to
  fetch schema. Defaults to `"main"`. Can be set through global option
  "hubAdmin.branch".

## Value

a named list of class `task_id` representing a task ID.

## Details

`required` and `optional` vectors for standard task_ids defined in a Hub
schema must match data types and formats specified in the schema. For
more details consult the [documentation on `tasks.json` Hub config
files](https://docs.hubverse.io/en/latest/quickstart-hub-admin/tasks-config.html)

JSON schema data type names differ to those in R. Use the following
mappings to create vectors of appropriate data types which will
correspond to correct JSON schema data types during config file
validation.

|         |           |
|---------|-----------|
| json    | R         |
| string  | character |
| boolean | logical   |
| integer | integer   |
| number  | double    |

Values across `required` and `optional` arguments must be unique.
`required` and `optional` must be of the same type (unless `NULL`).
Task_ids that represent dates must be supplied as character strings in
ISO 8601 date format (YYYY-MM-DD). If working with date objects, please
convert to character (e.g. using
[`as.character()`](https://rdrr.io/r/base/character.html)) before
supplying as arguments.

Task_ids not present in the schema are allowed as additional properties
but the user is responsible for providing values of the correct data
type.

## See also

[`create_task_ids()`](https://hubverse-org.github.io/hubAdmin/dev/reference/create_task_ids.md)

## Examples

``` r
create_task_id("horizon", required = 1L, optional = 2:4)
#> $horizon
#> $horizon$required
#> [1] 1
#> 
#> $horizon$optional
#> [1] 2 3 4
#> 
#> 
#> attr(,"class")
#> [1] "task_id" "list"   
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v6.0.0/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
# Set schema version to "v3.0.1" for all subsequent calls
options(hubAdmin.schema_version = "v3.0.1")
create_task_id("horizon", required = 1L, optional = 2:4)
#> $horizon
#> $horizon$required
#> [1] 1
#> 
#> $horizon$optional
#> [1] 2 3 4
#> 
#> 
#> attr(,"class")
#> [1] "task_id" "list"   
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
create_task_id("location", required = "US", optional = c("01", "02"))
#> $location
#> $location$required
#> [1] "US"
#> 
#> $location$optional
#> [1] "01" "02"
#> 
#> 
#> attr(,"class")
#> [1] "task_id" "list"   
#> attr(,"schema_id")
#> [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
#> attr(,"branch")
#> [1] "main"
options(hubAdmin.schema_version = "latest")
```
