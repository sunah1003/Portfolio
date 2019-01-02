/* 7_joins */
-- FOREIGN KEY
CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL);


CREATE TABLE customers2(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL);
    
    
CREATE TABLE orders(
    id INT AUTO_INCREMENT,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    PRIMARY KEY(id),
    FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
    ('George', 'Michael', 'gm@gmail.com'),
    ('David', 'Bowie', 'david@gmail.com'),
    ('Blue', 'Steele', 'blue@gmail.com'),
    ('Bette', 'Davis', 'bette@aol.com');
    
    
INSERT INTO customers2 (first_name, last_name, email) 
VALUES ('Boy2', 'George', 'george@gmail.com'),
    ('George2', 'Michael', 'gm@gmail.com'),
    ('David', 'Bowie', 'david@gmail.com'),
    ('Blue', 'Steele', 'blue@gmail.com'),
    ('Bette', 'Davis', 'bette@aol.com'); 
    
    
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
    ('2017/11/11', 35.50, 1),
    ('2014/12/12', 800.67, 2),
    ('2015/01/03', 12.50, 2),
    ('1999/04/11', 450.25, 5);


-- CROSS JOINS (CARTESIAN JOIN): Cross multiplying data
SELECT * FROM orders, customers;
SELECT * FROM orders CROSS JOIN customers;


-- INNER JOIN: Select all records from A and B where the join condition is met
-- IMPLICIT INNER JOIN:
SELECT * FROM customers, orders WHERE customers.id = orders.customer_id;
SELECT * FROM customers CROSS JOIN orders WHERE customers.id = orders.customer_id;
-- EXPLICIT INNER JOIN:
SELECT * FROM customers INNER JOIN orders ON customers.id = orders.customer_id;
-- as example:
-- select title, rating, concat(first_name, " ", last_name) as reviewer
-- from reviewers INNER JOIN reviews ON reviewers.id=reviews.reviewer_id
-- INNER JOIN series ON series.id=reviews.series_id 


-- LEFT JOIN: Select everything from A, along with any matching records in B
SELECT * FROM customers LEFT JOIN orders 
ON customers.id = orders.customer_id;

SELECT first_name, last_name, order_date, amount FROM customers LEFT JOIN orders
ON customers.id = orders.customer_id; 

SELECT first_name, last_name, IFNULL(SUM(amount), 0) AS total_spent
FROM customers LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent;


-- RIGHT JOIN: Select everything from B, along with any matching records in A
SELECT IFNULL(first_name,'MISSING') AS first, IFNULL(last_name,'USER') as last, order_date, amount, SUM(amount)
FROM customers RIGHT JOIN orders ON customers.id = orders.customer_id
GROUP BY first_name, last_name;


-- SELF JOIN
SELECT * FROM customers as c1 JOIN customers as c2 ON c1.first_name=c2.first_name ;
SELECT * FROM customers as c1 JOIN customers as c2 ON c1.first_name=c2.first_name AND c1.first_name="Boy";


-- FULL JOIN
SELECT * FROM customers FULL JOIN customers2;

-- UNION: allows to stack one dataset on top of the other
-- UNION only appends distinct values (no duplicate rows)
-- UNION ALL appends all the values 
-- Conditions: Both tables must have the same number of columns. The columns must have the same data types in the same order as the first table.
SELECT * FROM customers UNION SELECT * FROM customers2 ORDER BY id ASC;
SELECT * FROM customers UNION ALL SELECT * FROM customers2 ORDER BY id ASC;
SELECT * FROM customers WHERE first_name IN ("Boy","David","Blue") UNION  
SELECT * FROM customers2 WHERE first_name IN ("Boy","David","Blue");


/* Practices */
SELECT * FROM customers as c1 JOIN customers2 as c2;
SELECT COUNT(*) FROM customers as c1 JOIN customers2 as c2;
SELECT COUNT(c1.first_name) FROM customers as c1 JOIN customers2 as c2;
SELECT COUNT(DISTINCT c1.first_name) FROM customers as c1 JOIN customers2 as c2;
SELECT * FROM customers as c1 INNER JOIN customers2 as c2;
SELECT * FROM customers as c1 INNER JOIN customers2 as c2 ON c1.first_name=c2.first_name;
SELECT COUNT(*) FROM customers as c1 INNER JOIN customers2 as c2;
SELECT COUNT(*) FROM customers as c1 INNER JOIN customers2 as c2 ON c1.first_name=c2.first_name;

SELECT * FROM customers as c1 LEFT JOIN customers2 as c2 ON c1.first_name=c2.first_name;
SELECT * FROM customers as c1 LEFT JOIN customers2 as c2 ON c1.first_name=c2.first_name WHERE c2.first_name IS NULL;

SELECT * FROM customers as c1 RIGHT JOIN customers2 as c2 ON c1.first_name=c2.first_name;
SELECT * FROM customers as c1 RIGHT JOIN customers2 as c2 ON c1.first_name=c2.first_name WHERE c1.first_name IS NULL;

SELECT sub.* FROM (SELECT * FROM customers UNION ALL SELECT * FROM customers) sub;
SELECT sub.* FROM (SELECT * FROM customers UNION ALL SELECT * FROM customers) sub WHERE email LIKE "%gmail.com";
