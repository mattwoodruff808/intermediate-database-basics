-- Practice JOINs

-- Problem 1
SELECT * 
FROM invoice i
JOIN invoice_line il ON il.invoice_id = i.invoice_id
WHERE il.unit_price > 0.99;

-- Problem 2
SELECT i.invoice_date, c.first_name, c.last_name, i.total 
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

-- Problem 3
SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;

-- Problem 4
SELECT al.title, ar.name
FROM album al
JOIN artist ar ON al.artist_id = ar.artist_id;

-- Problem 5
SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p ON pt.playlist_id = p.playlist_id
WHERE p.name = 'Music';

-- Problem 6
SELECT t.name
FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
WHERE pt.playlist_id = 5;

-- Problem 7
SELECT t.name, p.name
FROM track t
JOIN playlist_track pt ON t.track_id = pt.track_id
JOIN playlist p ON pt.playlist_id = p.playlist_id;

-- Problem 8
SELECT t.name, al.title
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
JOIN album al ON t.album_id = al.album_id
WHERE g.name = 'Alternative & Punk';

-- Black Diamond (Will come back to this if I have time)

---------------------------


-- Practice nested queries

-- Problem 1
SELECT *
FROM invoice
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > 0.99);

-- Problem 2
SELECT *
FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music');

-- Problem 3
SELECT name
FROM track
WHERE track_id IN (SELECT track_id FROM playlist_track WHERE playlist_id = 5);

-- Problem 4
SELECT *
FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE title = 'Fireball');

-- Problem 5
SELECT *
FROM track
WHERE album_id IN (SELECT album_id FROM album WHERE title = 'Fireball');

-- Problem 6
SELECT *
FROM track
WHERE album_id IN (
  SELECT album_id FROM album WHERE artist_id IN (
    SELECT artist_id FROM artist WHERE name = 'Queen'
  )
);

---------------------------


-- Practice updating Rows

-- Problem 1
UPDATE customer
SET fax = null
WHERE fax IS NOT null;

-- Problem 2
UPDATE customer
SET company = 'Self'
WHERE company IS null;

-- Problem 3
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

-- Problem 4
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

-- Problem 5
UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS null;

---------------------------


-- Group by

-- Problem 1
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY g.name;

-- Problem 2
SELECT COUNT(*), g.name
FROM track t
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

-- Problem 3
SELECT ar.name, COUNT(*)
FROM album al
JOIN artist ar ON ar.artist_id = al.artist_id
GROUP BY ar.name;

---------------------------


-- Use Distinct

-- Problem 1
SELECT DISTINCT composer
FROM track;

-- Problem 2
SELECT DISTINCT billing_postal_code
FROM invoice;

-- Problem 3
SELECT DISTINCT company
FROM customer;

---------------------------


-- Delete Rows

-- Problem 1
DELETE FROM practice_delete
WHERE type = 'bronze';

-- Problem 2
DELETE FROM practice_delete
WHERE type = 'silver';

-- Problem 3
DELETE FROM practice_delete
WHERE value = 150;

---------------------------


-- eCommerce Simulation

-- Tables
CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(150)
);

CREATE TABLE products (
	product_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  price INT
);

CREATE TABLE orders (
	order_id SERIAL PRIMARY KEY,
  product_id INT REFERENCES products(product_id)
);

-- Adding Data
INSERT INTO users
(name, email)
VALUES
('Kaladin', 'kal@roshar.com'),
('Shallan', 'sketchy@roshar.com'),
('Adolin', 'daddysfavorite@roshar.com');

INSERT INTO products
(name, price)
VALUES
('Shardblade', 100000000),
('Sketchbook', 30),
('Wine', 500);

INSERT INTO orders
(product_id)
VALUES
(1),
(2),
(3);

-- Get all products for first order
SELECT * 
FROM products p
JOIN orders o ON p.product_id = o.product_id
WHERE o.order_id = 1;

-- Get all orders
SELECT * FROM orders;

-- Total cost of an order
SELECT SUM(p.price)
FROM products p
JOIN orders o ON p.product_id = o.product_id
WHERE o.order_id = 2;

-- Add foreign key to users connecting orders
ALTER TABLE users
ADD COLUMN order_id INT REFERENCES orders(order_id);

-- Get all orders for a user
SELECT *
FROM orders o
JOIN users u ON o.order_id = u.order_id
WHERE u.order_id = 1;

-- Get how many orders user has
SELECT COUNT(u.order_id)
FROM orders o
JOIN users u ON o.order_id = u.order_id
WHERE u.name = 'Kaladin';