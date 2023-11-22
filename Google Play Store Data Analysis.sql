-- 1. What is the average rating for all apps?
SELECT 
	ROUND(AVG(Rating), 2) AS average_rating
FROM googleplaystore;

-- 2. What is the distribution of app ratings?
SELECT 
	Rating, 
	COUNT(*) AS count
FROM googleplaystore
GROUP BY Rating;

-- 3. What is the relationship between app rating and number of reviews?
SELECT 
	Rating, 
	ROUND(AVG(Reviews), 2) AS average_reviews
FROM googleplaystore
GROUP BY Rating;

-- 4.  What are the most popular app categories by number of installs?
SELECT 
	Category, 
	COUNT(Installs) AS total_installs
FROM googleplaystore
GROUP BY Category
ORDER BY total_installs DESC;

-- 5. What are the most popular app categories by average rating?
SELECT 
	Category, 
	ROUND(AVG(Rating), 2) AS average_rating
FROM googleplaystore
GROUP BY Category
ORDER BY average_rating DESC;

-- 6. What is the relationship between app category and app type (paid or free)?
SELECT 
	Category, 
	Type, 
	COUNT(*) AS count
FROM googleplaystore
GROUP BY Category, Type;

-- 7. What is the distribution of sentiment for user reviews of each app?
SELECT 
	App, 
	Sentiment, 
	COUNT(*) AS count
FROM googleplaystore_user_reviews
GROUP BY App, Sentiment;

-- 8. What is the relationship between app rating and user sentiment?
SELECT 
	Rating, 
	Sentiment,
	count(*) AS total_sentiment
FROM googleplaystore_user_reviews
JOIN googleplaystore 
ON googleplaystore_user_reviews.App = googleplaystore.App
GROUP BY Rating, Sentiment
ORDER BY Rating, total_sentiment DESC;