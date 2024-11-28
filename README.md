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
[dockerhub-badge-latest-version-ce]: https://img.shields.io/docker/v/feskol/gitlab/ce-arm64?logo=docker
[dockerhub-badge-latest-version-ee]: https://img.shields.io/docker/v/feskol/gitlab/ee-arm64?logo=docker
[dockerhub-badge-image-size-ce]: https://img.shields.io/docker/image-size/feskol/gitlab/ce-arm64?label=gitlab-ce&logo=docker
[dockerhub-badge-image-size-ee]: https://img.shields.io/docker/image-size/feskol/gitlab/ee-arm64?label=gitlab-ce&logo=docker

## Usage

```bash
services:
  gitlab:
    image: feskol/gitlab:ce-arm64 # change the tag to your needs
    container_name: gitlab
    restart: unless-stopped
    hostname: 'gitlab.example.com'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        # 
        # Reduce the number of running workers to the minimum in order to reduce memory usage
        puma['worker_processes'] = 2
        sidekiq['concurrency'] = 9
    volumes:
      - './config:/etc/gitlab'
      - './logs:/var/log/gitlab'
      - './data:/var/opt/gitlab'
    shm_size: '256m'
```

#### Tags

Check [all available tags on Dockerhub](https://hub.docker.com/r/feskol/gitlab/tags).