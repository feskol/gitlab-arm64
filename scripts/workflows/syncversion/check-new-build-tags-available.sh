#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

set -e

# if empty "" or contains an empty array "[]"
if [[ ! -s "new_ce_versions.json" || $(jq 'length == 0' new_ce_versions.json) == "true" ]]; then
    echo "[NOT AVAILABLE] No new CE build tags"
    echo "NEW_CE_VERSIONS_AVAILABLE=false" >> $GITHUB_OUTPUT
else
    echo "[AVAILABLE] New CE build tags are available"
    echo "NEW_CE_VERSIONS_AVAILABLE=true" >> $GITHUB_OUTPUT
fi

# if empty "" or contains an empty array "[]"
if [[ ! -s "new_ee_versions.json" || $(jq 'length == 0' new_ee_versions.json) == "true" ]]; then
    echo "[NOT AVAILABLE] No new EE build tags"
    echo "NEW_EE_VERSIONS_AVAILABLE=false" >> $GITHUB_OUTPUT
else
    echo "[AVAILABLE] New EE build tags are available"
    echo "NEW_EE_VERSIONS_AVAILABLE=true" >> $GITHUB_OUTPUT
fi
