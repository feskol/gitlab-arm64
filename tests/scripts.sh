#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

# Here are all scripts defined to run through:
# [ATTENTION] they should have the same path as in ./scripts
SCRIPTS=(
    "workflows/syncversion/fetch_docker_tags.sh"
    "workflows/syncversion/extract_latest_available_major_version.sh"
    "workflows/syncversion/extract_latest_last_update.sh"
    "workflows/syncversion/get_last_update_date_from_file.sh"
    "workflows/syncversion/extract_new_build_tags.sh"
    "workflows/syncversion/check-new-build-tags-available.sh"
    "workflows/syncversion/trigger-build-action.sh"
    "workflows/syncversion/override_last_update_date_from_file.sh"
)
