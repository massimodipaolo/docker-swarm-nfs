# Swarm configuration

## Export .env file variables on leader node
~~~~
export $(grep -v '^#' .env | xargs -d '\r')
~~~~

## Create a swarm
~~~~
#leader node
sudo docker swarm init --advertise-addr $MANAGER_IP

#get token to add worker
sudo docker swarm join-token manager

#i.e. add manager(s) node to swarm
sudo docker swarm join --token SWMTKN-1-1r4kfznk0txz7q1jd0w7bqfzqqj5llvq477gzajeebi3oqifo1-ese7ltrr71ne7in1ys9q4c7ju 192.168.65.3:2377

#check nodes
sudo docker node ls
~~~~

## Mount nas on leader node, copy . in i.e. _config/swarm folder inside $NFS_MOUNT
~~~~
mkdir $NFS_MOUNT
sudo mount -t nfs4 $NFS_ADDR:$NFS_SHARE/ $NFS_MOUNT
~~~~

## Create overlay network for swarm services and standalone container (attachable)
~~~~
sudo docker network create -d overlay --attachable multi-host
~~~~

## Configure main stacks
-   For each compose file validate environment, i.e. mysql
    ~~~~
    docker-compose -f docker-compose-mysql.yml config
    ~~~~
-   Ensure that each volume map exists on nas shared folder
-   Copy /storage/prometheus/prometheus.yml to $NFS_MOUNT\prometheus\prometheus.yml and so on... 
-   Create stacks
    ~~~~
    #mssql
    sudo -E docker stack deploy -c docker-compose-mssql.yml mssql

    #mysql
    sudo -E docker stack deploy -c docker-compose-mysql.yml mysql

    #elastic
    #sudo -E docker stack deploy -c docker-compose-elastic.yml elastic

    #monitoring
    sudo -E docker stack deploy -c docker-compose-monitoring.yml monitoring
    ~~~~
-   Check running stacks and services
    ~~~~
    sudo docker stack ls
    sudo docker service ls
    ~~~~
-   Troubleshooting
    ~~~~
    sudo docker service logs {SERVICE}
    sudo docker service ps {SERVICE} --no-trunc    
    ~~~~

## Configure load balancer, [overview](https://www.slideshare.net/SreenivasMakam/docker-networking-tip-load-balancing-options)
TODO:
,
[traefik](https://dockerswarm.rocks/traefik/)
,
[HAproxy](https://www.thecuriousdev.org/haproxy-load-balancing-docker-swarm/) 
,
[nginx - 1](https://techcommunity.microsoft.com/t5/Containers/Use-NGINX-to-load-balance-across-your-Docker-Swarm-cluster/ba-p/382362)
,
[nginx - 2a](https://www.thepolyglotdeveloper.com/2017/03/nginx-reverse-proxy-containerized-docker-applications/)
,
[nginx - 2b](https://www.thepolyglotdeveloper.com/2017/05/load-balancing-docker-swarm-cluster-nginx-reverse-proxy/)

## Create local registry
~~~~
sudo -E docker stack deploy -c docker-compose-registry.yml registry
~~~~
TODO: ssl, auth

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
[Containers metrics](http://localhost:9089)    

