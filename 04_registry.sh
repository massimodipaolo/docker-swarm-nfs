#!/usr/bin/env bash

#create local registry
docker stack deploy -c ./stacks/registry/docker-compose.yml registry