/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */ 

SELECT rented.name, rented.title, rented.COUNT as "total rentals" FROM category categ
JOIN lateral (
    SELECT COUNT(rental_id) as COUNT, title, name FROM rental
    JOIN inventory USING (inventory_id)
    JOIN film USING (film_id)
    JOIN film_category USING (film_id)
    JOIN category cg USING (category_id)
    WHERE category_id = categ.category_id
    GROUP BY title, name
    ORDER BY COUNT(rental_id) DESC, title DESC
    limit 5
) rented ON TRUE
ORDER BY name, COUNT DESC, title;
