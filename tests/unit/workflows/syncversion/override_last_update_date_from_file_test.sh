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
    bash "../scripts/workflows/syncversion/override_last_update_date_from_file.sh"
}

function tear_down() {
    unset LATEST_CE_LAST_UPDATE LATEST_EE_LAST_UPDATE

    ./helper/cleanup.sh
}

function test_() {
    export LATEST_CE_LAST_UPDATE="2001-01-01T00:00:00.000000Z"
    export LATEST_EE_LAST_UPDATE="2001-01-01T00:00:00.000000Z"

    runScript

    assert_file_exists ".github/generated-files/last_modified_ce_date.txt"
    assert_file_exists ".github/generated-files/last_modified_ee_date.txt"

    assert_same "2001-01-01T00:00:00.000000Z" "$(cat ".github/generated-files/last_modified_ce_date.txt")"
    assert_same "2001-01-01T00:00:00.000000Z" "$(cat ".github/generated-files/last_modified_ee_date.txt")"
}
