# download_tasks_schema defaults work

    Code
      str(download_tasks_schema(), 4L)
    Output
      List of 8
       $ $schema             : chr "https://json-schema.org/draft/2020-12/schema"
       $ $id                 : chr "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json"
       $ title               : chr "Schema for Modeling Hub model task definitions"
       $ description         : chr "This is the schema of the tasks.json configuration file that defines the tasks within a modeling hub."
       $ type                : chr "object"
       $ properties          :List of 3
        ..$ schema_version         :List of 4
        .. ..$ description: chr "URL to a version of the Modeling Hub schema tasks-schema.json file (see https://github.com/hubverse-org/schemas"| __truncated__
        .. ..$ examples   : chr "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.0/tasks-schema.json"
        .. ..$ type       : chr "string"
        .. ..$ format     : chr "uri"
        ..$ rounds                 :List of 3
        .. ..$ description: chr "Array of modeling round properties"
        .. ..$ type       : chr "array"
        .. ..$ items      :List of 5
        .. .. ..$ type                : chr "object"
        .. .. ..$ description         : chr "Individual modeling round properties"
        .. .. ..$ properties          :List of 7
        .. .. ..$ required            : chr [1:4] "round_id_from_variable" "round_id" "model_tasks" "submissions_due"
        .. .. ..$ additionalProperties: logi TRUE
        ..$ output_type_id_datatype:List of 5
        .. ..$ description: chr "The hub level data type of the output_type_id column. This data type must be shared across all files in the hub"| __truncated__
        .. ..$ default    : chr "auto"
        .. ..$ examples   : chr "character"
        .. ..$ type       : chr "string"
        .. ..$ enum       : chr [1:6] "auto" "character" "double" "integer" ...
       $ required            : chr [1:2] "rounds" "schema_version"
       $ additionalProperties: logi FALSE

# download_tasks_schema json output work

    Code
      download_tasks_schema(format = "json")
    Output
      {
          "$schema": "https://json-schema.org/draft/2020-12/schema",
          "$id": "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json",
          "title": "Schema for Modeling Hub model task definitions",
          "description": "This is the schema of the tasks.json configuration file that defines the tasks within a modeling hub.",
          "type": "object",
          "properties": {
              "schema_version": {
                  "description": "URL to a version of the Modeling Hub schema tasks-schema.json file (see https://github.com/hubverse-org/schemas). Used to declare the schema version a 'tasks.json' file is written for and for config file validation. The URL provided should be the URL to the raw content of the schema file on GitHub.",
                  "examples": [
                      "https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.0/tasks-schema.json"
                  ],
                  "type": "string",
                  "format": "uri"
              },
              "rounds": {
                  "description": "Array of modeling round properties",
                  "type": "array",
                  "items": {
                      "type": "object",
                      "description": "Individual modeling round properties",
                      "properties": {
                          "round_id_from_variable": {
                              "description": "Whether the round identifier is encoded by a task id variable in the data.",
                              "type": "boolean"
                          },
                          "round_id": {
                              "description": "Round identifier. If round_id_from_variable = true, round_id should be the name of a task id variable present in all sets of modeling task specifications",
                              "examples": [
                                  "round-1",
                                  "2022-11-05",
                                  "origin_date"
                              ],
                              "type": "string"
                          },
                          "round_name": {
                              "description": "An optional round name. This can be useful for internal referencing of rounds, for examples, when a date is used as round_id but hub maintainers and teams also refer to rounds as round-1, round-2 etc.",
                              "examples": [
                                  "round-1"
                              ],
                              "type": "string"
                          },
                          "model_tasks": {
                              "type": "array",
                              "description": "Array defining round-specific modeling tasks. Can contain one or more groups of modeling tasks per round where each group is defined by a distinct combination of values of task id variables.",
                              "items": {
                                  "type": "object",
                                  "properties": {
                                      "task_ids": {
                                          "description": "Group of valid values of task id variables. A set of valid tasks corresponding to this group is formed by taking all combinations of these values.",
                                          "type": "object",
                                          "properties": {
                                              "origin_date": {
                                                  "description": "An object containing arrays of required and optional unique origin dates. Origin date defines the starting point that can be used for calculating a target_date via the formula target_date = origin_date + horizon x time_units_per_horizon (e.g., with weekly data, target_date is calculated as origin_date + horizon x 7 days)",
                                                  "examples": [
                                                      {
                                                          "required": null,
                                                          "optional": [
                                                              "2022-11-05",
                                                              "2022-11-12",
                                                              "2022-11-19"
                                                          ]
                                                      }
                                                  ],
                                                  "type": "object",
                                                  "properties": {
                                                      "required": {
                                                          "description": "Array of origin date unique identifiers that must be present for submission to be valid. Can be null if no origin dates are required and all valid origin dates are specified in the optional property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string",
                                                              "format": "date"
                                                          }
                                                      },
                                                      "optional": {
                                                          "description": "Array of valid but not required unique origin date identifiers. Can be null if all origin dates are required and are specified in the required property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string",
                                                              "format": "date"
                                                          }
                                                      }
                                                  },
                                                  "required": [
                                                      "required",
                                                      "optional"
                                                  ]
                                              },
                                              "forecast_date": {
                                                  "description": "An object containing arrays of required and optional unique forecast dates. Forecast date usually defines the date that a model is run to produce a forecast.",
                                                  "examples": [
                                                      {
                                                          "required": null,
                                                          "optional": [
                                                              "2022-11-05",
                                                              "2022-11-12",
                                                              "2022-11-19"
                                                          ]
                                                      }
                                                  ],
                                                  "type": "object",
                                                  "properties": {
                                                      "required": {
                                                          "description": "Array of forecast date unique identifiers that must be present for submission to be valid. Can be null if no forecast dates are required and all valid forecast dates are specified in the optional property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string",
                                                              "format": "date"
                                                          }
                                                      },
                                                      "optional": {
                                                          "description": "Array of valid but not required unique forecast date identifiers. Can be null if all forecast dates are required and are specified in the required property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string",
                                                              "format": "date"
                                                          }
                                                      }
                                                  },
                                                  "required": [
                                                      "required",
                                                      "optional"
                                                  ]
                                              },
                                              "scenario_id": {
                                                  "description": "An object containing arrays of required and optional unique identifiers of each valid scenario.",
                                                  "examples": [
                                                      {
                                                          "required": null,
                                                          "optional": [
                                                              1,
                                                              2,
                                                              3,
                                                              4
                                                          ]
                                                      },
                                                      {
                                                          "required": null,
                                                          "optional": [
                                                              "A-2021-03-28",
                                                              "B-2021-03-28",
                                                              "A-2021-04-05",
                                                              "B-2021-04-05"
                                                          ]
                                                      }
                                                  ],
                                                  "type": "object",
                                                  "properties": {
                                                      "required": {
                                                          "description": "Array of identifiers of scenarios that must be present in a valid submission. Can be null if no scenario ids are required and all valid ids are specified in the optional property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": [
                                                                  "integer",
                                                                  "string"
                                                              ]
                                                          }
                                                      },
                                                      "optional": {
                                                          "description": "Array of identifiers of valid but not required scenarios. Can be null if all scenarios are required and are specified in the required property.",
                                                          "type": [
                                                              "null",
                                                              "array"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": [
                                                                  "integer",
                                                                  "string"
                                                              ]
                                                          }
                                                      }
                                                  },
                                                  "required": [
                                                      "required",
                                                      "optional"
                                                  ]
                                              },
                                              "location": {
                                                  "description": "An object containing arrays of required and optional unique identifiers for each valid location, e.g. country codes, FIPS state or county level code etc.",
                                                  "examples": [
                                                      {
                                                          "required": "US",
                                                          "optional": [
                                                              "01",
                                                              "02",
                                                              "04",
                                                              "05",
                                                              "06",
                                                              "08",
                                                              "09",
                                                              "10",
                                                              "11",
                                                              "12",
                                                              "13",
                                                              "15",
                                                              "16",
                                                              "17",
                                                              "18",
                                                              "19",
                                                              "20",
                                                              "21",
                                                              "22",
                                                              "23",
                                                              "24",
                                                              "25",
                                                              "26",
                                                              "27",
                                                              "28",
                                                              "29",
                                                              "30",
                                                              "31",
                                                              "32",
                                                              "33",
                                                              "34",
                                                              "35",
                                                              "36",
                                                              "37",
                                                              "38",
                                                              "39",
                                                              "40",
                                                              "41",
                                                              "42",
                                                              "44",
                                                              "45",
                                                              "46",
                                                              "47",
                                                              "48",
                                                              "49",
                                                              "50",
                                                              "51",
                                                              "53",
                                                              "54",
                                                              "55",
                                                              "56"
                                                          ]
                                                      }
                                                  ],
                                                  "type": "object",
                                                  "properties": {
                                                      "required": {
                                                          "description": "Array of location unique identifiers that must be present for submission to be valid. Can be null if no locations are required and all valid locations are specified in the optional property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string"
                                                          }
                                                      },
                                                      "optional": {
                                                          "description": "Array of valid but not required unique location identifiers. Can be null if all locations are required and are specified in the required property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string"
                                                          }
                                                      }
                                                  },
                                                  "required": [
                                                      "required",
                                                      "optional"
                                                  ]
                                              },
                                              "target": {
                                                  "description": "An object containing arrays of required and optional unique identifiers for each valid target. Usually represents a single task ID target key variable.",
                                                  "type": "object",
                                                  "examples": [
                                                      {
                                                          "required": null,
                                                          "optional": [
                                                              "inc hosp",
                                                              "inc case",
                                                              "inc death"
                                                          ]
                                                      },
                                                      {
                                                          "required": [
                                                              "peak week inc hosp"
                                                          ],
                                                          "optional": null
                                                      }
                                                  ],
                                                  "properties": {
                                                      "required": {
                                                          "description": "Array of target unique identifiers that must be present for submission to be valid. Can be null if no targets are required and all valid targets are specified in the optional property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string"
                                                          }
                                                      },
                                                      "optional": {
                                                          "description": "Array of valid but not required unique target identifiers. Can be null if all targets are required and are specified in the required property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string"
                                                          }
                                                      }
                                                  },
                                                  "required": [
                                                      "required",
                                                      "optional"
                                                  ]
                                              },
                                              "target_variable": {
                                                  "description": "An object containing arrays of required and optional unique identifiers for each valid target variable. Usually forms part of a pair of task ID target key variables (along with target_outcome) which combine to define individual targets.",
                                                  "type": "object",
                                                  "examples": [
                                                      {
                                                          "required": null,
                                                          "optional": [
                                                              "hosp",
                                                              "death",
                                                              "case"
                                                          ]
                                                      },
                                                      {
                                                          "required": [
                                                              "hosp"
                                                          ],
                                                          "optional": [
                                                              "case"
                                                          ]
                                                      }
                                                  ],
                                                  "properties": {
                                                      "required": {
                                                          "description": "Array of target variable unique identifiers that must be present for submission to be valid. Can be null if no target variables are required and all valid target variables are specified in the optional property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string"
                                                          }
                                                      },
                                                      "optional": {
                                                          "description": "Array of valid but not required unique target variable identifiers. Can be null if all target variables are required and are specified in the required property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string"
                                                          }
                                                      }
                                                  },
                                                  "required": [
                                                      "required",
                                                      "optional"
                                                  ]
                                              },
                                              "target_outcome": {
                                                  "description": "An object containing arrays of required and optional unique identifiers for each valid target outcome. Usually forms part of a pair of task ID target key variables (along with target_variable) which combine to define individual targets.",
                                                  "type": "object",
                                                  "examples": [
                                                      {
                                                          "required": [
                                                              "inc"
                                                          ],
                                                          "optional": null
                                                      },
                                                      {
                                                          "required": [
                                                              "inc"
                                                          ],
                                                          "optional": [
                                                              "cum"
                                                          ]
                                                      }
                                                  ],
                                                  "properties": {
                                                      "required": {
                                                          "description": "Array of target outcome unique identifiers that must be present for submission to be valid. Can be null if no target outcomes are required and all valid target outcomes are specified in the optional property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string"
                                                          }
                                                      },
                                                      "optional": {
                                                          "description": "Array of valid but not required unique target outcome identifiers. Can be null if all target outcomes are required and are specified in the required property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string"
                                                          }
                                                      }
                                                  },
                                                  "required": [
                                                      "required",
                                                      "optional"
                                                  ]
                                              },
                                              "target_date": {
                                                  "description": "An object containing arrays of required and optional unique target dates. For short-term forecasts, the target_date specifies the date of occurrence of the outcome of interest. For instance, if models are requested to forecast the number of hospitalizations that will occur on 2022-07-15, the target_date is 2022-07-15",
                                                  "examples": [
                                                      {
                                                          "required": null,
                                                          "optional": [
                                                              "2022-11-12",
                                                              "2022-11-19",
                                                              "2022-11-26"
                                                          ]
                                                      }
                                                  ],
                                                  "type": "object",
                                                  "properties": {
                                                      "required": {
                                                          "description": "Array of target date unique identifiers that must be present for submission to be valid. Can be null if no target dates are required and all valid target dates are specified in the optional property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string",
                                                              "format": "date"
                                                          }
                                                      },
                                                      "optional": {
                                                          "description": "Array of valid but not required unique target date identifiers. Can be null if all target dates are required and are specified in the required property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string",
                                                              "format": "date"
                                                          }
                                                      }
                                                  },
                                                  "required": [
                                                      "required",
                                                      "optional"
                                                  ]
                                              },
                                              "target_end_date": {
                                                  "description": "An object containing arrays of required and optional unique target end dates. For short-term forecasts, the target_end_date specifies the date of occurrence of the outcome of interest. For instance, if models are requested to forecast the number of hospitalizations that will occur on 2022-07-15, the target_end_date is 2022-07-15",
                                                  "examples": [
                                                      {
                                                          "required": null,
                                                          "optional": [
                                                              "2022-11-12",
                                                              "2022-11-19",
                                                              "2022-11-26"
                                                          ]
                                                      }
                                                  ],
                                                  "type": "object",
                                                  "properties": {
                                                      "required": {
                                                          "description": "Array of target end date unique identifiers that must be present for submission to be valid. Can be null if no target end dates are required and all valid target end dates are specified in the optional property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string",
                                                              "format": "date"
                                                          }
                                                      },
                                                      "optional": {
                                                          "description": "Array of valid but not required unique target end date identifiers. Can be null if all target end dates are required and are specified in the required property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string",
                                                              "format": "date"
                                                          }
                                                      }
                                                  },
                                                  "required": [
                                                      "required",
                                                      "optional"
                                                  ]
                                              },
                                              "horizon": {
                                                  "description": "An object containing arrays of required and optional unique horizons. Horizons define the difference between the target_date and the origin_date in time units specified by the hub (e.g., may be days, weeks, or months)",
                                                  "examples": [
                                                      {
                                                          "required": null,
                                                          "optional": [
                                                              1,
                                                              2,
                                                              3,
                                                              4
                                                          ]
                                                      }
                                                  ],
                                                  "type": "object",
                                                  "properties": {
                                                      "required": {
                                                          "description": "Array of horizon unique identifiers that must be present for submission to be valid. Can be null if no horizons are required and all valid horizons are specified in the optional property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": [
                                                                  "integer",
                                                                  "string"
                                                              ]
                                                          }
                                                      },
                                                      "optional": {
                                                          "description": "Array of valid but not required unique horizon identifiers. Can be null if all horizons are required and are specified in the required property.",
                                                          "type": [
                                                              "null",
                                                              "array"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": [
                                                                  "integer",
                                                                  "string"
                                                              ]
                                                          }
                                                      }
                                                  },
                                                  "required": [
                                                      "required",
                                                      "optional"
                                                  ]
                                              },
                                              "age_group": {
                                                  "type": "object",
                                                  "description": "An object containing arrays of required and optional unique identifiers for age groups",
                                                  "examples": [
                                                      {
                                                          "required": [
                                                              "0-5",
                                                              "6-18",
                                                              "19-24",
                                                              "25-64",
                                                              "65+"
                                                          ],
                                                          "optional": null
                                                      }
                                                  ],
                                                  "properties": {
                                                      "required": {
                                                          "description": "Array of age group unique identifiers that must be present for submission to be valid. Can be null if no age groups are required and all valid age groups are specified in the optional property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string"
                                                          }
                                                      },
                                                      "optional": {
                                                          "description": "Array of valid but not required unique age group identifiers. Can be null if all age group are required and are specified in the required property.",
                                                          "type": [
                                                              "array",
                                                              "null"
                                                          ],
                                                          "uniqueItems": true,
                                                          "items": {
                                                              "type": "string"
                                                          }
                                                      }
                                                  },
                                                  "required": [
                                                      "required",
                                                      "optional"
                                                  ]
                                              }
                                          },
                                          "additionalProperties": {
                                              "type": "object",
                                              "description": "An object containing arrays of required and optional unique values for a custom Task ID",
                                              "properties": {
                                                  "required": {
                                                      "description": "Array of custom Task ID unique values that must be present for submission to be valid. Can be null if no values are required and all valid values are specified in the optional property.",
                                                      "type": [
                                                          "array",
                                                          "null"
                                                      ],
                                                      "uniqueItems": true
                                                  },
                                                  "optional": {
                                                      "description": "Array of valid but not required unique custom Task ID values. Can be null if all values are required and are specified in the required property.",
                                                      "type": [
                                                          "array",
                                                          "null"
                                                      ],
                                                      "uniqueItems": true
                                                  }
                                              },
                                              "required": [
                                                  "required",
                                                  "optional"
                                              ]
                                          }
                                      },
                                      "output_type": {
                                          "type": "object",
                                          "description": "Object defining valid model output types for a given modeling task. The name of each property corresponds to valid values in column 'output_type' while the 'output_type_id' property of each output type defines the valid values of the 'output_type_id' column and the 'value' property defines the valid values of the 'value' column for a given output type.",
                                          "properties": {
                                              "mean": {
                                                  "type": "object",
                                                  "description": "Object defining the mean of the predictive distribution output type.",
                                                  "properties": {
                                                      "output_type_id": {
                                                          "description": "output_type_id is not meaningful for a mean output_type. The property is primarily used to determine whether mean is a required or optional output type through properties required and optional. If mean is a required output type, the required property must be an array containing the single string element 'NA' and the optional property must be set to null. If mean is an optional output type, the optional property must be an array containing the single string element 'NA' and the required property must be set to null",
                                                          "examples": [
                                                              {
                                                                  "required": [
                                                                      "NA"
                                                                  ],
                                                                  "optional": null
                                                              },
                                                              {
                                                                  "required": null,
                                                                  "optional": [
                                                                      "NA"
                                                                  ]
                                                              }
                                                          ],
                                                          "type": "object",
                                                          "oneOf": [
                                                              {
                                                                  "properties": {
                                                                      "required": {
                                                                          "description": "When mean is required, property set to single element 'NA' array",
                                                                          "type": "array",
                                                                          "items": {
                                                                              "const": "NA",
                                                                              "maxItems": 1
                                                                          }
                                                                      },
                                                                      "optional": {
                                                                          "description": "When mean is required, property set to null",
                                                                          "type": "null"
                                                                      }
                                                                  }
                                                              },
                                                              {
                                                                  "properties": {
                                                                      "required": {
                                                                          "description": "When mean is optional, property set to null",
                                                                          "type": "null"
                                                                      },
                                                                      "optional": {
                                                                          "description": "When mean is optional, property set to single element 'NA' array",
                                                                          "type": "array",
                                                                          "items": {
                                                                              "const": "NA",
                                                                              "maxItems": 1
                                                                          }
                                                                      }
                                                                  }
                                                              }
                                                          ],
                                                          "required": [
                                                              "required",
                                                              "optional"
                                                          ]
                                                      },
                                                      "value": {
                                                          "type": "object",
                                                          "description": "Object defining the characteristics of valid mean values.",
                                                          "examples": [
                                                              {
                                                                  "type": "double",
                                                                  "minimum": 0
                                                              }
                                                          ],
                                                          "properties": {
                                                              "type": {
                                                                  "description": "Data type of mean values.",
                                                                  "type": "string",
                                                                  "enum": [
                                                                      "double",
                                                                      "integer"
                                                                  ]
                                                              },
                                                              "minimum": {
                                                                  "description": "The minimum inclusive valid mean value",
                                                                  "type": [
                                                                      "number",
                                                                      "integer"
                                                                  ]
                                                              },
                                                              "maximum": {
                                                                  "description": "the maximum inclusive valid mean value",
                                                                  "type": [
                                                                      "number",
                                                                      "integer"
                                                                  ]
                                                              }
                                                          },
                                                          "required": [
                                                              "type"
                                                          ]
                                                      }
                                                  },
                                                  "required": [
                                                      "output_type_id",
                                                      "value"
                                                  ]
                                              },
                                              "median": {
                                                  "type": "object",
                                                  "description": "Object defining the median of the predictive distribution output type",
                                                  "properties": {
                                                      "output_type_id": {
                                                          "description": "output_type_id is not meaningful for a median output_type. The property is primarily used to determine whether median is a required or optional output type through properties required and optional. If median is a required output type, the required property must be an array containing the single string element 'NA' and the optional property must be set to null. If median is an optional output type, the optional property must be an array containing the single string element 'NA' and the required property must be set to null",
                                                          "examples": [
                                                              {
                                                                  "required": [
                                                                      "NA"
                                                                  ],
                                                                  "optional": null
                                                              },
                                                              {
                                                                  "required": null,
                                                                  "optional": [
                                                                      "NA"
                                                                  ]
                                                              }
                                                          ],
                                                          "type": "object",
                                                          "oneOf": [
                                                              {
                                                                  "properties": {
                                                                      "required": {
                                                                          "description": "When median is required, property set to single element 'NA' array",
                                                                          "type": "array",
                                                                          "items": {
                                                                              "const": "NA",
                                                                              "maxItems": 1
                                                                          }
                                                                      },
                                                                      "optional": {
                                                                          "description": "When median is required, property set to null",
                                                                          "type": "null"
                                                                      }
                                                                  }
                                                              },
                                                              {
                                                                  "properties": {
                                                                      "required": {
                                                                          "description": "When median is optional, property set to null",
                                                                          "type": "null"
                                                                      },
                                                                      "optional": {
                                                                          "description": "When median is optional, property set to single element 'NA' array",
                                                                          "type": "array",
                                                                          "items": {
                                                                              "const": "NA",
                                                                              "maxItems": 1
                                                                          }
                                                                      }
                                                                  }
                                                              }
                                                          ],
                                                          "required": [
                                                              "required",
                                                              "optional"
                                                          ]
                                                      },
                                                      "value": {
                                                          "type": "object",
                                                          "description": "Object defining the characteristics of valid median values",
                                                          "examples": [
                                                              {
                                                                  "type": "double",
                                                                  "minimum": 0
                                                              }
                                                          ],
                                                          "properties": {
                                                              "type": {
                                                                  "description": "Data type of median values",
                                                                  "type": "string",
                                                                  "enum": [
                                                                      "double",
                                                                      "integer"
                                                                  ]
                                                              },
                                                              "minimum": {
                                                                  "description": "The minimum inclusive valid median value",
                                                                  "type": [
                                                                      "number",
                                                                      "integer"
                                                                  ]
                                                              },
                                                              "maximum": {
                                                                  "description": "the maximum inclusive valid median value",
                                                                  "type": [
                                                                      "number",
                                                                      "integer"
                                                                  ]
                                                              }
                                                          },
                                                          "required": [
                                                              "type"
                                                          ]
                                                      }
                                                  },
                                                  "required": [
                                                      "output_type_id",
                                                      "value"
                                                  ]
                                              },
                                              "quantile": {
                                                  "description": "Object defining the quantiles of the predictive distribution output type.",
                                                  "type": "object",
                                                  "properties": {
                                                      "output_type_id": {
                                                          "description": "Object containing required and optional arrays defining the probability levels at which quantiles of the predictive distribution will be recorded.",
                                                          "examples": [
                                                              {
                                                                  "required": [
                                                                      0.25,
                                                                      0.5,
                                                                      0.75
                                                                  ],
                                                                  "optional": [
                                                                      0.1,
                                                                      0.2,
                                                                      0.3,
                                                                      0.4,
                                                                      0.6,
                                                                      0.7,
                                                                      0.8,
                                                                      0.9
                                                                  ]
                                                              }
                                                          ],
                                                          "type": "object",
                                                          "properties": {
                                                              "required": {
                                                                  "description": "Array of unique probability levels between 0 and 1 that must be present for submission to be valid. Can be null if no probability levels are required and all valid probability levels are specified in the optional property.",
                                                                  "type": [
                                                                      "array",
                                                                      "null"
                                                                  ],
                                                                  "uniqueItems": true,
                                                                  "items": {
                                                                      "type": "number",
                                                                      "minimum": 0,
                                                                      "maximum": 1
                                                                  }
                                                              },
                                                              "optional": {
                                                                  "description": "Array of valid but not required unique probability levels. Can be null if all probability levels are required and are specified in the required property.",
                                                                  "type": [
                                                                      "array",
                                                                      "null"
                                                                  ],
                                                                  "uniqueItems": true,
                                                                  "items": {
                                                                      "type": "number",
                                                                      "minimum": 0,
                                                                      "maximum": 1
                                                                  }
                                                              }
                                                          },
                                                          "required": [
                                                              "required",
                                                              "optional"
                                                          ]
                                                      },
                                                      "value": {
                                                          "type": "object",
                                                          "description": "Object defining the characteristics of valid quantiles of the predictive distribution at a given probability level.",
                                                          "properties": {
                                                              "type": {
                                                                  "description": "Data type of quantile values.",
                                                                  "examples": [
                                                                      "double"
                                                                  ],
                                                                  "type": "string",
                                                                  "enum": [
                                                                      "double",
                                                                      "integer"
                                                                  ]
                                                              },
                                                              "minimum": {
                                                                  "description": "The minimum inclusive valid quantile value (optional).",
                                                                  "examples": [
                                                                      0
                                                                  ],
                                                                  "type": [
                                                                      "number",
                                                                      "integer"
                                                                  ]
                                                              },
                                                              "maximum": {
                                                                  "description": "The maximum inclusive valid quantile value (optional).",
                                                                  "type": [
                                                                      "number",
                                                                      "integer"
                                                                  ]
                                                              }
                                                          },
                                                          "required": [
                                                              "type"
                                                          ]
                                                      }
                                                  },
                                                  "required": [
                                                      "output_type_id",
                                                      "value"
                                                  ]
                                              },
                                              "cdf": {
                                                  "description": "Object defining the cumulative distribution function of the predictive distribution output type.",
                                                  "type": "object",
                                                  "properties": {
                                                      "output_type_id": {
                                                          "description": "Object containing required and optional arrays defining possible values of the target variable at which values of the cumulative distribution function of the predictive distribution will be recorded. These should be listed in order from low to high.",
                                                          "examples": [
                                                              {
                                                                  "required": [
                                                                      10,
                                                                      20
                                                                  ],
                                                                  "optional": null
                                                              },
                                                              {
                                                                  "required": [
                                                                      "EW202240",
                                                                      "EW202241",
                                                                      "EW202242",
                                                                      "EW202243",
                                                                      "EW202244",
                                                                      "EW202245",
                                                                      "EW202246",
                                                                      "EW202247"
                                                                  ],
                                                                  "optional": null
                                                              }
                                                          ],
                                                          "type": "object",
                                                          "properties": {
                                                              "required": {
                                                                  "description": "Array of unique target values that must be present for submission to be valid. Can be null if no target values are required and all valid target values are specified in the optional property.",
                                                                  "type": [
                                                                      "array",
                                                                      "null"
                                                                  ],
                                                                  "uniqueItems": true,
                                                                  "items": {
                                                                      "oneOf": [
                                                                          {
                                                                              "type": [
                                                                                  "number",
                                                                                  "integer"
                                                                              ],
                                                                              "minimum": 0
                                                                          },
                                                                          {
                                                                              "type": "string"
                                                                          }
                                                                      ]
                                                                  }
                                                              },
                                                              "optional": {
                                                                  "description": "Array of valid but not required unique target values. Can be null if all target values are required and are specified in the required property.",
                                                                  "type": [
                                                                      "array",
                                                                      "null"
                                                                  ],
                                                                  "uniqueItems": true,
                                                                  "items": {
                                                                      "oneOf": [
                                                                          {
                                                                              "type": [
                                                                                  "number",
                                                                                  "integer"
                                                                              ],
                                                                              "minimum": 0
                                                                          },
                                                                          {
                                                                              "type": "string"
                                                                          }
                                                                      ]
                                                                  }
                                                              }
                                                          },
                                                          "required": [
                                                              "required",
                                                              "optional"
                                                          ]
                                                      },
                                                      "value": {
                                                          "type": "object",
                                                          "description": "Object defining the characteristics of valid values of the cumulative distribution function at a given target value.",
                                                          "properties": {
                                                              "type": {
                                                                  "description": "Data type of cumulative distribution function values.",
                                                                  "examples": [
                                                                      "double"
                                                                  ],
                                                                  "const": "double"
                                                              },
                                                              "minimum": {
                                                                  "description": "The minimum inclusive valid cumulative distribution function value. Must be 0.",
                                                                  "const": 0
                                                              },
                                                              "maximum": {
                                                                  "description": "The maximum inclusive valid cumulative distribution function value. Must be 1.",
                                                                  "const": 1
                                                              }
                                                          },
                                                          "required": [
                                                              "type",
                                                              "minimum",
                                                              "maximum"
                                                          ]
                                                      }
                                                  },
                                                  "required": [
                                                      "output_type_id",
                                                      "value"
                                                  ]
                                              },
                                              "pmf": {
                                                  "description": "Object defining a probability mass function for a discrete variable output type. Includes nominal, binary and ordinal variable types.",
                                                  "type": "object",
                                                  "properties": {
                                                      "output_type_id": {
                                                          "description": "Object containing required and optional arrays specifying valid categories of a discrete variable. Note that for ordinal variables, the category levels should be listed in order from low to high.",
                                                          "examples": [
                                                              {
                                                                  "required": null,
                                                                  "optional": [
                                                                      "low",
                                                                      "moderate",
                                                                      "high",
                                                                      "extreme"
                                                                  ]
                                                              }
                                                          ],
                                                          "type": "object",
                                                          "properties": {
                                                              "required": {
                                                                  "description": "Array of unique categories of a discrete variable that must be present for submission to be valid. Can be null if no categories are required and all valid categories are specified in the optional property.",
                                                                  "type": [
                                                                      "array",
                                                                      "null"
                                                                  ],
                                                                  "uniqueItems": true,
                                                                  "items": {
                                                                      "type": "string"
                                                                  }
                                                              },
                                                              "optional": {
                                                                  "description": "Array of valid but not required unique categories of a discrete variable. Can be null if all categories are required and are specified in the required property.",
                                                                  "type": [
                                                                      "array",
                                                                      "null"
                                                                  ],
                                                                  "uniqueItems": true,
                                                                  "items": {
                                                                      "type": "string"
                                                                  }
                                                              }
                                                          },
                                                          "required": [
                                                              "required",
                                                              "optional"
                                                          ]
                                                      },
                                                      "value": {
                                                          "type": "object",
                                                          "description": "Object defining valid values of the probability mass function of the predictive distribution for a given category of a discrete outcome variable.",
                                                          "examples": [
                                                              {
                                                                  "type": "double",
                                                                  "minimum": 0,
                                                                  "maximum": 1
                                                              }
                                                          ],
                                                          "properties": {
                                                              "type": {
                                                                  "description": "Data type of the probability mass function values.",
                                                                  "const": "double"
                                                              },
                                                              "minimum": {
                                                                  "description": "The minimum inclusive valid probability mass function value. Must be 0.",
                                                                  "const": 0
                                                              },
                                                              "maximum": {
                                                                  "description": "The maximum inclusive valid probability mass function value. Must be 1.",
                                                                  "const": 1
                                                              }
                                                          },
                                                          "required": [
                                                              "type",
                                                              "minimum",
                                                              "maximum"
                                                          ]
                                                      }
                                                  },
                                                  "required": [
                                                      "output_type_id",
                                                      "value"
                                                  ]
                                              },
                                              "sample": {
                                                  "description": "Object defining a sample output type.",
                                                  "type": "object",
                                                  "properties": {
                                                      "output_type_id_params": {
                                                          "description": "Object containing parameters specifying how samples were drawn.",
                                                          "examples": [
                                                              {
                                                                  "output_type_id_params": {
                                                                      "is_required": true,
                                                                      "type": "integer",
                                                                      "min_samples_per_task": 100,
                                                                      "max_samples_per_task": 100
                                                                  }
                                                              },
                                                              {
                                                                  "output_type_id_params": {
                                                                      "is_required": false,
                                                                      "type": "character",
                                                                      "max_length": 6,
                                                                      "min_samples_per_task": 100,
                                                                      "max_samples_per_task": 500,
                                                                      "compound_taskid_set": [
                                                                          "origin_date",
                                                                          "horizon",
                                                                          "location",
                                                                          "variant"
                                                                      ]
                                                                  }
                                                              }
                                                          ],
                                                          "type": "object",
                                                          "properties": {
                                                              "is_required": {
                                                                  "description": "Boolean. Whether inclusion of samples is required for the submission to be valid",
                                                                  "type": "boolean"
                                                              },
                                                              "type": {
                                                                  "description": "Data type of sample indices.",
                                                                  "type": "string",
                                                                  "enum": [
                                                                      "character",
                                                                      "integer"
                                                                  ]
                                                              },
                                                              "max_length": {
                                                                  "description": "Required only if 'type' is 'character'. Positive integer representing the maximum number of characters in a sample index. Ignored if 'type' is 'integer'.",
                                                                  "type": "integer",
                                                                  "minimum": 1
                                                              },
                                                              "min_samples_per_task": {
                                                                  "description": "The minimum number of samples per individual task.",
                                                                  "type": "integer",
                                                                  "minimum": 1
                                                              },
                                                              "max_samples_per_task": {
                                                                  "description": "The maximum number of samples per individual task.",
                                                                  "type": "integer",
                                                                  "minimum": 1
                                                              },
                                                              "compound_taskid_set": {
                                                                  "description": "Optional. Specifies whether validation should factor in the presence of a compound modeling task. Each item of the array must be a task id variable name. If unspecified, defaults to all task ID variables.",
                                                                  "type": [
                                                                      "array"
                                                                  ],
                                                                  "uniqueItems": true,
                                                                  "items": {
                                                                      "type": "string"
                                                                  }
                                                              }
                                                          },
                                                          "required": [
                                                              "is_required",
                                                              "type",
                                                              "min_samples_per_task",
                                                              "max_samples_per_task"
                                                          ],
                                                          "if": {
                                                              "properties": {
                                                                  "type": {
                                                                      "const": "character"
                                                                  }
                                                              }
                                                          },
                                                          "then": {
                                                              "required": [
                                                                  "max_length"
                                                              ]
                                                          }
                                                      },
                                                      "value": {
                                                          "type": "object",
                                                          "description": "Object defining valid values of samples from the predictive distribution for a given sample index.  Depending on the Hub specification, samples with the same sample index (specified by the output_type_id) may be assumed to correspond to a joint distribution across multiple levels of the task id variables. See Hub documentation for details.",
                                                          "properties": {
                                                              "type": {
                                                                  "description": "Data type of sample value from the predictive distribution.",
                                                                  "examples": [
                                                                      {
                                                                          "type": "double"
                                                                      }
                                                                  ],
                                                                  "type": "string",
                                                                  "enum": [
                                                                      "double",
                                                                      "integer"
                                                                  ]
                                                              },
                                                              "minimum": {
                                                                  "description": "The minimum inclusive valid sample value from the predictive distribution.",
                                                                  "type": [
                                                                      "number",
                                                                      "integer"
                                                                  ]
                                                              },
                                                              "maximum": {
                                                                  "description": "The maximum inclusive valid sample value from the predictive distribution.",
                                                                  "type": [
                                                                      "number",
                                                                      "integer"
                                                                  ]
                                                              }
                                                          },
                                                          "required": [
                                                              "type"
                                                          ]
                                                      }
                                                  },
                                                  "required": [
                                                      "output_type_id_params",
                                                      "value"
                                                  ]
                                              }
                                          },
                                          "additionalProperties": false
                                      },
                                      "target_metadata": {
                                          "description": "Array of objects containing metadata about each unique target, one object for each unique target value.",
                                          "type": "array",
                                          "items": {
                                              "type": "object",
                                              "description": "Object containg metadata about a single unique target.",
                                              "properties": {
                                                  "target_id": {
                                                      "description": "Short description that uniquely identifies the target.",
                                                      "examples": [
                                                          "inc hosp",
                                                          "peak week hosp"
                                                      ],
                                                      "type": "string",
                                                      "maxLength": 30
                                                  },
                                                  "target_name": {
                                                      "description": "A longer human readable target description that could be used, for example, as a visualisation axis label.",
                                                      "examples": [
                                                          "Weekly incident influenza hospitalizations",
                                                          "Peak week for incident influenza hospitalizations"
                                                      ],
                                                      "type": "string",
                                                      "maxLength": 100
                                                  },
                                                  "target_units": {
                                                      "description": "Unit of observation of the target.",
                                                      "examples": [
                                                          "rate per 100,000 population",
                                                          "count",
                                                          "date"
                                                      ],
                                                      "type": "string",
                                                      "maxLength": 100
                                                  },
                                                  "target_keys": {
                                                      "description": "Should be either null, in the case where the target is not specified as a task_id and is specified solely through the target_id target_metadata property or an object with one or more properties, the names of which match task_id variable(s) named within the same model_tasks object. Each property should have one specified value. Each value, or the combination of values if multiple keys are specified, define a single target value.",
                                                      "examples": [
                                                          {
                                                              "target": "inc hosp"
                                                          },
                                                          {
                                                              "target": "peak week hosp"
                                                          },
                                                          {
                                                              "target_variable": "hosp",
                                                              "target_outcome": "inc"
                                                          },
                                                          {
                                                              "target_variable": "case",
                                                              "target_outcome": "peak week"
                                                          },
                                                          null
                                                      ],
                                                      "type": [
                                                          "object",
                                                          "null"
                                                      ]
                                                  },
                                                  "description": {
                                                      "description": "a verbose description of the target that might include information such as the target_measure above, or definitions of a 'rate' or similar.",
                                                      "type": "string"
                                                  },
                                                  "target_type": {
                                                      "description": "Target statistical data type",
                                                      "examples": [
                                                          "discrete",
                                                          "ordinal"
                                                      ],
                                                      "type": "string",
                                                      "enum": [
                                                          "continuous",
                                                          "discrete",
                                                          "date",
                                                          "binary",
                                                          "nominal",
                                                          "ordinal",
                                                          "compositional"
                                                      ]
                                                  },
                                                  "is_step_ahead": {
                                                      "description": "Whether the target is part of a sequence of values",
                                                      "examples": [
                                                          true,
                                                          false
                                                      ],
                                                      "type": "boolean"
                                                  },
                                                  "time_unit": {
                                                      "description": " if is_step_ahead is true, then this is required and defines the unit of time steps. if is_step_ahead is false, then this should be left out and/or will be ignored if present.",
                                                      "examples": [
                                                          "week"
                                                      ],
                                                      "type": "string",
                                                      "enum": [
                                                          "day",
                                                          "week",
                                                          "month"
                                                      ]
                                                  }
                                              },
                                              "required": [
                                                  "target_id",
                                                  "target_name",
                                                  "target_units",
                                                  "target_type",
                                                  "target_keys",
                                                  "is_step_ahead"
                                              ],
                                              "additionalProperties": false,
                                              "if": {
                                                  "properties": {
                                                      "is_step_ahead": {
                                                          "const": true
                                                      }
                                                  }
                                              },
                                              "then": {
                                                  "required": [
                                                      "time_unit"
                                                  ]
                                              }
                                          }
                                      }
                                  },
                                  "required": [
                                      "task_ids",
                                      "output_type",
                                      "target_metadata"
                                  ]
                              }
                          },
                          "submissions_due": {
                              "description": "Object defining the dates by which model forecasts must be submitted to the hub.",
                              "examples": [
                                  {
                                      "start": "2022-06-07",
                                      "end": "2022-07-20"
                                  },
                                  {
                                      "relative_to": "origin_date",
                                      "start": -4,
                                      "end": 2
                                  }
                              ],
                              "type": "object",
                              "oneOf": [
                                  {
                                      "properties": {
                                          "relative_to": {
                                              "description": "Name of task id variable in relation to which submission start and end dates are calculated.",
                                              "type": "string"
                                          },
                                          "start": {
                                              "description": "Difference in days between start and origin date.",
                                              "type": "integer"
                                          },
                                          "end": {
                                              "description": "Difference in days between end and origin date.",
                                              "type": "integer"
                                          }
                                      },
                                      "required": [
                                          "relative_to",
                                          "start",
                                          "end"
                                      ]
                                  },
                                  {
                                      "properties": {
                                          "start": {
                                              "description": "Submission start date.",
                                              "type": "string",
                                              "format": "date"
                                          },
                                          "end": {
                                              "description": "Submission end date.",
                                              "type": "string",
                                              "format": "date"
                                          }
                                      },
                                      "required": [
                                          "start",
                                          "end"
                                      ]
                                  }
                              ],
                              "required": [
                                  "start",
                                  "end"
                              ]
                          },
                          "last_data_date": {
                              "description": "The last date with recorded data in the data set used as input to a model.",
                              "examples": [
                                  "2022-07-18"
                              ],
                              "type": "string",
                              "format": "date"
                          },
                          "file_format": {
                              "description": "Accepted file formats of model output files for the round. Overrides the file formats provided in admin.json.",
                              "examples": [
                                  [
                                      "arrow",
                                      "parquet"
                                  ],
                                  [
                                      "csv"
                                  ]
                              ],
                              "type": "array",
                              "items": {
                                  "type": "string",
                                  "enum": [
                                      "csv",
                                      "parquet",
                                      "arrow"
                                  ]
                              }
                          }
                      },
                      "required": [
                          "round_id_from_variable",
                          "round_id",
                          "model_tasks",
                          "submissions_due"
                      ],
                      "additionalProperties": true
                  }
              },
              "output_type_id_datatype": {
                  "description": "The hub level data type of the output_type_id column. This data type must be shared across all files in the hub and be able to represent all output type ID values across all hub output types and rounds. If not provided or set to 'auto', hub defaults to autodetecting the simplest hub level data type.",
                  "default": "auto",
                  "examples": [
                      "character"
                  ],
                  "type": "string",
                  "enum": [
                      "auto",
                      "character",
                      "double",
                      "integer",
                      "logical",
                      "Date"
                  ]
              }
          },
          "required": [
              "rounds",
              "schema_version"
          ],
          "additionalProperties": false
      }
       

# download_tasks_schema schema version work

    Code
      str(download_tasks_schema(schema_version = "v2.0.1"), 4L)
    Output
      List of 8
       $ $schema             : chr "https://json-schema.org/draft/2020-12/schema"
       $ $id                 : chr "https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.1/tasks-schema.json"
       $ title               : chr "Schema for Modeling Hub model task definitions"
       $ description         : chr "This is the schema of the tasks.json configuration file that defines the tasks within a modeling hub."
       $ type                : chr "object"
       $ properties          :List of 2
        ..$ schema_version:List of 4
        .. ..$ description: chr "URL to a version of the Modeling Hub schema tasks-schema.json file (see https://github.com/hubverse-org/schemas"| __truncated__
        .. ..$ examples   : chr "https://raw.githubusercontent.com/hubverse-org/schemas/main/v0.0.1/tasks-schema.json"
        .. ..$ type       : chr "string"
        .. ..$ format     : chr "uri"
        ..$ rounds        :List of 3
        .. ..$ description: chr "Array of modeling round properties"
        .. ..$ type       : chr "array"
        .. ..$ items      :List of 5
        .. .. ..$ type                : chr "object"
        .. .. ..$ description         : chr "Individual modeling round properties"
        .. .. ..$ properties          :List of 7
        .. .. ..$ required            : chr [1:4] "round_id_from_variable" "round_id" "model_tasks" "submissions_due"
        .. .. ..$ additionalProperties: logi FALSE
       $ required            : chr [1:2] "rounds" "schema_version"
       $ additionalProperties: logi FALSE
