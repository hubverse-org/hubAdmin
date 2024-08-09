# Config for samples handled succesfully

    Code
      out
    Output
      [1] TRUE
    Message
      v ok:  testdata/tasks-samples-pass.json (<file://testdata/tasks-samples-pass.json>) (via tasks-schema v3.0.1 (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json>))

# Config for samples fail correctly

    Code
      out
    Output
      [1] FALSE
    Message
      ! 1 schema errors: testdata/tasks-samples-error-range.json
        (<file://testdata/tasks-samples-error-range.json>) (via tasks-schema v3.0.1
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

---

    Code
      out
    Output
      [1] FALSE
    Message
      ! 1 schema errors: testdata/tasks-samples-error-task-ids.json
        (<file://testdata/tasks-samples-error-task-ids.json>) (via tasks-schema
        v3.0.1
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v3.0.1/tasks-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

# Config errors detected successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 8 schema errors: testdata/tasks-errors.json
        (<file://testdata/tasks-errors.json>) (via tasks-schema v0.0.0.9
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v0.0.0.9/tasks-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

# Dynamic config errors detected successfully by custom R validation

    Code
      out
    Output
      [1] FALSE
    Message
      ! 4 schema errors: testdata/tasks-errors-rval.json
        (<file://testdata/tasks-errors-rval.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

# Reserved hub variable task id name detected correctly

    Code
      out
    Output
      [1] FALSE
    Message
      ! 6 schema errors: testdata/tasks-errors-rval-reserved.json
        (<file://testdata/tasks-errors-rval-reserved.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

# Additional properties error successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 1 schema errors: testdata/tasks-addprop.json
        (<file://testdata/tasks-addprop.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

# Duplicate values in individual array error successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 2 schema errors: testdata/dup-in-array.json
        (<file://testdata/dup-in-array.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

# Duplicate values across property error successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 3 schema errors: testdata/dup-in-property.json
        (<file://testdata/dup-in-property.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

# Inconsistent round ID variables across model tasks error successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 2 schema errors: testdata/round-id-inconsistent.json
        (<file://testdata/round-id-inconsistent.json>) (via tasks-schema v1.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v1.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

---

    Code
      out
    Output
      [1] FALSE
    Message
      ! 2 schema errors: testdata/round-id-inconsistent2.json
        (<file://testdata/round-id-inconsistent2.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

# Duplicate round ID values across rounds error successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 5 schema errors: testdata/dup-in-round-id.json
        (<file://testdata/dup-in-round-id.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

# All null task IDs error successfully

    Code
      out
    Output
      [1] FALSE
    Message
      ! 1 schema errors: testdata/both_null_tasks_all.json
        (<file://testdata/both_null_tasks_all.json>) (via tasks-schema v2.0.0
        (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))
      i use `view_config_val_errors()` to view the errors in a table.

# Old orgname config validates successfully

    Code
      out
    Output
      [1] TRUE
    Message
      v ok:  testdata/task-old-orgname.json (<file://testdata/task-old-orgname.json>) (via tasks-schema v2.0.0 (<https://raw.githubusercontent.com/hubverse-org/schemas/main/v2.0.0/tasks-schema.json>))

