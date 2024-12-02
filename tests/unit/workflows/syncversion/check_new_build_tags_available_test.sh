#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

# Import test-case
source ./helper/workflows/syncversion/test-case.sh

function runScript() {
    # Run original Script
    bash "../scripts/workflows/syncversion/check_new_build_tags_available.sh"
}

function tear_down() {
    cleanup
}

function test_new_build_tags_available() {
    cp "$(fixture_path "new_ce_versions.json")" ./
    cp "$(fixture_path "new_ee_versions.json")" ./

    runScript

    assert_same "true" "$(extract_value "NEW_BUILD_CE_VERSION_AVAILABLE" "$GITHUB_OUTPUT")"
    assert_same "true" "$(extract_value "NEW_BUILD_EE_VERSION_AVAILABLE" "$GITHUB_OUTPUT")"
}

function test_no_new_build_tags_available() {
    echo "[]" > new_ce_versions.json
    echo "[]" > new_ee_versions.json

    runScript

    assert_same "false" "$(extract_value "NEW_BUILD_CE_VERSION_AVAILABLE" "$GITHUB_OUTPUT")"
    assert_same "false" "$(extract_value "NEW_BUILD_EE_VERSION_AVAILABLE" "$GITHUB_OUTPUT")"
}
