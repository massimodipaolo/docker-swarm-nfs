#!/usr/bin/env bash

#env 
export $(grep -v '^#' .env | xargs -d '\r')

#mssql
sudo -E docker stack deploy -c docker-compose-mssql.yml mssql

#mysql
sudo -E docker stack deploy -c docker-compose-mysql.yml mysql

#monitoring
sudo -E docker stack deploy -c docker-compose-monitoring.yml monitoring

#check
#docker stack ls
#docker service ls