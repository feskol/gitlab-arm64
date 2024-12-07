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

# Fetch own docker tags
feskol_url="https://hub.docker.com/v2/repositories/feskol/gitlab/tags?page_size=100"

echo "" >own_tags.txt #creates the empty file

# Loop through all pages
while [[ -n "$feskol_url" ]]; do
    # Fetch data from the current URL
    response=$(curl -s "$feskol_url")

    # Extract tags and append to file (only full image needed - with "ce.0" suffix)
    echo "$response" | jq -r '.results[].name' | grep -E "^[0-9]+\.[0-9]+\.[0-9]+-(ce|ee)\.0$" >>own_tags.txt

    # Get the next page URL (or empty if no next page)
    feskol_url=$(echo "$response" | jq -r '.next // empty')
done

echo "Fetched 'feskol/gitlab' tags"

# Fetch GitLab's ce/ee tags (tag name and last updated date)
fetch_tags() {
    local repo_name=$1
    local output_file=$2
    local last_updated_file=$3
    local gitlab_url="https://hub.docker.com/v2/namespaces/gitlab/repositories/${repo_name}/tags?page_size=100"

    # Read the last updated timestamp from the file
    if [ -f "$last_updated_file" ]; then
        last_saved_date=$(cat "$last_updated_file")
    else
        last_saved_date="1970-01-01T00:00:00.000Z"
    fi

    # Initialize an empty array to store all tags
    tags="[]"

    # Loop through all pages
    while [ -n "$gitlab_url" ]; do
        echo "Fetching: $gitlab_url"

        # Fetch the data
        response=$(curl -s "$gitlab_url")

        # Extract tags and append to the JSON array
        new_tags=$(echo "$response" | jq -c '.results | map({name: .name, last_updated: .last_updated})')
        tags=$(echo "$tags$new_tags" | jq -s 'add')

        # Find the oldest "last_updated" timestamp on the current page
        oldest_date=$(echo "$response" | jq -r '[.results[].last_updated] | sort | first')

        # Compare the oldest date with the last saved date
        if [[ "$oldest_date" < "$last_saved_date" ]]; then
            echo "All remaining tags are older than $last_saved_date. Stopping fetch."
            break
        fi

        # Get the next URL
        gitlab_url=$(echo "$response" | jq -r '.next')

        # Stop if there's no next page
        [ "$gitlab_url" == "null" ] && gitlab_url=""
    done

    # Save the result to a JSON file
    echo "$tags" | jq '.' > "$output_file"

    echo "Fetched 'gitlab/$repo_name' tags. Tags saved to $output_file"
}

# Fetch tags for both gitlab-ce and gitlab-ee
fetch_tags "gitlab-ce" "gitlab_tags_ce.json" ".github/generated-files/last_modified_ce_date.txt"
fetch_tags "gitlab-ee" "gitlab_tags_ee.json" ".github/generated-files/last_modified_ee_date.txt"
