# Chapter 4 Commands Cheatsheet
## 1. Environment & WSL 2 Checks

wsl --status
wsl -l -v
docker --version
docker compose version

## 2. Basic Compose Lifecycle

# Start stack (foreground)
docker compose up

# Start stack (detached / background)
docker compose up -d

# Stop and remove containers, network, etc.
docker compose down

# Stop and also remove named volumes
docker compose down --volumes

## 3. Project Names, Multiple Files, Scaling

# Override project name
docker compose -p demo up

# Use base + prod override files
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d

# Use lab compose + prod override
docker compose -f compose.yaml -f compose.prod.yaml up --build

# Scale a service (e.g. worker to 5 replicas)
docker compose up -d --scale worker=5

## 4. Day-to-day Compose Operations
# List services in the current stack
docker compose ps

# Show logs for all services
docker compose logs

# Follow logs (all services)
docker compose logs -f

# Follow logs for a single service (example: db)
docker compose logs -f db

# Exec into a running service container
docker compose exec app sh
docker compose exec api sh

# Restart a single service
docker compose restart api

# Rebuild any changed services and restart (detached)
docker compose up -d --build

# Force rebuild of a specific service
docker compose build frontend

# Show events (start/stop, health, rebuilds, etc.)
docker compose events

# Show processes running inside containers
docker compose top

## 5. Networking & Connectivity
# List Docker networks
docker network ls

# Inspect a specific network
docker network inspect my_backend_net
docker network inspect myproject_default
# Inside a container (after docker compose exec):
ping db
ping database
nc -z db 5432 && echo "Port is open"

## Host–WSL connectivity checks:
# Get WSL host IP
wsl hostname -I

# Hit a service via WSL IP (example port)
curl http://172.25.240.1:3000

# Port proxy workaround:
# Forward localhost:3000 to WSL IP:3000
netsh interface portproxy add v4tov4 `
  listenaddress=127.0.0.1 listenport=3000 `
  connectaddress=172.25.240.1 connectport=3000

# Remove the port proxy
netsh interface portproxy delete v4tov4 `
  listenaddress=127.0.0.1 listenport=3000

6. Volumes & Storage

# List volumes
docker volume ls

# Remove unused volumes
docker volume prune

# Inspect a specific volume
docker volume inspect myproject_db_data

# Inspect the contents of a named volume:
docker run --rm -it -v myproject_db_data:/data alpine sh
# inside container:
ls /data

## 7. Inspecting Containers & Health
# Inspect full container metadata
docker inspect <container-id>
docker inspect app

# Inspect health status only
docker inspect --format='{{json .State.Health.Status}}' <container-id>

## 8. Windows / WSL Tuning
# Apply updated /etc/wsl.conf or .wslconfig
wsl --shutdown

# Inside your Linux distro:
echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

## 9. Running Compose Stacks on Windows (Lab)
# Bring up the Notes app stack and build images
docker compose up --build

# Check API endpoint
curl http://localhost:5001/notes

# Check frontend
curl http://localhost:8080

# Seed notes data into the Windows volume
echo "[\"Welcome to the Notes App\"]" > C:\notes-data\notes.json

# Live logs, processes, events for the lab stack
docker compose logs -f
docker compose top
docker compose events
