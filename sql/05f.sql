/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

SELECT categorized_films.title
FROM category target_category
INNER JOIN film_category target_film_category ON target_category.category_id = target_film_category.category_id
INNER JOIN film categorized_films ON target_film_category.film_id = categorized_films.film_id
WHERE target_category.name IN (
    SELECT distinct_category.name
    FROM category distinct_category
    INNER JOIN film_category distinct_film_category ON distinct_category.category_id = distinct_film_category.category_id
    INNER JOIN film distinct_films ON distinct_film_category.film_id = distinct_films.film_id
    WHERE distinct_films.title = 'AMERICAN CIRCUS'
)
GROUP BY categorized_films.title
HAVING COUNT(categorized_films.title) >= 2

INTERSECT

SELECT actor_shared_films.title
FROM film base_film
JOIN film_actor base_film_actor ON base_film.film_id = base_film_actor.film_id
JOIN actor film_actor ON base_film_actor.actor_id = film_actor.actor_id
JOIN film_actor shared_film_actor ON film_actor.actor_id = shared_film_actor.actor_id
JOIN film actor_shared_films ON shared_film_actor.film_id = actor_shared_films.film_id
WHERE base_film.title = 'AMERICAN CIRCUS'
GROUP BY actor_shared_films.title
HAVING COUNT(actor_shared_films.title) >= 1
ORDER BY title;

