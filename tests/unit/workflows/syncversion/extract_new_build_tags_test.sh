#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

# Import test-case
source ./helper/test-case.sh

function runScript() {
    # Run original Script
    bash "../scripts/workflows/syncversion/extract_new_build_tags.sh"
}

function set_up_before_script() {
    export LATEST_MAJOR_CE="17"
    export LATEST_MAJOR_MINOR_CE="17.6"
    export LATEST_MAJOR_EE="17"
    export LATEST_MAJOR_MINOR_EE="17.6"
}

function set_up() {

    cp ./fixtures/own_tags.txt ./
    cp ./fixtures/gitlab_tags_ce.json ./
    cp ./fixtures/gitlab_tags_ee.json ./
}

function tear_down() {
    ./helper/cleanup.sh
}

function test_file_creation() {

    SAVED_CE_LAST_MODIFIED_DATE="2024-10-31T00:00:00.000000Z" SAVED_EE_LAST_MODIFIED_DATE="2024-10-30T00:00:00.000000Z" runScript

    assert_file_exists "new_ce_versions.json"
    assert_file_exists "new_ee_versions.json"
}

function test_found_new_build_tags() {
    SAVED_CE_LAST_MODIFIED_DATE="2024-10-31T00:00:00.000000Z" SAVED_EE_LAST_MODIFIED_DATE="2024-10-30T00:00:00.000000Z" runScript

    assert_not_empty "$(cat "new_ce_versions.json")"
    assert_not_empty "$(cat "new_ee_versions.json")"

    assert_same "$(cat ./fixtures/new_ce_versions.json)" "$(cat new_ce_versions.json)"
    assert_same "$(cat ./fixtures/new_ee_versions.json)" "$(cat new_ee_versions.json)"
}

function test_no_new_builds() {
    SAVED_CE_LAST_MODIFIED_DATE="2030-00-00T00:00:00.000000Z" SAVED_EE_LAST_MODIFIED_DATE="2030-00-00T00:00:00.000000Z" runScript

    assert_same "[]" "$(cat new_ce_versions.json)"
    assert_same "[]" "$(cat new_ee_versions.json)"
}
