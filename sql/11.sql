/* For each customer, find the movie that they have rented most recently.
 *
 * NOTE:
 * This problem can be solved with either a subquery (using techniques we've covered in class),
 * or a new type of join called a LATERAL JOIN.
 * You are not required to use LATERAL JOINs,
 * and we will not cover in class how to use them.
 * Nevertheless, they can greatly simplify your code,
 * and so I recommend that you learn to use them.
 * The website <https://linuxhint.com/postgres-lateral-join/> provides a LATERAL JOIN that solves this problem.
 * All of the subsequent problems in this homework can be solved with LATERAL JOINs
 * (or slightly less conveniently with subqueries).
 */


SELECT first_name, last_name, title, rental_date FROM (
SELECT c.customer_id, c.first_name, c.last_name, r.rental_date, f.title FROM customer c
LEFT JOIN lateral (
    SELECT rental_id, rental_date, inventory_id
    FROM rental
    WHERE customer_id = c.customer_id
    ORDER BY rental_date DESC
    limit 1
) r ON TRUE
JOIN inventory USING (inventory_id)
JOIN film f USING (film_id)
) AS t
ORDER BY last_name;
