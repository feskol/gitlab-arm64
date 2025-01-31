# GitLab (CE/EE) Docker Image for ARM64

[![build-github-action][github-actions-badge-build]][github-actions-build]
[![syncversion-github-action][github-actions-badge-syncversion]][github-actions-syncversion]
[![GitHub Discussions][github-discussions-badge]][github-discussions-link]  
[![Docker Image][feskol-docker-image-badge]][dockerhub-link]
[![Docker Pulls][dockerhub-badge-pulls]][dockerhub-tags]
[![gitlab-ce-latest-arm][dockerhub-badge-latest-version-ce-arm]][dockerhub-tags]
[![gitlab-ee-latest-arm][dockerhub-badge-latest-version-ee-arm]][dockerhub-tags]
[![gitlab-ce-latest-arm-size][dockerhub-badge-image-size-ce-arm]][dockerhub-tags]
[![gitlab-ee-latest-arm-size][dockerhub-badge-image-size-ee-arm]][dockerhub-tags]  
[![Supported GitLab Versions][supported-gitlab-versions-badge]][dockerhub-link]  
[![Buy Me A Coffee][support-badge-buy-me-coffee]][support-buy-me-coffee]
[![PayPal][support-badge-paypal-me]][support-paypal-me]

[github-actions-build]: https://github.com/feskol/gitlab-arm64/actions/workflows/build.yml?query=branch%3Amain

[github-actions-badge-build]: https://github.com/feskol/gitlab-arm64/actions/workflows/build.yml/badge.svg?branch=main

[github-actions-syncversion]: https://github.com/feskol/gitlab-arm64/actions/workflows/syncversion.yml?query=branch%3Amain

[github-actions-badge-syncversion]: https://github.com/feskol/gitlab-arm64/actions/workflows/syncversion.yml/badge.svg?branch=main

[github-discussions-badge]: https://img.shields.io/github/discussions/feskol/gitlab-arm64?logo=github&logoColor=959da5&label=Discussions&labelColor=333a40&color=f479bb

[github-discussions-link]: https://github.com/feskol/gitlab-arm64/discussions

[feskol-docker-image-badge]: https://img.shields.io/badge/Image-feskol/gitlab-blue?logo=docker

[dockerhub-link]: https://hub.docker.com/r/feskol/gitlab

[dockerhub-tags]: https://hub.docker.com/r/feskol/gitlab/tags

[dockerhub-badge-pulls]: https://img.shields.io/docker/pulls/feskol/gitlab?logo=docker

[dockerhub-badge-latest-version-ce-arm]: https://img.shields.io/docker/v/feskol/gitlab/ce?arch=arm64&label=gitlab-ce&logo=docker

[dockerhub-badge-latest-version-ee-arm]: https://img.shields.io/docker/v/feskol/gitlab/ee?arch=arm64&label=gitlab-ee&logo=docker

[dockerhub-badge-image-size-ce-arm]: https://img.shields.io/docker/image-size/feskol/gitlab/ce?arch=arm64&label=gitlab-ce&logo=docker

[dockerhub-badge-image-size-ee-arm]: https://img.shields.io/docker/image-size/feskol/gitlab/ee?arch=arm64&label=gitlab-ee&logo=docker

[supported-gitlab-versions-badge]: https://img.shields.io/badge/Supported_GitLab_Versions-^17-orange?logo=gitlab

[support-buy-me-coffee]: https://buymeacoffee.com/feskol

[support-badge-buy-me-coffee]: https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?&logo=buy-me-a-coffee&logoColor=black

[support-paypal-me]: https://paypal.me/feskol

[support-badge-paypal-me]: https://img.shields.io/badge/PayPal_Me-003087?logo=paypal&logoColor=fff

[dockerhub-badge-latest-version-ce-amd]: https://img.shields.io/docker/v/feskol/gitlab/ce?arch=amd64&label=AMD64:%20gitlab-ce&logo=docker

[dockerhub-badge-latest-version-ee-amd]: https://img.shields.io/docker/v/feskol/gitlab/ee?arch=amd64&label=AMD64:%20gitlab-ee&logo=docker

[dockerhub-badge-image-size-ce-amd]: https://img.shields.io/docker/image-size/feskol/gitlab/ce?arch=amd64&label=AMD64:%20gitlab-ce&logo=docker

[dockerhub-badge-image-size-ee-amd]: https://img.shields.io/docker/image-size/feskol/gitlab/ee?arch=amd64&label=AMD64:%20gitlab-ee&logo=docker

## 🚀 Overview

This repository provides **GitLab Docker images for ARM64 architecture**.

GitLab does not officially support ARM64 yet.
As a result, GitLab does not provide **Docker images for ARM64**.
While there are some repositories that attempt to address this issue, they often take time to release updates.
This poses a challenge, especially when a security patch requires an immediate update.

To solve this problem, I created this repository providing a GitHub Action that checks for new releases daily and
automatically builds a **Docker image** for the latest releases.

The ARM64 Docker images are typically available on the [Docker Hub `feskol/gitlab`][dockerhub-tags] within 12 hours
after the official GitLab Docker images are released.

## ✨ Features

- **Automated Updates**:  
  A GitHub Action checks the latest releases of the official GitLab Docker images and triggers the build process when
  a new version is available.  
  This ensures the repository always provides up-to-date images for ARM64.

- **Fully Automatic**:  
  No manual intervention is required. The entire process, from release checking to image building is automated.

- **Compatibility**:  
  These images are build for **ARM64 architecture**, making GitLab accessible to users on **ARM-based platforms**.  
  They are also compatible with **AMD64 architecture**. For more details,
  see [Multi-Architecture Support](#-multi-architecture-support)

## 📋 Requirements

To use the Docker images built by this repository, you need:

- **ARM64 Architecture** (e.g. Raspberry Pi 4/5, ARM64 servers)
  or **AMD64 Architecture** (See [Multi-Architecture Support](#-multi-architecture-support))
- **Docker** installed on your system

## 🛠️ Usage

Pull the Docker images from [Docker Hub][dockerhub-tags].

```bash
# latest GitLab Community Edition (CE)
docker pull feskol/gitlab:latest
docker pull feskol/gitlab:ce     # "ce" is same as "latest"

# latest GitLab Enterprise Edition (EE)
docker pull feskol/gitlab:ee

# Specific version - replace "-ce" to "-ee" for Enterprise Edition
docker pull feskol/gitlab:17-ce
docker pull feskol/gitlab:17.7-ce
docker pull feskol/gitlab:17.7.0-ce
docker pull feskol/gitlab:17.7.0-ce.0
```

These images are used like GitLab’s official Docker images.  
Refer to **GitLab's Docker** documentation for setup instructions:

- https://docs.gitlab.com/ee/install/docker/installation.html

Here’s an example setup using `docker-compose.yaml`:

```yaml
services:
    gitlab:
        image: feskol/gitlab:17.7.0-ce # change the tag to your needs
        container_name: gitlab
        restart: unless-stopped
        hostname: 'gitlab.example.com'
        environment:
            GITLAB_OMNIBUS_CONFIG: |
                # Add any other gitlab.rb configuration here, each on its own line
                # For example: Reduce the number of running workers in order to reduce memory usage
                puma['worker_processes'] = 2
                sidekiq['concurrency'] = 9
        ports:
            - '80:80'
            - '443:443'
            - '22:22'
        volumes:
            - './config:/etc/gitlab'
            - './logs:/var/log/gitlab'
            - './data:/var/opt/gitlab'
        shm_size: '256m'
```

---

## 🐳 Multi-Architecture Support

[![gitlab-ce-latest-amd][dockerhub-badge-latest-version-ce-amd]][dockerhub-tags]
[![gitlab-ee-latest-amd][dockerhub-badge-latest-version-ee-amd]][dockerhub-tags]
[![gitlab-ce-latest-amd-size][dockerhub-badge-image-size-ce-amd]][dockerhub-tags]
[![gitlab-ee-latest-amd-size][dockerhub-badge-image-size-ee-amd]][dockerhub-tags]

This repository supports multi-architecture Docker images in addition to ARM64 images. This enhancement ensures
that the Docker images can run seamlessly on both AMD64 and ARM64 architectures.

### Supported Architectures

- **ARM64**: Optimized for ARM64 systems.
- **AMD64**: Uses the official GitLab Docker image.

### Benefits

- **Cross-Platform Compatibility**: Use the same image across multiple platforms.
- **Streamlined Workflows**: Unified image tagging for multi-arch builds simplifies deployment.

### How It Works

The build process creates a docker manifest for multi-arch images. For **AMD64**, the process leverages the official
GitLab Docker image to ensure compatibility and reliability.

### Usage

To pull the appropriate image for your architecture, simply use:

```bash
docker pull feskol/gitlab:latest    # you can use here any tag from the DockerHub (e.g. 17.6.2-ce / 17.6-ce / ce )
```

Docker will automatically fetch the image matching your system architecture.

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
    - `17.6.1-ce.0` (original GitLab version)
    - `17.6.1-ce` (version without the `.0` suffix)
    - `17.6-ce` (major and minor version)
    - `17-ce` (major version only)

Find [all available tags on Docker Hub](https://hub.docker.com/r/feskol/gitlab/tags).

> [!TIP]
> You want to share your feedback on the tags? Do it [here](https://github.com/feskol/gitlab-arm64/discussions/27)!

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
        image: feskol/gitlab:17.5.4-ce # outdated version
...

# New image tag
services:
    gitlab:
        image: feskol/gitlab:17.6.2-ce # updated version
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

## 🤝 Contribution Guidelines

We welcome contributions to this project! To ensure clarity and fairness for all contributors, we require that all
contributors sign our **Contributor License Agreement (CLA)**.

By signing the CLA, you confirm that:

1. You grant us the perpetual, worldwide, non-exclusive, royalty-free, irrevocable right to use, modify, sublicense, and
   distribute your contribution as part of this project or any other project.
2. You retain ownership of your contribution, but grant us the rights necessary to use it without restriction.
3. Your contribution does not violate the rights of any third party.

### How to Sign the CLA

Before submitting a pull request, please sign the CLA using the following link:  
[Sign the CLA](https://cla-assistant.io/feskol/gitlab-arm64)

Contributions cannot be merged unless the CLA is signed.

Thank you for your contributions and for helping us build something great!

## 🧪 Testing

Tests can be found in the `./tests/unit`.  
To ensure everyone uses the same test suite, I provided a Dockerfile with a docker-compose.yaml file that runs the
tests.

We're using [bashunit](https://bashunit.typeddevs.com/) for testing our scripts. Its binary is located in the `./lib`
directory.  
To ensure dependencies remain up-to-date, a GitHub Action (`.github/workflows/bashunit-update.yml`) has been set up to
check for new releases on a weekly basis. If a new release is found, a pull request (PR) is automatically created. Since
there are existing GitHub Actions that run tests using `bashunit`, it tries to automatically merge the PR if no errors
occur.

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
├── lib                 # bashunit binary
├── scripts             # scripts for the build/syncversion workflows
└── tests
    ├── fixtures        # fixtures for the tests
    ├── helper          # helping scripts (e.g. "test-case.sh"-files)
    └── unit            # The actual tests
```

## ❤️ Support This Project

If you find this project helpful and would like to support my work:

- 🌟 **Star the repository** to show your appreciation.
- 💸 **Donate via**:
    - Buy Me a Coffe: [![Buy Me A Coffee][support-badge-buy-me-coffee]][support-buy-me-coffee]
    - PayPal: [![PayPal][support-badge-paypal-me]][support-paypal-me]

Thank you for your support!
