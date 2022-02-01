SELECT price, order_id FROM olist.order_items
ORDER BY price 
LIMIT 1; 

SELECT price, order_id FROM olist.order_items
ORDER BY price DESC
LIMIT 1; 

-- 2. From the order_items table, what is range of the shipping_limit_date of the orders?
SELECT shipping_limit_date FROM olist.order_items 
ORDER BY shipping_limit_date 
LIMIT 1;

SELECT shipping_limit_date FROM olist.order_items 
ORDER BY shipping_limit_date DESC
LIMIT 1;

-- 3. From the customers table, find the states with the greatest number of customers.
select customer_state, count(customer_unique_id) FROM olist.customers 
GROUP BY customer_state 
ORDER BY count(customer_unique_id) DESC 
LIMIT 5;

-- 4. From the customers table, within the state with the greatest number of customers, find the cities with the greatest number of customers.
SELECT customer_city, count(customer_id) FROM olist.customers 
WHERE customer_state = 'SP' 
GROUP BY customer_city 
ORDER BY count(customer_id) DESC 
LIMIT 5;

-- 5. From the closed_deals table, how many distinct business segments are there (not including null)?
SELECT DISTINCT business_segment FROM olist.closed_deals
WHERE business_segment IS NOT NULL;

-- 6. From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).
SELECT business_segment, sum(declared_monthly_revenue) FROM olist.closed_deals
GROUP BY business_segment
ORDER BY sum(declared_monthly_revenue) DESC
LIMIT 3;

-- 7. From the order_reviews table, find the total number of distinct review score values.
SELECT review_id, sum(review_score) as total_score FROM olist.order_reviews
GROUP BY review_id
ORDER BY total_score DESC;

-- 8. In the order_reviews table, create a new column 
-- with a description that corresponds to each number category for each review score from 1 - 5
-- then find the review score and category occurring most frequently in the table.
SELECT * FROM olist.order_reviews;

-- don't forget the COMMA after the last column selected (at the end of SELECT line)
SELECT review_score, count(review_score) as freq,
CASE 
	WHEN review_score = '1' THEN 'very bad'
    WHEN review_score = '2' THEN 'bad'
    WHEN review_score = '3' THEN 'middle'
    WHEN review_score = '4' THEN 'good'
    ELSE 'very good'
END AS category
FROM olist.order_reviews
GROUP BY review_score
ORDER BY freq DESC;

-- 9. From the order_reviews table, find the review value occurring most frequently 
-- and how many times it occurs.
SELECT review_score, count(review_score) as freq FROM olist.order_reviews
GROUP BY review_score
ORDER BY freq DESC
LIMIT 1;