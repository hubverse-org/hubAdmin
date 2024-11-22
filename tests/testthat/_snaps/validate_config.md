# Config for samples handled succesfully

    Code
      out
    Output
      [1] TRUE
    Message
      v ok:  testdata/tasks-samples-pass.json (<file://testdata/tasks-samples-pass.json>) (via tasks-schema v3.0.1 (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json>))

# Config for samples fail correctly

    Code
      out
    Output
      [1] FALSE
    Message
      ! 1 schema errors: testdata/tasks-samples-error-range.json
        (<file://testdata/tasks-samples-error-range.json>) (via tasks-schema v3.0.1
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out, "errors")
    Output
                                                                     instancePath
      1 /rounds/0/model_tasks/0/task_ids/output_type/sample/output_type_id_params
                                                                                                                   schemaPath
      1 #/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/sample/output_type_id_params
                    keyword
      1 Sample number range
                                                                    message schema
      1 min_samples_per_task must be less or equal to max_samples_per_task.       
                                                       data
      1 min_samples_per_task: 60;\nmax_samples_per_task: 40

---

    Code
      out
    Output
      [1] FALSE
    Message
      ! 1 schema errors: testdata/tasks-samples-error-task-ids.json
        (<file://testdata/tasks-samples-error-task-ids.json>) (via tasks-schema
        v3.0.1
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out, "errors")
    Output
                                                                                         instancePath
      1 /rounds/0/model_tasks/0/task_ids/output_type/sample/output_type_id_params/compound_taskid_set
                                                                                                                                       schemaPath
      1 #/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/sample/output_type_id_params/compound_taskid_set
                           keyword
      1 compound_taskid_set values
                                                                 message schema
      1 compound_taskid_set value(s) 'origin_date' not valid task id(s).       
                                                                                                                         data
      1 compound_taskid_set values: origin_date, location, horizon;\ntask id values: forecast_date, target, horizon, location

# Config errors detected successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 8 schema errors: testdata/tasks-errors.json
        (<file://testdata/tasks-errors.json>) (via tasks-schema v0.0.0.9
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v0.0.0.9/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out, "errors")
    Output
                                                     instancePath
      1          /rounds/0/model_tasks/0/task_ids/target/required
      2 /rounds/0/model_tasks/0/output_type/mean/type_id/optional
      3 /rounds/0/model_tasks/0/output_type/mean/type_id/required
      4          /rounds/0/model_tasks/0/output_type/mean/type_id
      5                                 /rounds/0/submissions_due
      6                           /rounds/0/submissions_due/start
      7                             /rounds/0/submissions_due/end
      8                                 /rounds/0/submissions_due
                                                                                                                                               schemaPath
      1                             #/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/target/properties/required/type
      2 #/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/mean/properties/type_id/oneOf/0/properties/optional/type
      3 #/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/mean/properties/type_id/oneOf/1/properties/required/type
      4                            #/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/mean/properties/type_id/oneOf
      5                                                                             #/properties/rounds/items/properties/submissions_due/oneOf/0/required
      6                                                                #/properties/rounds/items/properties/submissions_due/oneOf/1/properties/start/type
      7                                                                  #/properties/rounds/items/properties/submissions_due/oneOf/1/properties/end/type
      8                                                                                        #/properties/rounds/items/properties/submissions_due/oneOf
         keyword params.type params.passingSchemas params.missingProperty
      1     type array, null                    NA                   <NA>
      2     type        null                    NA                   <NA>
      3     type        null                    NA                   <NA>
      4    oneOf        NULL                    NA                   <NA>
      5 required        NULL                    NA            relative_to
      6     type      string                    NA                   <NA>
      7     type      string                    NA                   <NA>
      8    oneOf        NULL                    NA                   <NA>
                                          message
      1                        must be array,null
      2                              must be null
      3                              must be null
      4    must match exactly one schema in oneOf
      5 must have required property 'relative_to'
      6                            must be string
      7                            must be string
      8    must match exactly one schema in oneOf
                                                                                                                                                                                                                                                                                                                                                           schema
      1                                                                                                                                                                                                                                                                                                                                               array, null
      2                                                                                                                                                                                                                                                                                                                                                      null
      3                                                                                                                                                                                                                                                                                                                                                      null
      4                                                                      When mean is required, property set to single element 'NA' array, When mean is optional, property set to null, array, null, NA, NA, 1, NA, When mean is required, property set to null, When mean is optional, property set to single element 'NA' array, null, array, NA, NA, NA, 1
      5                                                                                                                                                                                                                                                                                                                                   relative_to, start, end
      6                                                                                                                                                                                                                                                                                                                                                    string
      7                                                                                                                                                                                                                                                                                                                                                    string
      8 Name of task id variable in relation to which submission start and end dates are calculated., NA, string, NA, Difference in days between start and origin date., Submission start date., integer, string, NA, date, Difference in days between end and origin date., Submission end date., integer, string, NA, date, relative_to, start, end, start, end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                parentSchema.description
      1                                                                                                                                                                                                                                                                                                                                         Array of target unique identifiers that must be present for submission to be valid. Can be null if no targets are required and all valid targets are specified in the optional property.
      2                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      When mean is required, property set to null
      3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      When mean is optional, property set to null
      4 type_id is not meaningful for a mean output_type. The property is primarily used to determine whether mean is a required or optional output type through properties required and optional. If mean is a required output type, the required property must be an array containing the single string element 'NA' and the optional property must be set to null. If mean is an optional output type, the optional property must be an array containing the single string element 'NA' and the required property must be set to null
      5                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             <NA>
      6                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Submission start date.
      7                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             Submission end date.
      8                                                                                                                                                                                                                                                                                                                                                                                                                                                 Object defining the dates by which model forecasts must be submitted to the hub.
        parentSchema.type parentSchema.type
      1       array, null            string
      2              null              <NA>
      3              null              <NA>
      4            object              <NA>
      5              NULL              <NA>
      6            string              <NA>
      7            string              <NA>
      8            object              <NA>
                                 parentSchema.examples
      1                                           NULL
      2                                           NULL
      3                                           NULL
      4                                         NA, NA
      5                                           NULL
      6                                           NULL
      7                                           NULL
      8 2022-06-07, -4, 2022-07-20, 2, NA, origin_date
                                                                                                                                                                                                                                                                                                                                               parentSchema.oneOf
      1                                                                                                                                                                                                                                                                                                                                                      NULL
      2                                                                                                                                                                                                                                                                                                                                                      NULL
      3                                                                                                                                                                                                                                                                                                                                                      NULL
      4                                                                      When mean is required, property set to single element 'NA' array, When mean is optional, property set to null, array, null, NA, NA, 1, NA, When mean is required, property set to null, When mean is optional, property set to single element 'NA' array, null, array, NA, NA, NA, 1
      5                                                                                                                                                                                                                                                                                                                                                      NULL
      6                                                                                                                                                                                                                                                                                                                                                      NULL
      7                                                                                                                                                                                                                                                                                                                                                      NULL
      8 Name of task id variable in relation to which submission start and end dates are calculated., NA, string, NA, Difference in days between start and origin date., Submission start date., integer, string, NA, date, Difference in days between end and origin date., Submission end date., integer, string, NA, date, relative_to, start, end, start, end
          parentSchema.required
      1                    NULL
      2                    NULL
      3                    NULL
      4      required, optional
      5 relative_to, start, end
      6                    NULL
      7                    NULL
      8              start, end
                                                     parentSchema.properties.relative_to.description
      1                                                                                         <NA>
      2                                                                                         <NA>
      3                                                                                         <NA>
      4                                                                                         <NA>
      5 Name of task id variable in relation to which submission start and end dates are calculated.
      6                                                                                         <NA>
      7                                                                                         <NA>
      8                                                                                         <NA>
        parentSchema.properties.relative_to.type
      1                                     <NA>
      2                                     <NA>
      3                                     <NA>
      4                                     <NA>
      5                                   string
      6                                     <NA>
      7                                     <NA>
      8                                     <NA>
                parentSchema.properties.start.description
      1                                              <NA>
      2                                              <NA>
      3                                              <NA>
      4                                              <NA>
      5 Difference in days between start and origin date.
      6                                              <NA>
      7                                              <NA>
      8                                              <NA>
        parentSchema.properties.start.type
      1                               <NA>
      2                               <NA>
      3                               <NA>
      4                               <NA>
      5                            integer
      6                               <NA>
      7                               <NA>
      8                               <NA>
                parentSchema.properties.end.description
      1                                            <NA>
      2                                            <NA>
      3                                            <NA>
      4                                            <NA>
      5 Difference in days between end and origin date.
      6                                            <NA>
      7                                            <NA>
      8                                            <NA>
        parentSchema.properties.end.type parentSchema.format            data
      1                             <NA>                <NA> wk inc flu hosp
      2                             <NA>                <NA>              NA
      3                             <NA>                <NA>              NA
      4                             <NA>                <NA>          NA, NA
      5                          integer                <NA>           -6, 1
      6                             <NA>                date              -6
      7                             <NA>                date               1
      8                             <NA>                <NA>           -6, 1
                                                         dataPath
      1          /rounds/0/model_tasks/0/task_ids/target/required
      2 /rounds/0/model_tasks/0/output_type/mean/type_id/optional
      3 /rounds/0/model_tasks/0/output_type/mean/type_id/required
      4          /rounds/0/model_tasks/0/output_type/mean/type_id
      5                                 /rounds/0/submissions_due
      6                           /rounds/0/submissions_due/start
      7                             /rounds/0/submissions_due/end
      8                                 /rounds/0/submissions_due

# Dynamic config errors detected successfully by custom R validation

    Code
      out
    Output
      [1] FALSE
    Message
      ! 4 schema errors: testdata/tasks-errors-rval.json
        (<file://testdata/tasks-errors-rval.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out, "errors")
    Output
                                                                instancePath
      1 /rounds/0/model_tasks/1/target_metadata/0/target_keys/target_measure
      2 /rounds/0/model_tasks/1/target_metadata/1/target_keys/target_measure
      3 /rounds/0/model_tasks/1/target_metadata/0/target_keys/target_outcome
      4                      /rounds/0/model_tasks/1/task_ids/target_outcome
                                                                                                            schemaPath
      1 #/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_keys
      2 #/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_keys
      3 #/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_keys
      4                                     #/properties/rounds/items/properties/model_tasks/items/properties/task_ids
                   keyword
      1  target_keys names
      2  target_keys names
      3 target_keys values
      4     task_id values
                                                                                                              message
      1                                 target_key(s) 'target_measure' not properties of modeling task group task IDs
      2                                 target_key(s) 'target_measure' not properties of modeling task group task IDs
      3 target_key value 'flu hospitalisation' does not match any values in corresponding modeling task group task_id
      4                     task_id value(s) 'flu hosp, wk inc flu hosp' not defined in any corresponding target_key.
        schema
      1       
      2       
      3       
      4       
                                                                                                                                                      data
      1                   task_id names: origin_date, target_outcome, target_mesures, horizon, location;\ntarget_key names: target_measure, target_outcome
      2                   task_id names: origin_date, target_outcome, target_mesures, horizon, location;\ntarget_key names: target_measure, target_outcome
      3                          task_id.target_outcome values: flu hosp, wk inc flu hosp, flu case;\ntarget_key.target_outcome value: flu hospitalisation
      4 task_id.target_outcome unique values: flu hosp, wk inc flu hosp, flu case;\ntarget_key.target_outcome unique values: flu hospitalisation, flu case

# Reserved hub variable task id name detected correctly

    Code
      out
    Output
      [1] FALSE
    Message
      ! 6 schema errors: testdata/tasks-errors-rval-reserved.json
        (<file://testdata/tasks-errors-rval-reserved.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out, "errors")
    Output
                                                                instancePath
      1 /rounds/0/model_tasks/1/target_metadata/0/target_keys/target_measure
      2 /rounds/0/model_tasks/1/target_metadata/1/target_keys/target_measure
      3 /rounds/0/model_tasks/1/target_metadata/0/target_keys/target_outcome
      4                      /rounds/0/model_tasks/1/task_ids/target_outcome
      5                                    /rounds/0/model_tasks/0/task_ids/
      6                                    /rounds/0/model_tasks/1/task_ids/
                                                                                                            schemaPath
      1 #/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_keys
      2 #/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_keys
      3 #/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_keys
      4                                     #/properties/rounds/items/properties/model_tasks/items/properties/task_ids
      5                                     #/properties/rounds/items/properties/model_tasks/items/properties/task_ids
      6                                     #/properties/rounds/items/properties/model_tasks/items/properties/task_ids
                   keyword
      1  target_keys names
      2  target_keys names
      3 target_keys values
      4     task_id values
      5      task_id names
      6      task_id names
                                                                                                              message
      1                                 target_key(s) 'target_measure' not properties of modeling task group task IDs
      2                                 target_key(s) 'target_measure' not properties of modeling task group task IDs
      3 target_key value 'flu hospitalisation' does not match any values in corresponding modeling task group task_id
      4                     task_id value(s) 'flu hosp, wk inc flu hosp' not defined in any corresponding target_key.
      5                                        task_id name(s) 'model_id' must not match reserved hub variable names.
      6                                           task_id name(s) 'value' must not match reserved hub variable names.
        schema
      1       
      2       
      3       
      4       
      5       
      6       
                                                                                                                                                            data
      1                            task_id names: origin_date, target_outcome, target_mesures, horizon, value;\ntarget_key names: target_measure, target_outcome
      2                            task_id names: origin_date, target_outcome, target_mesures, horizon, value;\ntarget_key names: target_measure, target_outcome
      3                                task_id.target_outcome values: flu hosp, wk inc flu hosp, flu case;\ntarget_key.target_outcome value: flu hospitalisation
      4       task_id.target_outcome unique values: flu hosp, wk inc flu hosp, flu case;\ntarget_key.target_outcome unique values: flu hospitalisation, flu case
      5                      task_id names: origin_date, target, horizon & model_id;\nreserved hub variable names: model_id, output_type, output_type_id & value
      6 task_id names: origin_date, target_outcome, target_mesures, horizon & value;\nreserved hub variable names: model_id, output_type, output_type_id & value

# Additional properties error successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 1 schema errors: testdata/tasks-addprop.json
        (<file://testdata/tasks-addprop.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out, "errors")
    Output
                               instancePath
      1 /rounds/0/model_tasks/0/output_type
                                                                                                schemaPath
      1 #/properties/rounds/items/properties/model_tasks/items/properties/output_type/additionalProperties
                     keyword additionalProperty                             message
      1 additionalProperties    target_metadata must NOT have additional properties
        schema parentSchema.type
      1  FALSE            object
                                                                                                                                                                                                                                                                                                                                                  parentSchema.description
      1 Object defining valid model output types for a given modeling task. The name of each property corresponds to valid values in column 'output_type' while the 'output_type_id' property of each output type defines the valid values of the 'output_type_id' column and the 'value' property defines the valid values of the 'value' column for a given output type.
        parentSchema.properties.mean.type
      1                            object
                                    parentSchema.properties.mean.description
      1 Object defining the mean of the predictive distribution output type.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                             parentSchema.properties.mean.properties.output_type_id.description
      1 output_type_id is not meaningful for a mean output_type. The property is primarily used to determine whether mean is a required or optional output type through properties required and optional. If mean is a required output type, the required property must be an array containing the single string element 'NA' and the optional property must be set to null. If mean is an optional output type, the optional property must be an array containing the single string element 'NA' and the required property must be set to null
        parentSchema.properties.mean.properties.output_type_id.examples
      1                                                          NA, NA
        parentSchema.properties.mean.properties.output_type_id.type
      1                                                      object
                                                                                                                                                                                                                                parentSchema.properties.mean.properties.output_type_id.oneOf
      1 When mean is required, property set to single element 'NA' array, When mean is optional, property set to null, array, null, NA, NA, 1, NA, When mean is required, property set to null, When mean is optional, property set to single element 'NA' array, null, array, NA, NA, NA, 1
        parentSchema.properties.mean.properties.output_type_id.required
      1                                              required, optional
        parentSchema.properties.mean.properties.value.type
      1                                             object
        parentSchema.properties.mean.properties.value.description
      1 Object defining the characteristics of valid mean values.
        parentSchema.properties.mean.properties.value.examples
      1                                              double, 0
        parentSchema.properties.mean.properties.value.properties.type.description
      1                                                 Data type of mean values.
        parentSchema.properties.mean.properties.value.properties.type.type
      1                                                             string
        parentSchema.properties.mean.properties.value.properties.type.enum
      1                                                    double, integer
        parentSchema.properties.mean.properties.value.properties.minimum.description
      1                                       The minimum inclusive valid mean value
        parentSchema.properties.mean.properties.value.properties.minimum.type
      1                                                       number, integer
        parentSchema.properties.mean.properties.value.properties.maximum.description
      1                                       the maximum inclusive valid mean value
        parentSchema.properties.mean.properties.value.properties.maximum.type
      1                                                       number, integer
        parentSchema.properties.mean.properties.value.required
      1                                                   type
        parentSchema.properties.mean.required parentSchema.properties.median.type
      1                 output_type_id, value                              object
                                   parentSchema.properties.median.description
      1 Object defining the median of the predictive distribution output type
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   parentSchema.properties.median.properties.output_type_id.description
      1 output_type_id is not meaningful for a median output_type. The property is primarily used to determine whether median is a required or optional output type through properties required and optional. If median is a required output type, the required property must be an array containing the single string element 'NA' and the optional property must be set to null. If median is an optional output type, the optional property must be an array containing the single string element 'NA' and the required property must be set to null
        parentSchema.properties.median.properties.output_type_id.examples
      1                                                            NA, NA
        parentSchema.properties.median.properties.output_type_id.type
      1                                                        object
                                                                                                                                                                                                                                      parentSchema.properties.median.properties.output_type_id.oneOf
      1 When median is required, property set to single element 'NA' array, When median is optional, property set to null, array, null, NA, NA, 1, NA, When median is required, property set to null, When median is optional, property set to single element 'NA' array, null, array, NA, NA, NA, 1
        parentSchema.properties.median.properties.output_type_id.required
      1                                                required, optional
        parentSchema.properties.median.properties.value.type
      1                                               object
        parentSchema.properties.median.properties.value.description
      1  Object defining the characteristics of valid median values
        parentSchema.properties.median.properties.value.examples
      1                                                double, 0
        parentSchema.properties.median.properties.value.properties.type.description
      1                                                  Data type of median values
        parentSchema.properties.median.properties.value.properties.type.type
      1                                                               string
        parentSchema.properties.median.properties.value.properties.type.enum
      1                                                      double, integer
        parentSchema.properties.median.properties.value.properties.minimum.description
      1                                       The minimum inclusive valid median value
        parentSchema.properties.median.properties.value.properties.minimum.type
      1                                                         number, integer
        parentSchema.properties.median.properties.value.properties.maximum.description
      1                                       the maximum inclusive valid median value
        parentSchema.properties.median.properties.value.properties.maximum.type
      1                                                         number, integer
        parentSchema.properties.median.properties.value.required
      1                                                     type
        parentSchema.properties.median.required
      1                   output_type_id, value
                                     parentSchema.properties.quantile.description
      1 Object defining the quantiles of the predictive distribution output type.
        parentSchema.properties.quantile.type
      1                                object
                                                                                    parentSchema.properties.quantile.properties.output_type_id.description
      1 Object containing required and optional arrays defining the probability levels at which quantiles of the predictive distribution will be recorded.
        parentSchema.properties.quantile.properties.output_type_id.examples
      1    0.25, 0.50, 0.75, 0.10, 0.20, 0.30, 0.40, 0.60, 0.70, 0.80, 0.90
        parentSchema.properties.quantile.properties.output_type_id.type
      1                                                          object
                                                                                                                                            parentSchema.properties.quantile.properties.output_type_id.properties.required.description
      1 Array of unique probability levels between 0 and 1 that must be present for submission to be valid. Can be null if no probability levels are required and all valid probability levels are specified in the optional property.
        parentSchema.properties.quantile.properties.output_type_id.properties.required.type
      1                                                                         array, null
        parentSchema.properties.quantile.properties.output_type_id.properties.required.uniqueItems
      1                                                                                       TRUE
        parentSchema.properties.quantile.properties.output_type_id.properties.required.items.type
      1                                                                                    number
        parentSchema.properties.quantile.properties.output_type_id.properties.required.items.minimum
      1                                                                                            0
        parentSchema.properties.quantile.properties.output_type_id.properties.required.items.maximum
      1                                                                                            1
                                                                       parentSchema.properties.quantile.properties.output_type_id.properties.optional.description
      1 Array of valid but not required unique probability levels. Can be null if all probability levels are required and are specified in the required property.
        parentSchema.properties.quantile.properties.output_type_id.properties.optional.type
      1                                                                         array, null
        parentSchema.properties.quantile.properties.output_type_id.properties.optional.uniqueItems
      1                                                                                       TRUE
        parentSchema.properties.quantile.properties.output_type_id.properties.optional.items.type
      1                                                                                    number
        parentSchema.properties.quantile.properties.output_type_id.properties.optional.items.minimum
      1                                                                                            0
        parentSchema.properties.quantile.properties.output_type_id.properties.optional.items.maximum
      1                                                                                            1
        parentSchema.properties.quantile.properties.output_type_id.required
      1                                                  required, optional
        parentSchema.properties.quantile.properties.value.type
      1                                                 object
                                                              parentSchema.properties.quantile.properties.value.description
      1 Object defining the characteristics of valid quantiles of the predictive distribution at a given probability level.
        parentSchema.properties.quantile.properties.value.properties.type.description
      1                                                 Data type of quantile values.
        parentSchema.properties.quantile.properties.value.properties.type.examples
      1                                                                     double
        parentSchema.properties.quantile.properties.value.properties.type.type
      1                                                                 string
        parentSchema.properties.quantile.properties.value.properties.type.enum
      1                                                        double, integer
        parentSchema.properties.quantile.properties.value.properties.minimum.description
      1                           The minimum inclusive valid quantile value (optional).
        parentSchema.properties.quantile.properties.value.properties.minimum.examples
      1                                                                             0
        parentSchema.properties.quantile.properties.value.properties.minimum.type
      1                                                           number, integer
        parentSchema.properties.quantile.properties.value.properties.maximum.description
      1                           The maximum inclusive valid quantile value (optional).
        parentSchema.properties.quantile.properties.value.properties.maximum.type
      1                                                           number, integer
        parentSchema.properties.quantile.properties.value.required
      1                                                       type
        parentSchema.properties.quantile.required
      1                     output_type_id, value
                                                                 parentSchema.properties.cdf.description
      1 Object defining the cumulative distribution function of the predictive distribution output type.
        parentSchema.properties.cdf.type
      1                           object
                                                                                                                                              parentSchema.properties.cdf.properties.output_type_id.description
      1 Object containing required and optional arrays defining possible values of the target variable at which values of the cumulative distribution function of the predictive distribution will be recorded.
                                        parentSchema.properties.cdf.properties.output_type_id.examples
      1 10, 20, EW202240, EW202241, EW202242, EW202243, EW202244, EW202245, EW202246, EW202247, NA, NA
        parentSchema.properties.cdf.properties.output_type_id.type
      1                                                     object
                                                                                                                  parentSchema.properties.cdf.properties.output_type_id.properties.required.description
      1 Array of unique target values that must be present for submission to be valid. Can be null if no target values are required and all valid target values are specified in the optional property.
        parentSchema.properties.cdf.properties.output_type_id.properties.required.type
      1                                                                    array, null
        parentSchema.properties.cdf.properties.output_type_id.properties.required.uniqueItems
      1                                                                                  TRUE
        parentSchema.properties.cdf.properties.output_type_id.properties.required.oneOf
      1                   number, integer, string, 0, NA, NA, ^EW[0-9]{6}, NA, 8, NA, 8
                                                                  parentSchema.properties.cdf.properties.output_type_id.properties.optional.description
      1 Array of valid but not required unique target values. Can be null if all target values are required and are specified in the required property.
        parentSchema.properties.cdf.properties.output_type_id.properties.optional.type
      1                                                                    array, null
        parentSchema.properties.cdf.properties.output_type_id.properties.optional.uniqueItems
      1                                                                                  TRUE
        parentSchema.properties.cdf.properties.output_type_id.properties.optional.oneOf
      1                   number, integer, string, 0, NA, NA, ^EW[0-9]{6}, NA, 8, NA, 8
        parentSchema.properties.cdf.properties.output_type_id.required
      1                                             required, optional
        parentSchema.properties.cdf.properties.value.type
      1                                            object
                                                                    parentSchema.properties.cdf.properties.value.description
      1 Object defining the characteristics of valid values of the cumulative distribution function at a given target value.
        parentSchema.properties.cdf.properties.value.properties.type.description
      1                    Data type of cumulative distribution function values.
        parentSchema.properties.cdf.properties.value.properties.type.examples
      1                                                                double
        parentSchema.properties.cdf.properties.value.properties.type.const
      1                                                             double
           parentSchema.properties.cdf.properties.value.properties.minimum.description
      1 The minimum inclusive valid cumulative distribution function value. Must be 0.
        parentSchema.properties.cdf.properties.value.properties.minimum.const
      1                                                                     0
           parentSchema.properties.cdf.properties.value.properties.maximum.description
      1 The maximum inclusive valid cumulative distribution function value. Must be 1.
        parentSchema.properties.cdf.properties.value.properties.maximum.const
      1                                                                     1
        parentSchema.properties.cdf.properties.value.required
      1                                type, minimum, maximum
        parentSchema.properties.cdf.required
      1                output_type_id, value
                                                                                                      parentSchema.properties.pmf.description
      1 Object defining a probability mass function for a discrete variable output type. Includes nominal, binary and ordinal variable types.
        parentSchema.properties.pmf.type
      1                           object
                                         parentSchema.properties.pmf.properties.output_type_id.description
      1 Object containing required and optional arrays specifying valid categories of a discrete variable.
        parentSchema.properties.pmf.properties.output_type_id.examples
      1                               NA, low, moderate, high, extreme
        parentSchema.properties.pmf.properties.output_type_id.type
      1                                                     object
                                                                                                                                parentSchema.properties.pmf.properties.output_type_id.properties.required.description
      1 Array of unique categories of a discrete variable that must be present for submission to be valid. Can be null if no categories are required and all valid categories are specified in the optional property.
        parentSchema.properties.pmf.properties.output_type_id.properties.required.type
      1                                                                    array, null
        parentSchema.properties.pmf.properties.output_type_id.properties.required.uniqueItems
      1                                                                                  TRUE
        parentSchema.properties.pmf.properties.output_type_id.properties.required.type
      1                                                                         string
                                                                                   parentSchema.properties.pmf.properties.output_type_id.properties.optional.description
      1 Array of valid but not required unique categories of a discrete variable. Can be null if all categories are required and are specified in the required property.
        parentSchema.properties.pmf.properties.output_type_id.properties.optional.type
      1                                                                    array, null
        parentSchema.properties.pmf.properties.output_type_id.properties.optional.uniqueItems
      1                                                                                  TRUE
        parentSchema.properties.pmf.properties.output_type_id.properties.optional.type
      1                                                                         string
        parentSchema.properties.pmf.properties.output_type_id.required
      1                                             required, optional
        parentSchema.properties.pmf.properties.value.type
      1                                            object
                                                                                                 parentSchema.properties.pmf.properties.value.description
      1 Object defining valid values of the probability mass function of the predictive distribution for a given category of a discrete outcome variable.
        parentSchema.properties.pmf.properties.value.examples
      1                                          double, 0, 1
        parentSchema.properties.pmf.properties.value.properties.type.description
      1                       Data type of the probability mass function values.
        parentSchema.properties.pmf.properties.value.properties.type.const
      1                                                             double
        parentSchema.properties.pmf.properties.value.properties.minimum.description
      1     The minimum inclusive valid probability mass function value. Must be 0.
        parentSchema.properties.pmf.properties.value.properties.minimum.const
      1                                                                     0
        parentSchema.properties.pmf.properties.value.properties.maximum.description
      1     The maximum inclusive valid probability mass function value. Must be 1.
        parentSchema.properties.pmf.properties.value.properties.maximum.const
      1                                                                     1
        parentSchema.properties.pmf.properties.value.required
      1                                type, minimum, maximum
        parentSchema.properties.pmf.required
      1                output_type_id, value
        parentSchema.properties.sample.description
      1      Object defining a sample output type.
        parentSchema.properties.sample.type
      1                              object
                  parentSchema.properties.sample.properties.output_type_id.description
      1 Object containing required and optional arrays specifying valid sample values.
        parentSchema.properties.sample.properties.output_type_id.examples
      1                 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
        parentSchema.properties.sample.properties.output_type_id.type
      1                                                        object
                                                                                                                  parentSchema.properties.sample.properties.output_type_id.properties.required.description
      1 Array of unique sample indexes that must be present for submission to be valid. Can be null if no sample indexes are required and all valid sample indexes are specified in the optional property.
        parentSchema.properties.sample.properties.output_type_id.properties.required.type
      1                                                                       array, null
        parentSchema.properties.sample.properties.output_type_id.properties.required.uniqueItems
      1                                                                                     TRUE
        parentSchema.properties.sample.properties.output_type_id.properties.required.items.type
      1                                                                                 integer
        parentSchema.properties.sample.properties.output_type_id.properties.required.items.minimum
      1                                                                                          1
                                                                 parentSchema.properties.sample.properties.output_type_id.properties.optional.description
      1 Array of valid but not required unique sample indexes. Can be null if all sample indexes are required and are specified in the required property.
        parentSchema.properties.sample.properties.output_type_id.properties.optional.type
      1                                                                       array, null
        parentSchema.properties.sample.properties.output_type_id.properties.optional.uniqueItems
      1                                                                                     TRUE
        parentSchema.properties.sample.properties.output_type_id.properties.optional.items.type
      1                                                                                 integer
        parentSchema.properties.sample.properties.output_type_id.properties.optional.items.minimum
      1                                                                                          1
        parentSchema.properties.sample.properties.output_type_id.required
      1                                                required, optional
        parentSchema.properties.sample.properties.value.type
      1                                               object
                                                                                                                                                                                                                                                                                                  parentSchema.properties.sample.properties.value.description
      1 Object defining valid values of samples from the predictive distribution for a given sample index.  Depending on the Hub specification, samples with the same sample index (specified by the output_type_id) may be assumed to correspond to a joint distribution across multiple levels of the task id variables. See Hub documentation for details.
        parentSchema.properties.sample.properties.value.properties.type.description
      1                 Data type of sample value from the predictive distribution.
        parentSchema.properties.sample.properties.value.properties.type.examples
      1                                                                   double
        parentSchema.properties.sample.properties.value.properties.type.type
      1                                                               string
        parentSchema.properties.sample.properties.value.properties.type.enum
      1                                                      double, integer
           parentSchema.properties.sample.properties.value.properties.description
      1 The minimum inclusive valid sample value from the predictive distribution
           parentSchema.properties.sample.properties.value.properties.description
      1 The maximum inclusive valid sample value from the predictive distribution
        parentSchema.properties.sample.properties.value.required
      1                                                     type
        parentSchema.properties.sample.required parentSchema.additionalProperties
      1                   output_type_id, value                             FALSE
        data.mean.output_type_id.required data.mean.output_type_id.optional
      1                                NA                                NA
        data.mean.value.type data.mean.value.minimum
      1              integer                       0
                                                                                                                                  data.quantile.output_type_id.required
      1 0.010, 0.025, 0.050, 0.100, 0.150, 0.200, 0.250, 0.300, 0.350, 0.400, 0.450, 0.500, 0.550, 0.600, 0.650, 0.700, 0.750, 0.800, 0.850, 0.900, 0.950, 0.975, 0.990
        data.quantile.output_type_id.optional data.quantile.value.type
      1                                    NA                  integer
        data.quantile.value.minimum
      1                           0
                                                                                                                                                                              data.target_metadata
      1 inc flu hosp, daily incident influenza hospitalizations, count, inc flu hosp, This target represents a count of the number of new hospitalizations per day in a given location., TRUE, day
                                   dataPath
      1 /rounds/0/model_tasks/0/output_type

# Duplicate values in individual array error successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 2 schema errors: testdata/dup-in-array.json
        (<file://testdata/dup-in-array.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out, "errors")
    Output
                                                                instancePath
      1                /rounds/1/model_tasks/0/task_ids/origin_date/optional
      2 /rounds/1/model_tasks/0/output_type/quantile/output_type_id/required
                                                                                                                                                         schemaPath
      1                           #/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/origin_date/properties/optional/uniqueItems
      2 #/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/quantile/properties/output_type_id/properties/required/uniqueItems
            keyword params.i params.j
      1 uniqueItems        2        3
      2 uniqueItems       15       16
                                                                 message schema
      1   must NOT have duplicate items (items ## 3 and 2 are identical)   TRUE
      2 must NOT have duplicate items (items ## 16 and 15 are identical)   TRUE
                                                                                                                                                                                                              parentSchema.description
      1                                                                       Array of valid but not required unique origin date identifiers. Can be null if all origin dates are required and are specified in the required property.
      2 Array of unique probability levels between 0 and 1 that must be present for submission to be valid. Can be null if no probability levels are required and all valid probability levels are specified in the optional property.
        parentSchema.type parentSchema.uniqueItems parentSchema.items.type
      1       array, null                     TRUE                  string
      2       array, null                     TRUE                  number
        parentSchema.items.format parentSchema.items.minimum
      1                      date                         NA
      2                      <NA>                          0
        parentSchema.items.maximum
      1                         NA
      2                          1
                                                                                                                                                                                 data
      1                                                                                                                                2022-10-15, 2022-10-22, 2022-10-29, 2022-10-29
      2 0.010, 0.025, 0.050, 0.050, 0.100, 0.150, 0.200, 0.250, 0.300, 0.350, 0.400, 0.450, 0.500, 0.550, 0.600, 0.650, 0.650, 0.700, 0.750, 0.800, 0.850, 0.900, 0.950, 0.975, 0.990
                                                                    dataPath
      1                /rounds/1/model_tasks/0/task_ids/origin_date/optional
      2 /rounds/1/model_tasks/0/output_type/quantile/output_type_id/required

# Duplicate values across property error successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 3 schema errors: testdata/dup-in-property.json
        (<file://testdata/dup-in-property.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out, "errors")
    Output
                                        instancePath
      1     /rounds/0/model_tasks/0/task_ids/horizon
      2   /rounds/1/model_tasks/0/task_ids/age_group
      3 /rounds/1/model_tasks/0/output_type/quantile
                                                                                               schemaPath
      1     #/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/horizon
      2   #/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/age_group
      3 #/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/quantile
                        keyword
      1    task_ids uniqueItems
      2    task_ids uniqueItems
      3 output_type uniqueItems
                                                                                                                                          message
      1                         must NOT have duplicate items across 'required' and 'optional' properties. Task ID 'horizon' contains duplicates.
      2                       must NOT have duplicate items across 'required' and 'optional' properties. Task ID 'age_group' contains duplicates.
      3 must NOT have duplicate items across 'required' and 'optional' properties. Output type IDs of output type 'quantile' contains duplicates.
        schema                   data
      1           duplicate values: 2
      2         duplicate values: 65+
      3        duplicate values: 0.99

# Inconsistent round ID variables across model tasks error successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 2 schema errors: testdata/round-id-inconsistent.json
        (<file://testdata/round-id-inconsistent.json>) (via tasks-schema v1.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v1.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out, "errors")
    Output
                                          instancePath schemaPath      keyword
      1 /rounds/0/model_tasks/1/task_ids/forecast_date         NA round_id var
      2 /rounds/0/model_tasks/1/task_ids/forecast_date         NA round_id var
                                                                                    message
      1 round_id var 'forecast_date' property MUST be consistent across modeling task items
      2 round_id var 'forecast_date' property MUST be consistent across modeling task items
        schema
      1       
      2       
                                                                                                                data
      1 Component "optional": Lengths (23, 22) differ (string compare on first 22) compared to first model task item
      2                                    Component "optional": 1 string mismatch compared to first model task item

---

    Code
      out
    Output
      [1] FALSE
    Message
      ! 2 schema errors: testdata/round-id-inconsistent2.json
        (<file://testdata/round-id-inconsistent2.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out, "errors")
    Output
                                          instancePath
      1 /rounds/0/model_tasks/1/task_ids/forecast_date
      2 /rounds/0/model_tasks/1/task_ids/forecast_date
                                                                                                 schemaPath
      1 #/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/forecast_date
      2 #/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/forecast_date
             keyword
      1 round_id var
      2 round_id var
                                                                                    message
      1 round_id var 'forecast_date' property MUST be consistent across modeling task items
      2 round_id var 'forecast_date' property MUST be consistent across modeling task items
        schema
      1       
      2       
                                                                                                                data
      1 Component "optional": Lengths (23, 22) differ (string compare on first 22) compared to first model task item
      2                                    Component "optional": 1 string mismatch compared to first model task item

# Duplicate round ID values across rounds error successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 5 schema errors: testdata/dup-in-round-id.json
        (<file://testdata/dup-in-round-id.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out, "errors")
    Output
                                        instancePath
      1 /rounds/1/model_tasks/0/task_ids/origin_date
      2 /rounds/1/model_tasks/0/task_ids/origin_date
      3 /rounds/2/model_tasks/0/task_ids/origin_date
      4 /rounds/2/model_tasks/0/task_ids/origin_date
      5 /rounds/2/model_tasks/0/task_ids/origin_date
                                                                                               schemaPath
      1 #/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/origin_date
      2 #/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/origin_date
      3 #/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/origin_date
      4 #/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/origin_date
      5 #/properties/rounds/items/properties/model_tasks/items/properties/task_ids/properties/origin_date
                     keyword
      1 round_id uniqueItems
      2 round_id uniqueItems
      3 round_id uniqueItems
      4 round_id uniqueItems
      5 round_id uniqueItems
                                                          message schema
      1 must NOT contains duplicate round ID values across rounds       
      2 must NOT contains duplicate round ID values across rounds       
      3 must NOT contains duplicate round ID values across rounds       
      4 must NOT contains duplicate round ID values across rounds       
      5 must NOT contains duplicate round ID values across rounds       
                               data
      1 duplicate value: 2022-10-08
      2 duplicate value: 2022-10-15
      3 duplicate value: 2022-10-15
      4 duplicate value: 2022-10-22
      5 duplicate value: 2022-10-29

# All null task IDs error successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 1 schema errors: testdata/both_null_tasks_all.json
        (<file://testdata/both_null_tasks_all.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out, "errors")
    Output
                                    instancePath
      1 /rounds/*/model_tasks/*/task_ids/horizon
                                                                        schemaPath
      1 #/properties/rounds/items/properties/model_tasks/items/properties/task_ids
               keyword                                                      message
      1 task_id values task_id values cannot all be null across all modeling tasks.
        schema data
      1        null

# Old orgname config validates successfully

    Code
      out
    Output
      [1] TRUE
    Message
      v ok:  testdata/task-old-orgname.json (<file://testdata/task-old-orgname.json>) (via tasks-schema v2.0.0 (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))

---

    Code
      attr(out, "errors")
    Output
      NULL

# target keys error if arrays passed

    Code
      out_v4
    Output
      [1] FALSE
    Message
      ! 1 schema errors: testdata/tasks-target-key-array-v4.json
        (<file://testdata/tasks-target-key-array-v4.json>) (via tasks-schema v4.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/br-v4.0.0/v4.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view table of error details.

---

    Code
      attr(out_v4, "errors")
    Output
                                                        instancePath
      1 /rounds/0/model_tasks/0/target_metadata/0/target_keys/target
                                                                                                                                      schemaPath
      1 #/properties/rounds/items/properties/model_tasks/items/properties/target_metadata/items/properties/target_keys/additionalProperties/type
        keyword   type        message schema   type                      data
      1    type string must be string string string wk flu hosp rate category
                                                            dataPath
      1 /rounds/0/model_tasks/0/target_metadata/0/target_keys/target

---

    Code
      attr(out_v3, "errors")
    Output
                                                  instancePath
      1 /rounds/0/model_tasks/0/output_type/pmf/output_type_id
                                                                                                                             schemaPath
      1 #/properties/rounds/items/properties/model_tasks/items/properties/output_type/properties/pmf/properties/output_type_id/required
         keyword missingProperty                                message
      1 required        optional must have required property 'optional'
                    schema
      1 required, optional
                                                                                                                                                                                   parentSchema.description
      1 Object containing required and optional arrays specifying valid categories of a discrete variable. Note that for ordinal variables, the category levels should be listed in order from low to high.
                   parentSchema.examples parentSchema.type
      1 NA, low, moderate, high, extreme            object
                                                                                                                                                                         parentSchema.properties.required.description
      1 Array of unique categories of a discrete variable that must be present for submission to be valid. Can be null if no categories are required and all valid categories are specified in the optional property.
        parentSchema.properties.required.type
      1                           array, null
        parentSchema.properties.required.uniqueItems
      1                                         TRUE
        parentSchema.properties.required.type
      1                                string
                                                                                                                            parentSchema.properties.optional.description
      1 Array of valid but not required unique categories of a discrete variable. Can be null if all categories are required and are specified in the required property.
        parentSchema.properties.optional.type
      1                           array, null
        parentSchema.properties.optional.uniqueItems
      1                                         TRUE
        parentSchema.properties.optional.type parentSchema.required
      1                                string    required, optional
                              required
      1 low, moderate, high, very high
                                                      dataPath
      1 /rounds/0/model_tasks/0/output_type/pmf/output_type_id

# v4 validation works

    Code
      extract_error_tbl_cols(v4_fail)
    Output
      # A tibble: 6 x 1
        message                                  
        <chr>                                    
      1 must NOT have additional properties      
      2 must NOT have additional properties      
      3 must have required property 'is_required'
      4 must be null                             
      5 must have required property 'is_required'
      6 must NOT have additional properties      

---

    Code
      extract_error_tbl_cols(v4_fail_dynamic, c("message", "data"))
    Output
      # A tibble: 3 x 2
        message                                                                data   
        <chr>                                                                  <chr>  
      1 derived_task_ids values MUST MATCH valid round task_id variable names  target~
      2 derived_task_ids values MUST MATCH valid config task_id variable names random~
      3 derived_task_ids MUST NOT contain required values.                     target~

