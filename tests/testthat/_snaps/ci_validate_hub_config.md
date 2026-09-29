# ci_validate_hub creates message of success

    Code
      writeLines(diff1)
    Output
      :white_check_mark: Hub correctly configured!
      
      NOW 

---

    Code
      writeLines(diff2)
    Output
      :white_check_mark: Hub correctly configured!
      
      LATER 

# ci_validate_hub creates message of failure

    Code
      writeLines(diff1)
    Output
      ## :x: Invalid Configuration
      
      Errors were detected in one or more config files in `hub-config/`. Details about the exact locations of the errors can be found in the table below.
      
      <p>Report for directory <code><tmp>/error_hub/hub-config</code> using schema version <a href="https://github.com/hubverse-org/schemas/tree/main/v2.0.0"><b>v2.0.0</b></a></p>
      <table>
      <thead>
      <tr><th colspan="3">Error location</th><th colspan="3">Schema details</th><th>Config</th></tr>
      <tr><th>fileName</th><th>instancePath</th><th>schemaPath</th><th>keyword</th><th>message</th><th>schema</th><th>data</th></tr>
      </thead>
      <tbody>
      <tr><td>tasks.json</td><td><strong>rounds</strong><br>└<strong>1</strong><br>└─<strong>model_tasks</strong><br>└──<strong>1</strong></td><td>properties<br>└<strong>rounds</strong><br>└─items<br>└──properties<br>└───<strong>model_tasks</strong><br>└────items<br>└─────<strong>required</strong></td><td>required</td><td>❌ must have required property 'target_metadata'</td><td>task_ids, output_type, target_metadata</td><td>target_metadata</td></tr>
      <tr><td>tasks.json</td><td><strong>rounds</strong><br>└<strong>1</strong><br>└─<strong>model_tasks</strong><br>└──<strong>1</strong><br>└───<strong>task_ids</strong><br>└────<strong>target</strong><br>└─────<strong>required</strong></td><td>properties<br>└<strong>rounds</strong><br>└─items<br>└──properties<br>└───<strong>model_tasks</strong><br>└────items<br>└─────properties<br>└──────<strong>task_ids</strong><br>└───────properties<br>└────────<strong>target</strong><br>└─────────properties<br>└──────────<strong>required</strong><br>└───────────<strong>type</strong></td><td>type</td><td>❌ must be array,null</td><td>array, null</td><td>wk inc flu hosp</td></tr>
      <tr><td>tasks.json</td><td><strong>rounds</strong><br>└<strong>1</strong><br>└─<strong>model_tasks</strong><br>└──<strong>1</strong><br>└───<strong>output_type</strong><br>└────<strong>mean</strong><br>└─────<strong>output_type_id</strong></td><td>properties<br>└<strong>rounds</strong><br>└─items<br>└──properties<br>└───<strong>model_tasks</strong><br>└────items<br>└─────properties<br>└──────<strong>output_type</strong><br>└───────properties<br>└────────<strong>mean</strong><br>└─────────properties<br>└──────────<strong>output_type_id</strong><br>└───────────<strong>oneOf</strong></td><td>oneOf</td><td>❌ must match exactly one schema in oneOf</td><td><strong>1</strong><br><strong>required-description:</strong> When mean is required, property set to single element 'NA' array<br><strong>required-type:</strong> array<br><strong>required-items-const:</strong>'NA'<br><strong>required-items-maxItems:</strong> 1<br><strong>optional-description:</strong> When mean is required, property set to null<br><strong>optional-type:</strong> null<br><br><strong>2</strong><br><strong>required-description:</strong> When mean is optional, property set to null<br><strong>required-type:</strong> null<br><strong>optional-description:</strong> When mean is optional, property set to single element 'NA' array<br><strong>optional-type:</strong> array<br><strong>optional-items-const:</strong>'NA'<br><strong>optional-items-maxItems:</strong> 1</td><td>required: NA, optional: NA</td></tr>
      <tr><td>tasks.json</td><td><strong>rounds</strong><br>└<strong>1</strong><br>└─<strong>submissions_due</strong></td><td>properties<br>└<strong>rounds</strong><br>└─items<br>└──properties<br>└───<strong>submissions_due</strong><br>└────<strong>oneOf</strong></td><td>oneOf</td><td>❌ must match exactly one schema in oneOf</td><td><strong>1</strong><br><strong>relative_to-description:</strong> Name of task id variable in relation to which submission start and end dates are calculated.<br><strong>relative_to-type:</strong> string<br><strong>start-description:</strong> Difference in days between start and origin date.<br><strong>start-type:</strong> integer<br><strong>start-format:</strong>'NA'<br><strong>end-description:</strong> Difference in days between end and origin date.<br><strong>end-type:</strong> integer<br><strong>end-format:</strong>'NA'<br><strong>required1:</strong> relative_to<br><strong>required2:</strong> start<br><strong>required3:</strong> end<br><br><strong>2</strong><br><strong>relative_to-description:</strong>'NA'<br><strong>relative_to-type:</strong>'NA'<br><strong>start-description:</strong> Submission start date.<br><strong>start-type:</strong> string<br><strong>start-format:</strong> date<br><strong>end-description:</strong> Submission end date.<br><strong>end-type:</strong> string<br><strong>end-format:</strong> date<br><strong>required1:</strong> start<br><strong>required2:</strong> end</td><td>start: -6, end: 1</td></tr>
      <tr><td>model-metadata-schema.json</td><td></td><td>properties</td><td>required</td><td>❌ must have required properties: either 'model_id' or both 'team_abbr' and 'model_abbr'.</td><td></td><td></td></tr>
      </tbody>
      </table>
      
      For more information, please consult the [**`hubDocs` documentation**](https://docs.hubverse.io/en/latest/).
      NOW 

