#!/usr/bin/env bash

#overlay network for swarm services and standalone container (attachable)
docker network create -d overlay --attachable multi-host