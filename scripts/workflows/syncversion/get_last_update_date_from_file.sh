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

# Fetch the last saved last modified date for gitlab-ce and gitlab-ee from the file
saved_ce_last_modified_date=$(cat .github/generated-files/last_modified_ce_date.txt || echo "")
saved_ee_last_modified_date=$(cat .github/generated-files/last_modified_ee_date.txt || echo "")

echo "Last saved modified date for gitlab-ce: $saved_ce_last_modified_date"
echo "Last saved modified date for gitlab-ee: $saved_ee_last_modified_date"

# If this is the first run, we don't have a saved date, so save the current one
if [ -z "$saved_ce_last_modified_date" ]; then
    saved_ce_last_modified_date="$LATEST_CE_LAST_UPDATE"
    echo "First run for gitlab-ce, saving last modified date: $saved_ce_last_modified_date"
    mkdir -p .github/generated-files
    echo "$saved_ce_last_modified_date" > .github/generated-files/last_modified_ce_date.txt
fi

if [ -z "$saved_ee_last_modified_date" ]; then
    saved_ee_last_modified_date="$LATEST_EE_LAST_UPDATE"
    echo "First run for gitlab-ee, saving last modified date: $saved_ee_last_modified_date"
    mkdir -p .github/generated-files
    echo "$saved_ee_last_modified_date" > .github/generated-files/last_modified_ee_date.txt
fi

echo "SAVED_CE_LAST_MODIFIED_DATE=$saved_ce_last_modified_date" >> "$GITHUB_ENV"
echo "SAVED_EE_LAST_MODIFIED_DATE=$saved_ee_last_modified_date" >> "$GITHUB_ENV"
