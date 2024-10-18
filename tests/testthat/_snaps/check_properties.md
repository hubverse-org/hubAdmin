# check_properties_scalar works

    Code
      check_properties_scalar(properties, round_schema)
    Condition
      Error in `map()`:
      i In index: 2.
      Caused by error:
      x `round_id` is of type <integer>.
      ! Must be <character>.

---

    Code
      check_properties_scalar(properties, round_schema)
    Condition
      Error in `map()`:
      i In index: 2.
      Caused by error:
      x `round_id` must be length 1, not 2.

# check_properties_array works

    Code
      check_properties_array(properties, round_schema)
    Condition
      Error in `map()`:
      i In index: 1.
      Caused by error:
      x `file_format` is of type <integer>.
      ! Must be <character>.

