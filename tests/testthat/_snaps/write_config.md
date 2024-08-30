# write config works

    Code
      cat(file_contents, sep = "\n")
    Output
      {
        "schema_version": "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json",
        "rounds": [
          {
            "round_id_from_variable": true,
            "round_id": "origin_date",
            "model_tasks": [
              {
                "task_ids": {
                  "origin_date": {
                    "required": null,
                    "optional": ["2023-01-02", "2023-01-09", "2023-01-16"]
                  },
                  "location": {
                    "required": "US",
                    "optional": ["01", "02", "04", "05", "06"]
                  },
                  "horizon": {
                    "required": 1,
                    "optional": [2, 3, 4]
                  }
                },
                "output_type": {
                  "mean": {
                    "output_type_id": {
                      "required": "NA",
                      "optional": null
                    },
                    "value": {
                      "type": "double",
                      "minimum": 0
                    }
                  }
                },
                "target_metadata": [
                  {
                    "target_id": "inc hosp",
                    "target_name": "Weekly incident influenza hospitalizations",
                    "target_units": "rate per 100,000 population",
                    "target_keys": null,
                    "target_type": "discrete",
                    "is_step_ahead": true,
                    "time_unit": "week"
                  }
                ]
              }
            ],
            "submissions_due": {
              "relative_to": "origin_date",
              "start": -4,
              "end": 2
            }
          }
        ]
      }

---

    Code
      write_config(config = config, hub_path = temp_hub, overwrite = TRUE)
    Message
      v `config` written out successfully.
      ! Due to inconsistencies between R and JSON data types, some properties in the
        output file may not conform to schema expectations. They might be an <array>
        when a <scalar> is required or vice versa.
      * Please validate the file with `validate_config()` to identify any deviations.

