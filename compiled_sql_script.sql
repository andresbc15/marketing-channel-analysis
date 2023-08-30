/* 
January Digital Marketing Channel and Campaign Effectiveness
Compiled PostgreSQL scripts from Mode.com
Andres Cojuangco

Note: Each query generated a csv file in the sql_exports foldler. 
      These queries will not run in this file since I do not have 
      access to SQL.
 */

 -- display_metrics_year.csv 

 SELECT 
  year,
  subchannel,
  content,
  SUM(spend)/SUM(impressions) AS cost_per_impression,
  SUM(spend)/SUM(clicks) AS cost_per_click,
  (SUM(clicks)/SUM(impressions))*100 AS click_thru_rate,
  SUM(spend)/SUM(unique_visitors) AS cost_per_visit,
  SUM(pageviews)/SUM(unique_visitors) AS avg_pages_per_visit,
  (SUM(clicks)/SUM(visits))*100 AS clicks_to_visit,
  (SUM(conversions)/SUM(unique_visitors))*100 AS conversion_rate,
  SUM(revenue - spend) AS roi,
  SUM(revenue)/SUM(spend) AS roas
FROM andresbc843.marketing_data 
WHERE (year = 2023 OR year = 2022 OR year = 2021) 
  AND subchannel = 'display'
GROUP BY subchannel, year, content

-- profit_subchannel_year.csv

SELECT 
  subchannel,
  year,
  SUM(revenue - spend) AS profit
FROM andresbc843.marketing_data
GROUP BY subchannel, year
ORDER BY profit DESC;

-- roas_subchannel_alltime.csv

SELECT 
  subchannel,
  SUM(revenue)/SUM(spend) AS roas
FROM andresbc843.marketing_data
GROUP BY subchannel
ORDER BY roas DESC;

-- roas_subchannel_year.csv 

SELECT 
  year,
  subchannel,
  SUM(revenue)/SUM(spend) AS roas
FROM andresbc843.marketing_data
GROUP BY subchannel, year
ORDER BY roas DESC;

-- roas_subchannel_2023.csv

SELECT 
  subchannel,
 SUM(revenue)/SUM(spend) AS roas
FROM andresbc843.marketing_data
WHERE year = 2023
GROUP BY subchannel
ORDER BY roas DESC;

-- roas_year_month.csv

SELECT 
  year,
  month,
  SUM(revenue)/SUM(spend) AS roas
FROM andresbc843.marketing_data
GROUP BY year, month
ORDER BY roas DESC;

-- roi_subchannel_2023.csv

SELECT 
  subchannel,
  SUM(revenue - spend) AS roi
FROM andresbc843.marketing_data
WHERE year = 2023
GROUP BY subchannel
ORDER BY roi DESC;

-- roi_subchannel_alltime.csv

SELECT 
  subchannel,
  SUM(revenue - spend)/SUM(spend) AS roi
FROM andresbc843.marketing_data
GROUP BY subchannel
ORDER BY roi DESC;

-- roi_subchannel_year.csv

SELECT 
  subchannel,
  year,
  SUM(revenue - spend)/SUM(spend) AS roi
FROM andresbc843.marketing_data
GROUP BY subchannel, year
ORDER BY roi DESC;

-- subchannel_metrics_year.csv

SELECT 
  year,
  subchannel,
  SUM(spend)/SUM(impressions) AS cost_per_impression,
  SUM(spend)/SUM(clicks) AS cost_per_click,
  (SUM(clicks)/SUM(impressions))*100 AS click_thru_rate,
  SUM(spend)/SUM(unique_visitors) AS cost_per_visit,
  SUM(pageviews)/SUM(unique_visitors) AS avg_pages_per_visit,
  (SUM(clicks)/SUM(visits))*100 AS open_to_click_rate,
  (SUM(conversions)/SUM(unique_visitors))*100 AS conversion_rate,
  SUM(revenue - spend) AS roi,
  SUM(revenue)/SUM(spend) AS roas
FROM andresbc843.marketing_data 
WHERE year = 2023 OR year = 2022 OR year = 2021
GROUP BY subchannel, year
ORDER BY YEAR ASC;

-- video_effectiveness

SELECT 
  *,
  video_spend / video_views AS spend_per_view,
  video_views / video_impressions AS view_rate,
  video_completions / video_views AS video_completion_rate,
  link_clicks/video_views AS link_click_rate,
  revenue-spend AS roi,
  revenue/spend AS roas
FROM andresbc843.marketing_data
WHERE video_spend > 0;

-- video_subchannel_metrics

SELECT 
  year,
  subchannel,
  content,
  SUM(video_spend) / SUM(video_views) AS spend_per_view,
  SUM(video_views) / SUM(video_impressions) AS view_rate,
  SUM(video_completions) / SUM(video_views) AS video_completion_rate,
  SUM(link_clicks) / SUM(video_views)*100 AS link_click_rate,
  SUM(conversions) / SUM(unique_visitors) AS conversion_rate,
  SUM(revenue-spend) AS roi,
  SUM(revenue) / SUM(spend) AS roas
FROM andresbc843.new_video_features 
GROUP BY subchannel, content, year
ORDER BY year;
