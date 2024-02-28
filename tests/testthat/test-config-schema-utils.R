test_that("version from file handled successfully", {
    expect_equal(
        get_config_file_schema_version(
            system.file(
                "testhubs/simple/hub-config/tasks.json",
                package = "hubUtils"
            ),
            config = "tasks"
        ),
        "v2.0.0"
    )

    expect_error(
        get_config_file_schema_version(
            testthat::test_path("testdata", "empty.json"),
            config = "tasks"
        )
    )
})
