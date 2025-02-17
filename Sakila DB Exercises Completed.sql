use sakila;

/* 1) Display the first and last names of all actors from the table actor*/

SELECT first_name, last_name
FROM actor
;

/* 2) You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, “Joe.” 
What is one query would you use to obtain this information? */

SELECT actor_id, first_name,last_name
FROM actor
WHERE first_name = "Joe"
;

/* 3) Select specific columns from the films table that last 3 hours or longer. */    

SELECT title, length
FROM film
WHERE length >= 120
;
    
/* 4) Select all columns from the customer table for rows that have a last name beginning with "S" and a first name ending with "N". */

    SELECT *
    FROM customer
    WHERE last_name LIKE 'S%' AND first_name LIKE '%N'
    ;
    
/* 5) Select specific columns from the payments table for payments made on or after 05/27/2005. */

SELECT payment_date
FROM payment
WHERE payment_date >= 05/27/2005
;
    
/* 6) Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China: */

SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China')
;

/* 7) Find all actors whose last name contain the letters GEN */

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%'
;
    
/* 8) Find all actors whose last names contain the letters LI. This time, 
order the rows by last name and first name, in that order: */

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name
;
    
/* 9) Which actors have the first name ‘Scarlett’ */

SELECT first_name, last_name
FROM actor
WHERE first_name = 'Scarlett'
;

/* 10) Which actors have the last name ‘Johansson’ */

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE 'Johansson'
;

/* 11) Select the following columns from the film table for rows where the description ends with the word "Boat"
and rental duration greater than 6. Title, Description, Rental Duration */

SELECT title, description, rental_duration
FROM film
WHERE RIGHT(description,4) = 'Boat' AND rental_duration >= 6
;

/* 12) How many distinct actors last names are there? */

SELECT COUNT(DISTINCT(last_name))
FROM actor
;

/* 13) When is ‘Academy Dinosaur’ due? */

SELECT film.title, rental.rental_date, film.rental_duration, 
		DATE_ADD(rental.rental_date, INTERVAL film.rental_duration DAY) AS rental_due_date
        FROM rental 
		JOIN inventory ON rental.inventory_id=inventory.inventory_id 
			JOIN film ON inventory.film_id=film.film_id WHERE title='Academy Dinosaur' AND rental.return_date IS NULL;

/* 14) What is that average running time of all the films in the sakila DB? */

SELECT AVG(length)
FROM film
;


/* 15- Use `INNER JOIN` to display the first and last names, as well as the address, of each staff member. 
Use the tables `staff` and `address` */

  SELECT s.first_name, s.last_name, a.address
  FROM staff AS s
  INNER JOIN address AS a
  ON a.address_id = s.address_id
  ;
  
  
/* 16- Use `INNER JOIN` to display first name, last name and the amount for each staff member. 
Use tables `staff` and `payment*/

  SELECT s.first_name, s.last_name, p.amount
  FROM staff AS s
  INNER JOIN payment AS p
  ON s.staff_id = p.staff_id
  ;


/* 17- Use `INNER JOIN` to display first name, last name,  payment date and 
the amount for each staff member in  August of 2005. Use tables `staff` and `payment*/

  SELECT s.first_name, s.last_name, p.amount, p.payment_date
  FROM staff AS s
  INNER JOIN payment AS p
  ON s.staff_id = p.staff_id
  WHERE DATE_FORMAT(p.payment_date, '%M %Y') = 'August 2005'
  ORDER BY p.payment_date DESC
  ;

  
/* 18- Use `INNER JOIN` to display the total amount rung up by each staff member in August of 2005. 
Use tables `staff` and `payment`. */

SELECT SUM(p.amount)
  FROM staff AS s
  INNER JOIN payment AS p
  ON s.staff_id = p.staff_id
  WHERE DATE_FORMAT(p.payment_date, '%M %Y') = 'August 2005'
  ;


/* 19) List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. 
Use inner join, group by. */

SELECT DISTINCT(f.title), COUNT(fa.actor_id)
FROM film AS f
INNER JOIN film_actor AS fa
ON f.film_id = fa.film_id
GROUP BY f.title
;


/* 20) How many copies of the film `Hunchback Impossible` exist in the inventory system? 
Use tables `film` and `inventory`*/

SELECT COUNT(f.film_id)
FROM film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
WHERE f.title = 'Hunchback Impossible'
;




/* 21) Using the tables `payment` and `customer` and the `INNER JOIN` command, list payments by each customer. 
List the customers alphabetically by last name */

SELECT c.first_name, c.last_name, p.amount,p.payment_date
FROM payment AS p
INNER JOIN customer AS C
ON p.customer_id = c.customer_id
ORDER BY c.last_name
;


/* 22) Using the tables `payment` and `customer` and the `INNER JOIN` command, list the total paid by each customer. 
List the customers alphabetically by last name. */

SELECT SUM(p.amount)
FROM payment AS p
INNER JOIN customer AS C
ON p.customer_id = c.customer_id
ORDER BY c.last_name
;


/* 23) Which actor has appeared in the most films? */

SELECT a.first_name,a.last_name, COUNT(fa.film_id)
FROM film_actor AS fa
INNER JOIN actor AS a
ON fa.actor_id = a.actor_id
GROUP BY a.first_name, a.last_name
ORDER BY COUNT(fa.film_id) DESC 
LIMIT  1
;


/* 24) Find the most common actor surname from the Sakila database */

SELECT DISTINCT(last_name), COUNT(last_name)
FROM actor
GROUP BY last_name
ORDER BY COUNT(last_name) DESC
LIMIT 1
;


/* 25) List the last names of actors, as well as how many actors have that last name.*/


SELECT DISTINCT(last_name), COUNT(last_name)
FROM actor
GROUP BY last_name
ORDER BY COUNT(last_name) DESC
;

/* 26) Which last names are not repeated? (Please search for having clause for this exercises) */

SELECT DISTINCT(last_name), COUNT(last_name) AS name_count
FROM actor
GROUP BY last_name
HAVING name_count = 1
ORDER BY COUNT(last_name) DESC
;

/* 27) Which last names appear more than once? (Please search for having clause for this exercises) */


SELECT DISTINCT(last_name), COUNT(last_name) AS name_count
FROM actor
GROUP BY last_name
HAVING name_count > 1
ORDER BY COUNT(last_name) DESC
;

