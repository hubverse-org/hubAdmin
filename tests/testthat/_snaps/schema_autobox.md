# schema autobox boxes length 1L vectors correctly

    Code
      waldo::compare(config, schema_autobox(config))
    Output
      `old$rounds[[1]]$model_tasks[[1]]$task_ids$location$required` is a character vector ('US')
      `new$rounds[[1]]$model_tasks[[1]]$task_ids$location$required` is a list
      
      `old$rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required` is an integer vector (1)
      `new$rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required` is a list
      
      `old$rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required` is a character vector (NA)
      `new$rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required` is a list

---

    Code
      jsonlite::toJSON(schema_autobox(config), auto_unbox = TRUE, na = "string",
      null = "null", pretty = TRUE)
    Output
      {
        "schema_version": "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json",
        "rounds": [
          {
            "round_id_from_variable": true,
            "round_id": "origin_date",
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
                  }
                },
                "output_type": {
                  "mean": {
                    "output_type_id": {
                      "required": [
                        "NA"
                      ],
                      "optional": null
                    },
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
                    "target_keys": null,
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
        ]
      } 

---

    Code
      waldo::compare(jsonlite::toJSON(config$rounds[[1]]$model_tasks[[1]]$task_ids$
        location$required, auto_unbox = TRUE, na = "string", null = "null", pretty = TRUE),
      jsonlite::toJSON(schema_autobox(config)$rounds[[1]]$model_tasks[[1]]$task_ids$
        location$required, auto_unbox = TRUE, na = "string", null = "null", pretty = TRUE))
    Output
      `lines(old)`: "\"US\""               
      `lines(new)`: "["      "  \"US\"" "]"

---

    Code
      waldo::compare(jsonlite::toJSON(config$rounds[[1]]$model_tasks[[1]]$task_ids$
        horizon$required, auto_unbox = TRUE, na = "string", null = "null", pretty = TRUE),
      jsonlite::toJSON(schema_autobox(config)$rounds[[1]]$model_tasks[[1]]$task_ids$
        horizon$required, auto_unbox = TRUE, na = "string", null = "null", pretty = TRUE))
    Output
      `lines(old)`: "1"          
      `lines(new)`: "[" "  1" "]"

---

    Code
      waldo::compare(jsonlite::toJSON(config$rounds[[1]]$model_tasks[[1]]$output_type$
        mean$output_type_id$required, auto_unbox = TRUE, na = "string", null = "null",
      pretty = TRUE), jsonlite::toJSON(schema_autobox(config)$rounds[[1]]$
      model_tasks[[1]]$output_type$mean$output_type_id$required, auto_unbox = TRUE,
      na = "string", null = "null", pretty = TRUE))
    Output
      `lines(old)`: "\"NA\""               
      `lines(new)`: "["      "  \"NA\"" "]"

# get_array_paths identifies potential arrays correctly

    Code
      get_array_paths(schema)
    Output
      [[1]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "origin_date" "required"   
      
      [[2]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "origin_date" "optional"   
      
      [[3]]
      [1] "rounds"        "items"         "model_tasks"   "items"        
      [5] "task_ids"      "forecast_date" "required"     
      
      [[4]]
      [1] "rounds"        "items"         "model_tasks"   "items"        
      [5] "task_ids"      "forecast_date" "optional"     
      
      [[5]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "scenario_id" "required"   
      
      [[6]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "scenario_id" "optional"   
      
      [[7]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "location"    "required"   
      
      [[8]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "location"    "optional"   
      
      [[9]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "target"      "required"   
      
      [[10]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "target"      "optional"   
      
      [[11]]
      [1] "rounds"          "items"           "model_tasks"     "items"          
      [5] "task_ids"        "target_variable" "required"       
      
      [[12]]
      [1] "rounds"          "items"           "model_tasks"     "items"          
      [5] "task_ids"        "target_variable" "optional"       
      
      [[13]]
      [1] "rounds"         "items"          "model_tasks"    "items"         
      [5] "task_ids"       "target_outcome" "required"      
      
      [[14]]
      [1] "rounds"         "items"          "model_tasks"    "items"         
      [5] "task_ids"       "target_outcome" "optional"      
      
      [[15]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "target_date" "required"   
      
      [[16]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "target_date" "optional"   
      
      [[17]]
      [1] "rounds"          "items"           "model_tasks"     "items"          
      [5] "task_ids"        "target_end_date" "required"       
      
      [[18]]
      [1] "rounds"          "items"           "model_tasks"     "items"          
      [5] "task_ids"        "target_end_date" "optional"       
      
      [[19]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "horizon"     "required"   
      
      [[20]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "horizon"     "optional"   
      
      [[21]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "age_group"   "required"   
      
      [[22]]
      [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
      [6] "age_group"   "optional"   
      
      [[23]]
      [1] "rounds"               "items"                "model_tasks"         
      [4] "items"                "task_ids"             "additionalProperties"
      [7] "required"            
      
      [[24]]
      [1] "rounds"               "items"                "model_tasks"         
      [4] "items"                "task_ids"             "additionalProperties"
      [7] "optional"            
      
      [[25]]
      [1] "rounds"         "items"          "model_tasks"    "items"         
      [5] "output_type"    "mean"           "output_type_id" "required"      
      
      [[26]]
      [1] "rounds"         "items"          "model_tasks"    "items"         
      [5] "output_type"    "mean"           "output_type_id" "optional"      
      
      [[27]]
      [1] "rounds"         "items"          "model_tasks"    "items"         
      [5] "output_type"    "median"         "output_type_id" "required"      
      
      [[28]]
      [1] "rounds"         "items"          "model_tasks"    "items"         
      [5] "output_type"    "median"         "output_type_id" "optional"      
      
      [[29]]
      [1] "rounds"         "items"          "model_tasks"    "items"         
      [5] "output_type"    "quantile"       "output_type_id" "required"      
      
      [[30]]
      [1] "rounds"         "items"          "model_tasks"    "items"         
      [5] "output_type"    "quantile"       "output_type_id" "optional"      
      
      [[31]]
      [1] "rounds"         "items"          "model_tasks"    "items"         
      [5] "output_type"    "cdf"            "output_type_id" "required"      
      
      [[32]]
      [1] "rounds"         "items"          "model_tasks"    "items"         
      [5] "output_type"    "cdf"            "output_type_id" "optional"      
      
      [[33]]
      [1] "rounds"         "items"          "model_tasks"    "items"         
      [5] "output_type"    "pmf"            "output_type_id" "required"      
      
      [[34]]
      [1] "rounds"         "items"          "model_tasks"    "items"         
      [5] "output_type"    "pmf"            "output_type_id" "optional"      
      
      [[35]]
      [1] "rounds"                "items"                 "model_tasks"          
      [4] "items"                 "output_type"           "sample"               
      [7] "output_type_id_params" "compound_taskid_set"  
      
      [[36]]
      [1] "rounds"      "items"       "file_format"
      

