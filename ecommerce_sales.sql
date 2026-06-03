CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers VALUES
(1,'Rahul','Bangalore'),
(2,'Priya','Hyderabad'),
(3,'Amit','Chennai');

INSERT INTO Products VALUES
(101,'Laptop','Electronics',50000),
(102,'Mobile','Electronics',20000),
(103,'Headphones','Accessories',2000);

INSERT INTO Orders VALUES
(1001,1,'2025-01-10'),
(1002,2,'2025-01-15'),
(1003,1,'2025-02-05');

INSERT INTO Order_Details VALUES
(1,1001,101,1),
(2,1001,103,2),
(3,1002,102,1),
(4,1003,102,2);


SELECT
SUM(p.price * od.quantity) AS Total_Sales
FROM Order_Details od
JOIN Products p
ON od.product_id = p.product_id;

SELECT
p.product_name,
SUM(od.quantity) AS Total_Quantity
FROM Order_Details od
JOIN Products p
ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Total_Quantity DESC;


SELECT
c.customer_name,
SUM(p.price * od.quantity) AS Total_Spent
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Order_Details od
ON o.order_id = od.order_id
JOIN Products p
ON od.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY Total_Spent DESC;


SELECT
MONTH(o.order_date) AS Month_No,
SUM(p.price * od.quantity) AS Revenue
FROM Orders o
JOIN Order_Details od
ON o.order_id = od.order_id
JOIN Products p
ON od.product_id = p.product_id
GROUP BY MONTH(o.order_date)
ORDER BY Month_No;


SELECT
c.customer_name,
SUM(p.price * od.quantity) AS Total_Spent,
RANK() OVER (
ORDER BY SUM(p.price * od.quantity) DESC
) AS Customer_Rank
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
JOIN Order_Details od
ON o.order_id = od.order_id
JOIN Products p
ON od.product_id = p.product_id
GROUP BY c.customer_name;


