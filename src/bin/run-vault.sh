#!/usr/bin/env bash

# Consul settings
if [[ -z ${CONSUL_HOST} ]]; then
    export CONSUL_HOST=localhost
fi
if [[ -z ${CONSUL_PORT} ]]; then
    export CONSUL_PORT=8500
fi
if [[ -n ${CONSUL_SCHEME} ]]; then
    export CONSUL_SCHEME="scheme = \"${CONSUL_SCHEME}\""
else
    export CONSUL_SCHEME="scheme = \"http\""
fi
if [[ -n ${CONSUL_TOKEN} ]]; then
    export CONSUL_TOKEN="token = \"${CONSUL_TOKEN}\""
else
    export CONSUL_TOKEN=""
fi
if [[ -n ${CONSUL_TLS_SKIP_VERIFY} ]]; then
    export CONSUL_TLS_SKIP_VERIFY="tls_skip_verify = ${CONSUL_TLS_SKIP_VERIFY}"
else
    export CONSUL_TLS_SKIP_VERIFY="tls_skip_verify = 1"
fi

# Vault specific
if [[ -n ${TLS_CRT_FILE} ]]; then
    export TLS_CRT="tls_cert_file = \"${TLS_CRT_FILE}\""
    export TLS_DISABLE=0
else
    export TLS_CRT=""
    export TLS_DISABLE=1
fi
if [[ -n ${TLS_KEY_FILE} ]]; then
    export TLS_KEY="tls_key_file = \"${TLS_KEY_FILE}\""
    export TLS_DISABLE=0
else
    export TLS_KEY=""
    export TLS_DISABLE=1
fi
if [[ -n ${VAULT_LISTEN_ADDR} ]]; then
    export VAULT_LISTEN_ADDR="address = \"${VAULT_LISTEN_ADDR}\""
else
    export VAULT_LISTEN_ADDR="address = \"0.0.0.0:8200\""
fi
if [[ -n ${VAULT_TCP_CLUSTER_ADDR} ]]; then
    export VAULT_TCP_CLUSTER_ADDR="cluster_address = \"${VAULT_TCP_CLUSTER_ADDR}\""
else
    export VAULT_TCP_CLUSTER_ADDR=""
fi

if [[ ! -f /vault/config/config.hcl ]]; then
    cat <<EOF > /vault/config/config.hcl
backend "consul" {
    address = "${CONSUL_HOST}:${CONSUL_PORT}"
    check_timeout = "${CONSUL_CHECK_SECONDS:-5}s"
    path = "vault/"
    ${CONSUL_TLS_SKIP_VERIFY}
    ${CONSUL_TOKEN}
    ${CONSUL_SCHEME}
}

listener "tcp" {
    ${VAULT_LISTEN_ADDR}
    tls_disable = ${TLS_DISABLE:-1}
    ${TLS_KEY}
    ${TLS_CRT}
    ${VAULT_TCP_CLUSTER_ADDR}
}

disable_mlock = false
EOF
fi

/bin/vault server -config /vault/config/config.hcl
