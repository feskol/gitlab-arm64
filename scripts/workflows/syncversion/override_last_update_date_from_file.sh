#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

set -e

new_ce_last_modified_date="$LATEST_CE_LAST_UPDATE"
new_ee_last_modified_date="$LATEST_EE_LAST_UPDATE"

mkdir -p .github/generated-files/

echo "${new_ce_last_modified_date}" > .github/generated-files/last_modified_ce_date.txt
echo "${new_ee_last_modified_date}" > .github/generated-files/last_modified_ee_date.txt

echo "Overridden CE file with new date: ${new_ce_last_modified_date}"
echo "Overridden EE file with new date: ${new_ee_last_modified_date}"
