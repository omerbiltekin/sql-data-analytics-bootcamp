DROP DATABASE IF EXISTS verianalizi;
GO

CREATE DATABASE verianalizi;
GO

USE verianalizi;
GO

---------------------------------------------------
-- PRODUCTS
---------------------------------------------------

CREATE TABLE products (
    product_id INT IDENTITY(1001,1) PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    units_in_stock INT NOT NULL,
    sale_price DECIMAL(5,2) NOT NULL
);
GO

SET IDENTITY_INSERT products ON;

INSERT INTO products
(product_id, product_name, units_in_stock, sale_price)
VALUES
(1001,'Chocolate Chip Cookie',200,1.50),
(1002,'Banana Nut Muffin',180,2.50),
(1003,'Croissant',70,1.75),
(1004,'Cheese Danish',55,1.85),
(1005,'Cannoli',112,2.25),
(1006,'Sweet Bread Loaf',32,15.50),
(1007,'Strawberry Macaron',98,2.00),
(1008,'Coffee Cake',25,13.00),
(1009,'Carrot Cake',15,14.50),
(1010,'Chocolate Covered Doughnut',80,1.00);

SET IDENTITY_INSERT products OFF;
GO

---------------------------------------------------
-- SUPPLIERS
---------------------------------------------------

CREATE TABLE suppliers (
    supplier_id SMALLINT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
GO

SET IDENTITY_INSERT suppliers ON;

INSERT INTO suppliers
(supplier_id, name)
VALUES
(1,'Bakery LLC'),
(2,'Goods 4 U'),
(3,'Savory Loaf Delivery Co.'),
(4,'Mrs. Yums'),
(5,'Grain to Table LLC');

SET IDENTITY_INSERT suppliers OFF;
GO

---------------------------------------------------
-- DELIVERY STATUS
---------------------------------------------------

CREATE TABLE supplier_delivery_status (
    order_status_id TINYINT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
GO

INSERT INTO supplier_delivery_status
(order_status_id, name)
VALUES
(1,'Processed'),
(2,'Shipped'),
(3,'Delivered');
GO

---------------------------------------------------
-- ORDERED ITEMS
---------------------------------------------------

CREATE TABLE ordered_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    status TINYINT NOT NULL DEFAULT 1,
    quantity INT NOT NULL,
    unit_price DECIMAL(5,2) NOT NULL,
    shipped_date DATE NULL,
    shipper_id SMALLINT NULL,

    CONSTRAINT pk_ordered_items
        PRIMARY KEY (order_id, product_id),

    CONSTRAINT fk_order_items_products
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT fk_orders_order_statuses
        FOREIGN KEY (status)
        REFERENCES supplier_delivery_status(order_status_id),

    CONSTRAINT fk_orders_shippers
        FOREIGN KEY (shipper_id)
        REFERENCES suppliers(supplier_id)
);
GO

INSERT INTO ordered_items VALUES
(1,1004,1,53,0.35,'2021-08-15',1),
(2,1001,2,73,0.29,'2022-03-21',2),
(2,1004,3,10,0.35,'2022-02-07',5),
(2,1006,2,63,5.28,'2021-06-09',4),
(3,1003,1,21,0.50,'2021-09-06',1),
(4,1003,2,85,0.50,'2022-06-22',3),
(4,1010,3,42,0.39,'2021-05-13',4),
(5,1002,1,100,1.89,'2022-02-03',2),
(6,1001,2,35,0.29,'2021-11-06',3),
(6,1002,2,54,1.89,'2022-12-23',5),
(6,1003,3,10,0.50,'2022-04-05',1),
(6,1005,3,55,0.47,'2021-05-22',2),
(7,1003,3,12,0.50,'2022-06-26',1),
(8,1005,2,70,0.47,'2021-09-21',5),
(8,1008,2,96,8.59,'2022-11-10',3),
(9,1006,3,43,5.28,'2022-10-15',1),
(10,1001,1,33,0.29,'2022-01-06',1),
(10,1009,3,23,4.28,'2022-07-23',1);
GO

---------------------------------------------------
-- CUSTOMERS
---------------------------------------------------

CREATE TABLE customers (
    customer_id INT IDENTITY(100101,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NULL,
    phone VARCHAR(50) NULL,
    address VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state CHAR(2) NOT NULL,
    total_money_spent INT NOT NULL DEFAULT 0
);
GO

SET IDENTITY_INSERT customers ON;

INSERT INTO customers
(
    customer_id,
    first_name,
    last_name,
    birth_date,
    phone,
    address,
    city,
    state,
    total_money_spent
)
VALUES
(100101,'Kevin','Malone','1989-04-28','635-573-9754','1229 Main Street','Scranton','PA',11000),
(100102,'Charles','Xavier','1965-04-11','729-287-9456','123 North Hill Drive','Dallas','TX',947),
(100103,'Finley','Danish','1999-02-07','126-583-7856','432 Hilly Road','Austin','TX',534),
(100104,'Obi','Kenobi','1921-04-22','975-357-7663','101 Alpine Avenue','New York','NY',3567),
(100105,'Don','Draper','1948-11-07',NULL,'12 South Main Lane','San Francisco','CA',195),
(100106,'Frodo','Baggins','2001-09-04',NULL,'1 Pastery Lane','Chicago','IL',56),
(100107,'Michael','Scott','1978-08-20','235-357-3464','987 Croissant Street','Scranton','PA',2536),
(100108,'Maggie','Muffin','2001-07-06','906-485-1542','701 North Street','Sarasota','FL',1009),
(100109,'Kelly','Kapoor','1987-05-30','674-357-9151','62810 Julip Lane','Scranton','PA',540),
(100110,'Anakin','Skywalker','1934-10-15','346-458-3370','122 South Street','Charleston','SC',36);

SET IDENTITY_INSERT customers OFF;
GO

---------------------------------------------------
-- CUSTOMER ORDERS
---------------------------------------------------

CREATE TABLE customer_orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_total DECIMAL(6,2) NOT NULL,
    tip VARCHAR(2000) NULL,

    CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_customer_orders_products
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);
GO

SET IDENTITY_INSERT customer_orders ON;

INSERT INTO customer_orders
(
    order_id,
    customer_id,
    product_id,
    order_date,
    order_total,
    tip
)
VALUES
(1,100101,1001,'2020-01-30',26.24,'2'),
(2,100110,1002,'2021-08-25',6.19,'1'),
(3,100106,1005,'2022-12-12',3.87,'0'),
(4,100103,1007,'2018-03-22',4.00,'5'),
(5,100102,1003,'2017-08-25',9.97,'10'),
(6,100108,1009,'2018-11-18',87.01,'1'),
(7,100101,1001,'2022-09-20',2.45,'5'),
(8,100104,1008,'2018-06-08',16.42,'0'),
(9,100105,1007,'2019-07-05',8.11,'1'),
(10,100106,1006,'2018-04-22',53.12,'3'),
(11,100103,1001,'2019-11-18',27.01,'1'),
(12,100101,1003,'2018-09-20',10.45,'5'),
(13,100106,1008,'2020-06-08',90.42,'0'),
(14,100102,1009,'2022-07-05',11.11,'1'),
(15,100104,1006,'2020-04-22',24.12,'3');

SET IDENTITY_INSERT customer_orders OFF;
GO

---------------------------------------------------
-- CUSTOMER REVIEWS
---------------------------------------------------

CREATE TABLE customer_orders_review (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    order_date DATE NOT NULL,
    [Rating 1-10] INT NOT NULL
);
GO

SET IDENTITY_INSERT customer_orders_review ON;

INSERT INTO customer_orders_review
(
    order_id,
    customer_id,
    product_id,
    order_date,
    [Rating 1-10]
)
VALUES
(1,100101,1001,'2020-01-30',8),
(2,100110,1002,'2021-08-25',5),
(3,100111,1005,'2022-12-12',10),
(4,100103,1007,'2081-03-22',7),
(5,100102,1003,'2017-08-25',6),
(7,100101,1001,'2022-09-20',8),
(8,100104,1008,'2018-06-08',9),
(9,100105,1007,'2019-07-05',6),
(10,100106,1006,'2018-04-22',8),
(11,100103,1001,'2019-11-18',6),
(12,1001001,1003,'2018-09-20',9),
(13,100106,1008,'2020-06-08',10),
(14,100102,1009,'2023-07-05',8),
(15,100104,1006,'2020-04-22',7);

SET IDENTITY_INSERT customer_orders_review OFF;
GO

---------------------------------------------------
-- EMPLOYEES
---------------------------------------------------

CREATE TABLE employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    title VARCHAR(50) NOT NULL,
    salary INT NOT NULL
);
GO

SET IDENTITY_INSERT employees ON;

INSERT INTO employees
(
    employee_id,
    first_name,
    last_name,
    department,
    title,
    salary
)
VALUES
(1,'Christine','Freberg','Bakery','Lead Baker',70000),
(2,'Dwight','Schrute','Bakery','Assistant to the Lead Baker',45000),
(3,'Tom','Haveford','Bakery','Chocolatier',45000),
(4,'Ann','Perkins','Bakery','Bakery Clerk',30000),
(5,'Carl','Lorthner','Bakery','Dough Maker',40000),
(6,'Ron','Swanson','Marketing','Director of Marketing',75000),
(7,'Troy','Barnes','Marketing','Lead Marketer',60000),
(8,'Jeff','Winger','Marketing','Marketing Analyst',60000),
(9,'Annie','Edison','Marketing','Social Media Marketer',65000);

SET IDENTITY_INSERT employees OFF;
GO