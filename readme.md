# Swarm configuration

## Create a swarm
Exec **01_swarm.sh** on Leader server

~~~~
#get token to add worker
docker swarm join-token worker

#i.e. add worker node to swarm
docker swarm join --token SWMTKN-1-1r4kfznk0txz7q1jd0w7bqfzqqj5llvq477gzajeebi3oqifo1-ese7ltrr71ne7in1ys9q4c7ju 192.168.65.3:2377

#check nodes
docker node ls
~~~~

## Create overlay network for swarm services and standalone container (attachable)
Exec **02_network.sh**

## Configure main stacks
-   Edit each /stacks/{SERVICE}/.env file
-   For each /stacks/{SERVICE} folder validate environment 
    ~~~~
    docker-compose config
    ~~~~
-   Ensure that each volume map exists on host machine
-   Copy /stacks/monitoring/prometheus.yml to ${VOLUME_PATH}\prometheus\prometheus.yml
-   Copy /stacks/monitoring/grafana/provisioning folder to ${VOLUME_PATH}\grafana\provisioning
-   Exec **03_stacks.sh**
-   Check running stacks and services
    ~~~~
    docker stack ls
    docker service ls
    ~~~~
-   Troubleshooting
    ~~~~
    docker service logs SERVICE    
    ~~~~

## Create local registry
Exec **04_registry.sh**
### Push image to repo
~~~~
docker pull ubuntu
docker tag ubuntu localhost:5000/ubuntu
docker push localhost:5000/ubuntu
~~~~

# Enjoy!
[Graph monitor](http://localhost:3000)    
[Metrics query](http://localhost:9090)    
[Host metrics](http://localhost:9100)    
[Containers metrics](http://localhost:8082)    

