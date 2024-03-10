/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */

SELECT a.actor_id, a.first_name, a.last_name, revenue.film_id, revenue.title, revenue.RANK, revenue.revenue
FROM actor a
JOIN lateral (
    SELECT film_id, title, SUM(amount) as revenue, RANK () OVER (
    ORDER BY COALESCE(SUM(amount), 0.00) DESC, title ASC) RANK FROM film_actor
    JOIN film USING (film_id)
    JOIN inventory USING (film_id)
    JOIN rental USING (inventory_id)
    JOIN payment USING (rental_id)
    WHERE actor_id = a.actor_id
    GROUP BY film_id, title
    limit 3

) revenue ON TRUE;
