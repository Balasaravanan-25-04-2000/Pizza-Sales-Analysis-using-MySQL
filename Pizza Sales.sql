SELECT * FROM pizzadb.pizza_sales;

SELECT SUM(total_price) AS Total_Revenue FROM pizzadb.pizza_sales;

SELECT SUM(total_price) / COUNT(DISTINCT order_id) as Average_order_value FROM pizzadb.pizza_sales;

SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizzadb.pizza_sales;

SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizzadb.pizza_sales;

SELECT CAST(SUM(quantity) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Average_Pizzas_Per_Order FROM pizzadb.pizza_sales;