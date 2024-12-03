# create_config functions work correctly

    Code
      create_config(rounds)
    Output
      $schema_version
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
      
      $rounds
      $rounds[[1]]
      $rounds[[1]]$round_id_from_variable
      [1] TRUE
      
      $rounds[[1]]$round_id
      [1] "origin_date"
      
      $rounds[[1]]$model_tasks
      $rounds[[1]]$model_tasks[[1]]
      $rounds[[1]]$model_tasks[[1]]$task_ids
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$optional
      [1] "2023-01-02" "2023-01-09" "2023-01-16"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$required
      [1] "US"
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
      [1] "01" "02" "04" "05" "06"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
      [1] 1
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type
      $rounds[[1]]$model_tasks[[1]]$output_type$mean
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required
      NULL
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$is_required
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$type
      [1] "double"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "inc hosp"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "discrete"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $rounds[[1]]$submissions_due
      $rounds[[1]]$submissions_due$relative_to
      [1] "origin_date"
      
      $rounds[[1]]$submissions_due$start
      [1] -4
      
      $rounds[[1]]$submissions_due$end
      [1] 2
      
      
      
      
      attr(,"class")
      [1] "config" "list"  
      attr(,"type")
      [1] "tasks"
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
      attr(,"branch")
      [1] "main"

# create_config functions error correctly

    Code
      create_config(list(a = 10))
    Condition
      Error in `create_config()`:
      x `rounds` must inherit from class <rounds> but does not

# create_config handles output_type_id_datatype correctly 

    Code
      create_config(test_rounds, output_type_id_datatype = "character")
    Output
      $schema_version
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      
      $rounds
      $rounds[[1]]
      $rounds[[1]]$round_id_from_variable
      [1] TRUE
      
      $rounds[[1]]$round_id
      [1] "origin_date"
      
      $rounds[[1]]$model_tasks
      $rounds[[1]]$model_tasks[[1]]
      $rounds[[1]]$model_tasks[[1]]$task_ids
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$optional
      [1] "2023-01-02" "2023-01-09" "2023-01-16"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$required
      [1] "US"
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
      [1] "01" "02" "04" "05" "06"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
      [1] 1
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type
      $rounds[[1]]$model_tasks[[1]]$output_type$mean
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required
      [1] NA
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$optional
      NULL
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$type
      [1] "double"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "inc hosp"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "discrete"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $rounds[[1]]$submissions_due
      $rounds[[1]]$submissions_due$relative_to
      [1] "origin_date"
      
      $rounds[[1]]$submissions_due$start
      [1] -4
      
      $rounds[[1]]$submissions_due$end
      [1] 2
      
      
      
      
      $output_type_id_datatype
      [1] "character"
      
      attr(,"class")
      [1] "config" "list"  
      attr(,"type")
      [1] "tasks"
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      attr(,"branch")
      [1] "main"

---

    Code
      create_config(test_rounds_old, output_type_id_datatype = "character")
    Message
      ! `output_type_id_datatype` not avalaible in
      schema versions < "v3.0.1"
    Output
      $schema_version
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json"
      
      $rounds
      $rounds[[1]]
      $rounds[[1]]$round_id_from_variable
      [1] TRUE
      
      $rounds[[1]]$round_id
      [1] "origin_date"
      
      $rounds[[1]]$model_tasks
      $rounds[[1]]$model_tasks[[1]]
      $rounds[[1]]$model_tasks[[1]]$task_ids
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$optional
      [1] "2023-01-02" "2023-01-09" "2023-01-16"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$required
      [1] "US"
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
      [1] "01" "02" "04" "05" "06"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
      [1] 1
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type
      $rounds[[1]]$model_tasks[[1]]$output_type$mean
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required
      [1] NA
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$optional
      NULL
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$type
      [1] "double"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "inc hosp"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "discrete"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $rounds[[1]]$submissions_due
      $rounds[[1]]$submissions_due$relative_to
      [1] "origin_date"
      
      $rounds[[1]]$submissions_due$start
      [1] -4
      
      $rounds[[1]]$submissions_due$end
      [1] 2
      
      
      
      
      attr(,"class")
      [1] "config" "list"  
      attr(,"type")
      [1] "tasks"
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json"
      attr(,"branch")
      [1] "main"

# create_config derived_task_ids argument

    Code
      create_config(create_rounds(create_derived_task_ids_round(version = "v4.0.0")),
      derived_task_ids = "location")
    Output
      $schema_version
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
      
      $rounds
      $rounds[[1]]
      $rounds[[1]]$round_id_from_variable
      [1] TRUE
      
      $rounds[[1]]$round_id
      [1] "origin_date"
      
      $rounds[[1]]$model_tasks
      $rounds[[1]]$model_tasks[[1]]
      $rounds[[1]]$model_tasks[[1]]$task_ids
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$required
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$origin_date$optional
      [1] "2023-01-02" "2023-01-09" "2023-01-16"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$required
      [1] "US"
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$location$optional
      [1] "01" "02" "04" "05" "06"
      
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$required
      [1] 1
      
      $rounds[[1]]$model_tasks[[1]]$task_ids$horizon$optional
      [1] 2 3 4
      
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type
      $rounds[[1]]$model_tasks[[1]]$output_type$mean
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$output_type_id$required
      NULL
      
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$is_required
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$type
      [1] "double"
      
      $rounds[[1]]$model_tasks[[1]]$output_type$mean$value$minimum
      [1] 0
      
      
      
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_id
      [1] "inc hosp"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_name
      [1] "Weekly incident influenza hospitalizations"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_units
      [1] "rate per 100,000 population"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_keys
      NULL
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$target_type
      [1] "discrete"
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$is_step_ahead
      [1] TRUE
      
      $rounds[[1]]$model_tasks[[1]]$target_metadata[[1]]$time_unit
      [1] "week"
      
      
      
      
      
      $rounds[[1]]$submissions_due
      $rounds[[1]]$submissions_due$relative_to
      [1] "origin_date"
      
      $rounds[[1]]$submissions_due$start
      [1] -4
      
      $rounds[[1]]$submissions_due$end
      [1] 2
      
      
      
      
      $derived_task_ids
      [1] "location"
      
      attr(,"class")
      [1] "config" "list"  
      attr(,"type")
      [1] "tasks"
      attr(,"schema_id")
      [1] "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json"
      attr(,"branch")
      [1] "main"

---

    Code
      waldo::compare(create_config(create_rounds(create_derived_task_ids_round(
        version = "v4.0.0")), derived_task_ids = "location"), create_config(
        create_rounds(create_derived_task_ids_round(version = "v4.0.0")),
        derived_task_ids = NULL))
    Output
      `old` is length 3
      `new` is length 2
      
      `names(old)`: "schema_version" "rounds" "derived_task_ids"
      `names(new)`: "schema_version" "rounds"                   
      
      `old$derived_task_ids` is a character vector ('location')
      `new$derived_task_ids` is absent

---

    Code
      create_config(create_rounds(create_derived_task_ids_round(version = "v4.0.0")),
      derived_task_ids = 1L)
    Condition
      Error in `create_config()`:
      x `derived_task_ids` value 1 is not valid `task_id` variable in the provided `rounds` object.
      i Valid `task_id` variables are: "origin_date", "location", and "horizon"

---

    Code
      create_config(create_rounds(create_derived_task_ids_round(version = "v4.0.0")),
      derived_task_ids = "random_task_id")
    Condition
      Error in `create_config()`:
      x `derived_task_ids` value "random_task_id" is not valid `task_id` variable in the provided `rounds` object.
      i Valid `task_id` variables are: "origin_date", "location", and "horizon"

