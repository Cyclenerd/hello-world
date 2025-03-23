# Hello World Container Image

[![Badge: Docker](https://img.shields.io/badge/Docker-%230db7ed.svg?logo=docker&logoColor=white)](#readme)
[![Badge: Linux](https://img.shields.io/badge/Linux-FCC624.svg?logo=linux&logoColor=black)](#readme)
[![Badge: License](https://img.shields.io/github/license/cyclenerd/hello-world)](https://github.com/Cyclenerd/hello-world/blob/master/LICENSE)

Ultra-lightweight Container image (<80 KB uncompressed) that outputs "Hello World."

```text
Hello World ...!
This message shows that your installation appears to be working correctly.
```

This image is designed for basic container operation verification, demonstrating:

* The host system can run containers.
* Images can be successfully retrieved from the docker.io registry.
* Containers can be created without errors.
* The created container is able to stream output to your terminal.

**Container image:**

```text
docker.io/cyclenerd/hello-world:latest
```

**Multiarch support:**

* `amd64` : Intel or AMD 64-Bit CPU (x86-64)
* `arm64` : Arm-based 64-Bit CPU (i.e. Apple silicon, AWS Graviton, Ampere Altra, Google Axion)

## Quick Start

Docker:

```bash
docker run "docker.io/cyclenerd/hello-world:latest"
```

Podman:

```bash
podman run "docker.io/cyclenerd/hello-world:latest"
```

## Building from Source

To build the image yourself, copy the files from this directory into a local directory and issue these commands.

Docker:

```bash
docker build -t myhello .
docker run myhello
```

Podman:

```bash
podman build -t myhello .
podman run myhello
```

## Acknowledgments

This image is inspired by:

* [Docker Hello World](https://github.com/docker-library/hello-world)
* [Podman Hello World](https://github.com/containers/PodmanHello)

My goal was to explore the limits of container image size reduction.

## License

All files in this repository are under the [Apache License, Version 2.0](LICENSE) unless noted otherwise.
