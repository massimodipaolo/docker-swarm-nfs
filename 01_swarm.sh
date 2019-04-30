#!/usr/bin/env bash

#sudo mount -t nfs 192.168.0.210:/volume1/Container/ /mnt/nas210

#env
export $(grep -v '^#' .env | xargs -d '\r')

#create swarm
sudo docker swarm init --advertise-addr $MANAGER_IP