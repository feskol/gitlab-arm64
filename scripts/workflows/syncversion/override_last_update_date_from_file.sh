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

### ENVIRONMENT_VARIABLES: ###
# LATEST_CE_LAST_UPDATE
# LATEST_EE_LAST_UPDATE

override_last_update_date_from_file() {
    local edition=$1
    local folder=$2
    local file=$3
    local filePath="${folder}/${file}"
    local new_last_modified_date

    if [ "$edition" = "ce" ]; then
        new_last_modified_date="$LATEST_CE_LAST_UPDATE"
    elif [ "$edition" = "ee" ]; then
        new_last_modified_date="$LATEST_EE_LAST_UPDATE"
    fi

    mkdir -p "$folder"

    echo "${new_last_modified_date}" > "$filePath"
    echo "Overridden ${edition^^} file with new date: ${new_last_modified_date}"
}

override_last_update_date_from_file "ce" ".github/generated-files" "last_modified_ce_date.txt"
override_last_update_date_from_file "ee" ".github/generated-files" "last_modified_ee_date.txt"
