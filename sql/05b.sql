/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */ 

SELECT f1.title FROM film f
JOIN film_actor fal ON (f.film_id = fal.film_id)
JOIN actor a ON (fal.actor_id = a.actor_id)
JOIN film_actor fa1 ON (a.actor_id = fa1.actor_id)
JOIN film f1 ON (f1.film_id = fa1.film_id)
WHERE f.title = 'AMERICAN CIRCUS'
GROUP BY f1.title
HAVING COUNT(DISTINCT a.actor_id) >= 2
ORDER BY f1.title;
