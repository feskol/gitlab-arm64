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

# Define the array of supported versions
SUPPORTED_GITLAB_VERSIONS=("17")
echo "Supported GitLab Versions: ${SUPPORTED_GITLAB_VERSIONS[@]}"

# Function to process tags
extract_new_build_tags() {
    local input_file="$1"
    local saved_date="$2"
    local suffix="$3"
    local highestMajorVersion="$4"
    local highestMajorMinorVersion="$5"
    local new_versions="[]"

    for tag_data in $(jq -c '.[]' "$input_file"); do
        local tag_name tag_last_updated BASE_TAG TAG_MAJOR TAG_MAJOR_MINOR TAG_MAJOR_MINOR_PATCH
        tag_name=$(echo "$tag_data" | jq -r '.name')
        tag_last_updated=$(echo "$tag_data" | jq -r '.last_updated')

        BASE_TAG=$(echo "$tag_name" | sed -E "s/-${suffix}.0$//")
        TAG_MAJOR=$(echo "$BASE_TAG" | cut -d. -f1)
        TAG_MAJOR_MINOR=$(echo "$BASE_TAG" | cut -d. -f1-2)
        TAG_MAJOR_MINOR_PATCH=$(echo "$BASE_TAG" | cut -d. -f1-3)

        if [[ " ${SUPPORTED_GITLAB_VERSIONS[@]} " =~ " ${TAG_MAJOR} " ]] && \
           [[ "$tag_name" =~ ^[0-9]+\.[0-9]+\.[0-9]+-${suffix}\.0$ ]] && \
           [[ "$tag_last_updated" > "$saved_date" ]]; then

            local LATEST_PATCH is_latest_patch
            LATEST_PATCH=$(grep -E "^${TAG_MAJOR_MINOR//./\\.}\.[0-9]+-${suffix}\.0$" own_tags.txt | sort -V | tail -n 1 | sed -E "s/-${suffix}.0$//" | cut -d. -f1-3)
            is_latest_patch=false
            if [[ "$(echo -e "$TAG_MAJOR_MINOR_PATCH\n$LATEST_PATCH" | sort -V | tail -n 1)" == "$TAG_MAJOR_MINOR_PATCH" ]]; then
                is_latest_patch=true
            fi

            local LATEST_MINOR is_latest_minor
            LATEST_MINOR=$(grep -E "^${TAG_MAJOR}\.[0-9]+\.[0-9]+-${suffix}\.0$" own_tags.txt | sort -V | tail -n 1 | sed -E "s/-${suffix}.0$//" | cut -d. -f1-2)
            is_latest_minor=false
            if [[ $is_latest_patch == "true" ]] && [[ "$(echo -e "$TAG_MAJOR_MINOR\n$LATEST_MINOR" | sort -V | tail -n 1)" == "$TAG_MAJOR_MINOR" ]]; then
                is_latest_minor=true
            fi

            local is_latest_overall=false
            if [[ "$is_latest_patch" == true && "$is_latest_minor" == true ]]; then
                if [[ "$TAG_MAJOR_MINOR" == "$highestMajorMinorVersion" && "$TAG_MAJOR" == "$highestMajorVersion" ]]; then
                    is_latest_overall=true
                fi
            fi

            # Append to JSON array
            new_versions=$(echo "$new_versions" | jq ". += [{\"tag\": \"$tag_name\", \"is_latest_patch\": $is_latest_patch, \"is_latest_minor\": $is_latest_minor, \"is_latest_overall\": $is_latest_overall}]")
        fi
    done

    echo "$new_versions"
}


# Process gitlab-ce and gitlab-ee
new_ce_versions=$(extract_new_build_tags "gitlab_tags_ce.json" "$SAVED_CE_LAST_MODIFIED_DATE" "ce" "$LATEST_MAJOR_CE" "$LATEST_MAJOR_MINOR_CE")
new_ee_versions=$(extract_new_build_tags "gitlab_tags_ee.json" "$SAVED_EE_LAST_MODIFIED_DATE" "ee" "$LATEST_MAJOR_EE" "$LATEST_MAJOR_MINOR_EE")

# Output results
echo "New CE versions json: $new_ce_versions"
echo "New EE versions json: $new_ee_versions"
echo "$new_ce_versions" > new_ce_versions.json
echo "$new_ee_versions" > new_ee_versions.json
