USE sakila;

-- Inspecting the rental and film database for useful information:

SELECT * FROM rental;
SELECT * FROM film;

-- We want: 
-- film_id
-- language_id
-- rental_duration
-- rental_rate
-- length
-- replacement_cost
-- rating
-- recial_features
-- rental_date
-- inventory_id

SELECT film_id, language_id, rental_duration, rental_rate, length, replacement_cost,
rating
FROM film;


SELECT f.film_id AS film_id, i.store_id AS store_id, COUNT(r.inventory_id) AS copies,
SUM(		
			CASE
			WHEN YEAR(rental_date) = 2005 AND MONTH(rental_date) = 5 THEN 1
			ELSE 0
			END) AS rented
FROM film f
-- LEFT JOIN, because we want data for all films, even if we dont have them rented
LEFT JOIN inventory i
USING(film_id)
LEFT JOIN rental r
USING(inventory_id)
GROUP BY f.film_id;