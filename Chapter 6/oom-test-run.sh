#!/bin/sh
# Example: run a container with a low memory limit to trigger OOM
docker run --rm -m 128m --memory-swap=128m my-memory-hungry-image
