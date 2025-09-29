-- HR-Analytics: Employee count based on dynamic gender passing (Medium)
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50),
    gender VARCHAR(10)
);

INSERT INTO employees (emp_name, gender) VALUES
('John', 'Male'),
('Alice', 'Female'),
('Robert', 'Male'),
('Sophia', 'Female');

CREATE OR REPLACE PROCEDURE get_employee_count_by_gender(
    IN input_gender VARCHAR,
    OUT emp_count INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COUNT(*) INTO emp_count FROM employees WHERE gender = input_gender;
END;
$$;

CALL get_employee_count_by_gender('Male', emp_count);


-- SmartStore Automated Purchase System (Hard)
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2),
    quantity_remaining INT,
    quantity_sold INT DEFAULT 0
);
CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(product_id),
    quantity INT,
    total_price DECIMAL(10,2)
);

CREATE OR REPLACE PROCEDURE process_order(
    IN p_product_id INT,
    IN p_quantity INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    available_qty INT;
    unit_price DECIMAL(10,2);
BEGIN
    SELECT quantity_remaining, price INTO available_qty, unit_price
    FROM products WHERE product_id = p_product_id;

    IF available_qty >= p_quantity THEN
        INSERT INTO sales(product_id, quantity, total_price)
        VALUES (p_product_id, p_quantity, unit_price * p_quantity);

        UPDATE products
        SET quantity_remaining = quantity_remaining - p_quantity,
            quantity_sold = quantity_sold + p_quantity
        WHERE product_id = p_product_id;

        RAISE NOTICE 'Product sold successfully!';
    ELSE
        RAISE NOTICE 'Insufficient Quantity Available!';
    END IF;
END;
$$;

CALL process_order(1, 2);

