CREATE TABLE appleStore_description_combined AS

SELECT *  FROM appleStore_description1

UNION ALL

SELECT *  FROM appleStore_description2

UNION ALL

SELECT *  FROM appleStore_description3

UNION ALL

SELECT *  FROM appleStore_description4


** data analysis**

--check unique number of apps in both tables AppleStore

SELECT COUNT(DISTINCT id) AS UniqueAppIDs
FRom AppleStore

SELECT COUNT(DISTINCT id) AS UniqueAppIDs
FROM appleStore_description_combined

--check for any missing values in key fields

SELECT COUNT(*) AS MissingValue
FROM AppleStore
WHERE track_name is null or user_rating is NULL or prime_genre is null

SELECT COUNT(*) AS MissingValue
FROM appleStore_description_combined
WHERE app_desc ISNULL

--find out the number of apps per genre

SELECT prime_genre, COUNT(*) as NumApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC

-- Get an overview of the apps rating

SELECT min(user_rating) AS MinRating,
       max(user_rating) AS MaxRating,
       avg(user_rating) AS AvgRating
FROM AppleStore

--Determine wether paid apps have better rating than free apps

SELECT case 
             WHEN price > 0 THEN 'Paid'
             ELSE 'Free'
       END  AS App_Type,
       avg(user_rating) AS Avg_rating
FROM AppleStore
GROUP BY App_Type

-- Check if apps if more supported lagnuages have a better rating

SELECT CASE 
             WHEN lang_num < 10 Then '<10 Languages'
             WHEN lang_num BETWEEN 10 AND 30 THEN '10 - 30 languages'
             ELSE '> 30 languages'
       END AS language_bucket,
       avg(user_rating) AS Avg_rating
FROM AppleStore
GROUP by language_bucket
ORDER BY Avg_rating DESC

-- check genre with low ratings--

Select prime_genre,
       avg(user_rating) AS Avg_Rating
FROM AppleStore
GROUP by prime_genre
ORDER by Avg_rating ASC
LIMIT 10

--Check if there is correlation between the length of the app description and the user rating--
SELECT CASE
             WHEN length(b.app_desc) <500 then 'Short'
             WHEN length(b.app_desc) BETWEEN 500 and 1000 then 'Medium'
             Else 'Long'
       END AS desscription_length_bucket,
       avg(a.user_rating) AS average_rating
from 
     AppleStore as A

JOIN
     appleStore_description_combined as b 

ON 
     a.id = b.id
     
GROUP BY desscription_length_bucket
ORDER by average_rating DESC

-- Check the top-rated apps for each genre

SELECT 
     prime_genre,
     track_name,
     user_rating
FROM (
      SELECT
      prime_genre,
      track_name,
      user_rating,
      RANK() OVER(PARTITION BY prime_genre order by user_rating DESC, rating_count_tot desc) as rank
      FROM
      AppleStore
     ) as a 
WHERE
a.rank =1