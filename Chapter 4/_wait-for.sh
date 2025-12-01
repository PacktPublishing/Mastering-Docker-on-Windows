#!/bin/sh

until nc -z db 5432; do
  echo "Waiting for db..."
  sleep 2
done

echo "Database is up. Starting app..."
exec "$@"
