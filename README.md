# DHL Delivery Performance Analytics

Uçtan uca lojistik veri modelleme, veri temizleme ve teslimat performans analitiği projesi. Bu projede, DHL lojistik ağındaki paket teslimat süreleri, kargo firması (carrier) verimliliği, öncelik segmentasyonu ve SLA gecikme oranları SQL sorguları ile analiz edilmiştir.

---

## Proje Özeti & Amaçlar

Lojistik operasyonlarında veriye dayalı haftalık performans yönetimini sağlamak amacıyla relational (ilişkisel) veri modeli kurulmuş, uyumsuz veri tipleri ve metin alanları standardize edilmiş, operasyonel KPI'lar (SLA süreleri, gecikme oranları, ürün hacimleri) hesaplanmıştır.

### **Temel Odak Alanları:**
- **Veri Modelleme & Bütünlük:** Primary Key / Foreign Key ilişkisiyle 1-N yapılandırılmış tablo mimarisi (`shipment` & `shipment_item`).
- **Veri Temizleme (Data Cleaning):** Standart dışı tarih formatlarının ISO (`YYYY-MM-DD`) yapısına getirilmesi, metin standardizasyonu ve tire/boşluk temizliği.
- **KPI Hesaplamaları:** Depo çıkış süresi (`dispatch_time`), taşıma süresi (`transit_time`), uçtan uca teslimat süresi (`total_time`) ve 5 günü aşan teslimatların gecikme bayrağı (`delay`).
- **Segmentasyon & Trend Analizi:** Kargo firması, paket öncelik seviyesi (`urgency`), aylık trendler ve ürün grubu bazlı boyut analizleri.

---

## Öne Çıkan Analitik Bulgular (Key Insights)

- **Küresel Teslimat Performansı:** Toplam 49 paketin 34'ü başarıyla teslim edilmiştir (`Delivered`). Ortalama depo hazırlık süresi **2.13 gün**, ortalama kargo taşıma süresi **1.94 gün**, uçtan uca toplam teslimat süresi ise **4.24 gün** olarak gerçekleşmiştir.
- **Taşıyıcı Verimliliği (Carrier Benchmark):** 
  - **UPS:** Ortalama **3.57 gün** toplam teslimat süresi ve **1.57 gün** kargo süresi ile en hızlı performans gösteren taşıyıcıdır.
  - **DHL & Colissimo:** Ortalama **4.67 - 4.75 gün** teslimat süresiyle benzer bir performans sergilemiştir.
- **Öncelik Seviyesi Etkisi:** `High` öncelikli siparişlerin depo hazırlık süresi (**2.03 gün**), `Low` öncelikli siparişlere (**2.57 gün**) göre belirgin şekilde daha kısadır.
- **SLA Gecikme Oranı (Delay Rate):** Kargo süresi 5 günü aşan yalnızca 1 teslimat tespit edilmiş olup küresel gecikme oranı **%2.94** (`0.0294`) seviyesindedir.
- **Ürün Hacim Lideri:** En yüksek sevkiyat hacmine sahip ürün **548 adet** ile `T-shirt sport - Original` modelidir.

---

## Proje Klasör Yapısı

```text
dhl-delivery-performance-analytics/
├── data/
│   ├── DHL_data - shipment.csv      # Ham sevkiyat verisi
│   └── shipment_item.csv            # Paket detay ürün verisi
├── sql/
│   ├── 01_create_tables.sql         # Tablo şemaları ve ilişki tanımları
│   ├── 02_data_cleaning.sql          # Tarih ve metin dönüştürme sorguları
│   ├── 03_kpi_calculations.sql      # Süre metrikleri ve status/delay algoritmaları
│   └── 04_segmentation_analysis.sql # Global, carrier, urgency ve ürün JOIN sorguları
├── images/
│   └── kpi_preview.png              # SQL çıktı ve tablo ekran görüntüleri
└── README.md                        # Proje dokümantasyonu