/* ==============================================================================
   FILE: 01_setup_database.sql
   PURPOSE: Initialize the database schema and import raw CSV data.
   APPROACH: Creating tables with strict data types to ensure data integrity
             before executing advanced business and financial analytics.
   ============================================================================== */

-- ------------------------------------------------------------------------------
-- 1. TABLE: orders
-- DESCRIPTION: Acts as the primary ledger for all transactions. 
--              Crucial for tracking the lifecycle of each order to audit 
--              delivery efficiency, logistical bottlenecks, and retention.
-- ------------------------------------------------------------------------------
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,                 -- Unique identifier for the transaction
    customer_id VARCHAR(50),                          -- Transactional ID (Note: Order-scoped, not user-scoped)
    order_status VARCHAR(20),                         -- Current operational status (delivered, canceled, etc.)
    order_purchase_timestamp TIMESTAMP,               -- Exact time the transaction was initiated
    order_approved_at TIMESTAMP,                      -- Time the payment was verified and cleared
    order_delivered_carrier_date TIMESTAMP,           -- Time the logistics partner picked up the package
    order_delivered_customer_date TIMESTAMP,          -- Actual time the customer received the product
    order_estimated_delivery_date TIMESTAMP           -- Promised delivery time (Baseline for delay analysis)
);

-- IMPORT DATA: Populating the 'orders' table from the raw CSV file.
-- ACTION REQUIRED: Replace the file path below with your local directory path.
COPY orders
FROM 'C:\Users\SOLIT\Documents\Olist E-Commerce Unit Economics\archive\olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;


-- ------------------------------------------------------------------------------
-- 2. TABLE: order_items
-- DESCRIPTION: Contains the granular financial data for each individual product 
--              sold within an order. Used extensively for 'Unit Economics' analysis, 
--              specifically comparing product revenue against freight costs to 
--              identify margin leakage.
-- ------------------------------------------------------------------------------
CREATE TABLE order_items (
    order_id VARCHAR(50),                             -- Link to the orders table (Foreign Key)
    order_item_id INT,                                -- Sequence of the item within the same order basket
    product_id VARCHAR(50),                           -- Unique item identifier
    seller_id VARCHAR(50),                            -- Vendor identifier (Used for supply mapping)
    shipping_limit_date TIMESTAMP,                    -- Vendor SLA (Service Level Agreement) for shipping
    price NUMERIC(10, 2),                             -- Top-line revenue from the product
    freight_value NUMERIC(10, 2)                      -- Logistical cost (Key metric for operational inefficiency)
);

-- IMPORT DATA: Populating the 'order_items' table from the raw CSV file.
-- ACTION REQUIRED: Replace the file path below with your local directory path.
COPY order_items
FROM 'C:\Users\SOLIT\Documents\Olist E-Commerce Unit Economics\archive\olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

