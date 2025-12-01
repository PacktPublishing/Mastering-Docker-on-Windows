# Chapter 3 Command Cheatsheet

## Docker Volume Basics

### Create a volume
docker volume create demo-vol

### Write to a volume
docker run --rm -v demo-vol:/data alpine \
  sh -c "echo 'hello from volume' > /data/test.txt"

### Read from a volume
docker run --rm -v demo-vol:/data alpine \
  cat /data/test.txt

---

## Bind Mount Examples (Windows)

### Create folder for a bind mount
mkdir C:\docker-bind

### Create a test file
echo "from windows" > C:\docker-bind\msg.txt

### Mount Windows folder into Alpine
docker run --rm -v C:\docker-bind:/data alpine \
  cat /data/msg.txt

---

## Shared Volume Demonstration (Compose)

### Run the shared writer-reader demo
docker compose up

---

## Volume Backup and Restore (Windows)

### Backup a named volume
docker run --rm ^
  -v my-vol:/vol ^
  -v C:\backup:/backup ^
  alpine ^
  tar czf /backup/my-vol.tar.gz /vol

### Restore a named volume
docker run --rm ^
  -v my-vol:/vol ^
  -v C:\backup:/backup ^
  alpine ^
  tar xzf /backup/my-vol.tar.gz -C /vol

---

## Volume Snapshots (Linux hosts only)

### LVM snapshot example
lvcreate --size 1G --snapshot --name my-snapshot /dev/my-volume
tar czf backup.tar.gz /dev/my-volume/my-snapshot

### Merge snapshot back
lvconvert --merge /dev/my-volume/my-snapshot

---

## Docker Disk and Volume Management

### Remove unused volumes
docker volume prune

### Show system disk usage
docker system df

### Show detailed disk usage
docker system df -v

### List volumes
docker volume ls

### Inspect volume details
docker volume inspect my-vol

---

## Windows Permissions

### Grant access to Windows folder
icacls C:\data /grant Everyone:(OI)(CI)F

---

## WSL Disk Activity (for volume performance)
wsl.exe iotop -o

---

## The Big Lab: Notes Service Persistence

### Create persistent data folder
mkdir C:\notes-data

### Build Notes API image
docker build -t notes-api .

### Run Notes API with bind mount
docker run -d ^
  --name notes-api ^
  -p 5001:5000 ^
  -v C:\notes-data:/data ^
  notes-api

### Add a note
curl -X POST http://localhost:5001/notes ^
  -H "Content-Type: application/json" ^
  -d "{\"note\": \"first saved note\"}"

### Remove container
docker rm -f notes-api

### Start again with the same persisted data
docker run -d ^
  --name notes-api ^
  -p 5001:5000 ^
  -v C:\notes-data:/data ^
  notes-api

### Check that the note persisted
curl http://localhost:5001/notes

