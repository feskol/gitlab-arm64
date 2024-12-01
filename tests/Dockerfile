# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install common packages found in GitHub's `ubuntu-latest`
RUN apt-get update && \
    apt-get install -y \
    curl \
    git \
    build-essential \
    ca-certificates \
    sudo \
    gnupg \
    lsb-release \
    jq \
    python3 \
    python3-pip \
    python3-venv \
    nodejs \
    npm \
    docker.io \
    docker-compose \
    wget \
    zip \
    unzip \
    && apt-get clean


# Optionally, add any other tools you need
RUN npm install -g yarn

# Ensure the user is created for running commands as a non-root user
RUN useradd -ms /bin/bash githubuser && \
    echo "githubuser:password" | chpasswd && \
    adduser githubuser sudo

USER githubuser

# Set the working directory
WORKDIR /home/githubuser

# Command to run when starting the container (for example, a shell)
CMD ["bash"]
