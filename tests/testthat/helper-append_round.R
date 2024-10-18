create_new_round <- function(round_id = "2024-09-18") {
  structure(
    list(
      round_id_from_variable = TRUE, round_id = "nowcast_date",
      model_tasks = list(list(task_ids = list(
        nowcast_date = list(
          required = round_id, optional = NULL
        ), target_date = list(
          required = NULL, optional = c(
            "2024-09-11", "2024-09-04",
            "2024-08-28", "2024-08-21"
          )
        ), location = list(
          required = NULL,
          optional = c(
            "AL", "AK", "AZ", "AR", "CA", "CO", "CT",
            "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA",
            "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS",
            "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC",
            "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN",
            "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY", "PR"
          )
        ),
        variant = list(required = c(
          "24A", "24B", "24C", "other",
          "recombinant"
        ), optional = NULL)
      ), output_type = list(
        sample = list(output_type_id_params = list(
          is_required = FALSE,
          type = "character", max_length = 15L, min_samples_per_task = 1L,
          max_samples_per_task = 500L
        ), value = list(
          type = "double",
          minimum = 0L, maximum = 1L
        ))
      ), target_metadata = list(
        list(
          target_id = "variant prop", target_name = "Weekly nowcasted variant proportions",
          target_units = "proportion", target_keys = NULL,
          target_type = "compositional", is_step_ahead = TRUE,
          time_unit = "week"
        )
      ))), submissions_due = list(
        relative_to = "nowcast_date",
        start = -7L, end = 1L
      )
    ),
    class = c("round", "list"),
    round_id = "nowcast_date",
    branch = "main",
    schema_id = "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
  )
}
