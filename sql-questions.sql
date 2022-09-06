--1. List all customers who live in Texas (useJOINs)
SELECT first_name, last_name, district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
GROUP BY first_name, last_name, district
HAVING district = 'Texas'; 
--Answer = 5 customers live in Texas
--2. Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;
--Answer = 1406
--3. Show all customers names who have made payments over $175(usesubqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount)
);
--Answer 6 customers
--4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
Inner join country
ON city.country_id = country.country_id
GROUP BY first_name, last_name, country
HAVING country = 'Nepal';
--Answer = 1 customer in Nepal, Kevin Schuler
--5. Which staff member had the most transactions?
SELECT first_name, last_name, COUNT(payment_id)
FROM staff
INNER JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY first_name, last_name
ORDER BY COUNT DESC;
--Answer = Mike Hillyer = 7292, Jon Stephens = 7304

--6. How many movies of each rating are there?
SELECT COUNT(title), rating
FROM film
GROUP BY rating
ORDER BY rating;
--Answer = [G = 178], [PG = 194], [PG-13 = 223], [R = 195], [NC-17 = 210]
--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	WHERE amount > 6.99
	GROUP BY customer_id
	HAVING COUNT(customer_id) = 1
);
--Answer = 130 customers
--how many free rentals did our stores give away?
SELECT COUNT(amount)
FROM payment
WHERE amount = 0;
--Answer = 24