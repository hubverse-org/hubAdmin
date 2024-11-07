# hubAdmin (development version)

* Support v4.0.0 schema configuration of output types and output type IDs when creating config files programmatically. Specifically, whether an output type is required or not is specified via the `is_required` logical property whereas the `output_type_id` values as provided through the `required` property.
* Add dynamic checks to ensure `derived_task_ids` match valid task ID names to validation of `task.json` config files (#69).

# hubAdmin 1.3.0

* Add `derived_task_ids` property to `create_config()` (for specifying hub level derived task IDs) and `create_round()` (for specifying round level derived task IDs) (#52). This adds compatibility for the upcoming schemas v4.0.0 release.

# hubAdmin 1.2.0

* Add `as_config()` function to convert a list representation of a `tasks.json` config file to a `<config>` class object (#42). Useful when wanting to programmatically manipulate the contents of a `tasks.json` config file.
* Add `append_round()` function to append one or more `<round>` class objects to the `rounds` property of a `<config>` class object (#42). 
* Add `schema_autobox()` function that uses the schema to "box" length one vectors in a `<config>` class object that should be arrays in JSON format (#44). This transformation is now applied by default when writing a `<config>` class object to a JSON file using `write_json()` but can be deactivated using the `autobox` argument. The transformation is also applied to any properties that should be arrays covered by `additionalProperties` in the schema (e.g. custom task IDs). 
* Add `get_array_schema_paths()` utility function for extracting paths to potential array properties in a JSON schema and export previously internal `download_tasks_schema()`.
* Add link to development version documentation to README.

# hubAdmin 1.1.1

* Add `output_type_id_datatype` argument to `create_config()`. This allows for the specification of the data type of the `output_type_id` column of model output data through schema property `output_type_id_datatype`, introduced in [v3.0.1 version of the hubverse schema](https://github.com/hubverse-org/schemas/releases/tag/v3.0.1)  (#41)

# hubAdmin 1.1.0

* Add `write_config()` functions to write objects of class `<config>` to JSON files (#3)

# hubAdmin 1.0.2

* New feature: Add `ci_validate_hub_config()` as a non-interactive function that works with
  GitHub to produce a validation report on Continous Integration (#37)

# hubAdmin 1.0.1

* Update `create_output_type_cdf()` to accommodate less restrictive
  `output_type_id` checks introduced in schema version
  [`v3.0.1`](https://github.com/hubverse-org/schemas/releases/tag/v3.0.1)
  (#29).
* URL for hubdocs updated (#27)
* Output of `validate_config()` and `validate_hub_config()` are now classed so
  the summary of their contents is printed nicely to the screen, reducing the
  amount of screen space needed to report success or failure (#35)

# hubAdmin 1.0.0

* Breaking changes: Support schema v3.0.0 specification of sample output type IDs which are now specified through a `output_type_id_params` object instead of `output_type_id`. The main breaking change is in `create_output_type_sample()` which now takes arguments incompatible with previous schema versions and returns an object with an `output_type_id_params` object instead of `output_type_id`. Additional but back-compatible dynamic validation checks on sample output types have been added to `validate_config()`.

# hubAdmin 0.2.0

* Introduce validation check that ensures no all null task IDs exist in `tasks.json`.  

# hubAdmin 0.1.0

* Allow task ID `create_task_id()` arguments `required` and `optional` to both be set to `NULL`, facilitating the encoding of `NA` task IDs in modeling tasks where no value is expected for a given task ID.  

# hubAdmin 0.0.1

* Initial package release resulting from split of `hubUtils` package. See [`hubUtils` NEWS.md](https://github.com/hubverse-org/hubUtils/blob/main/NEWS.md) for details including previous release notes.
