/* 3_string */

CREATE DATABASE book_shop;
use book_shop;

CREATE TABLE books(
    book_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(100),
    author_fname VARCHAR(100),
    author_lname VARCHAR(100),
    released_year INT,
    stock_quantity INT,
    pages INT,
    PRIMARY KEY(book_id));
    
INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);


-- CONCAT 
SELECT CONCAT(author_fname, " ", author_lname) FROM books;
SELECT author_fname as first, author_lname as last, CONCAT(author_fname, ",", author_lname) as full FROM books;
SELECT CONCAT_WS("-",author_lname,author_fname) as FULL FROM books;
SELECT title, CONCAT(stock_quantity, " in stock") AS quantity FROM books;


-- SUBSTRING
SELECT SUBSTRING("Hello World",1,4);
SELECT SUBSTRING("Hello World",-7);
SELECT SUBSTRING(title,1,10) AS "Short Title" FROM books;
SELECT CONCAT(SUBSTRING(title,1,10), "...") AS "Short Title" FROM books;


-- REPLACE
SELECT REPLACE("Hello World", "Hell","Nell");
SELECT REPLACE(title, "e", "3") FROM books;
SELECT SUBSTRING(REPLACE(title, "e","3"),1,10) FROM books;


-- REVERSE
SELECT REVERSE("Hello World");
SELECT CONCAT(author_fname,"-",REVERSE(author_fname)) FROM books;


-- CHAR_LENGTH
SELECT CHAR_LENGTH("Hello World");
SELECT author_lname, CHAR_LENGTH(author_lname) AS "LNAME LENGTH" FROM books;
SELECT CONCAT(author_lname, " is ", CHAR_LENGTH(author_lname), " characters long") AS new FROM books;


-- UPPER AND LOWER
SELECT UPPER("hello world");
SELECT LOWER("HELLO WORLD");
SELECT CONCAT("My favorite book is ", UPPER(title)) FROM books;
