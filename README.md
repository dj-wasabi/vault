# wdijkerman/vault

![Docker Stars](https://img.shields.io/docker/stars/wdijkerman/vault.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/wdijkerman/vault.svg) [![](https://images.microbadger.com/badges/image/wdijkerman/vault.svg)](https://microbadger.com/images/wdijkerman/vault "Get your own image badge on microbadger.com") [![Build Status](https://travis-ci.org/dj-wasabi/vault.svg?branch=master)](https://travis-ci.org/dj-wasabi/vault) 

## Introduction

This is an Docker container for Vault running on Alpine.

The versions in this Docker container:

* alpine: 3.5
* vault: 0.6.4
* python: 2.7.13

### Volumes

The following volumes are available:

* /vault/ssl
* /vault/config
* /vault/audit

### User

Vault is running as user vault. With the following capabilities (which are configured in this container)it should be no problem running Vault as non-root user:

- cap_ipc_lock (Should not swap. Also `--cap-add IPC_LOCK` should be added to the command line when to start the Vault)

The UID used in this container is 994. So make sure the id is already available on the host running the container when host mounts are used.

### Versions

- `0.6.4`, [(Dockerfile)](https://github.com/dj-wasabi/docker-consul/blob/master/Dockerfile)
- `0.6.5`, `latest` [(Dockerfile)](https://github.com/dj-wasabi/docker-consul/blob/master/Dockerfile)

### Python?

Python is also installed in the container. Python is used for testing the container, which is done with the tool `testinfra`.
You can see in the `tests` directory a file named `test_vault.py` which will be executed. (Still WiP)

## Install the container

Just run the following command to download the container:

```bash
docker pull wdijkerman/vault
```

### Arguments

There are several arguments that can be used for configuring this container.


CONSUL_HOST
CONSUL_PORT
CONSUL_SCHEME
CONSUL_TLS_SKIP_VERIFY
CONSUL_TOKEN

--cap-add IPC_LOCK
