/*
JOIN Examole:
SELECT *
FROM racers
JOIN bikes ON racers.racerId = bikes.bikeId;



 1 */  
SELECT *
FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

/* 2 */ 

SELECT i.invoice_date, c.first_name, c.last_name, i.total
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

/* 3 */ 
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;


/* 4 */

SELECT al.title, ar.name
FROM album al
JOIN artist ar ON al.artist_id = ar.artist_id;

/* 5 */ 

SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

/* 6 */ 

SELECT t.name
FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5;

/* 7 */ 

SELECT t.name, p.name 
FROM track t
JOIN playlist_track pt ON pt.track_id = t.track_id
JOIN playlist p ON p.playlist_id = pt.playlist_id;

/* 8 */ 

SELECT t.name, a.title
FROM track t
JOIN album a ON a.album_id = t.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';




/* Practice nested queries ************************************* */ 

/* 1*/ 

SELECT * FROM invoice 
WHERE invoice_id IN
(SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99);

/* 2 */ 
SELECT * 
FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music');


/* 3 */ 

SELECT name 
FROM track
WHERE track_id IN (SELECT track_id  FROM playlist_track  WHERE playlist_id = 5);

/* 4 */ 

SELECT * 
FROM track
WHERE genre_id IN(SELECT genre_id FROM genre WHERE name = 'Comedy');

/* 5 */ 

SELECT * 
FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE title = 'Fireball');

/* 6 */ 
SELECT * 
FROM track
WHERE album_id IN (
  SELECT album_id FROM album WHERE artist_id IN( 
    SELECT artist_id FROM artist WHERE name = 'Queen'));

/* Practice updating rows  */ 

/* 1*/ 

UPDATE customer
SET fax = NULL
WHERE fax IS NOT NULL;

/* 2 */ 

UPDATE customer
SET company = 'Self' 
WHERE company IS NULL;

/* 3 */ 
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

/* 4 */ 
UPDATE customer 
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

/* 5 */ 

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS null;



/* Practice Group By  */ 

/* 1*/ 

SELECT count(*), g.name 
FROM track t
JOIN genre g ON t.genre_id = g.genre_id 
GROUP BY g.name;

/* 2 */ 
SELECT count(*), g.name 
FROM track t
JOIN genre g  ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

/* 3 */ 

SELECT count(*), a.name FROM artist a
JOIN album al ON al.artist_id = a.artist_id
GROUP BY a.name;

/* Use Distinct********************************************/ 

/* 1*/ 
SELECT DISTINCT composer FROM track;

/* 2 */
SELECT DISTINCT billing_postal_code FROM invoice;

/* 3 */ 

SELECT DISTINCT company FROM customer;


/**Deleting tables*******************/

/* 2 */
DELETE FROM practice_delete WHERE type = 'bronze';

/* 3 */

DELETE FROM practice_delete WHERE type = 'silver';

/* 4 */

DELETE FROM practice_delete WHERE value = 150;





/*eCommerce Simulation **********************************************/

CREATE TABLE users (
user_id SERIAL PRIMARY KEY,
user_name varchar(40),
user_email varchar(40));


INSERT INTO users (user_name, user_email)
VALUES('Kiersty Sholly', 'k@jet.com'),
('Faith Barney', 'f@jet.com'),
('Alex Rivas', 'a@jet.com'),
('Kalvin Willison', 'ka@jet.com'),
('Hema Willison', 'h@jet.com');

SELECT * FROM users;


CREATE TABLE products (
product_id SERIAL PRIMARY KEY,
product_name varchar(60),
product_price INT);

INSERT INTO products (product_name, product_price)
VALUES ('shark vacuum', 250),
('coffee pot', 20),
('pillows', 12.59),
('minky blanket', 200.13),
('arm sling', 16.76),
('dog treats', 9.82);

SELECT * FROM products;

ALTER TABLE products
ALTER COLUMN product_price
SET DATA TYPE DECIMAL;

INSERT INTO products (product_name, product_price)
VALUES ('salt n vinegar chips', 2.54);


SELECT * FROM products;



CREATE TABLE orders (
order_id SERIAL PRIMARY KEY,
product_id INT REFERENCES products(product_id),
order_total DECIMAL,
customer_id INT REFERENCES customer(customer_id));

INSERT INTO orders (order_total)
VALUES (13.45),
(27.50),
(2.59),
(240.13),
(216.76),
(9.82);
  
 SELECT * FROM orders;



SELECT * FROM products WHERE product_id IN (SELECT product_id FROM orders WHERE order_id = 1);



