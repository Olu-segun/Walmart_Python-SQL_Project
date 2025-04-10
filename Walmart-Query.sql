-- Business Problems
-- Q.1 Find different payment method and number of transactions, number of qty sold

SELECT DISTINCT payment_method , 
				COUNT(*) AS total_transaction_count, 
				SUM(quantity) AS qty_sold
FROM walmart
GROUP BY payment_method
ORDER BY  total_transaction_count DESC;

-- Q.2 Identify the highest-rated category in each branch, displaying the branch, category
-- AVG RATING

SELECT 	branch, 
		category, 
		AVG(rating) AS avg_rating,
		RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC ) as  rank
FROM walmart
GROUP BY branch, category;

-- Q.3 Identify the busiest day for each branch based on the number of transactions
SELECT * 
FROM
	(SELECT branch,
			TO_CHAR(TO_DATE(date, 'DD/MM/YY'), 'DAY') AS day_name,
			COUNT(invoice_id) AS no_transaction,
			RANK() OVER(PARTITION BY branch ORDER BY COUNT(invoice_id) DESC ) AS rank
	FROM walmart
	GROUP BY 1,2
	)
WHERE rank = 1;

--Q.4 Calculate the total quantity of items sold per payment method. List payment_method and total_quantity.
SELECT 	payment_method, 
		SUM(quantity) AS total_quantity
FROM walmart
GROUP BY payment_method;

-- Q.5 Determine the average, minimum, and maximum rating of category for each city. 
-- List the city, average_rating, min_rating, and max_rating.
SELECT 	city,
		category,
		ROUND(AVG(rating)::numeric, 2) AS avg_rating, 
		MAX(rating) AS maximum_rating,
		MIN(rating) AS minimum_rating
FROM walmart
GROUP BY city, category
ORDER BY avg_rating DESC;

--Q.6 Determine the most common payment method for each Branch. 
-- Display Branch and the preferred_payment_method.

-- USING Subquery.
SELECT *
FROM
		(SELECT branch, 
				payment_method, 
				COUNT(invoice_id) AS payment_mthod_count,
				RANK() OVER(PARTITION BY branch ORDER BY COUNT(invoice_id) DESC) AS rank
				FROM walmart
				GROUP BY 1, 2
			)
WHERE rank = 1;

-- USING CTE

WITH cte AS
			(SELECT branch, 
					payment_method, 
					COUNT(invoice_id) AS payment_mthod_count,
					RANK() OVER(PARTITION BY branch ORDER BY COUNT(invoice_id) DESC) AS rank
					FROM walmart
					GROUP BY 1, 2
			)

SELECT * 
FROM cte
WHERE rank = 1;

-- Q.7 Calculate the total profit for each category by considering total_profit as
-- (unit_price * quantity * profit_margin). 
-- List category and total_profit, ordered from highest to lowest profit.

SELECT 
	category,
	ROUND(SUM(total_amount)::numeric, 3) as total_revenue,
	ROUND (SUM(total_amount* profit_margin) ::numeric,3) as profit
FROM walmart
GROUP BY 1
ORDER BY profit DESC;

--Q.8 Categorize sales into 3 group MORNING, AFTERNOON, EVENING 
-- Find out each of the shift and number of invoices
SELECT 	branch,
		CASE
			WHEN EXTRACT(HOUR FROM(time::time)) < 12 THEN 'Morning'
			WHEN EXTRACT (HOUR FROM(time::time)) BETWEEN 12 AND 17 THEN 'Afternoon'
			ELSE 'Evening'
			END AS day_time,
			COUNT(*),
			ROW_NUMBER ()OVER(PARTITION BY branch ORDER BY COUNT(*) DESC )
FROM walmart
GROUP BY 1, 2
ORDER BY 1,3 DESC;


-- Q. 9 Identify 5 branch with highest decrese ratio in 
-- revevenue compare to last year(current year 2023 and last year 2022)

SELECT *,
		EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) as formated_date
FROM walmart;

WITH revenue_2022
AS 
	(	SELECT 	branch, 
				SUM(total_amount) AS revenue
		FROM walmart
		WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2022
		GROUP BY 1
	),
	
revenue_2023
AS
	(	SELECT 	branch, 
				SUM(total_amount) AS revenue
		FROM walmart
		WHERE EXTRACT(YEAR FROM TO_DATE(date, 'DD/MM/YY')) = 2023
		GROUP BY 1
	)
			
SELECT 
	ls.branch,
	ls.revenue as last_year_revenue,
	cs.revenue as cr_year_revenue,
	ROUND(
		(ls.revenue - cs.revenue)::numeric/
		ls.revenue::numeric * 100, 
		2) as rev_dec_ratio
FROM revenue_2022 as ls
JOIN
revenue_2023 as cs
ON ls.branch = cs.branch
WHERE 
	ls.revenue > cs.revenue
ORDER BY 4 DESC
LIMIT 10;
