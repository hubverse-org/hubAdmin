# validate_model_metadata_schema works

    Code
      out_error
    Output
      [1] FALSE
    Message
      ! 1 schema errors: hub-config/model-metadata-schema.json
        (<file://testdata/error_hub/hub-config/model-metadata-schema.json>) (from
        default json schema
        (<file://testdata/error_hub/hub-config/model-metadata-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

---

    Code
      print(out_error)
    Output
      [1] FALSE
    Message
      ! 1 schema errors: hub-config/model-metadata-schema.json
        (<file://testdata/error_hub/hub-config/model-metadata-schema.json>) (from
        default json schema
        (<file://testdata/error_hub/hub-config/model-metadata-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

---

    Code
      str(attr(out_error, "errors"))
    Output
      'data.frame':	1 obs. of  6 variables:
       $ instancePath: chr ""
       $ schemaPath  : chr "properties"
       $ keyword     : chr "required"
       $ message     : chr "must have required properties: either 'model_id' or both 'team_abbr' and 'model_abbr'."
       $ schema      : chr ""
       $ data        : chr "team_name, model_name, model_abbr, model_version, model_contributors, website_url, repo_url, license, designate"| __truncated__

