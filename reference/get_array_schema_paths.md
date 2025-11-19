# Get potential paths to properties in a config file that can be arrays from a hubverse schema

The functions identifies properties in a hubverse schema that can be
arrays of vectors and returns the paths of such elements in a config.
Properties that can be arrays of objects are ignored. Useful to
determine elements in a config object that may need to be boxed. Note
that any `"items"` elements indicate that the property is an array of
objects and will be expanded with element index when applied to config
objects.

## Usage

``` r
get_array_schema_paths(schema)
```

## Arguments

- schema:

  a list representation of a hubverse schema

## Value

a list where each element is character vector of a path to a property in
the schema that can be an array of vectors. Elements returned as
`"items"`

## Examples

``` r
schema <- download_tasks_schema("v3.0.1")
get_array_schema_paths(schema)
#> [[1]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "origin_date" "required"   
#> 
#> [[2]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "origin_date" "optional"   
#> 
#> [[3]]
#> [1] "rounds"        "items"         "model_tasks"   "items"        
#> [5] "task_ids"      "forecast_date" "required"     
#> 
#> [[4]]
#> [1] "rounds"        "items"         "model_tasks"   "items"        
#> [5] "task_ids"      "forecast_date" "optional"     
#> 
#> [[5]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "scenario_id" "required"   
#> 
#> [[6]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "scenario_id" "optional"   
#> 
#> [[7]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "location"    "required"   
#> 
#> [[8]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "location"    "optional"   
#> 
#> [[9]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "target"      "required"   
#> 
#> [[10]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "target"      "optional"   
#> 
#> [[11]]
#> [1] "rounds"          "items"           "model_tasks"     "items"          
#> [5] "task_ids"        "target_variable" "required"       
#> 
#> [[12]]
#> [1] "rounds"          "items"           "model_tasks"     "items"          
#> [5] "task_ids"        "target_variable" "optional"       
#> 
#> [[13]]
#> [1] "rounds"         "items"          "model_tasks"    "items"         
#> [5] "task_ids"       "target_outcome" "required"      
#> 
#> [[14]]
#> [1] "rounds"         "items"          "model_tasks"    "items"         
#> [5] "task_ids"       "target_outcome" "optional"      
#> 
#> [[15]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "target_date" "required"   
#> 
#> [[16]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "target_date" "optional"   
#> 
#> [[17]]
#> [1] "rounds"          "items"           "model_tasks"     "items"          
#> [5] "task_ids"        "target_end_date" "required"       
#> 
#> [[18]]
#> [1] "rounds"          "items"           "model_tasks"     "items"          
#> [5] "task_ids"        "target_end_date" "optional"       
#> 
#> [[19]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "horizon"     "required"   
#> 
#> [[20]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "horizon"     "optional"   
#> 
#> [[21]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "age_group"   "required"   
#> 
#> [[22]]
#> [1] "rounds"      "items"       "model_tasks" "items"       "task_ids"   
#> [6] "age_group"   "optional"   
#> 
#> [[23]]
#> [1] "rounds"               "items"                "model_tasks"         
#> [4] "items"                "task_ids"             "additionalProperties"
#> [7] "required"            
#> 
#> [[24]]
#> [1] "rounds"               "items"                "model_tasks"         
#> [4] "items"                "task_ids"             "additionalProperties"
#> [7] "optional"            
#> 
#> [[25]]
#> [1] "rounds"         "items"          "model_tasks"    "items"         
#> [5] "output_type"    "mean"           "output_type_id" "required"      
#> 
#> [[26]]
#> [1] "rounds"         "items"          "model_tasks"    "items"         
#> [5] "output_type"    "mean"           "output_type_id" "optional"      
#> 
#> [[27]]
#> [1] "rounds"         "items"          "model_tasks"    "items"         
#> [5] "output_type"    "median"         "output_type_id" "required"      
#> 
#> [[28]]
#> [1] "rounds"         "items"          "model_tasks"    "items"         
#> [5] "output_type"    "median"         "output_type_id" "optional"      
#> 
#> [[29]]
#> [1] "rounds"         "items"          "model_tasks"    "items"         
#> [5] "output_type"    "quantile"       "output_type_id" "required"      
#> 
#> [[30]]
#> [1] "rounds"         "items"          "model_tasks"    "items"         
#> [5] "output_type"    "quantile"       "output_type_id" "optional"      
#> 
#> [[31]]
#> [1] "rounds"         "items"          "model_tasks"    "items"         
#> [5] "output_type"    "cdf"            "output_type_id" "required"      
#> 
#> [[32]]
#> [1] "rounds"         "items"          "model_tasks"    "items"         
#> [5] "output_type"    "cdf"            "output_type_id" "optional"      
#> 
#> [[33]]
#> [1] "rounds"         "items"          "model_tasks"    "items"         
#> [5] "output_type"    "pmf"            "output_type_id" "required"      
#> 
#> [[34]]
#> [1] "rounds"         "items"          "model_tasks"    "items"         
#> [5] "output_type"    "pmf"            "output_type_id" "optional"      
#> 
#> [[35]]
#> [1] "rounds"                "items"                 "model_tasks"          
#> [4] "items"                 "output_type"           "sample"               
#> [7] "output_type_id_params" "compound_taskid_set"  
#> 
#> [[36]]
#> [1] "rounds"      "items"       "file_format"
#> 
```
