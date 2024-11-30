#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

# Import test-case
source ./helper/test-case.sh

function runScript() {
    # Run the original script
    node \
        --require "./workflows/syncversion/trigger-build-action/mock-github.js" \
        "../scripts/workflows/syncversion/trigger_build_action.js"
}

function tear_down() {
    ./helper/cleanup.sh
}

function test_build_run() {
    cp ./fixtures/new_ce_versions.json ./
    cp ./fixtures/new_ee_versions.json ./

    export NEW_BUILD_CE_VERSION_AVAILABLE="true"
    export NEW_BUILD_EE_VERSION_AVAILABLE="true"

    runScript

    assert_exit_code "0"
}

function test_no_tags_run() {
    echo "[]" > new_ce_versions.json
    echo "[]" > new_ee_versions.json

    export NEW_BUILD_CE_VERSION_AVAILABLE="false"
    export NEW_BUILD_EE_VERSION_AVAILABLE="false"

    runScript

    assert_exit_code "0"
}
