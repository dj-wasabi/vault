# wdijkerman/vault

![Docker Stars](https://img.shields.io/docker/stars/wdijkerman/vault.svg) ![Docker Pulls](https://img.shields.io/docker/pulls/wdijkerman/vault.svg) [![](https://images.microbadger.com/badges/image/wdijkerman/vault.svg)](https://microbadger.com/images/wdijkerman/vault "Get your own image badge on microbadger.com") [![Build Status](https://travis-ci.org/dj-wasabi/vault.svg?branch=master)](https://travis-ci.org/dj-wasabi/vault)

## Introduction

This is an Docker container for Vault running on Alpine.

The versions in this Docker container:

* alpine: 3.10
* vault: 1.2.3
* python: 2.7.13

### Volumes

The following volumes are available:

* /vault/ssl
* /vault/config
* /vault/audit

### User

Vault is running as user vault. With the following capabilities (which are configured in this container)it should be no problem running Vault as non-root user:

- cap_ipc_lock (Should not swap. Also `--cap-add IPC_LOCK` should be added to the command line when to start the Vault container.)

The UID used in this container is 1051. So make sure the id is already available on the host running the container when host mounts are used.

### Versions

- `0.6.2`, [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/d4fe374d29508926bed6c188b05c0764016f3a52/Dockerfile)
- `0.6.5`, [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/66494b152453c34e0094517383b2a2e38f5fdb8b/Dockerfile)
- `0.7.2`, [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/de4519d83b9c33a66d4f47dd4c0f688f358834bd/Dockerfile)
- `0.7.3`, [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/14574e99a643df5ea788c080f4407db2c1d682cb/Dockerfile)
- `0.8.0`, [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/99fd6aa38f4e7da3a4cbaa7adf74665b4a6e5f00/Dockerfile)
- `0.8.1`, [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/79b143040f4720610034ea08462957403dce7c9c/Dockerfile)
- `0.9.2`, [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/702f4fc7518d0891386f78d9f8d8f0b2b86893a5/Dockerfile)
- `0.9.6`, [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/c710ab97f1f9e86a273267fec577e320d6ce57ac/Dockerfile)
- `0.10.0`, [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/65320488ca30c444e64b743bbcf154ebf9a5a038/Dockerfile)
- `0.10.4`, [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/1b79dac2c49c6be8a0618d544c2c896ef950a5f8/Dockerfile)
- `0.11.0`, [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/9ad29339d9a3aa6a0cfe2c878673704a14ca1a66/Dockerfile)
- `1.0.3`,  [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/71d20340552532d5b31f0f08144c899b2c3754d6/Dockerfile)
- `1.1.0`,  [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/4cd23aee468f403e92fa553a0fd2924a4ac07738/Dockerfile)
- `1.1.2`,  [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/13c2601e52610fcfce497c7bb4deefcbfaef79f4/Dockerfile)
- `1.1.3`,  [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/dd8e57649842a1ad01133be2b6c5038896a9b456/Dockerfile)
- `1.2.0`,  [(Dockerfile)](https://github.com/dj-wasabi/vault/blob/1792b83ac09b1a812ab687e0cfc3b42ad9b329ea/Dockerfile)
- `1.2.0`, `latest`[(Dockerfile)](https://github.com/dj-wasabi/vault/blob/master/Dockerfile)

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
