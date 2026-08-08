/* ==============================================================================
   FILE: 02_setup_additional_tables.sql
   PURPOSE: Initialize secondary tables (Products and Reviews) to support 
            category performance evaluation and customer sentiment analysis.
   ============================================================================== */

-- ------------------------------------------------------------------------------
-- 1. TABLE: products
-- DESCRIPTION: Maps product IDs to their respective categories. Essential for 
--              grouping revenue and identifying top-performing product lines.
-- ------------------------------------------------------------------------------
CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,               -- Unique product identifier
    product_category_name VARCHAR(100),               -- Category name (in Portuguese)
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

-- IMPORT DATA: Populating the 'products' table.
-- ACTION REQUIRED: Make sure the file path matches your local directory.
COPY products
FROM 'C:/temp/olist_products_dataset.csv'
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', QUOTE '"');


-- ------------------------------------------------------------------------------
-- 2. TABLE: order_reviews
-- DESCRIPTION: Captures customer feedback, scores (1-5 stars), and review comments. 
--              Crucial for measuring the downstream impact of logistical failures.
-- ------------------------------------------------------------------------------
CREATE TABLE order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),                             -- Link to the orders table (Foreign Key)
    review_score INT,                                 -- Customer satisfaction score (1 to 5 stars)
    review_comment_title VARCHAR(255),
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

-- IMPORT DATA: Populating the 'order_reviews' table.
-- ACTION REQUIRED: Make sure the file path matches your local directory.
COPY order_reviews
FROM 'C:/temp/olist_order_reviews_dataset.csv'
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', QUOTE '"');

-- ------------------------------------------------------------------------------
-- TABLE 03: customers
-- DESCRIPTION: Stores customer demographic and geographic location data 
--              (city and state) for regional demand analysis.
-- ------------------------------------------------------------------------------
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

-- IMPORT DATA: Populating the 'customers' table.
-- ACTION REQUIRED: Make sure the file path matches your local directory.
COPY customers
FROM 'C:/temp/olist_customers_dataset.csv'
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8', QUOTE '"');