#!/bin/bash
#----------------------------------------------------------
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgei@pm.me>
#
# For complete copyright and license details, please refer
# to the LICENSE file distributed with this source code.
#----------------------------------------------------------

# Import test-case
source ./helper/workflows/syncversion/test-case.sh

function runScript() {
    # Run the original script
    node \
        --require "./workflows/syncversion/trigger-build-action/mock-github.js" \
        "../scripts/workflows/syncversion/trigger_build_action.js"
}

function tear_down() {
    cleanup
}

function test_build_run() {
    cp "$(fixture_path "new_ce_versions.json")" ./
    cp "$(fixture_path "new_ee_versions.json")" ./

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
