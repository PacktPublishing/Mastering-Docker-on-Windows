Chapter 10 cheatsheet

docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Image}}"
List running containers with a readable table showing name, status and image to quickly spot crash loops or stopped services

docker logs api --tail 20
Show the last 20 log lines from the api container to identify surface level errors and timeouts

docker logs worker --tail 20
Show the last 20 log lines from the worker container to diagnose startup failures or restart loops

docker exec -it worker sh
Start an interactive shell inside the worker container to inspect its runtime environment directly

env | grep REDIS
Filter environment variables inside a container to confirm Redis related configuration values

ping redis
Test basic network reachability and DNS resolution to the redis service from inside a container

curl http://redis:6379
Test application level connectivity to Redis on its service port

ls -lah /app/config
List config files inside the container to verify expected files exist and permissions are correct

docker inspect --format='{{.Config.Image}}' worker
Show the exact image name and tag the worker container is running to detect stale or incorrect deployments

docker history myapp:prod
Display the image layer history to inspect build steps, cache usage and unexpected layers

dive myapp:prod
Interactively inspect image layers to identify bloat, incorrect files or accidental dev artefacts

docker run -it --rm myapp:prod sh
Run the image in isolation with a shell to validate it independently of Compose, volumes or env overrides

docker inspect api | grep -A5 Networks
Inspect the networks attached to the api container to confirm it is on the expected Docker networks

docker network inspect backend
Inspect a Docker network to verify connected containers and identify stale or missing endpoints

docker exec -it api sh -c "nslookup redis"
Test Docker internal DNS resolution from inside the api container

docker exec -it api sh -c "curl -v redis:6379"
Verbose connectivity test to Redis to diagnose port, routing or protocol issues

docker compose up -d --force-recreate api worker
Recreate the api and worker containers from scratch using corrected configuration and images

docker logs -f worker
Stream live logs from the worker container during recovery to confirm stable startup

docker stats
Display real time CPU, memory and network usage for all running containers to confirm stabilisation

choco install dive
Install the Dive image inspection tool on Windows using Chocolatey