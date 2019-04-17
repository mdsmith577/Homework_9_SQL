USE sakila;

-- HOMEWORK 9, SQL --

-- 1A 
SELECT first_name as "First Name", last_name as "Last Name" FROM actor;

-- 1B
SELECT CONCAT(UPPER(first_name), " ", UPPER(last_name)) as "Actor Name" FROM actor;

-- 2A
SELECT actor_ID as "ID", first_name as "First Name", last_name as "Last Name"
FROM actor WHERE first_name = "Joe";

-- 2B
SELECT actor_ID as "ID", first_name as "First Name", last_name as "Last Name"
FROM actor WHERE last_name LIKE "%GEN%";

-- 2C
SELECT actor_ID as "ID", first_name as "First Name", last_name as "Last Name"
FROM actor WHERE last_name LIKE "%LI%" ORDER BY last_name, first_name;

-- 2D
SELECT country_id, country FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- 3A
ALTER TABLE actor
ADD COLUMN description BLOB;

SELECT * FROM actor;

-- 3B
ALTER TABLE actor
DROP COLUMN description;

SELECT * FROM actor;

-- 4A
SELECT last_name, COUNT(*) FROM actor
GROUP BY last_name;

-- 4B
SELECT last_name, COUNT(*) FROM actor
GROUP BY last_name HAVING COUNT(*) > 1;

-- 4C
UPDATE actor SET first_name="HARPO"
WHERE last_name="WILLIAMS" AND first_name="GROUCHO";

-- 4D
UPDATE actor SET first_name="GROUCHO"
WHERE EXISTS (
	SELECT *
	WHERE last_name="WILLIAMS" AND first_name="HARPO"
    );

-- 5A
USE sakila;
CREATE TABLE address(
	address_id INTEGER(10) AUTO_INCREMENT NOT NULL,
    address VARCHAR(50),
    address2 VARCHAR(50),
    district VARCHAR(20),
    city_id INTEGER(10),
    postal_code VARCHAR(10),
    phone VARCHAR(20),
    location GEOMETRY,
    last_update TIMESTAMP,
    PRIMARY KEY(address_id)
);

-- 6A
SELECT first_name AS "First Name", last_name AS "Last Name", address AS "Address"
FROM staff
LEFT JOIN address ON staff.address_id = address.address_id;

-- 6B
SELECT first_name AS "First Name", last_name AS "Last Name", SUM(amount) AS "Total Amount"
FROM staff
LEFT JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY first_name;

-- 6C
SELECT title AS "Title", COUNT(actor_id) AS "Actor Count"
FROM film
LEFT JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY title;

-- 6D
SELECT title, COUNT(inventory.film_id) AS "Copies in Inventory"
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
GROUP BY title
HAVING title="Hunchback Impossible";

-- 6E
SELECT first_name AS "First Name", last_name AS "Last Name", SUM(amount) AS "Total Amount Paid"
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY first_name
ORDER BY last_name;

-- 7A
SELECT title as "Title"
FROM film
WHERE language_id IN
(
	SELECT language_id
	FROM language
    WHERE name LIKE "E%"
)
HAVING title LIKE "K%" OR title LIKE "Q%";

-- 7B
SELECT first_name AS "First Name", last_name AS "Last Name"
FROM actor
WHERE actor_id IN
	(
	SELECT actor_id
    FROM film_actor
    WHERE film_id IN
		(
		SELECT film_id
        FROM film
        WHERE title = "Alone Trip"
        )
	);

-- 7C

-- USING JOIN:
SELECT customer.first_name AS "First Name", customer.last_name AS "Last Name", customer.email AS "E-mail"
FROM customer
INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id
WHERE country.country = "Canada";

-- WITHOUT JOINS:
SELECT first_name AS "First Name", last_name AS "Last Name", email AS "E-mail"
FROM customer
WHERE address_id IN
	(
	SELECT address_id
    FROM address
    WHERE city_id IN
		(
		SELECT city_id
		FROM city
		WHERE country_id IN
			(
			SELECT country_id
			FROM country
			WHERE country = "Canada"
            )
		)
	);

-- 7D
SELECT film.title AS "Title"
FROM film
INNER JOIN film_category ON film.film_id = film_category.film_id
INNER JOIN category ON film_category.category_id = category.category_id
WHERE category.name = "Family";

-- 7E
SELECT film.title AS "Title", COUNT(*) AS "Times Rented"
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY film.title
ORDER BY COUNT(*) DESC
;

-- 7F


-- 7G


-- 7H


-- 8A


-- 8B


-- 8C


