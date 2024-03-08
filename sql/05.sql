/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

SELECT f1.title FROM film f
JOIN film_actor fa ON (f.film_id = fa.film_id)
JOIN actor ON (fa.actor_id = actor.actor_id)
JOIN film_actor fa1 ON (actor.actor_id = fa1.actor_id)
JOIN film f1 ON (f1.film_id = fa1.film_id)
WHERE f.title = 'AMERICAN CIRCUS'
ORDER BY f1.title;
