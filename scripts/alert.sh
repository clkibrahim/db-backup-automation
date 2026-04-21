#!/bin/bash
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
MESSAGE="$1"
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ALERT_FILE="$PROJECT_DIR/logs/alerts.log"

mkdir -p "$PROJECT_DIR/logs"

echo "----------------------------------------" >> "$ALERT_FILE"
echo "TARIH: $TIMESTAMP" >> "$ALERT_FILE"
echo "KIME: admin@sirket.com" >> "$ALERT_FILE"
echo "KONU: KRITIK UYARI - Veritabani Yedekleme Hatasi" >> "$ALERT_FILE"
echo "MESAJ: $MESSAGE" >> "$ALERT_FILE"
echo "----------------------------------------" >> "$ALERT_FILE"

echo "[!] YÖNETİCİYE BİLDİRİM GÖNDERİLDİ: $MESSAGE"
