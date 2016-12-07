#!/usr/bin/env bash

if [[ $(docker ps | grep vaulttest | wc -l) -eq 0 ]] ;then
    docker run -d --name consultest -p 127.0.0.1:18500:8500 -p 127.0.0.1:18400:8400 -p 127.0.0.1:18300:8300 -p 127.0.0.1:18053:53/udp 192.168.1.210:5000/consul:latest -server -bootstrap -ui-dir /consul/ui
    sleep 5
    docker run -d --name vaulttest --link consultest -p 18200:8200 --cap-add IPC_LOCK -e CONSUL_HOST=localhost -e CONSUL_PORT=8500 vaulttest
fi
