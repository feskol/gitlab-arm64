# GitLab (CE/EE) Docker Image for ARM64

[![build-github-action][github-actions-badge-build]][github-actions-build]
[![syncversion-github-action][github-actions-badge-syncversion]][github-actions-syncversion]
[![GitHub Discussions][github-discussions-badge]][github-discussions-link]  
[![Docker Image][feskol-docker-image-badge]][dockerhub-link]
[![Docker Pulls][dockerhub-badge-pulls]][dockerhub-tags]
[![gitlab-ce-latest][dockerhub-badge-latest-version-ce]][dockerhub-tags]
[![gitlab-ee-latest][dockerhub-badge-latest-version-ee]][dockerhub-tags]
[![gitlab-ce-latest-size][dockerhub-badge-image-size-ce]][dockerhub-tags]
[![gitlab-ee-latest-size][dockerhub-badge-image-size-ee]][dockerhub-tags]  
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
[github-package-gitlab]: https://github.com/feskol/gitlab-arm64/pkgs/container/gitlab
[dockerhub-badge-pulls]: https://img.shields.io/docker/pulls/feskol/gitlab?logo=docker
[dockerhub-badge-latest-version-ce]: https://img.shields.io/docker/v/feskol/gitlab/ce?label=gitlab-ce&logo=docker
[dockerhub-badge-latest-version-ee]: https://img.shields.io/docker/v/feskol/gitlab/ee?label=gitlab-ee&logo=docker
[dockerhub-badge-image-size-ce]: https://img.shields.io/docker/image-size/feskol/gitlab/ce?label=gitlab-ce&logo=docker
[dockerhub-badge-image-size-ee]: https://img.shields.io/docker/image-size/feskol/gitlab/ee?label=gitlab-ee&logo=docker
[supported-gitlab-versions-badge]: https://img.shields.io/badge/Supported_GitLab_Versions-^17_|_^18-orange?logo=gitlab
[support-buy-me-coffee]: https://buymeacoffee.com/feskol
[support-badge-buy-me-coffee]: https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?&logo=buy-me-a-coffee&logoColor=black
[support-paypal-me]: https://paypal.me/feskol
[support-badge-paypal-me]: https://img.shields.io/badge/PayPal_Me-003087?logo=paypal&logoColor=fff

> [!NOTE]  
> Starting with GitLab version `18.1`, GitLab now provides **official ARM64 Docker images**.
> 
> This repository will continue to be maintained for users who prefer our custom tags or need more time to transition to the official images.  
> From now on, all new GitLab versions that support official ARM64 images will use those images when creating our tags, ensuring compatibility and reliability.  
> Essentially, you'll be using GitLab’s official images — just with the added flexibility of our tagging system.
> 
> If you’d like to switch directly to the official Docker images:
>  - [Official Gitlab CE tags](https://hub.docker.com/r/gitlab/gitlab-ce/tags)
>  - [Official Gitlab EE tags](https://hub.docker.com/r/gitlab/gitlab-ee/tags)

## 🚀 Overview

This repository provides **GitLab Docker images for the ARM64 architecture**.

**GitLab** has officially supported **ARM64 images** since version `18.1`.
This repository was originally created before **official ARM64 Docker** images were available.
It is now maintained to support custom tags and to give users time to transition to the **official GitLab images** — if they choose to do so.

This repository provides a GitHub Action that checks for new releases daily and
automatically builds the custom **Docker image** tags using the official GitLab images.

The custom Docker image tags are typically available **within 12 hours** after the official GitLab Docker images get
released.

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

### Pull the Docker images:

The Docker images are available on [Docker Hub][dockerhub-tags] and [GitHub Packages][github-package-gitlab].  
Both registries contain identical tags.

*For clarity, we use the Docker Hub image wherever a Docker image is used.  
If you prefer to use the GitHub Packages image, simply add `ghcr.io/` as a prefix to the image name.*  
*Example: `feskol/gitlab:latest `→ `ghcr.io/feskol/gitlab:latest`*

#### Docker Hub

Pull the Docker images from [Docker Hub][dockerhub-tags].

```bash
# latest GitLab Community Edition (CE)
docker pull feskol/gitlab:latest
docker pull feskol/gitlab:ce     # "ce" is same as "latest"

# latest GitLab Enterprise Edition (EE)
docker pull feskol/gitlab:ee

# Specific version - replace "-ce" to "-ee" for Enterprise Edition
docker pull feskol/gitlab:18-ce
docker pull feskol/gitlab:18.0-ce
docker pull feskol/gitlab:18.0.1-ce
docker pull feskol/gitlab:18.0.1-ce.0
```

#### GitHub packages

Pull the Docker images from [GitHub Packages][github-package-gitlab].

```bash
# latest GitLab Community Edition (CE)
docker pull ghcr.io/feskol/gitlab:latest
docker pull ghcr.io/feskol/gitlab:ce     # "ce" is same as "latest"

# latest GitLab Enterprise Edition (EE)
docker pull ghcr.io/feskol/gitlab:ee

# Specific version - replace "-ce" to "-ee" for Enterprise Edition
docker pull ghcr.io/feskol/gitlab:18-ce
docker pull ghcr.io/feskol/gitlab:18.0-ce
docker pull ghcr.io/feskol/gitlab:18.0.1-ce
docker pull ghcr.io/feskol/gitlab:18.0.1-ce.0
```

### Setup instructions

These images are used like GitLab’s official Docker images.  
Refer to **GitLab's Docker** documentation for setup instructions:

- [https://docs.gitlab.com/ee/install/docker/installation.html](https://docs.gitlab.com/ee/install/docker/installation.html)

Here’s an example setup using `docker-compose.yaml`:

```yaml
services:
    gitlab:
        image: feskol/gitlab:18.0.1-ce # change the tag to your needs
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

3. Start the container:

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

We welcome contributions to this project!  
To ensure clarity and fairness for all contributors, we require that all
contributors sign our **Contributor License Agreement (CLA)**.

Please read the [Contribution Guidelines](.github/CONTRIBUTING.md).

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

## ❤️ Support This Project

If you find this project helpful and would like to support my work:

- 🌟 **Star the repository** to show your appreciation.
- 💸 **Donate via**:
    - Buy Me a Coffe: [![Buy Me A Coffee][support-badge-buy-me-coffee]][support-buy-me-coffee]
    - PayPal: [![PayPal][support-badge-paypal-me]][support-paypal-me]

Thank you for your support!
