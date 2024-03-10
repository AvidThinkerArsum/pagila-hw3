/*
 * Find every documentary film that is rated G.
 * Report the title and the actors.
 *
 * HINT:
 * Getting the formatting right on this query can be tricky.
 * You are welcome to try to manually get the correct formatting.
 * But there is also a view in the database that contains the correct formatting,
 * and you can SELECT from that VIEW instead of constructing the entire query manually.
 */ 


SELECT title, STRING_AGG(
        UPPER(SUBSTRING(first_name FROM 1 FOR 1)) || LOWER(SUBSTRING(first_name FROM 2)) ||

        UPPER(SUBSTRING(last_name FROM 1 FOR 1)) || LOWER(SUBSTRING(last_name FROM 2)), ', '
    ) AS actors
FROM (
SELECT a.actor_id, a.first_name, a.last_name, r.title, r.film_id, r.rating FROM actor a
JOIN lateral (
    SELECT film_id, title, rating FROM film_actor
    JOIN film USING (film_id)
    JOIN film_category USING (film_id)
    JOIN category USING (category_id)
    WHERE actor_id = a.actor_id
    AND rating = 'G' AND name = 'Documentary'

) r ON TRUE
) AS t
GROUP BY title
ORDER BY title;
