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
    # load fixtures
    cp "$(fixture_path "gitlab_tags_ce.json")" ./
    cp "$(fixture_path "gitlab_tags_ee.json")" ./

    # Run original Script
    bash "../scripts/workflows/syncversion/extract_latest_last_update.sh"
}

function tear_down() {
    cleanup
}

function test_extract_last_update() {
    assert_same "2024-11-26T14:18:08.419895Z" "$(extract_value "LATEST_CE_LAST_UPDATE" "$GITHUB_OUTPUT")"
    assert_same "2024-11-26T14:18:17.782724Z" "$(extract_value "LATEST_EE_LAST_UPDATE" "$GITHUB_OUTPUT")"
}
