# write_config creates config path with default settings

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
                    "required": [
                      "US"
                    ],
                    "optional": ["01", "02", "04", "05", "06"]
                  },
                  "horizon": {
                    "required": [
                      1
                    ],
                    "optional": [2, 3, 4]
                  }
                },
                "output_type": {
                  "mean": {
                    "output_type_id": {
                      "required": [
                        "NA"
                      ],
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

# write_config handles overwrite settings correctly

    Code
      write_config(config = config, hub_path = temp_hub, overwrite = TRUE)
    Message
      v `config` written out successfully.

# write_config autoboxing works

    Code
      cat(file_contents, sep = "\n")
    Output
      {
        "schema_version": "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json",
        "rounds": [
          {
            "round_id_from_variable": true,
            "round_id": "nowcast_date",
            "model_tasks": [
              {
                "task_ids": {
                  "nowcast_date": {
                    "required": [
                      "2024-09-11"
                    ],
                    "optional": null
                  },
                  "target_date": {
                    "required": null,
                    "optional": ["2024-09-11", "2024-09-04", "2024-08-28", "2024-08-21"]
                  },
                  "location": {
                    "required": null,
                    "optional": ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY", "PR"]
                  },
                  "variant": {
                    "required": ["24A", "24B", "24C", "other", "recombinant"],
                    "optional": null
                  }
                },
                "output_type": {
                  "sample": {
                    "output_type_id_params": {
                      "is_required": false,
                      "type": "character",
                      "max_length": 15,
                      "min_samples_per_task": 1,
                      "max_samples_per_task": 500
                    },
                    "value": {
                      "type": "double",
                      "minimum": 0,
                      "maximum": 1
                    }
                  }
                },
                "target_metadata": [
                  {
                    "target_id": "variant prop",
                    "target_name": "Weekly nowcasted variant proportions",
                    "target_units": "proportion",
                    "target_keys": null,
                    "target_type": "compositional",
                    "is_step_ahead": true,
                    "time_unit": "week"
                  }
                ]
              }
            ],
            "submissions_due": {
              "relative_to": "nowcast_date",
              "start": -7,
              "end": 1
            }
          }
        ]
      }

---

    Code
      cat(file_contents, sep = "\n")
    Output
      {
        "schema_version": "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json",
        "rounds": [
          {
            "round_id_from_variable": true,
            "round_id": "nowcast_date",
            "model_tasks": [
              {
                "task_ids": {
                  "nowcast_date": {
                    "required": [
                      "2024-09-11"
                    ],
                    "optional": null
                  },
                  "target_date": {
                    "required": null,
                    "optional": ["2024-09-11", "2024-09-04", "2024-08-28", "2024-08-21"]
                  },
                  "location": {
                    "required": null,
                    "optional": ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY", "PR"]
                  },
                  "variant": {
                    "required": ["24A", "24B", "24C", "other", "recombinant"],
                    "optional": null
                  }
                },
                "output_type": {
                  "sample": {
                    "output_type_id_params": {
                      "is_required": false,
                      "type": "character",
                      "max_length": 15,
                      "min_samples_per_task": 1,
                      "max_samples_per_task": 500
                    },
                    "value": {
                      "type": "double",
                      "minimum": 0,
                      "maximum": 1
                    }
                  }
                },
                "target_metadata": [
                  {
                    "target_id": "variant prop",
                    "target_name": "Weekly nowcasted variant proportions",
                    "target_units": "proportion",
                    "target_keys": null,
                    "target_type": "compositional",
                    "is_step_ahead": true,
                    "time_unit": "week"
                  }
                ]
              }
            ],
            "submissions_due": {
              "relative_to": "nowcast_date",
              "start": -7,
              "end": 1
            }
          },
          {
            "round_id_from_variable": true,
            "round_id": "nowcast_date",
            "model_tasks": [
              {
                "task_ids": {
                  "nowcast_date": {
                    "required": [
                      "2024-09-18"
                    ],
                    "optional": null
                  },
                  "target_date": {
                    "required": null,
                    "optional": ["2024-09-11", "2024-09-04", "2024-08-28", "2024-08-21"]
                  },
                  "location": {
                    "required": null,
                    "optional": ["AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY", "PR"]
                  },
                  "variant": {
                    "required": ["24A", "24B", "24C", "other", "recombinant"],
                    "optional": null
                  }
                },
                "output_type": {
                  "sample": {
                    "output_type_id_params": {
                      "is_required": false,
                      "type": "character",
                      "max_length": 15,
                      "min_samples_per_task": 1,
                      "max_samples_per_task": 500
                    },
                    "value": {
                      "type": "double",
                      "minimum": 0,
                      "maximum": 1
                    }
                  }
                },
                "target_metadata": [
                  {
                    "target_id": "variant prop",
                    "target_name": "Weekly nowcasted variant proportions",
                    "target_units": "proportion",
                    "target_keys": null,
                    "target_type": "compositional",
                    "is_step_ahead": true,
                    "time_unit": "week"
                  }
                ]
              }
            ],
            "submissions_due": {
              "relative_to": "nowcast_date",
              "start": -7,
              "end": 1
            }
          }
        ]
      }

# write_config with autobox = FALSE does not box and issues warning

    Code
      write_config(config = config, hub_path = temp_hub, autobox = FALSE)
    Message
      v `config` written out successfully.
      ! Autoboxing was disabled. Some properties in the output file may not conform
        to schema expectations.
      i Due to inconsistencies between R and JSON data types, some properties in the
        output file might be an <array> when a <scalar> is required or vice versa.
      * Please validate the file with `validate_config()` to identify any deviations.

# write_config with box_extra_paths works

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
                    "required": [
                      "US"
                    ],
                    "optional": ["01", "02", "04", "05", "06"]
                  },
                  "horizon": {
                    "required": [
                      1
                    ],
                    "optional": [2, 3, 4]
                  }
                },
                "output_type": {
                  "mean": {
                    "output_type_id": {
                      "required": [
                        "NA"
                      ],
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
            },
            "extra_array_property": [
              "length_1L_property"
            ]
          }
        ]
      }

# write_config with v4 works

    Code
      write_config(config = config, hub_path = temp_hub)
    Message
      v `config` written out successfully.

---

    Code
      cat(readLines(file.path(temp_hub, "hub-config/tasks.json")), sep = "\n")
    Output
      {
        "schema_version": "https://raw.githubusercontent.com/hubverse-org/schemas/main/v4.0.0/tasks-schema.json",
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
                    "required": [
                      "US"
                    ],
                    "optional": ["01", "02", "04", "05", "06"]
                  },
                  "horizon": {
                    "required": [
                      1
                    ],
                    "optional": [2, 3, 4]
                  }
                },
                "output_type": {
                  "mean": {
                    "output_type_id": {
                      "required": null
                    },
                    "is_required": true,
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

