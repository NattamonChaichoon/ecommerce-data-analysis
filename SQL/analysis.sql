USE ecommerce_db;
SELECT * FROM ecommerce_dataset_updated LIMIT 10;
DROP TABLE IF EXISTS sales_clean;
CREATE TABLE sales_clean AS 
SELECT
	User_ID AS user_id,
    Product_ID AS product_id,
    Category AS category,
    `Price (Rs.)` AS price,
    `Discount (%)` AS discount_pct,
    `Final_Price(Rs.)` AS final_price,
    Payment_Method AS payment_method,
    Purchase_Date AS purchase_date
FROM ecommerce_dataset_updated;
SELECT final_price
FROM sales_clean
LIMIT 10;
-- Total revenue
SELECT SUM(final_price) AS total_revenue
FROM sales_clean;
-- Total orders
SELECT COUNT(*) AS total_orders
FROM sales_clean;
-- Total customers
SELECT COUNT(DISTINCT user_id) AS total_customers
FROM sales_clean;
-- Products Analysis
SELECT category, SUM(final_price) AS revenue
FROM sales_clean
GROUP BY category
ORDER BY revenue DESC;
-- Payment Analysis
SELECT payment_method,
	COUNT(*) AS orders,
    SUM(final_price) AS revenue
FROM sales_clean
GROUP BY payment_method
ORDER BY revenue DESC;
-- Customers Analysis
SELECT user_id,
	COUNT(*) AS orders,
    SUM(final_price) as total_spent
FROM sales_clean
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 10;

SELECT purchase_date
FROM sales_clean
LIMIT 10;
-- Monthly Analysis
SELECT 
	DATE_FORMAT(STR_TO_DATE(purchase_date, '%d-%m-%Y'), '%Y-%m')AS month,
	SUM(final_price) AS revenue
    FROM sales_clean
    GROUP BY month
    ORDER BY month;


