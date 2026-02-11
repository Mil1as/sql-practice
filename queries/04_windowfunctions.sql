
SELECT * FROM(
SELECT c.customer_id,p.payment_date, p.amount,
ROW_NUMBER() OVER(
	PARTITION BY c.customer_id
	ORDER BY p.payment_date
	) AS rn
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id)sq
WHERE rn = 1;

WITH customer_total AS (
    SELECT 
        customer_id,
        SUM(amount) AS total_spent
    FROM payment
    GROUP BY customer_id
)
SELECT 
    customer_id,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS rank
FROM customer_total;

WITH customer_previous AS(
SELECT p.customer_id,p.payment_date,p.amount,
LAG(p.amount) 
	OVER(PARTITION BY p.customer_id ORDER BY p.payment_date, p.payment_id) AS prev_payment 
FROM payment p)

SELECT customer_id,payment_date,amount,prev_payment, amount-prev_payment AS difference FROM customer_previous
