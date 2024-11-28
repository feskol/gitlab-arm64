# GitLab Docker Image for ARM64

[![build-badge][github-actions-badge]][github-actions]
[![Docker Pulls][dockerhub-badge-pulls]][dockerhub]
[![Docker Image Version (latest by date)][dockerhub-badge-latest-version-ce]][dockerhub]
[![Docker Image Version (latest by date)][dockerhub-badge-latest-version-ee]][dockerhub]
[![Docker Image Size (tag)][dockerhub-badge-image-size-ce]][dockerhub]
[![Docker Image Size (tag)][dockerhub-badge-image-size-ee]][dockerhub]

[github-actions]: https://github.com/feskol/gitlab-arm64/actions/workflows/build.yml
[github-actions-badge]: https://github.com/feskol/gitlab-arm64/actions/workflows/build.yml/badge.svg?branch=main
[dockerhub]: https://hub.docker.com/r/feskol/gitlab/tags
[dockerhub-badge-pulls]: https://img.shields.io/docker/pulls/feskol/gitlab?logo=docker
[dockerhub-badge-latest-version-ce]: https://img.shields.io/docker/v/feskol/gitlab/ce?logo=docker
[dockerhub-badge-latest-version-ee]: https://img.shields.io/docker/v/feskol/gitlab/ee?logo=docker
[dockerhub-badge-image-size-ce]: https://img.shields.io/docker/image-size/feskol/gitlab/ce?label=gitlab-ce&logo=docker
[dockerhub-badge-image-size-ee]: https://img.shields.io/docker/image-size/feskol/gitlab/ee?label=gitlab-ee&logo=docker

## Overview

GitLab does not officially support ARM64.
As a result, GitLab does not provide official Docker images for ARM64. While there are some GitHub repositories that
attempt to address this issue, they often take time to release updates. This poses a challenge, especially when a
security patch requires an immediate update.

To solve this problem, I created a GitHub Action that checks for new releases daily and automatically builds a Docker
image for the latest release.

> [!IMPORTANT]  
> Currently, only the latest version of GitLab is built automatically.
> Patches for older versions are not maintained.
> For example, if the latest version is 17.6.1 and a patch is released for 17.5.10, the action will not create a Docker
> image tag for 17.5.10.

## Usage

You can use this Docker image just like the official Docker image provided by GitLab.

For installation guidance, refer to the official Docker documentation:

- https://docs.gitlab.com/ee/install/docker/installation.html

Here’s an example setup of mine:

```bash
services:
  gitlab:
    image: feskol/gitlab:17.6.1-ce # change the tag to your needs
    container_name: gitlab
    restart: unless-stopped
    hostname: 'gitlab.example.com'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        # Add any other gitlab.rb configuration here, each on its own line
        # Reduce the number of running workers to the minimum in order to reduce memory usage
        puma['worker_processes'] = 2
        sidekiq['concurrency'] = 9
    volumes:
      - './config:/etc/gitlab'
      - './logs:/var/log/gitlab'
      - './data:/var/opt/gitlab'
    shm_size: '256m'
```

### Tags

You can view [all available tags on Docker Hub](https://hub.docker.com/r/feskol/gitlab/tags).

Here’s what you need to know about the tags:

- The `latest` tag corresponds to the newest CE edition available.
- The `ce` tag also represents the newest CE edition available.
- The `ee` tag corresponds to the newest EE edition available.

> [!NOTE]
> `latest` tag is identical to the `ce` tag.

### Update

To update GitLab, remove the current Docker container, pull the newer image version, and restart the container.

```bash
# Stop the docker container
docker compose down
```

```bash
# Old image tag:
services:
  gitlab:
    image: feskol/gitlab:17.6.0 # you need to update your tag here
...

# New image tag
services:
  gitlab:
    image: feskol/gitlab:17.6.1 # updated patch
...
```

````bash
# Start the docker-container
docker compose up -d
````

> [!WARNING]  
> Always follow the [official update guide](https://docs.gitlab.com/ee/update/).  
> Use GitLab's [Upgrade Path Tool](https://gitlab-com.gitlab.io/support/toolbox/upgrade-path/) or step-by-step guidance
> on supported update paths.