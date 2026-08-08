# Olist E-Commerce Analytics: Uncovering Margin Leakages & Logistical Bottlenecks in the Brazilian Market

## 1. Project Overview & Objective
This project goes beyond basic data extraction. The primary objective is to act as a data consultant for Olist, a major Brazilian e-commerce platform, to identify hidden operational bottlenecks that are draining profit margins and damaging brand reputation. 

By analyzing real-world logistical and transactional data, this project aims to bridge the gap between technical data mining and executive decision-making. The end goal is to provide actionable, data-driven strategies for regional fulfillment expansion, shipping cost optimization, and customer retention.

## 2. Tech Stack
* **Database & Data Mining:** PostgreSQL *(CTEs, Window Functions, JOINs, Aggregations)*
* **Data Visualization & Strategy:** Power BI *(Data modeling and executive dashboard design)*

## 3. The Dashboard
*(Pamerkan screenshot full dashboard Power BI `.png` lu di sini)*
![Executive Dashboard](link_gambar_screenshot_dashboard_lu_disini.png)

## 4. Executive Summary: Operational Bottlenecks & Strategic Expansion

**The Bottleneck: Margin Leakage & Logistical Inefficiencies**
An in-depth evaluation of transactional data reveals a critical margin leakage within specific product segments, most notably *artigos_de_natal* (Christmas decorations), where freight costs consume an alarming 37% of the average product price. Furthermore, logistical execution remains a severe operational bottleneck. Delivery delays have profoundly damaged brand perception; 46% of customers who experienced delayed shipments submitted a 1-star review, indicating that logistical friction is the primary catalyst for customer dissatisfaction.

**The Geographic Gap: Supply-Demand Asymmetry**
Geographic mapping indicates a disproportionate market concentration within the state of Sao Paulo (SP), generating over 5 million BRL in gross revenue with highly optimized freight costs (15 BRL). Conversely, regions outside this central hub, such as Bahia (BA) and Rio de Janeiro (RJ), demonstrate significant untapped demand but are constrained by prohibitive shipping costs (averaging over 21 BRL). This asymmetry heavily restricts market penetration in peripheral territories.

**Strategic Recommendations & Business Opportunities**
To mitigate margin deterioration and elevate customer retention, the enterprise must implement a strategic logistical consolidation. Establishing satellite fulfillment centers or regional transit hubs in high-cost, high-potential states will drastically reduce both freight expenditures and delivery timeframes. Additionally, renegotiating service-level agreements (SLAs) with logistics carriers is imperative to penalize delays and safeguard the platform's reputation.

## 5. SQL Query Documentation
The data extraction and analysis were executed through a structured SQL workflow:
* [`01_setup_database.sql`](link_ke_file_01_lu): Initialized the primary relational tables (`orders` and `order_items`) to establish the transactional foundation.
* [`02_setup_additional_tables.sql`](link_ke_file_02_lu): Integrated secondary dimensions, including product categories and customer reviews, to enable sentiment and product performance tracking.
* [`03_business_analysis.sql`](link_ke_file_03_lu): Executed complex aggregations to calculate freight-to-price ratios, measure the exact correlation between delivery delays and 1-star reviews, and map regional revenue against logistical costs.
