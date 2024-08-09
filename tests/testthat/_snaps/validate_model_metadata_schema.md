# Missing files returns an invalid config with an immediate message

    Code
      out
    Output
      [1] FALSE
    Message
      x error in parsing
        '[masked]/hub-config/model-metadata-schema.json'
      i (File does not exist:
        '[masked]/hub-config/model-metadata-schema.json')

# validate_model_metadata_schema works

    Code
      out_error
    Output
      [1] FALSE
    Message
      ! 1 schema errors: hub-config/model-metadata-schema.json
        (<file://testdata/error_hub/hub-config/model-metadata-schema.json>) (via none
        (<>))
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

# validate_model_metadata_schema errors for imparsable json

    Code
      out_error
    Output
      [1] FALSE
    Message
      x error in parsing
        '/tmp/Rtmp3YBxV9/file11fd653576c7a/hub-config/model-metadata-schema.json'
      i (SyntaxError: missing ) after argument list)

