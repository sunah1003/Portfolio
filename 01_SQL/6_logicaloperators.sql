/* 6_logicaloperators */
-- NOT EQUAL(!=)
SELECT title FROM books WHERE released_year = 2017;
SELECT title FROM books WHERE released_year != 2017;
SELECT title, author_lname FROM books WHERE author_lname != 'Harris';


-- NOT LIKE(NOT LIKE "%xx%")
SELECT title FROM books WHERE title LIKE 'W';
SELECT title FROM books WHERE title LIKE 'W%';
SELECT title FROM books WHERE title LIKE '%W%';
SELECT title FROM books WHERE title NOT LIKE 'W%';


-- GREATER THAN(>,>=), LESS THAN(<,>=)
SELECT title, released_year FROM books WHERE released_year > 2000 ORDER BY released_year;
SELECT title, released_year FROM books WHERE released_year >= 2000 ORDER BY released_year;
SELECT title, stock_quantity FROM books WHERE stock_quantity <= 100;
SELECT 99 > 1;
SELECT 99 > 567;
SELECT 'a' > 'b'
-- false
SELECT 'A' > 'a'
-- false
SELECT 'A' >=  'a'
-- true


-- AND(&&)
SELECT title, author_lname, released_year FROM books WHERE author_lname='Eggers';
SELECT title, author_lname, released_year FROM books WHERE released_year > 2010;
SELECT title, author_lname, released_year FROM books WHERE author_lname='Eggers' AND released_year > 2010;
SELECT 1 < 5 && 7 = 9;
-- false
SELECT -10 > -20 && 0 <= 0;
-- true
SELECT -40 <= 0 AND 10 > 40;
--false
SELECT 54 <= 54 && 'a' = 'A';
-- true
SELECT * FROM books WHERE author_lname='Eggers' AND released_year > 2010 
    AND title LIKE '%novel%';


-- OR (||)
SELECT title, author_lname, released_year, stock_quantity FROM books 
WHERE author_lname = 'Eggers'|| released_year > 2010 
OR stock_quantity > 100;


-- BETWEEN
SELECT name, birthdt FROM people 
WHERE birthdt BETWEEN CAST('1980-01-01' AS DATETIME) AND CAST('2000-01-01' AS DATETIME);


-- IN and NOT IN
SELECT title, author_lname FROM books
WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');

SELECT title, released_year FROM books WHERE released_year >= 2000 AND released_year % 2 != 0;

SELECT title, released_year FROM books WHERE released_year >= 2000
AND released_year NOT IN (2000,2002,2004,2006,2008,2010,2012,2014,2016);


-- CASE STATEMENTS
SELECT title, released_year, 
    CASE WHEN released_year >= 2000 THEN 'Modern Lit'
    ELSE '20th Century Lit'
    END AS GENRE
FROM books;

SELECT title, stock_quantity,
    CASE WHEN stock_quantity <= 50 THEN '*'
    WHEN stock_quantity <= 100 THEN '**'
    ELSE '***'
    END AS STOCK
FROM books; 

SELECT title, author_lname, 
    CASE WHEN count(*)=1 THEN CONCAT(count(*), " book")
    ELSE CONCAT(count(*)," books")
    END AS COUNT
FROM books GROUP BY author_lname, author_fname;