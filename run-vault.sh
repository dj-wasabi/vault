#!/usr/bin/env bash

if [[ -z ${CONSUL_HOST} ]]; then
    echo "No CONSUL_HOST parameter given"
    exit 0
fi
if [[ -z ${CONSUL_PORT} ]]; then
    export CONSUL_PORT=8500
fi
if [[ -n ${TLS_CRT_FILE} ]]; then
    export TLS_CRT="tls_cert_file = \"${TLS_CRT_FILE}\""
else
    export TLS_CRT=""
    export TLS_DISABLE=1
fi
if [[ -n ${TLS_KEY_FILE} ]]; then
    export TLS_KEY="tls_key_file = \"${TLS_KEY_FILE}\""
else
    export TLS_KEY=""
    export TLS_DISABLE=1
fi

cat <<EOF > /vault/config.hcl
# Backend configuration specific to Consul
backend "consul" {
    address = "${CONSUL_HOST}:${CONSUL_PORT}"
    check_timeout = "${CONSUL_CHECK_SECONDS:-5}s"
    path = "vault"
}

# Vault listen configuration.
listener "tcp" {
    address = "0.0.0.0:8200"
    tls_disable = ${TLS_DISABLE:-0}
    ${TLS_KEY}
    ${TLS_CRT}
}

# A boolean. If true, this will disable the server from executing the mlock syscall to prevent memory from being swapped to disk. This is not recommended in production.
disable_mlock = false
EOF

/bin/vault server -config /vault/config.hcl
