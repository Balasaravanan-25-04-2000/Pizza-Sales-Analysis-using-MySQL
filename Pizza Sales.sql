SELECT * FROM pizza_db.pizza_sales;
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Average_Order_Value FROM pizza_sales;
SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales;
SELECT COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales;
SELECT ROUND((SUM(quantity) / COUNT(DISTINCT order_id)),2) AS Average_Pizzas_Per_Order FROM pizza_sales;
SELECT DAYNAME(CURDATE()) AS Order_day, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

ALTER TABLE pizza_sales
MODIFY order_date VARCHAR(225);
DESC pizza_sales;
UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, "%d-%m-%Y");
ALTER TABLE pizza_sales
MODIFY order_date DATE;
SELECT * FROM pizza_db.pizza_sales;
SELECT DAYNAME(order_date) FROM pizza_db.pizza_sales;

# 1.Daily Trend
SELECT DAYNAME(order_date) AS Order_day, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales GROUP BY DAYNAME(order_date);

# 2.Hourly Trend
SELECT HOUR(order_time) AS Order_hours, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales GROUP BY HOUR(order_time);

# 3.Percentage of sales by Pizza category
SELECT pizza_category, ROUND(SUM(total_price),2) AS Total_Sales, ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date) = 1),2) AS PCT_sales_by_category 
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

# 4.Percentage of sales by Pizza size
SELECT pizza_size, ROUND(SUM(total_price),2) AS Total_Sales, ROUND(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE QUARTER(order_date) = 1),2) AS PCT_sales_by_category 
FROM pizza_sales
WHERE QUARTER(order_date) = 1
GROUP BY pizza_size
ORDER BY PCT_sales_by_category DESC;

# 5.Total Pizzas sold by Pizza category
SELECT pizza_category, SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales 
GROUP BY pizza_category;

# 6.Top 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name, SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold DESC
LIMIT 5;

# 7.Bottom 5 Worst Sellers by Total Pizzas Sold
SELECT pizza_name, SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_name
ORDER BY Total_Pizzas_Sold
LIMIT 5;
