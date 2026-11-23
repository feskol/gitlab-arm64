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
# ARM64_IMAGE_TAG
# MANIFEST_TAGS
# OFFICIAL_GITLAB_IMAGE
# IS_TEST

# Resolves an image reference to a single-platform manifest reference.
resolve_platform_ref() {
    local image="$1"
    local arch="$2"
    local raw media_type digest repo

    raw=$(docker buildx imagetools inspect --raw "$image")
    media_type=$(jq -r '.mediaType // empty' <<<"$raw")

    case "$media_type" in
        application/vnd.docker.distribution.manifest.list.v2+json | application/vnd.oci.image.index.v1+json)
            digest=$(jq -r --arg arch "$arch" '
                [.manifests[]
                    | select(.platform.os == "linux" and .platform.architecture == $arch)
                    | .digest][0] // empty' <<<"$raw")

            if [ -z "$digest" ]; then
                echo "Error: no linux/$arch manifest found in $image" >&2
                return 1
            fi

            # Strip digest and tag (keep a possible registry port intact)
            repo="${image%@*}"
            if [[ "${repo##*/}" == *:* ]]; then
                repo="${repo%:*}"
            fi

            echo "$repo@$digest"
            ;;
        *)
            echo "$image"
            ;;
    esac
}

# Split the DOCKERHUB_PUSH_TAGS into an array
IFS=',' read -r -a tags <<<"$MANIFEST_TAGS"

if [ "$IS_TEST" == "false" ]; then
    arm64_ref=$(resolve_platform_ref "$ARM64_IMAGE_TAG" "arm64")
    amd64_ref=$(resolve_platform_ref "$OFFICIAL_GITLAB_IMAGE" "amd64")
    echo "Using arm64 manifest: $arm64_ref"
    echo "Using amd64 manifest: $amd64_ref"
fi

# Loop through each tag and create and push the manifest
for tag in "${tags[@]}"; do
    if [ "$IS_TEST" == "false" ]; then
        # Create and push the multi-arch manifest
        docker buildx imagetools create \
            --tag "$tag" \
            "$arm64_ref" \
            "$amd64_ref"
    else
        echo "[TEST] Create manifest for $tag using arm64-image $ARM64_IMAGE_TAG and the official Gitlab tag $OFFICIAL_GITLAB_IMAGE"
    fi
done
