# BLM4522 Ağ Tabanlı Paralel Dağıtım Sistemleri - Proje Raporu

**Proje Konusu:** 7. Veritabanı Yedekleme ve Otomasyon Çalışması
**Öğrenci:** İbrahim Çelik
**Kullanılan Teknolojiler:** PostgreSQL, Docker, Shell Scripting, Linux Cron

## Proje Amacı
Bu projenin temel amacı veritabanı yedekleme (backup) işlemlerini kullanıcı müdahalesi olmadan otomatize etmek, yedeklerin durumlarını raporlamak ve olası başarısızlık durumlarında sistem yöneticilerine uyarılar (alert) göndermektir.

## 1. Veritabanı Mimarisi (Docker)
Proje, kendi bilgisayarımda izolasyonu sağlamak ve paralel dağıtım mimarilerine uygun hale getirmek amacıyla **Docker** üzerinde çalışmaktadır.
* `docker-compose.yml` dosyası ile `postgres:16` imajı kullanılarak bağımsız bir konteyner oluşturulmuştur.
* Parolalar ve konfigürasyon veri güvenliği açısından `.env` veya docker-compose ortamlarına gömülüdür.

## 2. Otomasyon ve Scripting Süreçleri

### A) Yedekleme İşlemi (`backup.sh`)
Veritabanına bağlanıp `pg_dump` komutu ile `.sql` formatında anlık tarihi baz alan yedek dosyaları oluşturur. Geliştirilen Bash script içerisinde bir kontrol yapısı bulunmaktadır:
- İşlem **başarılıysa**, `backup.log` dosyasına yedeğin alındığını rapor eder.
- İşlem **başarısızsa**, otomatik olarak `alert.sh` uygulamasını tetikler.

### B) Hata Bildirim Sistemi (`alert.sh`)
Veritabanı bağlantısı kopar veya çökerse, sistem yöneticilerine acil koduyla bildirim gönderilmesi gerekmektedir. Mail/SMS simülasyonu olarak geliştirilen bu script, sorunun ne anlama geldiğini `logs/alerts.log` dizinine yazar. Bu scriptin gerçek hayatta şirket log mekanizmalarına (Slack/Discord Webhook veya SMTP Node) entegre edilmesi hedeflenmiştir.

### C) Düzenli Sistem Raporlamaları (`report.sh`)
T-SQL veya PowerShell süreçlerine alternatif olarak geliştirilen raporda, sistem `backups` klasörüne girerek var olan tüm verileri sayar, boyutlarını (MB/GB) tespit eder. Arka planda `backup.log`'u okuyarak gün içerisinde kaç kere başarılı veya başarısız giriş yapıldığını hesaplayıp düzenli bir metin tabanlı (txt) analiz raporu çıkartır.

### D) Zamanlanmış Görevler (`setup_cron.sh`)
Veritabanı yöneticisinin scriptleri her gün elle çalıştırmaması için Linux çekirdeğinde bulunan **Cron** sistemi entegre edilmiştir.
* Her gece **02:00**: `backup.sh` komutu ile otomatik yedekleme başlatılır.
* Her sabah **08:00**: `report.sh` ile sabah ofise gelen görevliye sunulmak üzere detaylı yedekleme durumu raporu çıkartılır.

## Nasıl Test Edilir?
Projenin tamamen kurulması ve cron'a dahil edilmesi için terminal üzerinden bir kez aşağıdaki komutun çalıştırılması yeterlidir:
```bash
./scripts/setup_cron.sh
```

Videolu anlatım bağlantısı sisteme yüklenecektir.
