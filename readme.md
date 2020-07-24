# docker-azure-cli

[![Docker Automated build](https://img.shields.io/docker/cloud/automated/tinslice/azure-cli.svg?style=flat)](https://hub.docker.com/r/tinslice/azure-cli/builds)
[![Docker Build Status](https://img.shields.io/docker/cloud/build/tinslice/azure-cli.svg?style=flat)](https://hub.docker.com/r/tinslice/azure-cli/builds)
[![license](https://img.shields.io/github/license/tinslice/docker-azure-cli.svg)](https://github.com/tinslice/docker-azure-cli)

Docker image with azure cli, terraform, helm and other useful tools

## Usage

```bash
docker run --rm -it -v /path/to/project:/workspace tinslice/azure-cli:debian-10-slim-tf0.12.29 bash
```