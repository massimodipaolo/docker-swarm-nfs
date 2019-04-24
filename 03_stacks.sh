#!/usr/bin/env bash

#mssql
env $(cat .env | grep ^[A-Z] | xargs) docker stack deploy -c docker-compose-mssql.yml mssql

#mysql
#docker stack deploy -c ./stacks/mysql/docker-compose.yml mysql

#monitoring
#docker stack deploy -c ./stacks/monitoring/docker-compose.yml monitoring

#check
#docker stack ls
#docker service ls