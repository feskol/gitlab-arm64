#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

set -e

check_files() {
    local input_file="$1"
    local suffix="$2"
    local github_output_key="$3"

    # if empty "" or contains an empty array "[]"
    if [[ ! -s "$input_file" || $(jq 'length == 0' "$input_file") == "true" ]]; then
        echo "[NOT AVAILABLE] No new ${suffix} build tags"
        echo "${github_output_key}=false" >>$GITHUB_OUTPUT
    else
        echo "[AVAILABLE] New ${suffix} build tags are available"
        echo "${github_output_key}=true" >>$GITHUB_OUTPUT
    fi
}

# write outputs
check_files "new_ce_versions.json" "CE" "NEW_BUILD_CE_VERSION_AVAILABLE"
check_files "new_ee_versions.json" "EE" "NEW_BUILD_EE_VERSION_AVAILABLE"
