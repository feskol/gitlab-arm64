#!/bin/bash
#
# This file is part of the gitlab-arm64 project.
#
# (c) Festim Kolgeci <festim.kolgeci@pm.me>
#

export LATEST_CE_LAST_UPDATE=$(extract_value "LATEST_CE_LAST_UPDATE" "GITHUB_OUTPUT")
export LATEST_EE_LAST_UPDATE=$(extract_value "LATEST_EE_LAST_UPDATE" "GITHUB_OUTPUT")
