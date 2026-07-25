-- city generates the highest monthly revenue?
select city, round (sum(total_monthly_revenue),2)as total_revenue
from swiggy_zomato_featured
group by city
order by total_revenue desc;
 

-- city generating  highest monthly revenue!
SELECT
    city,
    ROUND(SUM(total_monthly_revenue), 2) AS total_revenue
FROM swiggy_zomato_featured
GROUP BY city
ORDER BY total_revenue DESC;
-- city generating  highest monthly profit
SELECT
    city,
    ROUND(SUM(total_monthly_profit), 2) AS total_profit
FROM swiggy_zomato_featured
GROUP BY city
ORDER BY total_profit DESC;

-- city generating  highest no. of monthly orders
SELECT
    city,
    SUM(total_monthly_orders) AS total_orders
FROM swiggy_zomato_featured
GROUP BY city
ORDER BY total_orders DESC;
-- restaurant types generating the highest revenue
SELECT
    restaurant_type,
    ROUND(SUM(total_monthly_revenue),2) AS revenue
FROM swiggy_zomato_featured
GROUP BY restaurant_type
ORDER BY revenue DESC;

-- Cities generating more than ₹100 Crore in monthly revenue

SELECT
    city,
    ROUND(SUM(total_monthly_revenue),2) AS total_revenue
FROM swiggy_zomato_featured
GROUP BY city
HAVING SUM(total_monthly_revenue) > 1000000000
ORDER BY total_revenue DESC;


-- restaurants based on average rating
SELECT
    restaurant_name,
    average_rating_both_platforms,
    CASE
        WHEN average_rating_both_platforms >= 4.5 THEN 'Excellent'
        WHEN average_rating_both_platforms >= 4.0 THEN 'Good'
        WHEN average_rating_both_platforms >= 3.5 THEN 'Average'
        ELSE 'Needs Improvement'
    END AS rating_category
FROM swiggy_zomato_featured;



-- Rank Restaurants by Revenue Within Each City
SELECT
    city,
    restaurant_name,
    total_monthly_revenue,
    RANK() OVER(
        PARTITION BY city
        ORDER BY total_monthly_revenue DESC
    ) AS revenue_rank
FROM swiggy_zomato_featured;



-- Top 3 Restaurants in Every City
WITH ranked_restaurants AS
(
    SELECT
        city,
        restaurant_name,
        total_monthly_revenue,
        DENSE_RANK() OVER(
            PARTITION BY city
            ORDER BY total_monthly_revenue DESC
        ) AS rnk
    FROM swiggy_zomato_featured
)

SELECT *
FROM ranked_restaurants
WHERE rnk <= 3
ORDER BY city, rnk;



-- Categorize Restaurants Based on Profit
SELECT
    restaurant_name,
    total_monthly_profit,
    CASE
        WHEN total_monthly_profit >= 500000 THEN 'High Profit'
        WHEN total_monthly_profit >= 250000 THEN 'Medium Profit'
        ELSE 'Low Profit'
    END AS profit_category
FROM swiggy_zomato_featured
ORDER BY total_monthly_profit DESC;