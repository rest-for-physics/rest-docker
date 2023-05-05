# [REST-for-Physics](https://github.com/rest-for-physics) official Docker images repository

[![Build and Publish Docker Image](https://github.com/rest-for-physics/rest-docker/actions/workflows/build-publish.yml/badge.svg)](https://github.com/rest-for-physics/rest-docker/actions/workflows/build-publish.yml)

This repository contains the Dockerfiles used in the REST-for-Physics framework. It includes images used for CI as well as images containing a working version of the framework.

The images are built automatically using GitHub Actions and are available as [GitHub Packages](https://github.com/orgs/rest-for-physics/packages?repo_name=rest-docker).

These images contain the full dependencies for installation of the framework. There are different images for different packages / libraries of the framework in order to minimize the amount of data that needs to be downloaded. The automatic build process makes sure that all images are in sync for a given tag.

## Images

All images are based on Ubuntu 22.04.

The following base images are available:

| Image | Description |
| ----- | ----------- |
[root](https://github.com/rest-for-physics/rest-docker/pkgs/container/root) | Image containing base linux packages and the officially support ROOT version. |
[root-garfield](https://github.com/rest-for-physics/rest-docker/pkgs/container/root-garfield) | Same contents as the root image with [Garfield++](https://gitlab.cern.ch/garfield/garfieldpp) installed. |
[root-geant4](https://github.com/rest-for-physics/rest-docker/pkgs/container/root-geant4) | Geant4 installation on top of the root image. |
[root-garfield-geant4](https://github.com/rest-for-physics/rest-docker/pkgs/container/root-garfield-geant4) | Geant4 and Garfield++ installation on top of the root image. This is the most complete base image where all packages / libraries of the framework can be installed. |

We also offer an image with a working installation of the framework:

https://github.com/rest-for-physics/rest-docker/pkgs/container/framework

A user with just Docker installed can try the framework by running the following command:

```bash
docker run --rm -it ghcr.io/rest-for-physics/framework:latest restRoot
```

### Version of dependencies

In order to check the version of dependencies used in the official image (root, Geant4, Garfield++) one can run the following command:

```bash
docker run --rm -it ghcr.io/rest-for-physics/root-garfield-geant4 version.sh
```
