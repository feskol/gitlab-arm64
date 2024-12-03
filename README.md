# GitLab (CE/EE) Docker Image for ARM64

[![build-badge][github-actions-badge-build]][github-actions-build]
[![build-badge][github-actions-badge-syncversion]][github-actions-syncversion]  
[![DOcker Image](https://img.shields.io/badge/Image-feskol/gitlab-blue?logo=docker)][dockerhub]
[![Docker Pulls][dockerhub-badge-pulls]][dockerhub-tags]
[![Docker Image Version (latest by date)][dockerhub-badge-latest-version-ce]][dockerhub-tags]
[![Docker Image Version (latest by date)][dockerhub-badge-latest-version-ee]][dockerhub-tags]
[![Docker Image Size (tag)][dockerhub-badge-image-size-ce]][dockerhub-tags]
[![Docker Image Size (tag)][dockerhub-badge-image-size-ee]][dockerhub-tags]  
[![Supported GitLab Versions](https://img.shields.io/badge/Supported_GitLab_Versions-^17-orange?logo=gitlab)][dockerhub]  
[![PayPal ME](https://img.shields.io/badge/Support_me-PayPal.Me-00457C?logo=paypal&logoColor=00457C)](https://paypal.me/feskol)

[github-actions-build]: https://github.com/feskol/gitlab-arm64/actions/workflows/build.yml

[github-actions-badge-build]: https://github.com/feskol/gitlab-arm64/actions/workflows/build.yml/badge.svg?branch=main

[github-actions-syncversion]: https://github.com/feskol/gitlab-arm64/actions/workflows/syncversion.yml

[github-actions-badge-syncversion]: https://github.com/feskol/gitlab-arm64/actions/workflows/syncversion.yml/badge.svg?branch=main

[dockerhub]: https://hub.docker.com/r/feskol/gitlab

[dockerhub-tags]: https://hub.docker.com/r/feskol/gitlab/tags

[dockerhub-badge-pulls]: https://img.shields.io/docker/pulls/feskol/gitlab?logo=docker

[dockerhub-badge-latest-version-ce]: https://img.shields.io/docker/v/feskol/gitlab/ce?arch=arm64&label=gitlab-ce&logo=docker

[dockerhub-badge-latest-version-ee]: https://img.shields.io/docker/v/feskol/gitlab/ee?arch=arm64&label=gitlab-ee&logo=docker

[dockerhub-badge-image-size-ce]: https://img.shields.io/docker/image-size/feskol/gitlab/ce?label=gitlab-ce&logo=docker

[dockerhub-badge-image-size-ee]: https://img.shields.io/docker/image-size/feskol/gitlab/ee?label=gitlab-ee&logo=docker

## 🚀 Overview

This repository provides **GitLab Docker images for ARM64 architecture**.

GitLab does not officially support ARM64.
As a result, GitLab does not provide official **Docker images for ARM64**. While there are some repositories that
attempt to address this issue, they often take time to release updates. This poses a challenge, especially when a
security patch requires an immediate update.

To solve this problem, I created this repository providing a Gitlab Action that checks for new releases twice a day and
automatically builds a **Docker image** for the latest release.

## ✨ Features

- **Automated Updates**:  
  A GitHub Action checks the latest releases of the official GitLab Docker images and triggers a build when a new
  version is available.  
  This ensures the repository always provides up-to-date images for ARM64.

- **Fully Automatic**:  
  No manual intervention is required. The entire process, from release checking to image building, is automated.

- **Compatibility**:  
  These images are specifically designed for ARM64 architecture, making GitLab accessible to users on ARM-based
  platforms.

## 📋 Requirements

To use the Docker images built by this repository, you need:

- **ARM64 Architecture** (e.g., Raspberry Pi 4/5, ARM64 servers)
- **Docker** installed on your system

## 🛠️ Usage

Pull the Docker images from [Docker Hub][dockerhub-tags].


```bash
# latest GitLab Community Edition (CE)
docker pull feskol/gitlab:latest
docker pull feskol/gitlab:ce          # "ce" is same as "latest"

# latest GitLab Enterprise Edition (EE)
docker pull feskol/gitlab:ee

# Specific version - replace "-ce" to "-ee" for Enterprise Edition
docker pull feskol/gitlab:17-ce
docker pull feskol/gitlab:17.6-ce
docker pull feskol/gitlab:17.6.1-ce
```

These images are used like GitLab’s official Docker images.  
Refer to **GitLab's Docker** documentation for setup instructions:

- https://docs.gitlab.com/ee/install/docker/installation.html

Here’s an example setup using `docker-compose.yaml`:

```yaml
services:
  gitlab:
    image: feskol/gitlab:17.6.1-ce # change the tag to your needs
    container_name: gitlab
    restart: unless-stopped
    hostname: 'gitlab.example.com'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        # Add any other gitlab.rb configuration here, each on its own line
        # Reduce the number of running workers in order to reduce memory usage
        puma['worker_processes'] = 2
        sidekiq['concurrency'] = 9
    volumes:
      - './config:/etc/gitlab'
      - './logs:/var/log/gitlab'
      - './data:/var/opt/gitlab'
    shm_size: '256m'
```

---

## 🏷️ Tags

The following tags are available for the Docker images, providing flexibility and alignment with GitLab's versioning
system:

- **`latest`**:  
  Points to the newest Community Edition (CE) release available.

- **`ce`**:  
  Represents the newest Community Edition (CE) release available.

- **`ee`**:  
  Represents the newest Enterprise Edition (EE) release available.

- **Version-specific tags**:  
  Tags are generated based on GitLab's versioning system: **`(major).(minor).(patch)-(edition).0`**.  
  For example, if the newest version is `17.6.1-ce.0`,
  the following Docker image tags are created pointing to that version:
    - `17.6.1-ce.0` (original version)
    - `17.6.1-ce` (version without the `.0` suffix)
    - `17.6-ce` (major and minor version)
    - `17-ce` (major version only)

Find [all available tags on Docker Hub](https://hub.docker.com/r/feskol/gitlab/tags).

> [!NOTE]
> This project supports **GitLab (CE/EE)** starting from version **17 and higher**!

## 🔄 Update

#### Using Docker Compose

1. Stop the container:

```bash
docker compose down
```

2. Update the `docker-compose.yaml` file to the new version tag.

```yaml
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

3. Restart the container:

````bash
docker compose up -d
````

> [!WARNING]  
> Always follow the [official update guide](https://docs.gitlab.com/ee/update/).  
> Use GitLab's [Upgrade Path Tool](https://gitlab-com.gitlab.io/support/toolbox/upgrade-path/?distro=docker) for
> step-by-step guidance on update paths.

## 🌐 Links

Here are the links used by this repository:

- [GitLab Omnibus Docker Files](https://gitlab.com/gitlab-org/omnibus-gitlab/-/tree/master/docker)
- [GitLab CE Versions](https://packages.gitlab.com/gitlab/gitlab-ce)
- [GitLab EE Versions](https://packages.gitlab.com/gitlab/gitlab-ee)
- [DockerHub Gitlab CE](https://hub.docker.com/r/gitlab/gitlab-ce)
- [DockerHub Gitlab EE](https://hub.docker.com/r/gitlab/gitlab-ee)

## ❤️ Support This Project

If you find this project helpful and would like to support my work:

- 🌟 **Star the repository** to show your appreciation.
- 💸 **Donate via PayPal**: [![PayPal ME](https://img.shields.io/badge/Support_me-PayPal.Me-00457C?logo=paypal&logoColor=00457C)](https://paypal.me/feskol)
- 💬 **Spread the word** by sharing this project with others.

Thank you for your support!

## 🧪 Testing

Tests can be found in the `./tests/unit`.  
To ensure everyone uses the same test suite, I provided a Dockerfile with a docker-compose.yaml file including a service
that runs the tests.

We're using [bashunit](https://bashunit.typeddevs.com/) for testing our scripts which is located in the `./lib`
directory.

#### Command:

To run the tests, run:

```bash
# Run all tests
docker compose run --rm test

# Run tests for specific folder
docker compose run --rm test ../lib/bashunit ./unit/workflows/build
```

If you encounter errors, try using the `--verbose` option for more details.

```bash
docker compose run --rm test ../lib/bashunit --verbose ./unit
```

#### Structure:

```
...
├── scripts
└── tests
    ├── fixtures        # containing fixtures for the tests
    ├── helper          # contains helping scripts
    ├── unit            # The actual tests
    └── workflows       # Directory with workflow-specific scripts (e.g., mocks).
```