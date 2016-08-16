#!/usr/bin/env bash

if [[ $(docker ps | grep vaulttest | wc -l) -eq 0 ]]
    then docker run -d --name vaulttest vaulttest
fi