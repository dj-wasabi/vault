#!/bin/bash

docker stop consul
docker stop vault

docker rm consul
docker rm vault

