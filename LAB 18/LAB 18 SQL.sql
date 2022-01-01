create database lab_18;

-- the complete table 
SELECT * FROM lab_18.applestore;

-- how many devices used: up_devices

-- 1. What are the different genres?
SELECT prime_genre FROM lab_18.applestore
GROUP BY prime_genre;
SELECT DISTINCT prime_genre FROM lab_18.applestore;

-- 2. Which is the genre with the most apps rated? 
SELECT prime_genre, avg(user_rating) AS ave_rate FROM lab_18.applestore
GROUP BY prime_genre
ORDER BY ave_rate DESC
LIMIT 1;

-- 3. Which is the genre with most apps? 
SELECT prime_genre, count(track_name) AS tot_apps FROM lab_18.applestore
GROUP BY prime_genre
ORDER BY tot_apps DESC
LIMIT 1;

-- 4. Which is the one with least? 
SELECT prime_genre, count(track_name) AS tot_apps FROM lab_18.applestore
GROUP BY prime_genre
ORDER BY tot_apps
LIMIT 1;

-- 5. Find the top 10 apps most rated.  
SELECT track_name, rating_count_tot FROM lab_18.applestore
ORDER BY rating_count_tot DESC
LIMIT 10;

-- 6. Find the top 10 apps best rated by users. 
SELECT track_name, user_rating FROM lab_18.applestore
ORDER BY user_rating DESC
LIMIT 10;

-- 7. Take a look at the data you retrieved in question 5. Give some insights. 
-- table 1
SELECT track_name, rating_count_tot/user_rating AS num_vote, prime_genre, price FROM lab_18.applestore
ORDER BY num_vote DESC
LIMIT 10;

-- 8. Take a look at the data you retrieved in question 6. Give some insights.
-- table 2
SELECT track_name, rating_count_tot/user_rating AS num_vote, prime_genre, price FROM lab_18.applestore
WHERE track_name in ('J&J Official 7 Minute Workout','Fragment\'s Note', 'Dragon Island Blue', 'Fieldrunners 2', 'Sworkit - Custom Workouts for Exercise & Fitness', 'Pumped: BMX', 'Headspace', 'Timeshare+','Infect Them All : Vampires', 'Daily Audio Bible App');


-- 9. Now compare the data from questions 5 and 6. What do you see? need to show the comparison
-- comparison table in 7 & 8

-- 10. How could you take the top 3 regarding both user ratings and number of votes? creative, also need to use code to show the arguments of your opinion
-- table 3: order by most voted apps, then by rating
SELECT track_name, user_rating, rating_count_tot/user_rating AS num_vote, prime_genre FROM lab_18.applestore
ORDER BY num_vote DESC, user_rating DESC
LIMIT 10;

-- table 4 : order by rating, then by most voted apps
SELECT track_name, user_rating, rating_count_tot/user_rating AS num_vote, prime_genre FROM lab_18.applestore
ORDER BY user_rating DESC, num_vote DESC
LIMIT 5;


-- 11. Do people care about the price of an app? Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?
-- table 5
SELECT track_name, price, user_rating, rating_count_tot/user_rating AS num_vote FROM lab_18.applestore
ORDER BY num_vote DESC, user_rating DESC
LIMIT 15;

-- table 6
SELECT track_name, price, user_rating, rating_count_tot/user_rating AS num_vote FROM lab_18.applestore
WHERE price > 9
ORDER BY price DESC, user_rating DESC;

-- table 7
SELECT track_name, price, user_rating, rating_count_tot/user_rating AS num_vote FROM lab_18.applestore
WHERE PRICE BETWEEN 0.99 AND 5 AND rating_count_tot/user_rating > 10000
ORDER BY user_rating DESC, num_vote; 