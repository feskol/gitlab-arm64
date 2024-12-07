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
    bash "../scripts/workflows/syncversion/extract_new_build_tags.sh"
}

function set_up() {
    export LATEST_MAJOR_CE="17"
    export LATEST_MAJOR_MINOR_CE="17.6"
    export LATEST_MAJOR_EE="17"
    export LATEST_MAJOR_MINOR_EE="17.6"

    cp "$(fixture_path "own_tags.txt")" ./
    cp "$(fixture_path "gitlab_tags_ce.json")" ./
    cp "$(fixture_path "gitlab_tags_ee.json")" ./
}

function tear_down() {
    cleanup
}

function test_file_creation() {
    export SAVED_CE_LAST_MODIFIED_DATE="2024-10-31T00:00:00.000000Z"
    export SAVED_EE_LAST_MODIFIED_DATE="2024-10-30T00:00:00.000000Z"

    runScript

    assert_file_exists new_ce_versions.json
    assert_file_exists new_ee_versions.json
}

function test_found_new_build_tags() {
    export SAVED_CE_LAST_MODIFIED_DATE="2024-10-31T00:00:00.000000Z"
    export SAVED_EE_LAST_MODIFIED_DATE="2024-10-30T00:00:00.000000Z"

    runScript

    assert_not_empty "$(cat new_ce_versions.json)"
    assert_not_empty "$(cat new_ee_versions.json)"

    new_ce_versions_fixture_path="$(fixture_path "new_ce_versions.json")"
    new_ee_versions_fixture_path="$(fixture_path "new_ee_versions.json")"
    assert_same "$(cat "$new_ce_versions_fixture_path")" "$(cat new_ce_versions.json)"
    assert_same "$(cat "$new_ee_versions_fixture_path")" "$(cat new_ee_versions.json)"
}

function test_no_new_builds() {
    export SAVED_CE_LAST_MODIFIED_DATE="2030-00-00T00:00:00.000000Z"
    export SAVED_EE_LAST_MODIFIED_DATE="2030-00-00T00:00:00.000000Z"

    runScript

    assert_same "[]" "$(cat new_ce_versions.json)"
    assert_same "[]" "$(cat new_ee_versions.json)"
}
