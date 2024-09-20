# append_round fails with duplicate round_ids

    Code
      append_round(config = config, create_new_round("2024-09-11"))
    Condition
      Error in `append_round()`:
      x `round_id` "2024-09-11" already exists in `config`.
      ! Please ensure new rounds contain unique `round_id`s.

# append_round fails with schema_id mismatch

    Code
      append_round(config = config, round_with_mismatched_schema_id)
    Condition
      Error in `append_round()`:
      x Schema version mismatch between `config` and round.
      ! Must be the same.
      * `config`: "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      * round: "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json"

---

    Code
      append_round(config, round_with_mismatched_schema_id, round)
    Condition
      Error in `create_rounds()`:
      ! All items supplied must be created against the same Hub schema.
      x `schema_id` attributes are not consistent across all items.
      Item `schema_id` attributes:
      * Item 1 : https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json
      * Item 2 : https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json

---

    Code
      append_round(config, round_with_mismatched_schema_id,
        round_with_mismatched_schema_id_2)
    Condition
      Error in `append_round()`:
      x Schema version mismatch between `config` and rounds.
      ! Must be the same.
      * `config`: "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
      * rounds: "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json"

