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

extract_tag(){
    local edition=$1
    local json_file=$2
    local editionUpperCase="${edition^^}"
    local latest_tag base_tag latest_major latest_major_minor

    latest_tag=$(jq -r ".[] | select(.name | test(\"^[0-9]+\\\\.[0-9]+\\\\.[0-9]+-${edition}\\\\.0$\")) | .name" "$json_file" | sort -V | tail -n 1)
    if [[ -z "$latest_tag" ]]; then
        echo "Error: No tag found for $editionUpperCase in $json_file"
        exit 1
    fi

    # Output latest ce/ee tags
    echo "Latest ${editionUpperCase} tag: $latest_tag"
    echo "LATEST_${editionUpperCase}_TAG=$latest_tag" >> "$GITHUB_OUTPUT"

    # Strip version-specific parts to generate base tags
    base_tag=$(echo "$latest_tag" | sed -E "s/-${edition}.0$//")

    # Read the highest version tag
    latest_major=$(echo "$base_tag" | cut -d. -f1)

    echo "LATEST_MAJOR_${editionUpperCase}=$latest_major" >> "$GITHUB_ENV"
    echo "${editionUpperCase} latest major: $latest_major"

    # Read the highest major.minor
    latest_major_minor=$(echo "$base_tag" | cut -d. -f1-2)

    echo "LATEST_MAJOR_MINOR_${editionUpperCase}=$latest_major_minor" >> "$GITHUB_ENV"
    echo "${editionUpperCase} latest major.minor: $latest_major_minor"
}

extract_tag "ce" gitlab_tags_ce.json
extract_tag "ee" gitlab_tags_ee.json
