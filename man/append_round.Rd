% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/append_round.R
\name{append_round}
\alias{append_round}
\title{Append one or more rounds to a config class object.}
\usage{
append_round(config, ...)
}
\arguments{
\item{config}{an object of class \verb{<config>}.}

\item{...}{one or more objects of class \verb{<round>}.}
}
\value{
an object of class \verb{<config>} with the rounds appended sequentially to
the end of the \code{rounds} property.
}
\description{
Append one or more \verb{<round>}s sequentially to the end of the \code{rounds} property of
a \verb{<config>} class object.
}
\examples{
config <- create_config(
  create_rounds(
    create_round(
      round_id_from_variable = TRUE,
      round_id = "origin_date",
      model_tasks = create_model_tasks(
        create_model_task(
          task_ids = create_task_ids(
            create_task_id("origin_date",
              required = NULL,
              optional = c(
                "2023-01-02",
                "2023-01-09",
                "2023-01-16"
              )
            ),
            create_task_id("location",
              required = "US",
              optional = c("01", "02", "04", "05", "06")
            ),
            create_task_id("horizon",
              required = 1L,
              optional = 2:4
            )
          ),
          output_type = create_output_type(
            create_output_type_mean(
              is_required = TRUE,
              value_type = "double",
              value_minimum = 0L
            )
          ),
          target_metadata = create_target_metadata(
            create_target_metadata_item(
              target_id = "inc hosp",
              target_name = "Weekly incident influenza hospitalizations",
              target_units = "rate per 100,000 population",
              target_keys = NULL,
              target_type = "discrete",
              is_step_ahead = TRUE,
              time_unit = "week"
            )
          )
        )
      ),
      submissions_due = list(
        relative_to = "origin_date",
        start = -4L,
        end = 2L
      )
    )
  )
)
# Add a new round with an age_group task_id
new_round <- create_round(
  round_id_from_variable = TRUE,
  round_id = "origin_date",
  model_tasks = create_model_tasks(
    create_model_task(
      task_ids = create_task_ids(
        create_task_id("origin_date",
          required = NULL,
          optional = c(
            "2023-01-23"
          )
        ),
        create_task_id("location",
          required = "US",
          optional = c("01", "02", "04", "05", "06")
        ),
        create_task_id("horizon",
          required = 1L,
          optional = 2:4
        ),
        create_task_id("age_group",
          required = NULL,
          optional = c("1", "2", "3", "4", "5")
        )
      ),
      output_type = create_output_type(
        create_output_type_mean(
          is_required = TRUE,
          value_type = "double",
          value_minimum = 0L
        )
      ),
      target_metadata = create_target_metadata(
        create_target_metadata_item(
          target_id = "inc hosp",
          target_name = "Weekly incident influenza hospitalizations",
          target_units = "rate per 100,000 population",
          target_keys = NULL,
          target_type = "discrete",
          is_step_ahead = TRUE,
          time_unit = "week"
        )
      )
    )
  ),
  submissions_due = list(
    relative_to = "origin_date",
    start = -4L,
    end = 2L
  )
)
append_round(config, new_round)
# Append in existing config file using an older schema version
options(hubAdmin.schema_version = "v4.0.0")
config <- hubUtils::read_config_file(
  system.file("v4-tasks.json", package = "hubAdmin")
)
# Create new round using version defined through
# hubAdmin.schema_version option
new_round <- create_round(
  round_id_from_variable = TRUE,
  round_id = "origin_date",
  model_tasks = create_model_tasks(
    create_model_task(
      task_ids = create_task_ids(
        create_task_id("origin_date",
          required = NULL,
          optional = c(
            "2023-01-23"
          )
        ),
        create_task_id("location",
          required = "US",
          optional = c("01", "02", "04", "05", "06")
        ),
        create_task_id("horizon",
          required = 1L,
          optional = 2:4
        ),
        create_task_id("age_group",
          required = NULL,
          optional = c("1", "2", "3", "4", "5")
        )
      ),
      output_type = create_output_type(
        create_output_type_mean(
          is_required = TRUE,
          value_type = "double",
          value_minimum = 0L
        )
      ),
      target_metadata = create_target_metadata(
        create_target_metadata_item(
          target_id = "inc hosp",
          target_name = "Weekly incident influenza hospitalizations",
          target_units = "rate per 100,000 population",
          target_keys = NULL,
          target_type = "discrete",
          is_step_ahead = TRUE,
          time_unit = "week"
        )
      )
    )
  ),
  submissions_due = list(
    relative_to = "origin_date",
    start = -4L,
    end = 2L
  )
)
append_round(config, new_round)
# Reset option to latest schema version
options(hubAdmin.schema_version = "latest")
}
