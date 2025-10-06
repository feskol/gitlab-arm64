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

check_files() {
    local new_versions_json="$1"
    local suffix="$2"

    # if empty "" or contains an empty array "[]"
    if [[ -z "$new_versions_json" || $(echo "$new_versions_json" | jq 'length == 0') == "true" ]]; then
        echo "[NOT AVAILABLE] No new ${suffix} build tags"
        echo "NEW_BUILD_${suffix}_VERSION_AVAILABLE=false" >> "$GITHUB_ENV"
    else
        echo "[AVAILABLE] New ${suffix} build tags are available"
        echo "NEW_BUILD_${suffix}_VERSION_AVAILABLE=true" >> "$GITHUB_ENV"
    fi
}

# Check files for CE and EE
check_files "$NEW_BUILD_CE_VERSIONS" "CE"
check_files "$NEW_BUILD_EE_VERSIONS" "EE"
