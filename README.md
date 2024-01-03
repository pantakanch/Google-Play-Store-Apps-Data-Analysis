# Google-Play-Store-Apps-SQL-Data-Analysis

This project explores the Google Play Store app ecosystem using a Kaggle dataset. It will analyze app ratings, categories, genres, user reviews, and sentiment to gain insights.

Dataset on Kaggle: https://www.kaggle.com/datasets/lava18/google-play-store-apps

# Key Questions:
1. What is the average app rating?
2. How do app ratings distribute?
3. Which app categories have the most installs?
4. Which app genres have the highest average ratings?
5. How many free and paid apps are there in each category?
6. What is the overall sentiment of user reviews?
7. How does sentiment vary for each app?
8. Which app has the most positive reviews?
9. What are the top 10 positively reviewed in games category?

# Query:

1. What is the average app rating?
```
SELECT 
	ROUND(AVG(Rating), 2) AS average_rating
FROM googleplaystore;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/4394ccb1-f730-4693-a793-d20742d8b69f)

2. How do app ratings distribute?
```
SELECT 
    rating_range, 
    COUNT(*) AS count_rating
FROM (
    SELECT
        CASE
            WHEN Rating BETWEEN 1 AND 1.9 THEN 1
            WHEN Rating BETWEEN 2 AND 2.9 THEN 2
            WHEN Rating BETWEEN 3 AND 3.9 THEN 3
            WHEN Rating BETWEEN 4 AND 4.9 THEN 4
            WHEN Rating = 5 THEN 5
            ELSE "no_rating"
        END AS rating_range
    FROM googleplaystore
)
GROUP BY rating_range
ORDER BY rating_range;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/df839512-45d2-4773-8b0d-f1167c121896)

3. Which app categories have the most installs?
```
SELECT 
	Category,
	SUM(CAST(REPLACE(Installs, '+', '') * 1000 AS INTEGER)) AS total_installs
FROM googleplaystore
GROUP BY Category
ORDER BY total_installs DESC;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/ee4d1ed5-7855-45e9-a2bf-69f0725d7082)

4. Which app genres have the highest average ratings?
```
SELECT 
	Genres, 
	ROUND(AVG(Rating), 2) AS average_rating
FROM googleplaystore
GROUP BY Genres
ORDER BY average_rating DESC;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/54f1b7dd-5e80-428d-9b43-bebbb7b9733f)

5. How many free and paid apps are there in each category?
```
SELECT 
	Category, 
	Type, 
	COUNT(*) AS count_type
FROM googleplaystore
GROUP BY Category, Type;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/ac412e41-5056-45ea-8ecb-ec762bd63380)

6. What is the overall sentiment of user reviews?
```
SELECT 
	Sentiment, 
	COUNT(*) AS sentiment_count
FROM googleplaystore_user_reviews
GROUP BY Sentiment
ORDER BY Sentiment;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/33f33c98-a5b2-441d-8ab2-d403dbadae27)

7. How does sentiment vary for each app?
```
SELECT 
	App, 
	Sentiment,
	count(*) AS sentiment_count
FROM googleplaystore_user_reviews
GROUP BY App, Sentiment;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/669f002c-2055-42b7-bfe5-64a0eaa4eeb5)

8. Which app has the most positive reviews?
```
SELECT 
	App, 
	Sentiment,
	count(*) AS sentiment_count
FROM googleplaystore_user_reviews
WHERE Sentiment = 'Positive'
GROUP BY App
ORDER BY sentiment_count DESC;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/65131565-0987-4c69-824b-3ca442cbff25)

9. What are the top 10 positively reviewed in games category?
```
SELECT 
	googleplaystore_user_reviews.App AS google_app,
	AVG(Sentiment_Polarity) AS avg_sentiment
FROM googleplaystore_user_reviews
	JOIN googleplaystore 
	ON googleplaystore_user_reviews.App = googleplaystore.App
WHERE googleplaystore.Category = 'GAME'
GROUP BY google_app
ORDER BY avg_sentiment DESC
LIMIT 10;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/eed49ed1-c045-4688-af57-8314b7863abe)
