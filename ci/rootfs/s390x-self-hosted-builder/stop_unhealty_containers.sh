#!/usr/bin/env bash

# Add this to cron to kill unhealty containers. Systemd will restart the actions-runner.

for container_id in $(docker ps --filter "health=unhealthy" --format '{{.ID}}'); do
    docker exec "$container_id" kill -INT -- -1
    docker wait "$container_id"
    docker rm "$container_id"
done
