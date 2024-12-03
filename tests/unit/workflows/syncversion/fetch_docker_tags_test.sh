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

function set_up() {
    # Run the original script
    bash "../scripts/workflows/syncversion/fetch_docker_tags.sh"
}

function tear_down() {
    cleanup
}

function test_files_and_not_empty() {
    assert_file_exists "own_tags.txt"
    assert_file_exists "gitlab_tags_ce.json"
    assert_file_exists "gitlab_tags_ee.json"

    assert_not_empty "$(cat "own_tags.txt")"
    assert_not_empty "$(cat "gitlab_tags_ce.json")"
    assert_not_empty "$(cat "gitlab_tags_ee.json")"
}
