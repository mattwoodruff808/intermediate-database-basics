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


-- Problem 2

-- Problem 3

-- Problem 4

-- Problem 5

-- Problem 6