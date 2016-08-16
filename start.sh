#!/bin/bash

# Start
docker run -d -p 8400:8400 -p 8500:8500  -p 8600:53/udp --name consul -h consul wdijkerman/consul -server -bootstrap -ui-dir /consul/ui -advertise=192.168.99.100
docker run -dit -p 8200:8200 --hostname vault --name vault vault

docker ps
