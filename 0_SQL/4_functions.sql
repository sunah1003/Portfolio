/* 4_function */
INSERT INTO books (
    title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256), 
    ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
    ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);
SELECT title FROM books;


-- DISTINCT
SELECT author_lname FROM books;
SELECT DISTINCT author_lname FROM books;
SELECT DISTINCT(CONCAT(author_fname," ",author_lname)) FROM books;


-- ORDER BY
SELECT author_lname FROM books ORDER BY author_lname DESC;
SELECT * FROM books ORDER BY title ASC;
SELECT title, pages FROM books ORDER BY released_year DESC;
SELECT title, pages,released_year FROM books ORDER BY released_year,title DESC;
SELECT title, author_fname, author_lname FROM books ORDER BY 3 DESC;
SELECT title, author_fname, author_lname FROM books ORDER BY 2 DESC, author_lname ASC;


-- LIMIT
SELECT * FROM books LIMIT 2;
SELECT title FROM books ORDER BY released_year DESC LIMIT 1,5;
SELECT title FROM books ORDER BY released_year DESC LIMIT 3,5;
-- -> print until the end of the row:
SELECT title FROM books ORDER BY released_year DESC LIMIT 15,123456789;


-- LIKE
SELECT title, author_fname FROM books WHERE author_fname LIKE "%da%";
SELECT title, author_fname FROM books WHERE author_fname LIKE "%da";
SELECT title, author_fname FROM books WHERE author_fname LIKE "da%";
SELECT title FROM books WHERE title LIKE "%the%" ORDER BY title DESC;


-- WILDCARDS
SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '__';
-- -> stock_quantity in two digits
SELECT stock_quantity FROM books WHERE stock_quantity LIKE '(___)___-____';
SELECT title FROM books WHERE title LIKE '%\%%';
SELECT title FROM books WHERE title LIKE '%\_%';


-- COUNT
SELECT COUNT(*) FROM books;
SELECT COUNT(author_fname) FROM books;
SELECT COUNT(DISTINCT author_fname) FROM books;
SELECT COUNT(*) FROM books WHERE title LIKE "%THE%";


-- GROUP BY
SELECT title, author_lname, COUNT(*) FROM books GROUP BY author_lname;
SELECT title, author_lname, COUNT(*) FROM books GROUP BY author_lname, author_fname;
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;
SELECT title, author_lname, released_year, COUNT(*) FROM books GROUP BY released_year,author_lname, author_fname;
SELECT CONCAT('In ', released_year, ' ', COUNT(*), ' book(s) released') AS year FROM books GROUP BY released_year;


-- Aggregate functions: MIN, MAX, SUM, AVG
SELECT MIN(released_year) FROM books;
SELECT MAX(pages), title FROM books;
SELECT * FROM books WHERE pages=(SELECT MIN(pages) FROM books);
SELECT * FROM books ORDER BY pages ASC LIMIT 1; 
SELECT CONCAT(author_fname, " ", author_lname) AS author, MAX(pages) AS "longest book" FROM books GROUP BY author_lname, author_fname ORDER BY Max(pages) DESC;
SELECT title, author_fname, author_lname, SUM(pages) FROM books GROUP BY author_lname, author_fname ORDER BY SUM(pages) DESC;
SELECT AVG(released_year) FROM books;
SELECT released_year, AVG(stock_quantity) FROM books GROUP BY released_year ORDER BY AVG(stock_quantity) DESC;


-- Further Exercise:
SELECT CONCAT(author_fname, " ", author_lname), pages FROM books WHERE pages=(SELECT MAX(pages) FROM books);
SELECT CONCAT(author_fname, " ", author_lname), pages FROM books ORDER BY pages DESC LIMIT 1;
SELECT CONCAT(author_fname, " ", author_lname), MAX(pages) FROM books GROUP BY author_lname ORDER BY MAX(pages) DESC LIMIT 1;
SELECT released_year AS year, count(*) as "# of books", AVG(pages) AS "avg pages" FROM books GROUP BY released_year;