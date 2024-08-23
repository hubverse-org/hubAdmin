## hubAdmin (development)

* New feature: Add `ci_validate_hub_config()` as a non-interactive function that works with
  GitHub to produce a validation report on Continous Integration (suggested: 
  @zkamvar, #31; implemented: @zkamvar, #37)

## hubAdmin 1.0.1

* Update `create_output_type_cdf()` to accommodate less restrictive
  `output_type_id` checks introduced in schema version
  [`v3.0.1`](https://github.com/hubverse-org/schemas/releases/tag/v3.0.1)
  (implemented: @annakrystalli, #29).
* URL for hubdocs updated (@zkamvar, #27)
* Output of `validate_config()` and `validate_hub_config()` are now classed so
  the summary of their contents is printed nicely to the screen, reducing the
  amount of screen space needed to report success or failure (suggested: 
  @zkamvar, #32; implemented: @zkamvar, #35)

## hubAdmin 1.0.0

* Breaking changes: Support schema v3.0.0 specification of sample output type IDs which are now specified through a `output_type_id_params` object instead of `output_type_id`. The main breaking change is in `create_output_type_sample()` which now takes arguments incompatible with previous schema versions and returns an object with an `output_type_id_params` object instead of `output_type_id`. Additional but back-compatible dynamic validation checks on sample output types have been added to `validate_config()`.

## hubAdmin 0.2.0

* Introduce validation check that ensures no all null task IDs exist in `tasks.json`.  

## hubAdmin 0.1.0

* Allow task ID `create_task_id()` arguments `required` and `optional` to both be set to `NULL`, facilitating the encoding of `NA` task IDs in modeling tasks where no value is expected for a given task ID.  

## hubAdmin 0.0.1

* Initial package release resulting from split of `hubUtils` package. See [`hubUtils` NEWS.md](https://github.com/hubverse-org/hubUtils/blob/main/NEWS.md) for details including previous release notes.
