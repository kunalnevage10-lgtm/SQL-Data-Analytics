
SELECT * FROM `data-to-insights.ecommerce.all_sessions`
 LIMIT 10;
 SELECT 
  city, 
  SUM(totalTransactionRevenue) / 1000000 AS total_revenue
FROM `data-to-insights.ecommerce.all_sessions`
WHERE totalTransactionRevenue IS NOT NULL 
  AND city != '(not set)'
  AND city != 'not available in demo dataset'
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 10;

SELECT
v2ProductName,
SUM (productQuantity)AS total_units_sold
FROM `data-to-insights.ecommerce.all_sessions`
WHERE productQuantity IS NOT NULL
GROUP BY v2ProductName
ORDER BY total_units_sold DESC
LIMIT 10;

SELECT 
  channelGrouping,
  COUNT(DISTINCT visitId) AS total_sessions,
  COUNT(DISTINCT CASE WHEN totalTransactionRevenue IS NOT NULL THEN visitId END) AS total_transactions,
  (COUNT(DISTINCT CASE WHEN totalTransactionRevenue IS NOT NULL THEN visitId END) / COUNT(DISTINCT visitId)) * 100 AS conversion_rate
FROM `data-to-insights.ecommerce.all_sessions`
GROUP BY channelGrouping
ORDER BY conversion_rate DESC;

SELECT 
  fullVisitorId
FROM `data-to-insights.ecommerce.all_sessions`
GROUP BY fullVisitorId
HAVING MAX(CASE WHEN eCommerceAction_type = '3' THEN 1 ELSE 0 END) = 1 
   AND MAX(CASE WHEN eCommerceAction_type = '6' THEN 1 ELSE 0 END) = 0
LIMIT 20;
