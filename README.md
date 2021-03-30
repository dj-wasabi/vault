# wdijkerman/vault

![Docker Stars](https://img.shields.io/docker/stars/wdijkerman/vault.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/wdijkerman/vault.svg) [![](https://images.microbadger.com/badges/image/wdijkerman/vault.svg)](https://microbadger.com/images/wdijkerman/vault "Get your own image badge on microbadger.com") [![Build Status](https://travis-ci.org/dj-wasabi/vault.svg?branch=master)](https://travis-ci.org/dj-wasabi/vault) [![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

<!--TOC-->

- [wdijkerman/vault](#wdijkermanvault)
  - [Introduction](#introduction)
    - [Volumes](#volumes)
    - [User](#user)
    - [Python?](#python)
  - [Install the container](#install-the-container)
    - [Configuration](#configuration)
  - [Tests](#tests)
  - [how to's](#how-tos)
  - [License](#license)
  - [Issues](#issues)

<!--TOC-->

## Introduction

This is an Docker container for Vault running on Alpine.

The versions in this Docker container:

* alpine: 3.12
* vault: 1.7.0
* python: 3.8.5

### Volumes

The following volumes are available:

* /vault/ssl
* /vault/config
* /vault/audit

### User

Vault is running as user vault. With the following capabilities (which are configured in this container)it should be no problem running Vault as non-root user:

- cap_ipc_lock (Should not swap. Also `--cap-add IPC_LOCK` should be added to the command line when to start the Vault container.)

The UID used in this container is 1051. So make sure the id is already available on the host running the container when host mounts are used.

### Python?

Python is also installed in the container. Python is used for testing the container, which is done with the tool `testinfra`.
You can see in the `tests` directory a file named `test_vault.py` which will be executed. (Still WiP)

## Install the container

Just run the following command to download the container:

```bash
docker pull wdijkerman/vault
```

### Configuration

Suggested to use a secure Vault running is to make sure it can not use the swap. When configuring the container, please make sure it ran with `--cap-add IPC_LOCK`.

There are 2 ways to configure Vault:

* Place your own hcl configuration files;
* Set some environment variables and basic configuration file is created;

#### Configuration file

Make sure that before you start the Vault container a file is present in the container on location `/vault/config/config.hcl`.
Please take a look at https://www.vaultproject.io/docs/configuration/index.html for correctly configuring the Vault instance.

#### Environment variables

There are several arguments that can be used for configuring this container.

Environment | Description
--- | ---
CONSUL_HOST | The fqdn or ip of the Consul agent. Default: `consul`
CONSUL_PORT | The port on which Consul is available. Default: `8500`
CONSUL_SCHEME | If consul is on http or https. Default: `http`
CONSUL_TLS_SKIP_VERIFY | If the ssl certificate should be verified or not. Default: `1`
CONSUL_TOKEN | If an Consul ACL token needs to be used for Vault.
TLS_CRT_FILE | The location to the SSL CRT file.
TLS_KEY_FILE | The location to the SSL KEY file.
VAULT_LISTEN_ADDR | The IP/fqdn on which this Vault instance is listening on.
VAULT_TCP_CLUSTER_ADDR | The IP/fqdn on which the Vault Cluster is listening on.

## Tests

Testinfra

## how to's

[Setting up a secure Consul cluster](https://werner-dijkerman.nl/2017/01/09/setting-up-a-secure-consul-cluster-with-docker/)

[Configuring Access Control Lists](https://werner-dijkerman.nl/2017/01/11/configuring-access-control-lists-in-consul/)

[Setting up a secure Vault with a Consul backend](https://werner-dijkerman.nl/2017/01/15/setting-up-a-secure-vault-with-a-consul-backend/)

## License

The MIT License (MIT)

See file: License

## Issues

Please report issues at https://github.com/dj-wasabi/vault/issues

Pull Requests are welcome!
