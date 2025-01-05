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

function set_up() {
    # load fixtures
    cp "$(fixture_path "gitlab_tags_ce.json")" ./
    cp "$(fixture_path "gitlab_tags_ee.json")" ./

    # Run original script
    bash "../scripts/workflows/syncversion/extract_latest_available_major_version.sh"
}

function tear_down() {
    cleanup
}

function test_latest_major_extraction() {
    assert_same "17" "$(extract_value "LATEST_MAJOR_CE" "$GITHUB_ENV")"
    assert_same "17" "$(extract_value "LATEST_MAJOR_EE" "$GITHUB_ENV")"
}

function test_latest_major_minor_extraction() {
    assert_same "17.6" "$(extract_value "LATEST_MAJOR_MINOR_CE" "$GITHUB_ENV")"
    assert_same "17.6" "$(extract_value "LATEST_MAJOR_MINOR_EE" "$GITHUB_ENV")"
}

function test_latest_tags() {
    assert_same "17.6.1-ce.0" "$(extract_value "LATEST_CE_TAG" "$GITHUB_OUTPUT")"
    assert_same "17.6.1-ee.0" "$(extract_value "LATEST_EE_TAG" "$GITHUB_OUTPUT")"
}
