# Chapter 7 Cheatsheet: Scaling & High Availability

## docker compose scale
Scale any service:

docker compose up --scale api=3 -d


## docker compose ps
Show running services:
 
docker compose ps
 

## docker compose logs
Follow logs:
 
docker compose logs -f api
 

## docker compose restart
Restart services:
 
docker compose restart api
 

## docker compose down
Stop everything:
 
docker compose down
 

## Simulated load using curl
Basic loop for load:
 
for /l %i in (1,1,20) do curl http://localhost:5001/notes
 

## Bring up load balancer + replicas
 
docker compose up -d --build
 

## Inspect HA behaviour
Check which replica handled a request:
 
curl http://localhost:5001/notes/summary
 

## View container distribution
 
docker compose ps
 

## Test failover
Stop one instance:
 
docker compose stop genai-a
 

## Test that load balancer still routes requests
 
curl http://localhost:5001/notes/summary
 
