-- PMG Graduate Leadership Program Technical Assessment 
-- SQL Assessment
-- Name: Emily Wang '''

-- Please provide a SQL statement for each question

-- 1. Write a query to get the sum of impressions by day.

SELECT date, SUM(impressions) 
FROM marketing_data
GROUP BY date;

    
-- 2. Write a query to get the top three revenue-generating states in order of best to worst. 
-- How much revenue did the third best state generate? Answer: $37577

SELECT state, SUM(revenue) AS total_revenue
FROM website_revenue
GROUP BY state
ORDER BY total_revenue DESC
LIMIT 3;

-- 3. Write a query that shows total cost, impressions, clicks, and revenue of each campaign. Make sure to include the campaign name in the output.
SELECT md.campaign_id, ci.name AS campaign_name, 
       SUM(cost) AS total_cost, 
       SUM(impressions) AS total_impressions, 
       SUM(clicks) AS total_clicks, 
       SUM(wr.revenue) AS total_revenue
FROM marketing_data md
JOIN campaign_info ci ON md.campaign_id = ci.id
JOIN website_revenue wr ON md.campaign_id = wr.campaign_id
GROUP BY md.campaign_id, ci.name;

-- 4. Write a query to get the number of conversions of Campaign5 by state.  
-- Which state generated the most conversions for this campaign? Answer: Georgia (You can add limit 1; to the end of the query to just show this answer) 
SELECT wr.state, SUM(md.conversions) AS total_conversions
FROM marketing_data md
INNER JOIN website_revenue wr ON md.campaign_id = wr.campaign_id
INNER JOIN campaign_info ci ON md.campaign_id = ci.id
WHERE ci.name = 'Campaign5'
GROUP BY wr.state
ORDER BY total_conversions DESC


-- 5. In your opinion, which campaign was the most efficient, and why?
-- Answer: Campaign 4
----  To determine efficiency, we can calculate the revenue-to-cost ratio for each campaign. A higher ratio indicates better efficiency.

SELECT md.campaign_id, ci.name AS campaign_name, 
       SUM(wr.revenue) AS total_revenue, --get revenue from website_revenue table
       SUM(cost) AS total_cost, -- get total cost from marketing_data table
       SUM(wr.revenue) / SUM(cost) AS efficiency_ratio --calculate revenue to cost ratio
FROM marketing_data md
JOIN campaign_info ci ON md.campaign_id = ci.id
JOIN website_revenue wr ON md.campaign_id = wr.campaign_id
GROUP BY md.campaign_id, ci.name
ORDER BY efficiency_ratio DESC
LIMIT 1;


--Bonus Question

--Write a query that showcases the best day of the week (e.g., Sunday, Monday, Tuesday, etc.) to run ads.
SELECT DATENAME(date) AS day_of_week, AVG(impressions) AS avg_impressions
FROM marketing_data
GROUP BY day_of_week
ORDER BY avg_impressions DESC
LIMIT 1;