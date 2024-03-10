/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */

SELECT f1.title FROM film f
JOIN film_actor fal ON (f.film_id = fal.film_id)
JOIN actor a ON (fal.actor_id = a.actor_id)
JOIN film_actor fa1 ON (a.actor_id = fa1.actor_id)
JOIN film f1 ON (f1.film_id = fa1.film_id)
WHERE f.title IN ('AMERICAN CIRCUS', 'ACADEMY DINOSAUR', 'AGENT TRUMAN')
GROUP BY f1.title
HAVING COUNT(f1.title) >= 3
ORDER BY f1.title
