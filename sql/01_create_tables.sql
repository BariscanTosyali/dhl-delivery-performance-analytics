-- 1. Sevkiyat Ana Tablosu
DROP TABLE IF EXISTS shipment;

CREATE TABLE shipment (
    shipment_id INTEGER PRIMARY KEY,
    customer_name TEXT,
    customer_surname TEXT,
    tracking_url TEXT,
    tracking_code TEXT,
    carrier_name TEXT,
    urgency TEXT,
    order_date DATE,
    dispatch_date DATE,
    arrival_date DATE,
    cancel_date DATE
);

-- 2. Sevkiyat Kalemi Tablosu
DROP TABLE IF EXISTS shipment_item;

CREATE TABLE shipment_item (
    shipment_id INTEGER,
    product_name TEXT,
    quantity INTEGER,
    FOREIGN KEY (shipment_id) REFERENCES shipment(shipment_id)
);
