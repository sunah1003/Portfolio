/* 5_datatypes */
-- String: CHAR and VARCHAR
CREATE TABLE dogs (name CHAR(5), breed VARCHAR(10));
INSERT INTO dogs (name, breed) VALUES ('Princess Jane', 'Retrievesadfdsafdasfsafr');
SELECT * FROM dogs;

-- Number: DECIMAL
CREATE TABLE items(price DECIMAL(5,2));
INSERT INTO items(price) VALUES(7);
INSERT INTO items(price) VALUES(7987654);
INSERT INTO items(price) VALUES(34.88);
INSERT INTO items(price) VALUES(298.9999);
INSERT INTO items(price) VALUES(1.9999);
SELECT * FROM items;

-- Number: FLOAT and DOUBLE
CREATE TABLE thingies (price FLOAT, price2 DOUBLE);
INSERT INTO thingies(price) VALUES (88.45);
SELECT * FROM thingies;
INSERT INTO thingies(price) VALUES (8877.45);
SELECT * FROM thingies;
INSERT INTO thingies(price, price2) VALUES (8877665544.45,8877665544.45);
SELECT * FROM thingies;
-- FLOAT: Precision issues of 7 digits, DOUBLE: Precision issues of 15 digits


-- DATES and TIMES
-- DATE: Values with a date but no time: "YYYY-MM-DD"
-- TIME: Values with a time but no date: "HH:MM:SS"
-- DATETIME: Values with a date and time: "YYYY-MM-DD HH:MM:SS"
SELECT CURDATE();
SELECT CURTIME();
SELECT NOW();

CREATE TABLE people (
    name VARCHAR(100),
    birthdate DATE,
    birthtime TIME,
    birthdt DATETIME);
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Padma', '1983-11-11', '10:07:35', '1983-11-11 10:07:35');
INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES('Larry', '1943-12-25', '04:10:42', '1943-12-25 04:10:42');
SELECT * FROM people;


SELECT name, birthdate FROM people;
SELECT name, DAY(birthdate) FROM people;
SELECT name, birthdate, DAY(birthdate) FROM people;
SELECT name, birthdate, DAYNAME(birthdate) FROM people;
SELECT name, birthdate, DAYOFWEEK(birthdate) FROM people;
SELECT name, birthdate, DAYOFYEAR(birthdate) FROM people;
SELECT name, birthtime, DAYOFYEAR(birthtime) FROM people;
SELECT name, birthdt, DAYOFYEAR(birthdt) FROM people;
SELECT name, birthdt, MONTH(birthdt) FROM people;
SELECT name, birthdt, MONTHNAME(birthdt) FROM people;
SELECT name, birthtime, HOUR(birthtime) FROM people;
SELECT name, birthtime, MINUTE(birthtime) FROM people;
SELECT CONCAT(MONTHNAME(birthdate), ' ', DAY(birthdate), ' ', YEAR(birthdate)) FROM people;
SELECT DATE_FORMAT(birthdt, 'Was born on a %W') FROM people;
SELECT DATE_FORMAT(birthdt, '%m/%d/%Y') FROM people;
SELECT DATE_FORMAT(birthdt, '%m/%d/%Y at %h:%i') FROM people;

/* DATE_FORMAT
%a: Abbreviated weekday name(Sun..Sat)
%b: Abbreviated month name(Jan..Dec)
%c: Month, numeric(0..12)
%D: Day of the month with English suffix(0th, 1st, 2nd, 3rd..)
%d: Day of the month, numeric(00..31)
%e: Day of the month, numeric(0..31)
%f: Microseconds(000000..999999)
%H: Hour(00..23)
%h: Hour(01..12)
%I: Hour(01..12)
%i: Minutes, numeric(00..59)
%j: Day of year(001..366)
%k: Hour(0..23)
%l: Hour(1..12)
%M: Month name(January..December)
%m: Month, numeric(00..12)
%p: AM or PM
%r: Time, 12-hour(hh:mm:ss followed by AM or PM)
%S: Seconds(00..59)
%s: Seconds(00..59)
%T: Time, 24-hour(hh:mm:ss)
%U: Week(00..53), where Sunday is the first day of the week; WEEK() mode 0
%u: Week(00..53), where Monday is the first day of the week; WEEK() mode 1
%V: Week(00..53), where Sunday is the first day of the week; WEEK() mode 2, used with %X
%v: Week(00..53), where Monday is the first day of the week; WEEK() mode 3, used with %x
%W: Weekday name (Sunday..Saturday)
%w: Day of the week(0:Sunday.. 6:Saturday)
%X: Year for the week where Sunday is the first day of the week, numeric, four digits, used with %V
%x: Year for the week where Monday is the first day of the week, numeric, four digits, used with %v
%Y: Year, numeric, four digits
%y: Year, numeric, two digits
%%: A literal % character
*/


-- DATE MATH
SELECT * FROM people;
SELECT DATEDIFF(NOW(), birthdate) FROM people;
SELECT name, birthdate, DATEDIFF(NOW(), birthdate) FROM people;
SELECT birthdt FROM people;
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 1 MONTH) FROM people;
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 10 SECOND) FROM people;
SELECT birthdt, DATE_ADD(birthdt, INTERVAL 3 QUARTER) FROM people;
SELECT birthdt, birthdt + INTERVAL 1 MONTH FROM people;
SELECT birthdt, birthdt - INTERVAL 5 MONTH FROM people;
SELECT birthdt, birthdt + INTERVAL 15 MONTH + INTERVAL 10 HOUR FROM people;


-- TIMESTAMP
-- The Timestamp data type is used for values that contain both date and time parts. TIMESTAMP has a range of "1970-01-01 00:00:01" UTC to "2038-01-19 03:14:07" UTC.
-- Why TIMESTAMP instead of DATETIME: DATETIME(8bytes) takes more space than TIMESTAMP(4bytes)
CREATE TABLE comments (
    content VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW());
INSERT INTO comments (content) VALUES('lol what a funny article');
INSERT INTO comments (content) VALUES('I found this offensive');
INSERT INTO comments (content) VALUES('Ifasfsadfsadfsad');
SELECT * FROM comments ORDER BY created_at DESC;
CREATE TABLE comments2 (
    content VARCHAR(100),
    changed_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP);
INSERT INTO comments2 (content) VALUES('dasdasdasd');
INSERT INTO comments2 (content) VALUES('lololololo');
INSERT INTO comments2 (content) VALUES('I LIKE CATS AND DOGS');
UPDATE comments2 SET content='THIS IS NOT GIBBERISH' WHERE content='dasdasdasd';
SELECT * FROM comments2;
SELECT * FROM comments2 ORDER BY changed_at;
 CREATE TABLE comments2 (
    content VARCHAR(100),
    changed_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW());
