#!/bin/bash
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
BACKUP_SCRIPT="$PROJECT_DIR/scripts/backup.sh"
REPORT_SCRIPT="$PROJECT_DIR/scripts/report.sh"

CRON_JOB_BACKUP="0 2 * * * $BACKUP_SCRIPT >> $PROJECT_DIR/logs/cron_backup.log 2>&1"
CRON_JOB_REPORT="0 8 * * * $REPORT_SCRIPT >> $PROJECT_DIR/logs/cron_report.log 2>&1"

echo "Cron gorevleri ayarlaniyor..."

(crontab -l 2>/dev/null | grep -F "$BACKUP_SCRIPT") || (crontab -l 2>/dev/null; echo "$CRON_JOB_BACKUP") | crontab -
(crontab -l 2>/dev/null | grep -F "$REPORT_SCRIPT") || (crontab -l 2>/dev/null; echo "$CRON_JOB_REPORT") | crontab -

echo "Cron yapilandirmasi tamamlandi!"
echo "Yedekleme gorevi: Her gun saat 02:00'da calisacak."
echo "Raporlama gorevi: Her gun saat 08:00'da calisacak."
echo "--- Mevcut Cron Gorevleri ---"
crontab -l | grep -F "$PROJECT_DIR"
