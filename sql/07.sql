/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

SELECT actor.first_name || ' ' || actor.last_name AS "Actor Name"
FROM actor
WHERE actor.actor_id IN (
    SELECT actor.actor_id
    FROM actor
    JOIN film_actor USING (actor_id)
    JOIN film USING (film_id)
    WHERE title IN (
        SELECT title
        FROM film
        JOIN film_actor ON film.film_id = film_actor.film_id
        JOIN actor ON film_actor.actor_id = actor.actor_id
        WHERE actor.actor_id IN (
            SELECT actor.actor_id
            FROM actor
            JOIN film_actor USING (actor_id)
            JOIN film USING (film_id)
            WHERE title IN (
                SELECT title
                FROM film
                JOIN film_actor ON film.film_id = film_actor.film_id
                JOIN actor ON film_actor.actor_id = actor.actor_id
                WHERE actor.first_name = 'RUSSELL' AND actor.last_name = 'BACALL'
            )
            EXCEPT
            SELECT actor.actor_id
            FROM actor
            WHERE actor.first_name = 'RUSSELL' AND actor.last_name = 'BACALL'
        )
    )
    EXCEPT (
        SELECT actor.actor_id
        FROM actor
        JOIN film_actor USING (actor_id)
        JOIN film USING (film_id)
        WHERE title IN (
            SELECT title
            FROM film
            JOIN film_actor ON film.film_id = film_actor.film_id
            JOIN actor ON film_actor.actor_id = actor.actor_id
            WHERE actor.first_name = 'RUSSELL' AND actor.last_name = 'BACALL'
        )
        EXCEPT
        SELECT actor.actor_id
        FROM actor
        WHERE actor.first_name = 'RUSSELL' AND actor.last_name = 'BACALL'
    )
    EXCEPT
    SELECT actor.actor_id
    FROM actor
    WHERE actor.first_name = 'RUSSELL' AND actor.last_name = 'BACALL'
)
ORDER BY "Actor Name";

