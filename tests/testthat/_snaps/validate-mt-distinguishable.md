# modeling tasks that define the same value combinations are detected

    Code
      cat(errors$message, errors$data, sep = "\n")
    Output
      modeling task item defines value combinations also defined by the modeling task item at '/rounds/1/model_tasks/0'. Modeling task items in a round MUST NOT define the same combination of task ID values, output type and output type ID.
      overlap on horizon (2), identical on all other task IDs; output types in common: mean

# values in common are listed where the modeling tasks differ

    Code
      cat(errors$data)
    Output
      overlap on horizon (1, 2, 3, 4, 5 and 1 more), identical on all other task IDs; output types in common: quantile (0.5)

