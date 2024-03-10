/*
 * Management wants to rank customers by how much money they have spent in order to send coupons to the top 10%.
 *
 * Write a query that computes the total amount that each customer has spent.
 * Include a "percentile" column that contains the customer's percentile spending,
 * and include only customers in at least the 90th percentile.
 * Order the results alphabetically.
 *
 * HINT:
 * I used the `ntile` window function to compute the percentile.
 */

SELECT customer_id, name, total_payment, percentile
FROM (SELECT customer_id, first_name || ' ' || last_name "name", SUM(amount) total_payment, ntile(100) OVER (ORDER BY SUM(amount)) percentile
FROM payment
JOIN customer c1 USING (customer_id)
GROUP BY customer_id, name) t
WHERE percentile >= 90
ORDER BY name;
