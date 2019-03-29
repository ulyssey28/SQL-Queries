USE sakila;

-- 1a
SELECT first_name, last_name
FROM actor;

-- 1b
SELECT CONCAT(first_name, ' ', last_name) as 'Actor Name'
FROM actor;

-- 2a
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- 2b
SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

-- 2c
SELECT *
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- 2d
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan' , 'Bangladesh' , 'China');

-- 3a
ALTER TABLE actor
ADD COLUMN description BLOB; 


-- 3b
ALTER TABLE actor
DROP description;

-- 4a
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;

-- 4b
SELECT last_name, COUNT(last_name) 
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- 4c 
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- 4d (Safe update error... so i commented the code)
/* UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO'; */

-- 5a
SHOW CREATE TABLE address;

-- 6a
SELECT first_name, last_name, address
FROM address JOIN staff ON address.address_id = staff.address_id;

-- 6b 
SELECT first_name, last_name, SUM(amount)
FROM staff JOIN payment on staff.staff_id = payment.staff_id
WHERE payment_date LIKE '2005-__-08%'
GROUP BY first_name, last_name;

-- 6c
SELECT title, COUNT(actor_id)
FROM film_actor JOIN film ON film_actor.film_id = film.film_id
GROUP BY title;

-- 6d
SELECT title, COUNT(inventory_id)
FROM inventory JOIN film ON inventory.film_id = film.film_id
GROUP BY title
HAVING title = 'Hunchback Impossible';

-- 6e 
SELECT first_name, last_name, SUM(amount) as "Total Amount Paid"
FROM payment JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY first_name, last_name
ORDER BY last_name;

-- 7a
SELECT title
FROM film 
WHERE (title LIKE 'K%' OR title LIKE 'Q%')
AND language_id IN (
SELECT language_id
FROM language
WHERE name = 'English'
);

-- 7b
SELECT actor_id, first_name, last_name
FROM actor
WHERE actor_id IN ( 

    SELECT actor_id
    FROM film_actor 
    WHERE film_id IN (
    
        SELECT film_id
        FROM film
		WHERE title = 'Alone Trip'
        
         )
);

-- 7c
SELECT first_name, last_name, email
FROM customer 
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country = 'Canada';






-- 7d 
SELECT film_id, title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_category
    WHERE category_id IN (
         SELECT category_id
         FROM category
         WHERE name = 'Family'
		)
);






-- 7e
SELECT title, COUNT(rental_id)
FROM inventory 
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
GROUP BY title
ORDER BY COUNT(rental_id) DESC;

-- 7f
SELECT store.store_id, SUM(amount)
FROM store
JOIN customer ON store.store_id = customer.store_id
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY store.store_id;

-- 7g
SELECT store.store_id, city, country, address.address_id
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 7h
SELECT category.name, SUM(amount)
FROM film_category
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY SUM(amount) DESC
LIMIT 5;


-- 8a 
CREATE VIEW top_five_genres AS 
SELECT category.name, SUM(amount)
FROM film_category
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY SUM(amount) DESC
LIMIT 5;


-- 8b
SELECT *
FROM top_five_genres;

-- 8c
DROP VIEW top_five_genres;

