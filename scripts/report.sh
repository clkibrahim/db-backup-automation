#!/bin/bash
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
REPORT_FILE="$PROJECT_DIR/logs/backup_report_$(date +%Y-%m-%d).txt"
BACKUP_DIR="$PROJECT_DIR/backups"
LOG_FILE="$PROJECT_DIR/logs/backup.log"

mkdir -p "$PROJECT_DIR/logs"

{
echo "================================================="
echo "             YEDEKLEME SISTEM RAPORU            "
echo "================================================="
echo "Rapor Tarihi: $(date +"%Y-%m-%d %H:%M:%S")"
echo ""
echo "1. MEVCUT YEDEKLER"
echo "-------------------------------------------------"
if [ -d "$BACKUP_DIR" ] && [ "$(ls -A "$BACKUP_DIR")" ]; then
    ls -lh "$BACKUP_DIR" | awk '{print $5, "\t", $9}' | tail -n +2
    COUNT=$(ls -1q "$BACKUP_DIR" | wc -l)
    echo "Toplam Yedek Sayisi: $COUNT"
else
    echo "Henuz alinmis mevcut yedek bulunmamaktadir."
fi
echo ""
echo "2. SON CIKAN LOG DURUMLARI (Basarili / Basarisiz)"
echo "-------------------------------------------------"
if [ -f "$LOG_FILE" ]; then
    tail -n 10 "$LOG_FILE" | sed 's/^/  /'
    echo ""
    SUCCESS=$(grep -i -c -e "successful" -e "başarılı" "$LOG_FILE" || true)
    FAILED=$(grep -i -c -e "failed" -e "başarısız" "$LOG_FILE" || true)
    echo "Basarili Islem Sayisi: $SUCCESS"
    echo "Hatali Islem Sayisi: $FAILED"
else
    echo "Log dosyasi henuz olusturulmamis."
fi
echo "================================================="
} > "$REPORT_FILE"

echo "Rapor olusturuldu: $REPORT_FILE"
