CASE WHEN
SELECT c.first_name, SUM(p.amount) AS suma,
CASE 
	WHEN SUM(p.amount) > 200 THEN 'VIP' 
	WHEN SUM(p.amount) > 100 THEN 'Regular' 
	ELSE 'Low'
END AS segment
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name
ORDER BY suma DESC