# Chapter 8 – Commands Cheat Sheet

docker build -t finacr.azurecr.io/finance-dashboard:1.0.0 .
Build the Finance Dashboard image and tag it for Azure Container Registry

docker run -d -p 8080:80 finacr.azurecr.io/finance-dashboard:1.0.0
Run the Finance Dashboard container locally and expose it on port 8080

docker push finacr.azurecr.io/finance-dashboard:1.0.0
Push the Finance Dashboard image to Azure Container Registry

az acr login -n finacr
Authenticate Docker with Azure Container Registry

docker pull mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
Pull a pinned Windows base image locally

docker inspect --format='{{index .RepoDigests 0}}' mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019
Retrieve the immutable digest for a base image

az acr create -g rg-finance -n finacr --sku Standard
Create an Azure Container Registry

az acr import -n finacr --source mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019 --image base/aspnet:4.8-windowsservercore-ltsc2019
Mirror a Microsoft base image into ACR

docker compose up -d
Start a Compose-defined stack in detached mode

docker compose down
Stop and remove containers defined by Compose

docker compose down -v
Stop the stack and remove associated volumes

docker compose build
Build images defined in a Docker Compose file

docker ps
List running containers

docker logs finance-dashboard
View logs from the Finance Dashboard container

docker stats
Show live resource usage for containers

docker context show
Display the currently active Docker context

docker context ls
List all configured Docker contexts

docker context create notes-remote --docker "host=ssh://user@remote-host"
Create a Docker context pointing to a remote host over SSH

docker context use notes-remote
Switch the Docker CLI to the remote context

docker context use default
Switch back to the local Docker context

docker info
Display Docker engine and host details

docker version
Display Docker client and server versions

docker login
Authenticate with Docker Hub

docker build -t yourname/notes-api:8.0 ./api
Build and tag the Notes API image

docker build -t yourname/notes-frontend:8.0 ./frontend
Build and tag the Notes frontend image

docker build -t yourname/notes-genai-summariser:8.0 ./genai-summariser
Build and tag the Notes GenAI summariser image

docker push yourname/notes-api:8.0
Push the Notes API image to a registry

docker push yourname/notes-frontend:8.0
Push the Notes frontend image to a registry

docker push yourname/notes-genai-summariser:8.0
Push the Notes GenAI summariser image to a registry

curl http://remote-host:5001/notes
Call the Notes API on a remote host

curl http://remote-host:5001/notes/summary
Call the Notes GenAI summary endpoint

docker network ls
List Docker networks

docker network inspect <network-name>
Inspect a Docker network and its attached containers

docker exec -it <container> nslookup api
Test in-container DNS resolution

docker exec -it web curl http://api:8080/health
Test direct service connectivity inside a container

docker secret create db_password secret.txt
Create a Docker secret from a file

docker system prune -f
Remove unused Docker resources

docker volume prune -f
Remove unused Docker volumes

docker image prune -f
Remove unused Docker images
