#!/bin/bash
#----------------------------------------------------------
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgei@pm.me>
#
# For complete copyright and license details, please refer
# to the LICENSE file distributed with this source code.
#----------------------------------------------------------

set -e

extract_latest_last_update() {
    local edition=$1
    local json_file=$2
    local editionUpperCase="${edition^^}"
    local latest_last_update

    # Get the most recent 'last_updated' for valid release tags
    latest_last_update=$(jq -r ".[] | select(.name | test(\"^[0-9]+\\\\.[0-9]+\\\\.[0-9]+-${edition}\\\\.0$\")) | .last_updated" "$json_file" | sort -V | tail -n 1)
    if [[ -z "$latest_last_update" ]]; then
        echo "Error: Could not find the most recent 'last_updated' tag for $editionUpperCase in $json_file"
        exit 1
    fi

    echo "LATEST_${editionUpperCase}_LAST_UPDATE=$latest_last_update" >> "$GITHUB_ENV"
    echo "Latest ${editionUpperCase} last_update: $latest_last_update"
}

extract_latest_last_update "ce" gitlab_tags_ce.json
extract_latest_last_update "ee" gitlab_tags_ee.json
