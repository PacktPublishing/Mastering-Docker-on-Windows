# Chapter 2 Command Cheatsheet

## General Docker Commands

### List networks
docker network ls  
Shows all Docker networks and their drivers.

### Inspect a network
docker network inspect <network-name>  
Shows subnet, gateway, driver, and attached containers.

### Remove a network
docker network rm <network-name>  
Deletes a network (only if no containers are attached).

### Prune unused networks - my favourite!
docker network prune  
Deletes unused user-defined networks.

### List Docker info including plugins
docker info  
Shows system-level Docker information including available network drivers.

### List only network plugins
docker info --format "{{json .Plugins.Network}}"  
Outputs only the list of supported network drivers.

---

## Container Inspection Commands

### Inspect a container
docker inspect <container>  
Shows full container metadata including network settings.

### Get container IP address
docker inspect -f "{{ .NetworkSettings.IPAddress }}" <container>  
Returns the container's assigned IP.

### Get specific network IP
docker inspect -f "{{ .NetworkSettings.Networks.<network>.IPAddress }}" <container>  
Shows container IP on a specific network.

### Get network ID for container
docker inspect -f "{{ range .NetworkSettings.Networks }}{{ .NetworkID }}{{ end }}" <container>  
Outputs the network ID a container is attached to.

---

## Running Containers

### Run a container with a port mapping
docker run -d -p 8080:80 nginx  
Maps container port 80 to host port 8080.

### Run a container on a custom network
docker run -dit --name <name> --network <network> alpine /bin/sh  
Starts an interactive Alpine container on a user-defined network.

### Run with host networking (WSL network stack)
docker run --rm -it --network host alpine /bin/sh  
Shares the WSL2 network namespace with the container.

---

## Network Management (User-Defined Bridge)

### Create a bridge network
docker network create <network-name>  
Creates a user-defined network with built-in DNS resolution.

### Create a bridge network with custom subnet
docker network create --subnet=192.168.100.0/24 --gateway=192.168.100.1 --driver=bridge custom-bridge  
Creates a bridge network with explicit IP ranges.

### Connect a container to a network
docker network connect <network> <container>  

### Disconnect a container
docker network disconnect <network> <container>  

---

## Overlay Networks (Docker Swarm)

### Initialize Swarm mode
docker swarm init  
Enables Swarm mode to allow overlay networks.

### Create an encrypted overlay network
docker network create --driver overlay --opt encrypted <network>  
Creates an overlay network with encrypted mTLS traffic.

### Create a service on an overlay network
docker service create --name <service> --network <network> -p 8080:80 nginx  
Deploys a Swarm service attached to an overlay network.

### List services
docker service ls  

### Inspect a service
docker service inspect <service>  

### Inspect service tasks
docker service ps <service>  

---

## Connectivity Debugging

### Exec into a container
docker exec -it <container> /bin/sh  

### Ping another container by name
ping <container-name>  
Tests DNS and network connectivity.

---

## Port and Host Debugging (Windows / WSL2)

### Curl from PowerShell
curl http://localhost:<port>  

### Get WSL2 IP
wsl.exe hostname -I  
Shows the IP of the WSL VM.

### Curl the container via WSL IP
curl http://<WSL-IP>:<port>  

### Create Windows-to-WSL port proxy
netsh interface portproxy add v4tov4 listenport=<port> listenaddress=127.0.0.1 connectport=<port> connectaddress=<WSL-IP>  

---

## Windows Networking Quick Checks

### List active listeners
Get-NetTCPConnection -LocalPort <port>  

### List containers with ports
docker ps --format "table {{.Names}}\t{{.Ports}}"  

---

## Notes Service (Big Lab)

### Build Notes API image
docker build -t notes-api .  

### Create app network
docker network create notes-net  

### Run API
docker run -d --name notes-api --network notes-net -p 5000:5000 notes-api  

### Run placeholder backend
docker run -d --name notes-backend --network notes-net alpine sleep 999999  

### Test container-to-container DNS
docker exec -it notes-api ping notes-backend  

### Test from host
curl http://localhost:5000  
# if localhost fails:
wsl.exe hostname -I  
curl http://<WSL-IP>:5000  