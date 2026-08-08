/* ==============================================================================
   FILE: 03_business_analysis.sql
   PURPOSE: Execute advanced SQL queries to uncover business insights, margin 
            leakages, and operational bottlenecks.
   TARGET: Provide data-backed recommendations for executive decision-making.
   ============================================================================== */

-- ------------------------------------------------------------------------------
-- BUSINESS QUESTION 1: Margin Leakage Audit (Freight vs Product Price)
-- OBJECTIVE: Identify product categories where logistics/shipping costs (freight) 
--            consume an abnormally high percentage of the product's actual price, 
--            leading to potential financial margin leakage for sellers/platform.
-- ------------------------------------------------------------------------------

SELECT 
    p.product_category_name AS category_name,
    COUNT(oi.order_id) AS total_items_sold,
    ROUND(AVG(oi.price), 2) AS avg_product_price,
    ROUND(AVG(oi.freight_value), 2) AS avg_freight_value,
    ROUND(
        (SUM(oi.freight_value) / NULLIF(SUM(oi.price), 0)) * 100, 2
    ) AS freight_to_price_ratio_pct
FROM order_items AS oi
JOIN products AS p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
HAVING COUNT(oi.order_id) >= 100 
ORDER BY freight_to_price_ratio_pct DESC
LIMIT 10;


-- ------------------------------------------------------------------------------
-- BUSINESS QUESTION 2: Impact of Delivery Delays on Customer Satisfaction
-- OBJECTIVE: Analyze how carrier delivery delays affect customer review scores 
--            and measure the exact percentage of 1-star reviews caused by logistical failures.
-- ------------------------------------------------------------------------------

SELECT 
    CASE 
        WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 'Delayed Delivery'
        ELSE 'On-Time / Early Delivery'
    END AS delivery_status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(r.review_score), 2) AS avg_review_score,
    ROUND(
        COUNT(CASE WHEN r.review_score = 1 THEN 1 END) * 100.0 / COUNT(r.review_id), 2
    ) AS percentage_1_star_reviews
FROM orders AS o
JOIN order_reviews AS r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY delivery_status;

-- ------------------------------------------------------------------------------
-- BUSINESS QUESTION 3: Geographic Supply & Demand Concentration Analysis
-- OBJECTIVE: Identify top customer states/cities driving transaction volume and 
--            evaluate whether seller distribution aligns with buyer demand to 
--            optimize regional warehouse placement.
-- ------------------------------------------------------------------------------

SELECT 
    c.customer_state AS buyer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(AVG(oi.freight_value), 2) AS avg_freight_cost,
    ROUND(SUM(oi.price), 2) AS total_gross_revenue
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
JOIN customers AS c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_orders DESC
LIMIT 10;