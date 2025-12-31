#!/bin/bash
set -e

# Configuration
BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="${BACKUP_DIR}/galaxy_backup_${TIMESTAMP}.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "Starting Galaxy backup to ${BACKUP_FILE}..."

# Create tarball of data and config
# Excluding pg_data if it's huge might be wise later, but for now we back up everything persistent
tar -czf "$BACKUP_FILE" ./data ./config .env

echo "Backup completed successfully!"
ls -lh "$BACKUP_FILE"
