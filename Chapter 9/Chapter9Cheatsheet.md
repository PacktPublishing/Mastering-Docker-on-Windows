# Chapter 9 Command Cheat Sheet *Docker and Hybrid Cloud Integration*

## .NET build and container image creation

### `dotnet publish -c Release -o publish`

Builds the .NET application in Release mode and outputs the compiled artefacts to the `publish` directory. Used to prepare binaries for containerisation.

### `docker build -t hybrid-api:1.0.0 .`

Builds a Docker image from the current directory and tags it as `hybrid-api:1.0.0`.

---

## Image tagging for multi-registry promotion

### `docker tag hybrid-api:1.0.0 123456789012.dkr.ecr.eu-west-1.amazonaws.com/hybrid-api:1.0.0`

Creates an additional tag for the same image so it can be pushed to AWS Elastic Container Registry.

### `docker tag hybrid-api:1.0.0 myregistry.azurecr.io/hybrid-api:1.0.0`

Creates an additional tag for the same image so it can be pushed to Azure Container Registry.

---

## Image distribution

### `docker push 123456789012.dkr.ecr.eu-west-1.amazonaws.com/hybrid-api:1.0.0`

Pushes the tagged image to AWS ECR.

### `docker push myregistry.azurecr.io/hybrid-api:1.0.0`

Pushes the tagged image to Azure Container Registry.

---

## Docker Swarm cluster creation

### `docker swarm init --advertise-addr <aws-private-ip>`

Initialises a Docker Swarm manager node and advertises its private IP for cluster communication.

### `docker swarm join --token <token> <aws-private-ip>:2377`
Joins a worker node to an existing Docker Swarm cluster using the provided join token.

---

## Docker networking for hybrid environments

### `docker network create --driver overlay --opt encrypted hybrid-net`

Creates an encrypted overlay network for secure container-to-container communication across nodes and clouds.

### `docker network create --driver overlay --attachable hybrid-net`

Creates an attachable overlay network that allows both Swarm services and standalone containers to connect.

---

## Docker Swarm service deployment
### `docker service create --name hybrid-api --replicas 2 --network hybrid-net -p 8080:80 myregistry.azurecr.io/hybrid-api:1.0.0`

Creates a replicated Swarm service, attaches it to the encrypted overlay network, and publishes port 8080.

### `docker service create --name hybrid-web --replicas 4 --publish 80:80 nginx:alpine`

Deploys a replicated NGINX service across the Swarm with port 80 exposed via the routing mesh.

---

## Docker Compose and Stack operations

### `docker-compose up`

Starts services defined in `docker-compose.yml` and automatically applies override files if present.

### `docker stack deploy -c docker-compose.yml hybrid-stack`
Deploys a multi-service application as a Swarm stack using a Compose file.

### `docker compose -f compose.release.yaml up -d`

Deploys services defined in the release Compose file in detached mode using prebuilt images.

### `docker compose -f compose.release.yaml ps`

Lists the running containers defined in the release Compose file.

### `docker compose -f compose.release.yaml config`

Renders the fully resolved Compose configuration after environment variable substitution.

---

## Secrets management

### `echo "db-password-here" | docker secret create notes_db_password -`
Creates a Docker Swarm secret from standard input without storing the value in a file.

### `echo "supersecurepassword" | docker secret create db_password -`

Creates a secure Docker secret intended for runtime injection into services.

---

## Image trust and signing

### `DOCKER_CONTENT_TRUST=1 docker push myregistry.azurecr.io/myapp:1.3.0`

Pushes an image with Docker Content Trust enabled, ensuring the image is signed and verifiable.

---

## CI and image inspection

### `docker image inspect $env:IMAGE_API --format '{{json .Config.Labels}}'`

Inspects an image and outputs OCI metadata labels in JSON format for provenance verification.

---

## Docker context management
### `docker context use notes-remote`
Switches the active Docker context to a remote host for deployment.

### `docker info`

Displays Docker daemon information for the currently active context.

---

## Environment variable injection (PowerShell)

### `$env:IMAGE_API = "<user>/notes-api:<sha>"`

Sets the API image reference for Compose deployment.

### `$env:IMAGE_FRONTEND = "<user>/notes-frontend:<sha>"`

Sets the frontend image reference for Compose deployment.
### `$env:IMAGE_GENAI = "<user>/notes-genai-summariser:<sha>"`

Sets the GenAI image reference for Compose deployment.

---

## Application validation

### `curl http://<remote-host>:5001/notes`

Sends an HTTP request to validate the Notes API endpoint.

### `curl http://<remote-host>:5001/notes/summary`

Validates the GenAI summarisation endpoint.

---

## Image promotion and rollback

### `docker pull <user>/notes-api:<sha>`

Pulls a specific immutable image version.
### `docker tag <user>/notes-api:<sha> <user>/notes-api:staging`
Retags an immutable image for promotion to staging.

### `docker push <user>/notes-api:staging`

Pushes the promoted staging tag to the registry.

---

## Configuration validation and hygiene

### `docker compose -f compose.release.yaml config | Select-String "latest"`

Checks for accidental use of the `latest` tag in the release configuration.

### `docker compose -f compose.release.yaml config | Select-String "build:"`

Ensures no image builds occur in production-style Compose files.