/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */  

SELECT title_list.title
FROM film initial_film
INNER JOIN film_actor initial_actor_film ON initial_film.film_id = initial_actor_film.film_id
INNER JOIN actor film_actor ON initial_actor_film.actor_id = film_actor.actor_id
INNER JOIN film_actor secondary_actor_film ON film_actor.actor_id = secondary_actor_film.actor_id
INNER JOIN film title_list ON secondary_actor_film.film_id = title_list.film_id
WHERE initial_film.title = 'AMERICAN CIRCUS'
GROUP BY title_list.title
HAVING COUNT(title_list.title) > 0

INTERSECT

SELECT title_list.title
FROM film initial_film
JOIN film_actor initial_actor_film ON initial_film.film_id = initial_actor_film.film_id
JOIN actor film_actor ON initial_actor_film.actor_id = film_actor.actor_id
JOIN film_actor secondary_actor_film ON film_actor.actor_id = secondary_actor_film.actor_id
JOIN film title_list ON secondary_actor_film.film_id = title_list.film_id
WHERE initial_film.title = 'ACADEMY DINOSAUR'
GROUP BY title_list.title
HAVING COUNT(title_list.title) > 0

INTERSECT

SELECT title_list.title
FROM film initial_film
JOIN film_actor initial_actor_film ON initial_film.film_id = initial_actor_film.film_id
JOIN actor film_actor ON initial_actor_film.actor_id = film_actor.actor_id
JOIN film_actor secondary_actor_film ON film_actor.actor_id = secondary_actor_film.actor_id
JOIN film title_list ON secondary_actor_film.film_id = title_list.film_id
WHERE initial_film.title = 'AGENT TRUMAN'
GROUP BY title_list.title
HAVING COUNT(title_list.title) > 0
ORDER BY title;

