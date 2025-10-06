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

function test_found_new_build_tags() {
    export SAVED_CE_LAST_MODIFIED_DATE="2024-10-31T00:00:00.000000Z"
    export SAVED_EE_LAST_MODIFIED_DATE="2024-10-30T00:00:00.000000Z"

    runScript

    assert_not_empty "$(extract_value "NEW_BUILD_CE_VERSIONS" "$GITHUB_ENV")"
    assert_not_empty "$(extract_value "NEW_BUILD_EE_VERSIONS" "$GITHUB_ENV")"

    new_ce_versions_fixture_path="$(fixture_path "new_ce_versions.json")"
    new_ee_versions_fixture_path="$(fixture_path "new_ee_versions.json")"
    assert_same "$(jq -c . "$new_ce_versions_fixture_path")" "$(extract_value "NEW_BUILD_CE_VERSIONS" "$GITHUB_ENV")"
    assert_same "$(jq -c . "$new_ee_versions_fixture_path")" "$(extract_value "NEW_BUILD_EE_VERSIONS" "$GITHUB_ENV")"
}

function test_no_new_builds() {
    export SAVED_CE_LAST_MODIFIED_DATE="2030-00-00T00:00:00.000000Z"
    export SAVED_EE_LAST_MODIFIED_DATE="2030-00-00T00:00:00.000000Z"

    runScript

    assert_same "[]" "$(extract_value "NEW_BUILD_CE_VERSIONS" "$GITHUB_ENV")"
    assert_same "[]" "$(extract_value "NEW_BUILD_EE_VERSIONS" "$GITHUB_ENV")"
}

function test_check_support_for_gitlab_version_starting_from_17() {
    export LATEST_MAJOR_CE="19"
    export LATEST_MAJOR_MINOR_CE="19.0"
    export LATEST_MAJOR_EE="19"
    export LATEST_MAJOR_MINOR_EE="19.0"

    cp "$(fixture_path "extract_new_build_tags/gitlab_tags_ce.json")" ./
    cp "$(fixture_path "extract_new_build_tags/gitlab_tags_ee.json")" ./

    export SAVED_CE_LAST_MODIFIED_DATE="2000-01-01T00:00:00.000000Z"
    export SAVED_EE_LAST_MODIFIED_DATE="2000-01-01T00:00:00.000000Z"

    runScript

    assert_not_contains "16.0.0-ce.0" "$(extract_value "NEW_BUILD_CE_VERSIONS" "$GITHUB_ENV")"
    assert_not_contains "15.0.0-ce.0" "$(extract_value "NEW_BUILD_CE_VERSIONS" "$GITHUB_ENV")"

    assert_contains "17.0.0-ce.0" "$(extract_value "NEW_BUILD_CE_VERSIONS" "$GITHUB_ENV")"
    assert_contains "18.0.0-ce.0" "$(extract_value "NEW_BUILD_CE_VERSIONS" "$GITHUB_ENV")"
    assert_contains "19.0.0-ce.0" "$(extract_value "NEW_BUILD_CE_VERSIONS" "$GITHUB_ENV")"

    expected="$(fixture_path "extract_new_build_tags/expected_values.json")"
    assert_same "$(jq -c . "$expected")" "$(extract_value "NEW_BUILD_CE_VERSIONS" "$GITHUB_ENV")"
}
