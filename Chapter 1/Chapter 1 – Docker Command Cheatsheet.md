# Chapter 1 – Docker Command Cheatsheet

## `wsl --status`
### Displays WSL availability, default version, and kernel status. Use to confirm WSL 2 is active.

## `wsl --list --verbose`
### Lists installed WSL distros and shows if each is version 1 or 2.

## `wsl --install`
### Enables WSL, enables Virtual Machine Platform, sets WSL 2 as default, installs Ubuntu automatically.

## `wsl --set-version <Distro> 2`
### Upgrades a WSL distribution to WSL 2.

## `wsl --shutdown`
### Stops all WSL instances so new .wslconfig settings apply.

---

## `docker run hello-world`
### Runs hello-world to verify Docker installation.

## `docker --version`
### Prints Docker CLI version.

## `docker version`
### Prints client and server versions.

## `docker info`
### Shows system-level Docker details
---

## `docker pull <image>`
### Downloads an image from Docker Hub.

## `docker pull alpine`
### Pulls Alpine Linux.

## `docker pull alpine:3.18`
### Pulls Alpine pinned to version 3.18.

---

## `docker run <image>`
### Runs a container with the default command.

## `docker run -it <image> /bin/sh`
### Starts a container and opens an interactive shell.

## `docker run node node --version`
### Executes a single command inside a Node container.

## `docker run -it --name <name> <image> /bin/sh`
### Creates and names a container and opens a shell.

## `docker run -d <image>`
### Runs a container in detached mode.

## `docker run -d -p 8080:80 nginx`
### Runs NGINX and maps port 8080 on the host to port 80 in the container.

## `docker run --rm <image> <command>`
### Runs a temporary container that auto-removes on exit.

---

## `docker ps`
### Lists running containers.

## `docker ps -a`
### Lists all containers, including stopped ones.

## `docker inspect <container>`
### Prints full JSON metadata of a container.

## `docker inspect -f "{{ .NetworkSettings.IPAddress }}" <container>`
### Outputs only a container’s IP address.

## `docker stop <container>`
### Gracefully stops a running container.

## `docker kill <container>`
### Force-kills a container.

## `docker rm <container>`
### Removes a stopped container.

## `docker rm -f <container>`
### Force-removes a running container.

## `docker container prune`
### Removes all stopped containers.

---

## `docker images`
### Lists local images.

## `docker rmi <image>`
### Removes an image.

## `docker rmi -f <image>`
### Forces image removal.

## `docker image prune`
### Removes unused and dangling images.

## `docker system prune`
### Removes unused containers, networks, images, and build cache.

## `docker images -f dangling=true`
### Lists dangling (untagged) layers.

## `docker tag <image-id> <repo:tag>`
### Applies a new tag to an image.

---

## `docker start <container>`
### Restarts an existing container.

## `docker attach <container>`
### Connects to the container’s main process.

## `docker exec -it <container> /bin/sh`
### Opens a shell inside a running container.

---

## `docker build -t <name> .`
### Builds an image using the Dockerfile in the current directory.

## `docker build -t my-node-app .`
### Builds the example Node image.

## `docker run -p 3000:3000 my-node-app`
### Runs the built Node application.

## `docker tag my-node-app yourusername/my-node-app:latest`
### Tags the image for pushing to Docker Hub.

## `docker login`
### Authenticates to Docker Hub.

## `docker push yourusername/my-node-app:latest`
### Pushes the tagged image to Docker Hub.
