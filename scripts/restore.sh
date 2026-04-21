#!/bin/bash

if [ -z "$1" ]; then
  echo "Kullanim: ./scripts/restore.sh backups/dosya_adi.sql"
  exit 1
fi

BACKUP_FILE="$1"

docker exec -i postgres_backup_db psql -U admin -d librarydb < "$BACKUP_FILE"
