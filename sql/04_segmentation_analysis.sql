-- 1. Global KPI Tablosu
DROP TABLE IF EXISTS shipment_kpi_global;
CREATE TABLE shipment_kpi_global AS
SELECT 
    COUNT(*) AS total_shipment_count,
    MIN(total_time) AS min_total_time,
    MAX(total_time) AS max_total_time,
    ROUND(AVG(dispatch_time), 2) AS avg_dispatch_time,
    ROUND(AVG(transit_time), 2) AS avg_transit_time,
    ROUND(AVG(total_time), 2) AS avg_total_time,
    ROUND(
        CASE 
            WHEN COUNT(delay) = 0 THEN 0.0
            ELSE CAST(SUM(delay) AS FLOAT) / COUNT(delay)
        END, 4
    ) AS delay_rate
FROM shipment_kpi;

-- 2. Taşıyıcı Bazlı KPI Tablosu
DROP TABLE IF EXISTS shipment_kpi_carrier;
CREATE TABLE shipment_kpi_carrier AS
SELECT 
    clean_carrier AS carrier,
    COUNT(*) AS total_shipment_count,
    MIN(total_time) AS min_total_time,
    MAX(total_time) AS max_total_time,
    ROUND(AVG(dispatch_time), 2) AS avg_dispatch_time,
    ROUND(AVG(transit_time), 2) AS avg_transit_time,
    ROUND(AVG(total_time), 2) AS avg_total_time
FROM shipment_kpi
GROUP BY clean_carrier;

-- 3. Öncelik Segmenti KPI Tablosu
DROP TABLE IF EXISTS shipment_kpi_urgency;
CREATE TABLE shipment_kpi_urgency AS
SELECT 
    urgency,
    COUNT(*) AS total_shipment_count,
    MIN(total_time) AS min_total_time,
    MAX(total_time) AS max_total_time,
    ROUND(AVG(dispatch_time), 2) AS avg_dispatch_time,
    ROUND(AVG(transit_time), 2) AS avg_transit_time,
    ROUND(AVG(total_time), 2) AS avg_total_time,
    ROUND(
        CASE 
            WHEN AVG(total_time) IS NULL OR AVG(total_time) = 0 THEN NULL
            ELSE AVG(transit_time) / AVG(total_time)
        END, 4
    ) AS transit_to_total_ratio
FROM shipment_kpi
GROUP BY urgency;

-- 4. Aylık Trend Tablosu
DROP TABLE IF EXISTS shipment_kpi_month;
CREATE TABLE shipment_kpi_month AS
SELECT 
    STRFTIME('%m', order_date) AS month_order,
    COUNT(*) AS total_shipment_count,
    ROUND(AVG(dispatch_time), 2) AS avg_dispatch_time,
    ROUND(AVG(transit_time), 2) AS avg_transit_time,
    ROUND(AVG(total_time), 2) AS avg_total_time
FROM shipment_kpi
GROUP BY STRFTIME('%m', order_date)
ORDER BY month_order;

-- 5. Ürün Bazlı Sevkiyat ve Hacim Analizi (JOIN)
SELECT 
    si.product_name,
    COUNT(DISTINCT sk.shipment_id) AS toplam_paket_sayisi,
    SUM(si.quantity) AS toplam_urun_adedi,
    ROUND(AVG(sk.total_time), 2) AS ortalama_teslimat_suresi,
    SUM(CASE WHEN sk.delay = 1 THEN 1 ELSE 0 END) AS geciken_paket_sayisi
FROM shipment_item si
JOIN shipment_kpi sk ON si.shipment_id = sk.shipment_id
GROUP BY si.product_name
ORDER BY toplam_urun_adedi DESC;
