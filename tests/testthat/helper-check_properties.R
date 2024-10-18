create_example_properties <- function() {
    list(
        round_id_from_variable = TRUE, round_id = "origin_date",
        model_tasks = list(list(
            task_ids = list(origin_date = list(
                required = NULL, optional = c(
                    "2023-01-02", "2023-01-09",
                    "2023-01-16"
                )
            ), location = list(required = "US", optional = c(
                "01",
                "02", "04", "05", "06"
            )), horizon = list(required = 1L, optional = 2:4)),
            output_type = list(mean = list(output_type_id = list(
                required = NA_character_, optional = NULL
            ), value = list(
                type = "double", minimum = 0L
            ))), target_metadata = list(
                list(
                    target_id = "inc hosp", target_name = "Weekly incident influenza hospitalizations",
                    target_units = "rate per 100,000 population",
                    target_keys = NULL, target_type = "discrete",
                    is_step_ahead = TRUE, time_unit = "week"
                )
            )
        )),
        submissions_due = list(
            relative_to = "origin_date", start = -4L,
            end = 2L
        ), derived_task_ids = "location"
    )
}
