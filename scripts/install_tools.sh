#!/bin/bash
set -e

# Load environment variables to get the API key if needed (optional)
if [ -f ../.env ]; then
    export $(grep -v '^#' ../.env | xargs)
fi

GALAXY_URL="${GALAXY_URL:-http://localhost:8080}"
API_KEY="${GALAXY_API_KEY:-admin}" # Default to 'admin' bootstrap key or set via env
TOOL_LIST_FILE="${1:-../config/tool_list.yaml}"

# Check if ephemeris is installed
if ! command -v shed-tools &> /dev/null; then
    echo "Ephemeris (shed-tools) is not installed."
    echo "Please run: pip install ephemeris"
    exit 1
fi

echo "Installing tools from $TOOL_LIST_FILE to $GALAXY_URL..."

# Verify Galaxy is up first
../scripts/wait-for-galaxy.sh "$GALAXY_URL" 60

# Install tools
# Note: You might need to generate an API key first if not configured as a bootstrap user
shed-tools install --yaml_tool "$TOOL_LIST_FILE" --galaxy "$GALAXY_URL" --api_key "$API_KEY"

echo "Tool installation complete."
