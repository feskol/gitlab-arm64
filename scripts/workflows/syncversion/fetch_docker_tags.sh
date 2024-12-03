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

echo "" > own_tags.txt #creates the empty own_tags.txt file

# Loop through all pages
while [[ -n "$feskol_url" ]]; do
    # Fetch data from the current URL
    response=$(curl -s "$feskol_url")

    # Extract tags and append to file (only full image needed - with "ce.0" suffix)
    echo "$response" | jq -r '.results[].name' | grep -E "^[0-9]+\.[0-9]+\.[0-9]+-(ce|ee)\.0$" >> own_tags.txt

    # Get the next page URL (or empty if no next page)
    feskol_url=$(echo "$response" | jq -r '.next // empty')
done

echo "Fetched 'feskol/gitlab' tags"

# Fetch GitLab's ce/ee tags (tag name and last updated date)
gitlab_ce_url="https://hub.docker.com/v2/namespaces/gitlab/repositories/gitlab-ce/tags?page_size=100"
curl -s "$gitlab_ce_url" | jq -r '[.results[] | {name: .name, last_updated: .last_updated}]' > gitlab_tags_ce.json
echo "Fetched 'gitlab/gitlab-ce' tags"

gitlab_ee_url="https://hub.docker.com/v2/namespaces/gitlab/repositories/gitlab-ee/tags?page_size=100"
curl -s "$gitlab_ee_url" | jq -r '[.results[] | {name: .name, last_updated: .last_updated}]' > gitlab_tags_ee.json
echo "Fetched 'gitlab/gitlab-ee' tags"
