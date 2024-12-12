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

function set_up_before_script() {
    cleanup
}

function runScript() {
    # Run original Script
    bash "../scripts/workflows/syncversion/check_new_build_tags_available.sh"
}

function tear_down() {
    cleanup
}

function test_new_build_tags_available() {
    export NEW_BUILD_CE_VERSIONS="$(fixture_path "new_ce_versions.json" | cat)"
    export NEW_BUILD_EE_VERSIONS="$(fixture_path "new_ee_versions.json" | cat)"

    echo "$NEW_BUILD_CE_VERSIONS"

    runScript

    assert_same "true" "$(extract_value "NEW_BUILD_CE_VERSION_AVAILABLE" "$GITHUB_ENV")"
    assert_same "true" "$(extract_value "NEW_BUILD_EE_VERSION_AVAILABLE" "$GITHUB_ENV")"
}

function test_no_new_build_tags_available() {
    export NEW_BUILD_CE_VERSIONS="[]"
    export NEW_BUILD_EE_VERSIONS="[]"

    runScript

    assert_same "false" "$(extract_value "NEW_BUILD_CE_VERSION_AVAILABLE" "$GITHUB_ENV")"
    assert_same "false" "$(extract_value "NEW_BUILD_EE_VERSION_AVAILABLE" "$GITHUB_ENV")"
}
