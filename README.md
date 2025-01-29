# Gnuastro Deconvolution Docker Environment

This repository provides a Docker environment for running Gnuastro and its deconvolution functionality. You can either build the Docker image locally or pull it from Docker Hub to quickly set up the environment.

## Prerequisites

- Docker
- Docker-compose

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/alvaromrls/astdeconvolvedocker
cd astdeconvolvedocker
```

### 2. [A] Build the docker image (option 1)

It can take some time, you have time to make a coffe (and drink it).

```bash
docker build -t gnuastro-deconvolution .
```

### 2. [B] Pull the docker image (option 2)

If you prefer not to build the image locally, you can pull the pre-built image from Docker Hub:

```bash
docker pull alvaromrls/gnuastro-deconvolution:latest
```

### 3. Run the Docker using Docker Compose

```bash
docker-compose run dev_environment
```

## Using the Image

### Files Synchronization

The `files` folder is synchronized between the Docker container and your host system. However, since this folder is included in the `.gitignore`, changes to it will not be tracked in Git. Feel free to modify `.gitignore` for your personal use if you want to track those changes.

### DS9 Compatibility

Please note that the image does not support directly opening images with DS9 inside the Docker container. While it’s technically possible to run DS9 in Docker with additional configuration, it's easier to open the synchronized files in DS9 directly on your host system instead.
