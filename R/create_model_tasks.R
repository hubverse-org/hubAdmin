#' Create a `model_tasks` class object.
#'
#' @param ... objects of class `model_tasks` created using function
#' [`create_model_task()`]
#'
#' @return a named list of class `model_tasks`.
#' @export
#' @seealso [create_model_task()]
#'
#' @examples
#' create_model_tasks(
#'   create_model_task(
#'     task_ids = create_task_ids(
#'       create_task_id("origin_date",
#'         required = NULL,
#'         optional = c(
#'           "2023-01-02",
#'           "2023-01-09",
#'           "2023-01-16"
#'         )
#'       ),
#'       create_task_id("location",
#'         required = "US",
#'         optional = c("01", "02", "04", "05", "06")
#'       ),
#'       create_task_id("horizon",
#'         required = 1L,
#'         optional = 2:4
#'       )
#'     ),
#'     output_type = create_output_type(
#'       create_output_type_mean(
#'         is_required = TRUE,
#'         value_type = "double",
#'         value_minimum = 0L
#'       )
#'     ),
#'     target_metadata = create_target_metadata(
#'       create_target_metadata_item(
#'         target_id = "inc hosp",
#'         target_name = "Weekly incident influenza hospitalizations",
#'         target_units = "rate per 100,000 population",
#'         target_keys = NULL,
#'         target_type = "discrete",
#'         is_step_ahead = TRUE,
#'         time_unit = "week"
#'       )
#'     )
#'   )
#' )
#' create_model_tasks(
#'   create_model_task(
#'     task_ids = create_task_ids(
#'       create_task_id("origin_date",
#'         required = NULL,
#'         optional = c(
#'           "2023-01-02",
#'           "2023-01-09",
#'           "2023-01-16"
#'         )
#'       ),
#'       create_task_id("location",
#'         required = "US",
#'         optional = c("01", "02", "04", "05", "06")
#'       ),
#'       create_task_id("target",
#'         required = NULL,
#'         optional = c("inc death", "inc hosp")
#'       ),
#'       create_task_id("horizon",
#'         required = 1L,
#'         optional = 2:4
#'       )
#'     ),
#'     output_type = create_output_type(
#'       create_output_type_mean(
#'         is_required = TRUE,
#'         value_type = "double",
#'         value_minimum = 0L
#'       ),
#'       create_output_type_median(
#'         is_required = FALSE,
#'         value_type = "double"
#'       ),
#'       create_output_type_quantile(
#'         required = c(
#'           0.1, 0.2, 0.3, 0.4, 0.6,
#'           0.7, 0.8, 0.9
#'         ),
#'         is_required = TRUE,
#'         value_type = "double",
#'         value_minimum = 0
#'       )
#'     ),
#'     target_metadata = create_target_metadata(
#'       create_target_metadata_item(
#'         target_id = "inc hosp",
#'         target_name = "Weekly incident influenza hospitalizations",
#'         target_units = "rate per 100,000 population",
#'         target_keys = list(target = "inc hosp"),
#'         target_type = "discrete",
#'         is_step_ahead = TRUE,
#'         time_unit = "week"
#'       ),
#'       create_target_metadata_item(
#'         target_id = "inc death",
#'         target_name = "Weekly incident influenza deaths",
#'         target_units = "rate per 100,000 population",
#'         target_keys = list(target = "inc death"),
#'         target_type = "discrete",
#'         is_step_ahead = TRUE,
#'         time_unit = "week"
#'       )
#'     )
#'   ),
#'   create_model_task(
#'     task_ids = create_task_ids(
#'       create_task_id("origin_date",
#'         required = NULL,
#'         optional = c(
#'           "2023-01-02",
#'           "2023-01-09",
#'           "2023-01-16"
#'         )
#'       ),
#'       create_task_id("location",
#'         required = "US",
#'         optional = c("01", "02", "04", "05", "06")
#'       ),
#'       create_task_id("target",
#'         required = "flu hosp rt chng",
#'         optional = NULL
#'       ),
#'       create_task_id("horizon",
#'         required = 1L,
#'         optional = 2:4
#'       )
#'     ),
#'     output_type = create_output_type(
#'       create_output_type_pmf(
#'         required = c(
#'           "large_decrease",
#'           "decrease",
#'           "stable",
#'           "increase",
#'           "large_increase"
#'         ),
#'         is_required = TRUE,
#'         value_type = "double"
#'       )
#'     ),
#'     target_metadata = create_target_metadata(
#'       create_target_metadata_item(
#'         target_id = "flu hosp rt chng",
#'         target_name = "Weekly influenza hospitalization rate change",
#'         target_units = "rate per 100,000 population",
#'         target_keys = list(target = "flu hosp rt chng"),
#'         target_type = "nominal",
#'         is_step_ahead = TRUE,
#'         time_unit = "week"
#'       )
#'     )
#'   )
#' )
create_model_tasks <- function(...) {
  collect_items(...,
    item_class = "model_task",
    output_class = "model_tasks",
    flatten = FALSE
  )
}
