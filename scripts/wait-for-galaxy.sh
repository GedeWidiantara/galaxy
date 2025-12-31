#!/bin/bash

GALAXY_URL="${1:-http://localhost:8080}"
TIMEOUT="${2:-600}" # Default timeout 10 minutes

echo "Waiting for Galaxy at $GALAXY_URL to be ready (timeout: $TIMEOUT seconds)..."

start_time=$(date +%s)

while true; do
    current_time=$(date +%s)
    elapsed=$((current_time - start_time))

    if [ "$elapsed" -ge "$TIMEOUT" ]; then
        echo "Error: Timed out waiting for Galaxy to become ready."
        exit 1
    fi

    # Check if Galaxy responds with 200 OK
    if curl -s -f -o /dev/null "$GALAXY_URL"; then
        echo "Galaxy is ready!"
        exit 0
    fi

    echo "Galaxy is not ready yet... (elapsed: ${elapsed}s)"
    sleep 10
done
