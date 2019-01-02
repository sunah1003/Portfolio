/* 2_CRUD (Create, Read, Update, Delete) */
CREATE DATABASE my_db;
SHOW DATABASES;
USE my_db;
SELECT DATABASE();
/* ##### CREATE ##### */ 
DROP TABLE my_tb;
CREATE TABLE my_tb(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL DEFAULT 'unnamed',
    age INT DEFAULT 20,
    PRIMARY KEY(id));
--By name, NULL cannot be accepted
--By age, NULL can be accepted

SHOW TABLES;
SHOW COLUMNS FROM my_tb;
DESC my_tb; 

-- INSERTING DATA
INSERT INTO my_tb(name, age) VALUES ("Sunah", 29), ("Amy",30), ("Tom",31);
INSERT INTO my_tb(name) VALUES ("Susan");
INSERT INTO my_tb(age) VALUES (30);
-- View warning:
SHOW WARNINGS;


/* ##### READ ##### */ 
SELECT * FROM my_tb;
SELECT name FROM my_tb;
SELECT name, age FROM my_tb;
SELECT * FROM my_tb WHERE age=30;
SELECT * FROM my_tb WHERE name="Sunah";
SELECT name as "NewName", age as "AGE" FROM my_tb WHERE name="unnamed";

/* ##### UPDATE ##### */ 
UPDATE my_tb SET name="noname" WHERE name="unnamed";
UPDATE my_tb SET age=30 WHERE age!=30;

/* ##### DELETE ##### */ 
DELETE FROM my_tb WHERE name="Sunah";
DELETE FROM my_tb WHERE age=30;
