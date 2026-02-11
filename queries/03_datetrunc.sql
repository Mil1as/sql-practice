SELECT DATE_TRUNC('month',r.rental_date) AS month,
COUNT(*) AS rentals_count
FROM rental r
GROUP BY month
ORDER BY month;