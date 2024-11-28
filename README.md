# GitLab (CE/EE) Docker Image for ARM64

[![build-badge][github-actions-badge]][github-actions]
[![Docker Pulls][dockerhub-badge-pulls]][dockerhub]
[![Docker Image Version (latest by date)][dockerhub-badge-latest-version-ce]][dockerhub]
[![Docker Image Version (latest by date)][dockerhub-badge-latest-version-ee]][dockerhub]
[![Docker Image Size (tag)][dockerhub-badge-image-size-ce]][dockerhub]
[![Docker Image Size (tag)][dockerhub-badge-image-size-ee]][dockerhub]
[![PayPal ME](https://img.shields.io/badge/Support-PayPal.Me-00457C?logo=paypal&logoColor=00457C)](https://paypal.me/feskol)

[github-actions]: https://github.com/feskol/gitlab-arm64/actions/workflows/build.yml
[github-actions-badge]: https://github.com/feskol/gitlab-arm64/actions/workflows/build.yml/badge.svg?branch=main
[dockerhub]: https://hub.docker.com/r/feskol/gitlab/tags
[dockerhub-badge-pulls]: https://img.shields.io/docker/pulls/feskol/gitlab?logo=docker
[dockerhub-badge-latest-version-ce]: https://img.shields.io/docker/v/feskol/gitlab/ce?arch=arm64&logo=docker
[dockerhub-badge-latest-version-ee]: https://img.shields.io/docker/v/feskol/gitlab/ee?arch=arm64&logo=docker
[dockerhub-badge-image-size-ce]: https://img.shields.io/docker/image-size/feskol/gitlab/ce?label=gitlab-ce&logo=docker
[dockerhub-badge-image-size-ee]: https://img.shields.io/docker/image-size/feskol/gitlab/ee?label=gitlab-ee&logo=docker


## Overview

This repository provides **GitLab Docker images for ARM64 architecture**.

GitLab does not officially support ARM64.
As a result, GitLab does not provide official Docker images for ARM64. While there are some GitHub repositories that
attempt to address this issue, they often take time to release updates. This poses a challenge, especially when a
security patch requires an immediate update.

To solve this problem, I created a GitHub Action that checks for new releases twice a day and automatically builds a
Docker image for the latest release.

> [!IMPORTANT]  
> Currently, only the latest version of GitLab is built automatically.
> Patches for older versions are not maintained.
> For example, if the latest version is 17.6.1 and a patch is released for 17.5.10, the action will not create a Docker
> image tag for 17.5.10.

## Features

- **Automated Updates**:  
  A GitHub Action checks the latest releases of the official GitLab Docker images and triggers a build when a new version is available.  
  This ensures the repository always provides up-to-date images for ARM64.

- **Fully Automatic**:  
  No manual intervention is required. The entire process, from release checking to image building, is automated.

- **Compatibility**:  
  These images are specifically designed for ARM64 architecture, making GitLab accessible to users on ARM-based platforms.

## Requirements

To use the Docker images built by this repository, you need:
- **ARM64 Architecture** (e.g., Raspberry Pi 4/5, ARM64 servers)
- **Docker** installed on your system

## Usage

You can pull the Docker images from docker.io registry once they are published.  

```bash
# latest GitLab Community Edition (CE)
docker pull feskol/gitlab:latest
docker pull feskol/gitlab:ce          # "ce" is same as "latest"

# latest GitLab Enterprise Edition (EE)
docker pull feskol/gitlab:ee

# Specific version --- replace "-ce" to "-ee" for Enterprise Edition
docker pull feskol/gitlab:17-ce
docker pull feskol/gitlab:17.6-ce
docker pull feskol/gitlab:17.6.1-ce
```

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

---

### Tags

You can view [all available tags on Docker Hub](https://hub.docker.com/r/feskol/gitlab/tags).

The following tags are available for the Docker images, providing flexibility and alignment with GitLab's versioning system:

1. **`latest`**:  
   Points to the newest Community Edition (CE) release available.

2. **`ce`**:  
   Represents the newest Community Edition (CE) release available.

3. **`ee`**:  
   Represents the newest Enterprise Edition (EE) release available.

4. **Version-specific tags**:  
   Tags are generated based on GitLab's versioning system: **`(major).(minor).(patch)-(edition).0`**.  
   For example, if the newest version is `17.6.1-ce.0`,
   the following Docker image tags are created pointing to that version:
    - `17.6.1-ce.0` (original version)
    - `17.6.1-ce` (version without the `.0` suffix)
    - `17.6-ce` (major and minor version)
    - `17-ce` (major version only)

These tags allow you to use a specific version or track broader releases based on your requirements.

---

### Update

To update GitLab, remove the current Docker container, pull the newer image version, and restart the container.

> [!WARNING]  
> Always follow the [official update guide](https://docs.gitlab.com/ee/update/).  
> Use GitLab's [Upgrade Path Tool](https://gitlab-com.gitlab.io/support/toolbox/upgrade-path/?distro=docker) for 
> step-by-step guidance on update paths.

```bash
# Stop the docker container
docker compose down
```

```bash
# Old image tag:
services:
  gitlab:
    image: feskol/gitlab:17.6.0-ce # you need to update your tag here
...

# New image tag
services:
  gitlab:
    image: feskol/gitlab:17.6.1-ce # updated patch
...
```

````bash
# Start the docker-container
docker compose up -d
````

## Links

Here are the links necessary for this repository to function properly:
- [GitLab Omnibus Docker Files](https://gitlab.com/gitlab-org/omnibus-gitlab/-/tree/master/docker)
- [GitLab CE Versions](https://packages.gitlab.com/gitlab/gitlab-ce)
- [GitLab EE Versions](https://packages.gitlab.com/gitlab/gitlab-ee)
- [DockerHub Gitlab CE](https://hub.docker.com/r/gitlab/gitlab-ce)
- [DockerHub Gitlab EE](https://hub.docker.com/r/gitlab/gitlab-ee)

## Support Me

If you find this project helpful and would like to support my work:

- 🌟 **Star the repository** to show your appreciation.
- 💸 **Donate via PayPal**: [![PayPal ME](https://img.shields.io/badge/Support-PayPal.Me-00457C?logo=paypal&logoColor=00457C)](https://paypal.me/feskol)
- 💬 **Spread the word** by sharing this project with others.

Thank you for your support!

---

*Note: This repository does not provide installation instructions or additional configuration files beyond the GitHub Actions YAML for automating the image builds.*