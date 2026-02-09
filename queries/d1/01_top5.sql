-- TOP 5 clients by amount of money paid
-- Counting draws so it will show more customers if they paid same amount of money
WITH customer_total AS(
	SELECT c.customer_id,c.first_name,c.last_name, SUM(p.amount) AS total_spent
	FROM customer c
	JOIN payment p ON p.customer_id = c.customer_id
	GROUP BY c.customer_id,c.first_name,c.last_name
)

SELECT first_name,last_name
FROM customer_total
WHERE total_spent >=(
	SELECT MIN(total_spent)
	FROM(
		SELECT total_spent
		FROM customer_total
		ORDER BY total_spent DESC
		LIMIT 5
		)top5
);


-- Not counting draws so only 5 customers
SELECT c.first_name,c.last_name
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name
ORDER BY SUM(p.amount) DESC
LIMIT 5;