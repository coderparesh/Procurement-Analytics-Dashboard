/*
================================================================================
Project: Procurement & Supplier Performance Analytics Dashboard
File: procurement_sql_case_study.sql
Author: Naveen Koyyala

Purpose:
This SQL case study adds stronger SQL proof to the Procurement Analytics Dashboard.
It answers real business questions related to supplier performance, procurement spend,
delivery delays, defect rates, compliance, cost savings, and high-risk suppliers.

How to use:
1. Create a MySQL database.
2. Import your Purchase_Orders.xlsx data into a table named: purchase_orders
3. Rename your table columns to match the assumed column names below OR update the
   column names in these queries according to your actual dataset.
4. Run each query one by one.
5. Take screenshots of important query outputs and add them to GitHub.

Assumed table name:
purchase_orders

Assumed columns:
purchase_order_id
supplier_name
category
order_date
delivery_date
quantity
unit_price
negotiated_price
delivery_status
defective_units
compliance_status
order_status

If your actual Excel column names are different, change only the column names in the
queries. Keep the business logic the same.

Skills demonstrated:
SELECT, WHERE, ORDER BY, GROUP BY, HAVING, CASE WHEN, CTEs, Window Functions,
KPI calculation, business analysis, supplier risk analysis, and reporting insights.
================================================================================
*/


/*
================================================================================
SECTION 1: BASIC DATA EXPLORATION
Goal: Understand dataset size, suppliers, categories, date range, and order value.
================================================================================
*/


-- 01. View sample records from the procurement dataset
SELECT *
FROM purchase_orders
LIMIT 10;


-- 02. Count total purchase orders
SELECT 
    COUNT(*) AS total_purchase_orders
FROM purchase_orders;


-- 03. Count unique suppliers
SELECT 
    COUNT(DISTINCT supplier_name) AS total_suppliers
FROM purchase_orders;


-- 04. Count unique product categories
SELECT 
    COUNT(DISTINCT category) AS total_categories
FROM purchase_orders;


-- 05. Find dataset date range
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM purchase_orders;


/*
================================================================================
SECTION 2: PROCUREMENT SPEND ANALYSIS
Goal: Analyze total spend, average order value, and category-wise spending.
================================================================================
*/


-- 06. Calculate total procurement spend
SELECT 
    ROUND(SUM(quantity * unit_price), 2) AS total_procurement_spend
FROM purchase_orders;


-- 07. Calculate average order value
SELECT 
    ROUND(AVG(quantity * unit_price), 2) AS average_order_value
FROM purchase_orders;


-- 08. Supplier-wise total spend
SELECT 
    supplier_name,
    COUNT(*) AS total_orders,
    ROUND(SUM(quantity * unit_price), 2) AS total_spend
FROM purchase_orders
GROUP BY supplier_name
ORDER BY total_spend DESC;


-- 09. Category-wise total spend
SELECT 
    category,
    COUNT(*) AS total_orders,
    ROUND(SUM(quantity * unit_price), 2) AS total_spend
FROM purchase_orders
GROUP BY category
ORDER BY total_spend DESC;


-- 10. Monthly procurement spend trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders,
    ROUND(SUM(quantity * unit_price), 2) AS monthly_spend
FROM purchase_orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;


/*
================================================================================
SECTION 3: SUPPLIER PERFORMANCE ANALYSIS
Goal: Identify top suppliers, low-performing suppliers, and supplier contribution.
================================================================================
*/


-- 11. Rank suppliers by total spend using window function
SELECT 
    supplier_name,
    ROUND(SUM(quantity * unit_price), 2) AS total_spend,
    RANK() OVER (ORDER BY SUM(quantity * unit_price) DESC) AS supplier_spend_rank
FROM purchase_orders
GROUP BY supplier_name;


-- 12. Supplier contribution percentage to total spend
SELECT 
    supplier_name,
    ROUND(SUM(quantity * unit_price), 2) AS supplier_spend,
    ROUND(
        SUM(quantity * unit_price) * 100.0 / 
        (SELECT SUM(quantity * unit_price) FROM purchase_orders),
        2
    ) AS spend_contribution_percentage
FROM purchase_orders
GROUP BY supplier_name
ORDER BY spend_contribution_percentage DESC;


-- 13. Top 3 suppliers by purchase value
SELECT 
    supplier_name,
    COUNT(*) AS total_orders,
    ROUND(SUM(quantity * unit_price), 2) AS total_spend
FROM purchase_orders
GROUP BY supplier_name
ORDER BY total_spend DESC
LIMIT 3;


/*
================================================================================
SECTION 4: DELIVERY PERFORMANCE ANALYSIS
Goal: Analyze delayed orders and supplier-wise on-time delivery performance.
================================================================================
*/


-- 14. Count orders by delivery status
SELECT 
    delivery_status,
    COUNT(*) AS total_orders
FROM purchase_orders
GROUP BY delivery_status
ORDER BY total_orders DESC;


-- 15. Overall on-time delivery percentage
SELECT 
    COUNT(*) AS total_orders,
    SUM(CASE WHEN delivery_status = 'On Time' THEN 1 ELSE 0 END) AS on_time_orders,
    SUM(CASE WHEN delivery_status = 'Delayed' THEN 1 ELSE 0 END) AS delayed_orders,
    ROUND(
        SUM(CASE WHEN delivery_status = 'On Time' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS on_time_delivery_percentage
FROM purchase_orders;


-- 16. Supplier-wise delay rate
SELECT 
    supplier_name,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN delivery_status = 'Delayed' THEN 1 ELSE 0 END) AS delayed_orders,
    ROUND(
        SUM(CASE WHEN delivery_status = 'Delayed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS delay_rate_percentage
FROM purchase_orders
GROUP BY supplier_name
ORDER BY delay_rate_percentage DESC;


-- 17. Monthly delayed order trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN delivery_status = 'Delayed' THEN 1 ELSE 0 END) AS delayed_orders,
    ROUND(
        SUM(CASE WHEN delivery_status = 'Delayed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS monthly_delay_rate_percentage
FROM purchase_orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;


/*
================================================================================
SECTION 5: QUALITY AND DEFECT ANALYSIS
Goal: Identify suppliers and categories with high defect issues.
================================================================================
*/


-- 18. Total defective units
SELECT 
    SUM(defective_units) AS total_defective_units
FROM purchase_orders;


-- 19. Supplier-wise defect rate
SELECT 
    supplier_name,
    SUM(quantity) AS total_units_ordered,
    SUM(defective_units) AS total_defective_units,
    ROUND(
        SUM(defective_units) * 100.0 / NULLIF(SUM(quantity), 0),
        2
    ) AS defect_rate_percentage
FROM purchase_orders
GROUP BY supplier_name
ORDER BY defect_rate_percentage DESC;


-- 20. Category-wise defect rate
SELECT 
    category,
    SUM(quantity) AS total_units_ordered,
    SUM(defective_units) AS total_defective_units,
    ROUND(
        SUM(defective_units) * 100.0 / NULLIF(SUM(quantity), 0),
        2
    ) AS defect_rate_percentage
FROM purchase_orders
GROUP BY category
ORDER BY defect_rate_percentage DESC;


/*
================================================================================
SECTION 6: COMPLIANCE ANALYSIS
Goal: Track supplier compliance and identify non-compliant suppliers.
================================================================================
*/


-- 21. Overall compliance rate
SELECT 
    COUNT(*) AS total_orders,
    SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) AS compliant_orders,
    SUM(CASE WHEN compliance_status <> 'Compliant' THEN 1 ELSE 0 END) AS non_compliant_orders,
    ROUND(
        SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS compliance_rate_percentage
FROM purchase_orders;


-- 22. Supplier-wise compliance rate
SELECT 
    supplier_name,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) AS compliant_orders,
    ROUND(
        SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS compliance_rate_percentage
FROM purchase_orders
GROUP BY supplier_name
ORDER BY compliance_rate_percentage ASC;


/*
================================================================================
SECTION 7: COST SAVINGS OPPORTUNITY ANALYSIS
Goal: Compare actual unit price with negotiated price to identify savings.
================================================================================
*/


-- 23. Total negotiated savings opportunity
SELECT 
    ROUND(SUM((unit_price - negotiated_price) * quantity), 2) AS total_savings_opportunity
FROM purchase_orders
WHERE unit_price > negotiated_price;


-- 24. Supplier-wise savings opportunity
SELECT 
    supplier_name,
    ROUND(SUM(quantity * unit_price), 2) AS total_spend,
    ROUND(SUM(CASE 
        WHEN unit_price > negotiated_price 
        THEN (unit_price - negotiated_price) * quantity 
        ELSE 0 
    END), 2) AS savings_opportunity
FROM purchase_orders
GROUP BY supplier_name
ORDER BY savings_opportunity DESC;


-- 25. Category-wise savings opportunity
SELECT 
    category,
    ROUND(SUM(quantity * unit_price), 2) AS total_spend,
    ROUND(SUM(CASE 
        WHEN unit_price > negotiated_price 
        THEN (unit_price - negotiated_price) * quantity 
        ELSE 0 
    END), 2) AS savings_opportunity
FROM purchase_orders
GROUP BY category
ORDER BY savings_opportunity DESC;


/*
================================================================================
SECTION 8: ORDER STATUS ANALYSIS
Goal: Track completed, pending, and cancelled purchase orders.
================================================================================
*/


-- 26. Count purchase orders by order status
SELECT 
    order_status,
    COUNT(*) AS total_orders
FROM purchase_orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- 27. Supplier-wise pending and cancelled orders
SELECT 
    supplier_name,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN order_status = 'Pending' THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN order_status = 'Cancelled' THEN 1 ELSE 0 END) AS cancelled_orders
FROM purchase_orders
GROUP BY supplier_name
ORDER BY pending_orders DESC, cancelled_orders DESC;


/*
================================================================================
SECTION 9: HIGH-RISK SUPPLIER ANALYSIS
Goal: Identify suppliers with high delay rate, high defect rate, or low compliance.
================================================================================
*/


-- 28. Supplier risk summary using CTE
WITH supplier_kpi AS (
    SELECT 
        supplier_name,
        COUNT(*) AS total_orders,
        ROUND(SUM(quantity * unit_price), 2) AS total_spend,
        ROUND(
            SUM(CASE WHEN delivery_status = 'Delayed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
            2
        ) AS delay_rate_percentage,
        ROUND(
            SUM(defective_units) * 100.0 / NULLIF(SUM(quantity), 0),
            2
        ) AS defect_rate_percentage,
        ROUND(
            SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
            2
        ) AS compliance_rate_percentage
    FROM purchase_orders
    GROUP BY supplier_name
)
SELECT 
    supplier_name,
    total_orders,
    total_spend,
    delay_rate_percentage,
    defect_rate_percentage,
    compliance_rate_percentage,
    CASE
        WHEN delay_rate_percentage > 25 
             OR defect_rate_percentage > 8 
             OR compliance_rate_percentage < 70
        THEN 'High Risk'
        WHEN delay_rate_percentage BETWEEN 15 AND 25 
             OR defect_rate_percentage BETWEEN 5 AND 8 
             OR compliance_rate_percentage BETWEEN 70 AND 85
        THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS supplier_risk_level
FROM supplier_kpi
ORDER BY 
    CASE
        WHEN delay_rate_percentage > 25 
             OR defect_rate_percentage > 8 
             OR compliance_rate_percentage < 70
        THEN 1
        WHEN delay_rate_percentage BETWEEN 15 AND 25 
             OR defect_rate_percentage BETWEEN 5 AND 8 
             OR compliance_rate_percentage BETWEEN 70 AND 85
        THEN 2
        ELSE 3
    END,
    total_spend DESC;


-- 29. High-value suppliers with poor performance
WITH supplier_kpi AS (
    SELECT 
        supplier_name,
        ROUND(SUM(quantity * unit_price), 2) AS total_spend,
        ROUND(
            SUM(CASE WHEN delivery_status = 'Delayed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
            2
        ) AS delay_rate_percentage,
        ROUND(
            SUM(defective_units) * 100.0 / NULLIF(SUM(quantity), 0),
            2
        ) AS defect_rate_percentage
    FROM purchase_orders
    GROUP BY supplier_name
)
SELECT 
    supplier_name,
    total_spend,
    delay_rate_percentage,
    defect_rate_percentage
FROM supplier_kpi
WHERE total_spend > (
    SELECT AVG(supplier_total_spend)
    FROM (
        SELECT SUM(quantity * unit_price) AS supplier_total_spend
        FROM purchase_orders
        GROUP BY supplier_name
    ) AS avg_supplier_spend
)
AND (
    delay_rate_percentage > 25
    OR defect_rate_percentage > 8
)
ORDER BY total_spend DESC;


/*
================================================================================
SECTION 10: FINAL BUSINESS INSIGHTS
Goal: Create final recruiter-friendly summary outputs.
================================================================================
*/


-- 30. Final supplier performance summary for dashboard/reporting
WITH supplier_summary AS (
    SELECT 
        supplier_name,
        COUNT(*) AS total_orders,
        ROUND(SUM(quantity * unit_price), 2) AS total_spend,
        ROUND(AVG(quantity * unit_price), 2) AS average_order_value,
        ROUND(
            SUM(CASE WHEN delivery_status = 'On Time' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
            2
        ) AS on_time_delivery_percentage,
        ROUND(
            SUM(defective_units) * 100.0 / NULLIF(SUM(quantity), 0),
            2
        ) AS defect_rate_percentage,
        ROUND(
            SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
            2
        ) AS compliance_rate_percentage,
        ROUND(SUM(CASE 
            WHEN unit_price > negotiated_price 
            THEN (unit_price - negotiated_price) * quantity 
            ELSE 0 
        END), 2) AS savings_opportunity
    FROM purchase_orders
    GROUP BY supplier_name
)
SELECT 
    supplier_name,
    total_orders,
    total_spend,
    average_order_value,
    on_time_delivery_percentage,
    defect_rate_percentage,
    compliance_rate_percentage,
    savings_opportunity,
    CASE
        WHEN on_time_delivery_percentage < 75 
             OR defect_rate_percentage > 8 
             OR compliance_rate_percentage < 70
        THEN 'Needs Review'
        ELSE 'Performing Well'
    END AS business_recommendation
FROM supplier_summary
ORDER BY total_spend DESC;


/*
================================================================================
Recommended README update:

Add this section to your project README.md:

## SQL Case Study Added

This project includes a SQL case study with 30 business-focused queries covering:
- Procurement spend analysis
- Supplier performance analysis
- Delivery delay analysis
- Defect rate analysis
- Compliance tracking
- Cost savings opportunity
- High-risk supplier identification
- Final business insight summary

SQL skills used:
SELECT, WHERE, GROUP BY, HAVING, CASE WHEN, CTEs, subqueries, window functions,
KPI calculations, and business reporting logic.

Resume bullet:
Wrote 30 SQL queries to analyze procurement spend, supplier performance, delivery
delays, defect rates, compliance, cost savings opportunities, and high-risk vendors
using MySQL, CTEs, CASE statements, aggregations, and ranking logic.
================================================================================
*/
