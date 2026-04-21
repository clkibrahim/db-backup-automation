#!/bin/bash

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR="$(pwd)/backups"
LOG_DIR="$(pwd)/logs"
BACKUP_FILE="$BACKUP_DIR/librarydb_$TIMESTAMP.sql"
LOG_FILE="$LOG_DIR/backup.log"

mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup started" >> "$LOG_FILE"

docker exec postgres_backup_db pg_dump -U admin -c -d librarydb > "$BACKUP_FILE"

if [ $? -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup successful: $BACKUP_FILE" >> "$LOG_FILE"
    echo "Backup başarılı: $BACKUP_FILE"
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup failed" >> "$LOG_FILE"
    echo "Backup başarısız."
    SCRIPT_DIR="$(dirname "$0")"
    bash "$SCRIPT_DIR/alert.sh" "PostgreSQL veritabanindan 'librarydb' icin yedek alinamadi. Lutfen servisi ve baglantiyi kontrol ediniz!"
fi
