---------------------------------------------------------------------------------------------------------------------------------------------
-- SECTION : WALMART SALES ANALYSIS
-- Purpose  : Analyze payment method usage and transaction volume from Walmart sales data
-- Notes    : Aggregates transaction count and total quantity sold per payment method
---------------------------------------------------------------------------------------------------------------------------------------------
-- 1A. Preview raw sales data
-- Purpose : Quick inspection of the dataset to understand structure and values
SELECT
	*
FROM
	WALMART_SALES;

-- 1B. Payment method analysis
-- Purpose : Identify which payment methods are most frequently used and their contribution in terms of quantity sold
-- Logic   : Group by payment_method to calculate:
--           - Number of transactions (COUNT)
--           - Total quantity sold (SUM of quantity)
SELECT
	PAYMENT_METHOD,
	COUNT(*) AS NO_OF_TRANSACTIONS,
	SUM(QUANTITY) AS TOTAL_QUANTITY
FROM
	WALMART_SALES
GROUP BY
	PAYMENT_METHOD;

-- 1C. Highest rated category per branch
-- Purpose : Identify the best-performing product category in each branch based on customer ratings
-- Logic   : 
--          - Compute average rating per branch-category
--          - Rank categories within each branch using ROW_NUMBER()
--          - Select top-ranked category per branch
SELECT
	*
FROM
	(
		SELECT
			BRANCH,
			CATEGORY,
			AVG(RATING) AS HIGHEST_RATING,
			ROW_NUMBER() OVER (
				PARTITION BY
					BRANCH
				ORDER BY
					AVG(RATING) DESC
			) AS RANK
		FROM
			WALMART_SALES
		GROUP BY
			BRANCH,
			CATEGORY
		ORDER BY
			1,
			2
	)
WHERE
	RANK = 1
	-- 1D. Most popular category per branch (based on transaction count)
	-- Purpose : Identify which category is most frequently purchased in each branch
	-- Logic   : Rank categories per branch by number of transactions
SELECT
	*
FROM
	(
		SELECT
			BRANCH,
			TO_CHAR(DATE, 'Day') AS DAY,
			COUNT(*) AS NO_OF_TRANSACTIONS,
			ROW_NUMBER() OVER (
				PARTITION BY
					BRANCH
				ORDER BY
					COUNT(*) DESC
			) AS RANK
		FROM
			WALMART_SALES
		GROUP BY
			BRANCH,
			TO_CHAR(DATE, 'Day')
		ORDER BY
			1,
			3 DESC
	)
WHERE
	RANK = 1
	-- 1E. Total quantity sold per payment method
	-- Purpose : Measure product volume distribution across different payment methods
SELECT
	PAYMENT_METHOD,
	SUM(QUANTITY) AS TOTAL_QUANTITY_SOLD
FROM
	WALMART_SALES
GROUP BY
	PAYMENT_METHOD
	-- 1F. Rating distribution by city and category
	-- Purpose : Understand customer satisfaction spread across locations and product categories
	-- Logic   : Compute min, max, and average ratings per city-category combination
SELECT
	CITY,
	CATEGORY,
	MIN(RATING) AS MIN_RATING,
	MAX(RATING) AS MAX_RATING,
	AVG(RATING) AS AVG_RATING
FROM
	WALMART_SALES
GROUP BY
	1,
	2
	-- 1G. Revenue and profit contribution by category
	-- Purpose : Identify top revenue-generating categories and estimated profit contribution
	-- Logic   : 
	--          - Sum total revenue per category
	--          - Calculate profit using profit_margin
	--          - Rank categories by revenue
SELECT
	CATEGORY,
	SUM(TOTAL) AS REVENUE,
	SUM(TOTAL * PROFIT_MARGIN) AS PROFIT,
	ROW_NUMBER() OVER (
		ORDER BY
			SUM(TOTAL) DESC
	) AS RANK
FROM
	WALMART_SALES
GROUP BY
	1
	-- 1H. Most used payment method per branch
	-- Purpose : Identify dominant payment method in each branch
	-- Logic   : Rank payment methods per branch by transaction count
SELECT
	*
FROM
	(
		SELECT
			BRANCH,
			PAYMENT_METHOD,
			COUNT(*) AS PAYMENT_METHOD,
			ROW_NUMBER() OVER (
				PARTITION BY
					BRANCH
				ORDER BY
					COUNT(*) DESC
			) AS RANK
		FROM
			WALMART_SALES
		GROUP BY
			1,
			2
	)
WHERE
	RANK = 1
	-- 1I. Branch-wise transaction distribution by shift
	-- Purpose : Understand sales activity distribution across time of day (Morning, Afternoon, Evening)
	-- Logic   : Categorize time into shifts using CASE and group transactions per branch
SELECT
	BRANCH,
	COUNT(*) AS NO_OF_TRANSACTIONS,
	CASE
		WHEN EXTRACT(
			HOUR
			FROM
				TIME
		) < 12 THEN 'Morning'
		WHEN EXTRACT(
			HOUR
			FROM
				TIME
		) BETWEEN 12 AND 17  THEN 'Afternoon'
		ELSE 'Evening'
	END AS SHIFT
FROM
	WALMART_SALES
GROUP BY
	1,
	3
ORDER BY
	1,
	2
	-- 1J. Year-over-year revenue comparison (2023 vs 2022)
	-- Purpose : Identify revenue decline per branch between two years
	-- Logic   : 
	--          - Compute yearly revenue using CTEs
	--          - Join both years by branch
	--          - Calculate percentage decline
WITH
	REVENUE_2023 AS (
		SELECT
			BRANCH,
			SUM(TOTAL) AS REVENUE
		FROM
			WALMART_SALES
		WHERE
			EXTRACT(
				YEAR
				FROM
					DATE
			) = '2023'
		GROUP BY
			1
	),
	REVENUE_2022 AS (
		SELECT
			BRANCH,
			SUM(TOTAL) AS PREV_REVENUE
		FROM
			WALMART_SALES
		WHERE
			EXTRACT(
				YEAR
				FROM
					DATE
			) = '2022'
		GROUP BY
			1
	)
	-- 1K. Full dataset with derived shift column
	-- Purpose : Create enriched dataset with time-of-day classification for further BI analysis
	-- Logic   : Add shift column using CASE on transaction time
SELECT
	CR.BRANCH,
	PV.PREV_REVENUE AS PREVIOUS_YEAR_REVENUE,
	CR.REVENUE AS CURRENT_YEAR_REVENUE,
	ROUND(
		(
			(PREV_REVENUE - CR.REVENUE) * 100.0 / PREV_REVENUE
		)::NUMERIC,
		2
	) AS YOY_DECLINE
FROM
	REVENUE_2023 CR
	JOIN REVENUE_2022 PV ON CR.BRANCH = PV.BRANCH
WHERE
	PV.PREV_REVENUE > CR.REVENUE
SELECT
	INVOICE_ID,
	BRANCH,
	CITY,
	CATEGORY,
	UNIT_PRICE,
	QUANTITY,
	DATE,
	TIME,
	PAYMENT_METHOD,
	RATING,
	PROFIT_MARGIN,
	TOTAL,
	CASE
		WHEN EXTRACT(
			HOUR
			FROM
				TIME
		) < 12 THEN 'Morning'
		WHEN EXTRACT(
			HOUR
			FROM
				TIME
		) BETWEEN 12 AND 17  THEN 'Afternoon'
		ELSE 'Evening'
	END AS SHIFT
FROM
	WALMART_SALES;

SELECT
	*
FROM
	WALMART_SALES