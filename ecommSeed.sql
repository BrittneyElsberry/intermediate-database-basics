CREATE TABLE users (
user_id SERIAL PRIMARY KEY,
user_name varchar(40),
user_email varchar(40));

CREATE TABLE products (
product_id SERIAL PRIMARY KEY,
product_name varchar(60),
product_price DECIMAL);



CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
product_id INT REFERENCES products(product_id),
order_total DECIMAL,
customer_id INT REFERENCES customer(customer_id));
