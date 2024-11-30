#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

# Import test-case
source ./helper/test-case.sh

function set_up() {
    # load fixtures
    cp "./fixtures/gitlab_tags_ce.json" ./
    cp "./fixtures/gitlab_tags_ee.json" ./

    # Run original script
    bash "../scripts/workflows/syncversion/extract_latest_available_major_version.sh"
}

function tear_down() {
    ./helper/cleanup.sh
}

function test_latest_major_extraction() {
    assert_same "17" "$(extract_value "LATEST_MAJOR_CE" "GITHUB_OUTPUT")"
    assert_same "17" "$(extract_value "LATEST_MAJOR_EE" "GITHUB_OUTPUT")"
}

function test_latest_major_minor_extraction() {
    assert_same "17.6" "$(extract_value "LATEST_MAJOR_MINOR_CE" "GITHUB_OUTPUT")"
    assert_same "17.6" "$(extract_value "LATEST_MAJOR_MINOR_EE" "GITHUB_OUTPUT")"
}
