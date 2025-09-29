-- PROBLEM 1
Create table TRANSACTION_DATA(id int,val decimal);
INSERT INTO TRANSACTION_DATA(ID,VAL)
SELECT 1,RANDOM()
FROM GENERATE_SERIES(1,1000000);
INSERT INTO TRANSACTION_DATA(ID,VAL)
SELECT 2,RANDOM()
FROM GENERATE_SERIES(1,1000000);
SELECT * FROM TRANSACTION_DATA;
CREATE or REPLACE VIEW SALES_SUMMARY AS
SELECT
ID,
COUNT(*) AS total_quantity_sold, sum(val) AS total_sales,
count(distinct id) AS total_orders
FROM TRANSACTION_DATA GROUP BY ID;
EXPLAIN ANALYZE
SELECT * FROM SALES_SUMMARY;
CREATE MATERIALIZED VIEW SALES_SUMM AS
SELECT
ID,
COUNT(*) AS total_quantity_sold, sum(val) AS total_sales, count(distinct id) AS total_orders
FROM TRANSACTION_DATA GROUP BY ID;
EXPLAIN ANALYZE
SELECT * FROM SALES_SUMM;

-- PROBLEM 2

CREATE TABLE customer_data (
  transaction_id SERIAL PRIMARY KEY,
  customer_name VARCHAR(100),
  email VARCHAR(100),
  phone VARCHAR(15),
  payment_info VARCHAR(50),
  order_value DECIMAL,
  order_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO customer_data (customer_name, email, phone, payment_info, order_value)
VALUES
('M', 'M@example.com', '9131094977', '1234-5678-9012-3456', 500),
('A', 'A@example.com', '9931094977', '1234-5678-9012-3456', 234),
('B', 'B@example.com', '9263444151', '9876-5432-1098-7654', 754),
('C', 'C@example.com', '9263444151', '9876-5432-1098-7654', 300);

CREATE OR REPLACE VIEW restricted_sales_data AS
SELECT
  customer_name,
  COUNT(*) AS total_orders,
  SUM(order_value) AS total_sales
FROM customer_data
GROUP BY customer_name;

SELECT * FROM restricted_sales_data;

CREATE USER client1 WITH PASSWORD 'password123';

GRANT SELECT ON restricted_sales_data TO client1;

REVOKE SELECT ON restricted_sales_data FROM client1;
