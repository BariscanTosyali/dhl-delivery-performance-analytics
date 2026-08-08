-- 1. Tarih Formatlarının YYYY-MM-DD Standardına Getirilmesi
UPDATE shipment SET order_date = SUBSTR(order_date, 1, 10) WHERE order_date IS NOT NULL;
UPDATE shipment SET dispatch_date = SUBSTR(dispatch_date, 1, 10) WHERE dispatch_date IS NOT NULL;
UPDATE shipment SET cancel_date = SUBSTR(cancel_date, 1, 10) WHERE cancel_date IS NOT NULL;

-- M/D/YYYY formatındaki arrival_date verilerini dönüştürme
UPDATE shipment 
SET arrival_date = PRINTF('%04d-%02d-%02d',
    CAST(SUBSTR(SUBSTR(arrival_date, INSTR(arrival_date, '/') + 1), INSTR(SUBSTR(arrival_date, INSTR(arrival_date, '/') + 1), '/') + 1, 4) AS INT),
    CAST(SUBSTR(arrival_date, 1, INSTR(arrival_date, '/') - 1) AS INT),
    CAST(SUBSTR(SUBSTR(arrival_date, INSTR(arrival_date, '/') + 1), 1, INSTR(SUBSTR(arrival_date, INSTR(arrival_date, '/') + 1), '/') - 1) AS INT)
)
WHERE arrival_date IS NOT NULL AND arrival_date LIKE '%/%';

-- 2. Metin Alanlarının Standardizasyonu
UPDATE shipment SET carrier_name = LOWER(carrier_name);
UPDATE shipment SET tracking_code = REPLACE(tracking_code, '-', '');
