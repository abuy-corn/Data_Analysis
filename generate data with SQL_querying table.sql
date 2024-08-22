CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(10),
    registration_date DATE
);

INSERT INTO Customers (customer_id, first_name, last_name, email, phone, address, city, state, zip_code, registration_date) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St', 'Springfield', 'IL', '62701', '2024-01-15'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Elm St', 'Shelbyville', 'IL', '62702', '2024-02-20'),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '345-678-9012', '789 Oak St', 'Springfield', 'IL', '62703', '2024-03-10');

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    stock_quantity INT
);

INSERT INTO Products (product_id, name, description, price, stock_quantity) VALUES
(101, 'Laptop', '14 inch, 8GB RAM, 256GB SSD', 799.99, 50),
(102, 'Smartphone', '6.5 inch, 128GB Storage, 5G', 599.99, 100),
(103, 'Headphones', 'Wireless, Noise-cancelling', 199.99, 200);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES
(1001, 1, '2024-04-05', 1399.98, 'Completed'),
(1002, 2, '2024-04-10', 199.99, 'Completed'),
(1003, 3, '2024-04-15', 799.99, 'Pending');

CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO OrderItems (order_item_id, order_id, product_id, quantity, unit_price) VALUES
(1, 1001, 101, 1, 799.99),
(2, 1001, 102, 1, 599.99),
(3, 1002, 103, 1, 199.99),
(4, 1003, 101, 1, 799.99);

DELIMITER $$

CREATE PROCEDURE generate_customers(IN num_customers INT)
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= num_customers DO
        INSERT INTO Customers (customer_id, first_name, last_name, email, phone, address, city, state, zip_code, registration_date)
        VALUES (
            i + 3, -- Starting after existing rows
            CONCAT('First', i),
            CONCAT('Last', i),
            CONCAT('email', i, '@example.com'),
            CONCAT('555-', LPAD(i, 4, '0')),
            CONCAT(i, ' Example St'),
            'City',
            'State',
            '12345',
            DATE_ADD('2024-01-01', INTERVAL i DAY)
        );
        SET i = i + 1;
    END WHILE;
END $$

DELIMITER ;

-- Call the procedure to generate 100 more customers
CALL generate_customers(100);


SELECT *
FROM Customers


