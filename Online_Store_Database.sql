-- Create the customers table
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100),
  email VARCHAR(100),
  address VARCHAR(200)
);

-- Create the products table
CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  price DECIMAL(10, 2),
  category VARCHAR(50)
);

-- Create the orders table
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create the order_items table
CREATE TABLE order_items (
  order_item_id INT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data into customers table
INSERT INTO customers (customer_id, customer_name, email, address)
VALUES (1, 'John Doe', 'john.doe@example.com', '123 Main St'),
       (2, 'Jane Smith', 'jane.smith@example.com', '456 Elm St');

-- Insert sample data into products table
INSERT INTO products (product_id, product_name, price, category)
VALUES (1, 'Widget A', 9.99, 'Widgets'),
       (2, 'Widget B', 14.99, 'Widgets'),
       (3, 'Gadget X', 19.99, 'Gadgets');

-- Insert sample data into orders table
INSERT INTO orders (order_id, customer_id, order_date)
VALUES (1, 1, '2023-05-01'),
       (2, 2, '2023-05-02');

-- Insert sample data into order_items table
INSERT INTO order_items (order_item_id, order_id, product_id, quantity)
VALUES (1, 1, 1, 2),
       (2, 1, 2, 1),
       (3, 2, 3, 3);

-- Perform SQL queries and operations

-- Retrieve all customers and their contact details
SELECT * FROM customers;

-- Retrieve products and their prices
SELECT product_name, price FROM products;

-- Calculate the total sales for a given time period (e.g., May 2023)
SELECT SUM(p.price * oi.quantity) AS total_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_date >= '2023-05-01' AND o.order_date <= '2023-05-31';

-- Find the most popular products based on the number of orders
SELECT p.product_name, COUNT(oi.order_item_id) AS order_count
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY order_count DESC;

-- Insert a new customer
INSERT INTO customers (customer_id, customer_name, email, address)
VALUES (3, 'Sarah Johnson', 'sarah.johnson@example.com', '789 Oak St');

-- Update customer information
UPDATE customers
SET address = '321 Pine St'
WHERE customer_id = 3;

-- Delete an order
DELETE FROM orders
WHERE order_id = 2;

