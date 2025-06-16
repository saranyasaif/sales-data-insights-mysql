use sara;
CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),
city VARCHAR(100),
region VARCHAR(50)
);
CREATE TABLE products (
product_id INT PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(100),
price DECIMAL(10, 2)
);
CREATE TABLE sales (
sale_id INT PRIMARY KEY,
sale_date DATE,
customer_id INT,
product_id INT,
quantity INT,
total_amount DECIMAL(10, 2),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
FOREIGN KEY (product_id) REFERENCES products(product_id)
);
INSERT INTO customers VALUES
(1,	'Alice Johnson',	'Chennai',	'South'),
(2, 'Bob Smith',	'Mumbai',	'West'),
(3, 'Carol Patel'	,'Delhi'	,'North'),
(4, 'David Rao','Bangalore',	'South'),
(5, 'Emma Das',	'Hyderabad	','South'),
(6, 'Frank Mehta',	'Kolkata',	'East'),
(7, 'Grace Gupta'	,'Pune','West'),
(8, 'Helen Kumar',	'Ahmedabad',	'West'),
(9, 'Ian Shah'	,'Kochi',	'South'),
(10, 'Jane Iyer'	,'Jaipur'	,'North'),
(11	,'Kevin Pillai'	,'Chennai'	,'South'),
(12	,'Laura Reddy',	'Mumbai',	'West'),
(13, 'Mike' ,'Sinha	Delhi'	,'North'),
(14, 'Nina Bose','Kolkata',	'East'),
(15, 'Oscar Raju'	,'Hyderabad'	,'South'),
(16, 'Paula Verma',	'Bangalore'	,'South'),
(17, 'Quinn Agarwal'	,'Pune'	,'West'),
(18, 'Ravi Sharma',	'Lucknow',	'North'),
(19, 'Sara Fernandes',	'Goa'	,'West'),
(20, 'Tom Abraham',	'Coimbatore',	'South');
select * from customers;

INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Laptop Pro 15', 'Electronics', 75000.00),
(2, 'Smartphone Max', 'Electronics', 50000.00),
(3, 'Bluetooth Speaker', 'Electronics', 3500.00),
(4, 'Wireless Mouse', 'Accessories', 900.00),
(5, 'Gaming Keyboard', 'Accessories', 2300.00),
(6, 'Office Chair', 'Furniture', 6000.00),
(7, 'LED Monitor 24', 'Electronics', 9000.00),
(8, 'Tablet Lite', 'Electronics', 18000.00),
(9, 'Smartwatch Neo', 'Wearables', 4500.00),
(10, 'External HDD 1TB', 'Electronics', 4000.00),
(11, 'Desk Organizer', 'Accessories', 1200.00),
(12, 'USB-C Charger', 'Accessories', 700.00),
(13, 'DSLR Camera X100', 'Electronics', 45000.00),
(14, 'Tripod Stand', 'Accessories', 1500.00),
(15, 'Noise Cancelling HP', 'Electronics', 7200.00),
(16, 'Fitness Band Plus', 'Wearables', 2000.00),
(17, 'Air Purifier', 'Home', 9500.00),
(18, 'Water Bottle Steel', 'Lifestyle', 600.00),
(19, 'Power Bank 20000mAh', 'Accessories', 1300.00),
(20, 'Android TV Box', 'Electronics', 3800.00);

INSERT INTO sales (sale_id, customer_id, product_id, quantity, sale_date, total_amount) VALUES
(1, 2, 1, 1, '2024-10-12', 75000.00),
(2, 5, 2, 1, '2024-10-13', 50000.00),
(3, 1, 7, 2, '2024-10-15', 18000.00),
(4, 10, 6, 1, '2024-10-15', 6000.00),
(5, 4, 4, 3, '2024-10-16', 2700.00),
(6, 12, 3, 2, '2024-10-17', 7000.00),
(7, 3, 5, 1, '2024-10-18', 2300.00),
(8, 6, 9, 1, '2024-10-19', 4500.00),
(9, 7, 10, 1, '2024-10-19', 4000.00),
(10, 8, 11, 1, '2024-10-20', 1200.00),
(11, 15, 8, 2, '2024-10-21', 36000.00),
(12, 18, 13, 1, '2024-10-22', 45000.00),
(13, 9, 14, 1, '2024-10-23', 1500.00),
(14, 11, 12, 2, '2024-10-24', 1400.00),
(15, 13, 16, 1, '2024-10-25', 2000.00),
(16, 16, 15, 1, '2024-10-26', 7200.00),
(17, 19, 17, 1, '2024-10-26', 9500.00),
(18, 20, 18, 1, '2024-10-27', 600.00),
(19, 17, 19, 2, '2024-10-28', 2600.00),
(20, 14, 20, 1, '2024-10-29', 3800.00);

select * from sales;
-- Total sales by region
SELECT c.region, SUM(s.total_amount) AS total_sales
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.region;

-- Monthy sales trend
SELECT DATE_FORMAT(sale_date, '%Y-%m') AS month, SUM(total_amount) AS total_sales
FROM sales
GROUP BY month
ORDER BY month;

-- Top 5 Product by revenue 
SELECT p.product_name, SUM(s.total_amount) AS revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 5;

-- Average order value per customer
SELECT c.customer_name, AVG(s.total_amount) AS avg_order_value
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_name;

-- product wise sales revenue
SELECT 
    p.product_name,
    SUM(s.total_amount) AS total_revenue
FROM 
    sales s
JOIN 
    products p ON s.product_id = p.product_id
GROUP BY 
    p.product_name
ORDER BY 
    total_revenue DESC;
 
 -- Daily sales summary
SELECT 
    sale_date,
    COUNT(*) AS number_of_orders,
    SUM(total_amount) AS daily_revenue
FROM 
    sales
GROUP BY 
    sale_date
ORDER BY 
    sale_date;
    
-- Most popular Product Category    
SELECT 
    p.category,
    SUM(s.quantity) AS total_units_sold
FROM 
    sales s
JOIN 
    products p ON s.product_id = p.product_id
GROUP BY 
    p.category
ORDER BY 
    total_units_sold DESC;
    