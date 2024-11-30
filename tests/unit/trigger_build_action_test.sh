#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

# Import test-case
source ./helper/test-case.sh

function set_up() {
    cp ./fixtures/new_ce_versions.json ./
    cp ./fixtures/new_ee_versions.json ./

    # Define ENV variables
    export NEW_BUILD_CE_VERSION_AVAILABLE="true"
    export NEW_BUILD_EE_VERSION_AVAILABLE="true"
}

function tear_down() {
    ./helper/cleanup.sh
}

function test_run() {
    # Run the original script
    node \
        --require "./workflows/syncversion/trigger-build-action/mock-github.js" \
        "../scripts/workflows/syncversion/trigger_build_action.js"

    assert_exit_code "0"
}
