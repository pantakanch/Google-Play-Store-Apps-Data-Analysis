# Google-Play-Store-Apps-SQL-Data-Analysis

## Overview:
The "Google Play Store Apps SQL Data Analysis" project dives into the vast ecosystem of the Google Play Store, leveraging a Kaggle dataset to glean insights into app ratings, categories, genres, user reviews, and sentiments.

Dataset on Kaggle: https://www.kaggle.com/datasets/lava18/google-play-store-apps

## Key Questions:

1. **Average App Rating:**
   - What is the average app rating?

2. **App Ratings Distribution:**
   - How do app ratings distribute?

3. **Category-wise Installs:**
   - Which app categories have the most installs?

4. **Highest Rated Genres:**
   - Which app genres have the highest average ratings?

5. **Free and Paid Apps Breakdown:**
   - How many free and paid apps are there in each category?

6. **User Reviews Sentiment Overview:**
   - What is the overall sentiment of user reviews?

7. **App-specific Sentiment Analysis:**
   - How does sentiment vary for each app?

8. **Most Positively Reviewed App:**
   - Which app has the most positive reviews?

9. **Top 10 Positively Reviewed Games:**
   - What are the top 10 positively reviewed apps in the Games category?

## SQL Queries:

- **Average App Rating:**
```
SELECT 
	ROUND(AVG(Rating), 2) AS average_rating
FROM googleplaystore;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/4394ccb1-f730-4693-a793-d20742d8b69f)

- **App Ratings Distribution:**
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

- **Category-wise Installs:**
```
SELECT 
	Category,
	SUM(CAST(REPLACE(Installs, '+', '') * 1000 AS INTEGER)) AS total_installs
FROM googleplaystore
GROUP BY Category
ORDER BY total_installs DESC;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/ee4d1ed5-7855-45e9-a2bf-69f0725d7082)

- **Highest Rated Genres:**
```
SELECT 
	Genres, 
	ROUND(AVG(Rating), 2) AS average_rating
FROM googleplaystore
GROUP BY Genres
ORDER BY average_rating DESC;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/54f1b7dd-5e80-428d-9b43-bebbb7b9733f)

- **Free and Paid Apps Breakdown:**
```
SELECT 
	Category, 
	Type, 
	COUNT(*) AS count_type
FROM googleplaystore
GROUP BY Category, Type;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/ac412e41-5056-45ea-8ecb-ec762bd63380)

- **User Reviews Sentiment Overview:**
```
SELECT 
	Sentiment, 
	COUNT(*) AS sentiment_count
FROM googleplaystore_user_reviews
GROUP BY Sentiment
ORDER BY Sentiment;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/33f33c98-a5b2-441d-8ab2-d403dbadae27)

- **App-specific Sentiment Analysis:**
```
SELECT 
	App, 
	Sentiment,
	count(*) AS sentiment_count
FROM googleplaystore_user_reviews
GROUP BY App, Sentiment;
```
![image](https://github.com/pantakanch/Google-Play-Store-Apps-SQL-Data-Analysis/assets/113978334/669f002c-2055-42b7-bfe5-64a0eaa4eeb5)

- **Most Positively Reviewed App:**
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

- **Top 10 Positively Reviewed Games:**
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
