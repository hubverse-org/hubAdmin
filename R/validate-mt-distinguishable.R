#' Validate that the modeling tasks in a round are distinguishable
#'
#' Each modeling task defines a set of value combinations: every combination of
#' its task ID values with the output type IDs it allows under each of its
#' output types. No two modeling tasks in a round may define the same
#' combination.
#'
#' Model output does not name the modeling task it is submitted to, so the
#' combination of values a row carries is what identifies that modeling task.
#' Each row is then validated against the config of the modeling task it was
#' assigned to. If two modeling tasks define the same combination, a row
#' carrying that combination matches both of them. The row cannot then be
#' assigned to one modeling task, and so cannot be validated against the
#' correct config.
#'
#' @param round A list representation of a round object from a `tasks.json`
#'  config file.
#' @param round_i Integer. The position of `round` in the config's `rounds`
#'  array.
#' @param schema A json representation of the schema to validate against.
#' @param derived_task_ids Character vector of the names of task IDs whose
#'  values are derived from other task IDs, or `NULL` for none.
#'
#' @return `NULL` when every pair of modeling tasks in the round is
#'  distinguishable. Otherwise a data frame of error rows, one per pair that is
#'  not, each reported against the second modeling task of its pair.
#' @noRd
validate_round_mts_distinguishable <- function(
  round,
  round_i,
  schema,
  derived_task_ids = NULL
) {
  if (length(round[["model_tasks"]]) < 2L) {
    return(NULL)
  }

  value_sets <- get_mt_value_sets(round, derived_task_ids)
  # A matrix with one column per pair of modeling task indices.
  pairs <- utils::combn(seq_along(value_sets), 2L)
  overlaps <- purrr::map2(
    pairs[1L, ],
    pairs[2L, ],
    \(i, j) mt_pair_overlap(value_sets[[i]], value_sets[[j]])
  )

  indistinguishable <- !purrr::map_lgl(overlaps, is.null)
  if (!any(indistinguishable)) {
    return(NULL)
  }
  pairs <- pairs[, indistinguishable, drop = FALSE]
  overlaps <- overlaps[indistinguishable]

  instance_path <- get_error_path(
    schema,
    "model_tasks",
    "instance",
    append_item_n = TRUE
  )
  mt_path <- function(model_task_i) {
    glue::glue_data(
      list(round_i = round_i, model_task_i = model_task_i),
      instance_path
    ) |>
      as.character()
  }

  tibble::tibble(
    instancePath = mt_path(pairs[2L, ]),
    schemaPath = get_error_path(schema, "model_tasks", "schema"),
    keyword = "model_tasks distinguishable",
    message = glue::glue(
      "modeling task item defines value combinations also defined by the",
      " modeling task item at '{mt_path(pairs[1L, ])}'. Modeling task",
      " items in a round MUST NOT define the same combination of task ID",
      " values, output type and output type ID."
    ),
    schema = "",
    data = purrr::map_chr(overlaps, mt_overlap_data)
  ) |>
    as.data.frame()
}

#' The values each modeling task in a round allows
#'
#' A modeling task's value combinations are every combination drawn from these
#' sets. Note that the sets themselves are compared, so the combinations are
#' never enumerated.
#'
#' A modeling task need not use every task ID the round defines. A modeling task
#' that does not use a task ID either leaves it out or sets it to null, and its
#' value set for that task ID is `NA`. Note that `NA` matches only `NA`, so a
#' modeling task that uses a task ID is distinguishable from one that does not.
#'
#' Derived task IDs are left out. A derived task ID's value is worked out from
#' other task IDs, and those task IDs are compared in their own right, so a
#' derived task ID only ever repeats a distinction they already make.
#'
#' @param round A list representation of a round object from a `tasks.json`
#'  config file.
#' @param derived_task_ids Character vector of the names of task IDs whose
#'  values are derived from other task IDs, or `NULL` for none.
#'
#' @return A list with one element per modeling task in `round`. Each element
#'  holds `task_ids`, a named list of the values allowed for every task ID the
#'  round defines other than derived task IDs, and `output_type_ids`, a named
#'  list of the output type IDs allowed under each output type the modeling
#'  task offers.
#' @noRd
get_mt_value_sets <- function(round, derived_task_ids = NULL) {
  task_id_names <- setdiff(get_round_task_ids(round), derived_task_ids)

  purrr::map(
    round[["model_tasks"]],
    \(model_task) {
      list(
        task_ids = purrr::map(
          purrr::set_names(task_id_names),
          \(task_id) as_value_set(model_task[["task_ids"]][[task_id]])
        ),
        output_type_ids = purrr::map(
          model_task[["output_type"]],
          \(output_type) as_value_set(get_output_type_ids(output_type))
        )
      )
    }
  )
}

#' Read a model task property into a value set
#'
#' @param x A model task property (a task ID or an `output_type_id`) holding
#'  `required` and `optional` values, or `NULL`.
#'
#' @return A vector of the values `x` holds, or `NA` when it holds none.
#' @noRd
as_value_set <- function(x) {
  unlist(x, use.names = FALSE) %||% NA
}

#' The values two modeling tasks have in common
#'
#' A pair of modeling tasks is distinguishable when at least one dimension
#' distinguishes them, that is, when the two modeling tasks have no value at
#' all in common on that dimension. The dimensions are each task ID, the output
#' types and their output type IDs. Note that output type IDs are specific to
#' their output type, so the last two are compared together: output type IDs
#' are compared only for an output type both modeling tasks offer.
#'
#' @param x,y Value sets for a pair of modeling tasks, as returned by
#'  `get_mt_value_sets()`.
#'
#' @return `NULL` when the pair is distinguishable. Otherwise a list with
#'  `task_ids`, a named list with one element per task ID, and `output_types`,
#'  a named list with one element per output type under which the pair has
#'  output type IDs in common. Each element holds the values the pair shares,
#'  as returned by `get_partial_overlap()`.
#' @noRd
mt_pair_overlap <- function(x, y) {
  x_task_ids <- x[["task_ids"]]
  y_task_ids <- y[["task_ids"]]
  task_ids_overlap <- purrr::map2_lgl(
    x_task_ids,
    y_task_ids,
    has_shared_values
  )
  if (!all(task_ids_overlap)) {
    return(NULL)
  }

  x_output_type_ids <- x[["output_type_ids"]]
  y_output_type_ids <- y[["output_type_ids"]]
  output_types <- intersect(
    names(x_output_type_ids),
    names(y_output_type_ids)
  ) |>
    purrr::keep(
      \(output_type) {
        has_shared_values(
          x_output_type_ids[[output_type]],
          y_output_type_ids[[output_type]]
        )
      }
    )
  if (length(output_types) == 0L) {
    return(NULL)
  }

  list(
    task_ids = purrr::map2(x_task_ids, y_task_ids, get_partial_overlap),
    output_types = purrr::map(
      purrr::set_names(output_types),
      \(output_type) {
        get_partial_overlap(
          x_output_type_ids[[output_type]],
          y_output_type_ids[[output_type]]
        )
      }
    )
  )
}

#' Whether two value sets have at least one value in common
#'
#' @param x,y Value sets, as returned by `as_value_set()`.
#'
#' @return `TRUE` when the two value sets share at least one value. Note that
#'  `%in%` matches `NA` to `NA`, unlike `==`, so two value sets that both hold
#'  no values overlap.
#' @noRd
has_shared_values <- function(x, y) {
  any(x %in% y)
}

#' The values two value sets have in common
#'
#' @param x,y Value sets, as returned by `as_value_set()`.
#'
#' @return The values in both `x` and `y`, in the order `y` lists them.
#' @noRd
get_shared_values <- function(x, y) {
  unique(y[y %in% x])
}

#' The values two value sets have in common, unless they are identical
#'
#' Builds the elements of the list `mt_pair_overlap()` returns. The error
#' message lists shared values only for partial overlaps, so identical value
#' sets give `NULL`.
#'
#' @param x,y Value sets, as returned by `as_value_set()`.
#'
#' @return The values in both `x` and `y`, in the order `y` lists them, when
#'  the two differ, or `NULL` when they are identical.
#' @noRd
get_partial_overlap <- function(x, y) {
  if (setequal(x, y)) {
    return(NULL)
  }
  get_shared_values(x, y)
}

#' Describe what leaves a pair of modeling tasks indistinguishable
#'
#' Builds the `data` field of the error row. A pair is only reported as
#' indistinguishable when the two modeling tasks have values in common on every
#' task ID. Listing every task ID would therefore add no information. The
#' message names only the task IDs whose value sets differ, with the values in
#' common, and summarises the rest as identical. Every output type under which
#' the two modeling tasks have output type IDs in common is named. Where their
#' output type ID sets differ, the output type IDs in common are listed too.
#'
#' @param overlap The values the pair has in common, as returned by
#'  `mt_pair_overlap()`.
#'
#' @return A string describing the overlap.
#' @noRd
mt_overlap_data <- function(overlap) {
  task_ids <- overlap[["task_ids"]]
  partial <- purrr::compact(task_ids)
  task_ids_desc <- if (length(partial) == 0L) {
    "identical on every task ID"
  } else if (length(partial) == length(task_ids)) {
    glue::glue("overlap on {format_shared(partial)}")
  } else {
    glue::glue(
      "overlap on {format_shared(partial)}, identical on all other task IDs"
    )
  }
  glue::glue(
    "{task_ids_desc}; output types in common:",
    " {format_shared(overlap[['output_types']])}"
  )
}

#' Format the values a pair shares on each named dimension
#'
#' @param x A named list, as held in the `task_ids` and `output_types` elements
#'  returned by `mt_pair_overlap()`.
#'
#' @return A string naming each dimension, followed in parentheses by the values
#'  in common where the element holds any. Note that at most `max_values` are
#'  listed per dimension, as a task ID such as `location` can share many.
#' @noRd
format_shared <- function(x, max_values = 5L) {
  purrr::imap_chr(
    x,
    \(values, name) {
      if (is.null(values)) {
        return(name)
      }
      shown <- glue::glue_collapse(utils::head(values, max_values), sep = ", ")
      n_extra <- length(values) - max_values
      if (n_extra > 0L) {
        shown <- glue::glue("{shown} and {n_extra} more")
      }
      glue::glue("{name} ({shown})")
    }
  ) |>
    glue::glue_collapse(sep = ", ", last = " and ")
}
