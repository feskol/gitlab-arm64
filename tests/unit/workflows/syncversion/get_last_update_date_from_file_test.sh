#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

# Import test-case
source ./helper/test-case.sh

function runScript() {
    # Run original script
    bash "../scripts/workflows/syncversion/get_last_update_date_from_file.sh"
}

function tear_down() {
    unset LATEST_CE_LAST_UPDATE LATEST_EE_LAST_UPDATE

    ./helper/cleanup.sh
}

function test_not_existing_last_modified_files() {
    export LATEST_CE_LAST_UPDATE="2024-01-01T00:00:00.000000Z"
    export LATEST_EE_LAST_UPDATE="2024-02-02T00:00:00.000000Z"

    runScript

    assert_same "2024-01-01T00:00:00.000000Z" "$(extract_value "SAVED_CE_LAST_MODIFIED_DATE" "$GITHUB_OUTPUT")"
    assert_same "2024-02-02T00:00:00.000000Z" "$(extract_value "SAVED_EE_LAST_MODIFIED_DATE" "$GITHUB_OUTPUT")"
}

function test_existing_last_modified_files() {
    cp -r ./fixtures/.github/ ./.github

    ls -l .github

    runScript

    echo "$GITHUB_OUTPUT"

    assert_same "2024-10-31T00:00:00.000000Z" "$(extract_value "SAVED_CE_LAST_MODIFIED_DATE" "$GITHUB_OUTPUT")"
    assert_same "2024-10-30T00:00:00.000000Z" "$(extract_value "SAVED_EE_LAST_MODIFIED_DATE" "$GITHUB_OUTPUT")"
}
