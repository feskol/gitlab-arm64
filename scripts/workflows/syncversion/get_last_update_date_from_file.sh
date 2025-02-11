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

get_last_update_date_from_file(){
    local edition=$1
    local folder=$2
    local file=$3
    local filePath="$folder/$file"
    local saved_last_modified_date latest_update

    # Fetch the last saved last modified date for gitlab-ce and gitlab-ee from the file
    saved_last_modified_date=$(cat "$filePath" || echo "")

    echo "Last saved modified date for gitlab-$edition: $saved_last_modified_date"

    # If this is the first run, we don't have a saved date, so save the current one
    if [ -z "$saved_last_modified_date" ]; then

        if [ "$edition" = "ce" ]; then
            latest_update="$LATEST_CE_LAST_UPDATE"
        elif [ "$edition" = "ee" ]; then
            latest_update="$LATEST_EE_LAST_UPDATE"
        fi

        saved_last_modified_date="$latest_update"

        echo "First run for gitlab-$edition, saving last modified date: $saved_last_modified_date"
        mkdir -p "$folder"
        echo "$saved_last_modified_date" > "$filePath"
    fi

    echo "SAVED_${edition^^}_LAST_MODIFIED_DATE=$saved_last_modified_date" >> "$GITHUB_ENV"
}

get_last_update_date_from_file "ce" ".github/generated-files" "last_modified_ce_date.txt"
get_last_update_date_from_file "ee" ".github/generated-files" "last_modified_ee_date.txt"
