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
      i use `view_config_val_errors()` to view table of error details.

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
      i use `view_config_val_errors()` to view table of error details.

