-- find the names of the tables in this database.
SELECT name 
FROM sqlite_master
WHERE type = 'table'；
 
 -- find the structure of the `crime_scene_report` table
SELECT sql 
FROM sqlite_master
WHERE name = 'crime_scene_report'；
 
-- 
SELECT sql 
FROM sqlite_master
WHERE name = 'interview'

-- check person table structure
SELECT * FROM person LIMIT 10;

-- check type of crume scene          
SELECT DISTINCT type FROM crime_scene_report;             

-- check related crime 
SELECT * FROM crime_scene_report 
WHERE type = 'murder' 
AND city = 'SQL City'; 

-- got clue as below with date 20180115:
-- Security footage shows that there were 2 witnesses. 
-- The first witness lives at the last house on "Northwestern Dr". 
-- The second witness, named Annabel, lives somewhere on "Franklin Ave".

-- for the 1st witness 
SELECT * FROM person 
WHERE address_street_name = 'Northwestern Dr' 
ORDER BY address_number DESC LIMIT 1;
-- only one result, with id = 14887, license_id = 118009, ssn = 111564949

-- for the 2nd witness 
SELECT * FROM person 
WHERE name like '%Annabel%' AND address_street_name = 'Franklin Ave';
-- only one result, with id = 16371, name = Annabel Miller, license_id = 490173, address_street_name = Franklin Ave, ssn = 318771143

-- check their interview
SELECT p.id, p.name, i.transcript
FROM person p
JOIN interview i
ON p.id = i.person_id
WHERE p.id = 14887 OR p.id = 16371;

-- get some new clues:
-- 14887: I heard a gunshot and then saw a man run out. 
-- He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". 
-- Only gold members have those bags. The man got into a car with a plate that included "H42W".
-- 16371: I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

-- check by car plate
SELECT id, gender 
FROM drivers_license 
WHERE plate_number LIKE '%H42W%';
-- got 2 liscense_id with gender 'male' : 423327, 664760

SELECT id, license_id
FROM person
WHERE license_id = '423327' or license_id ='664760';
-- got 2 person_id 51739, 67318

-- check by gym
-- check gym tables structure
SELECT * FROM get_fit_now_check_in;
SELECT * FROM get_fit_now_memeber;

SELECT m.id AS gym_id, m.person_id, m.membership_status
FROM get_fit_now_member m
JOIN get_fit_now_check_in ci
ON m.id = ci.membership_id
WHERE ci.check_in_date = '20180109' AND m.membership_status = 'gold' AND (ci.membership_id LIKE '48Z%');
-- got 2 person_id 28819, 67318

-- GOT IT!! only 67318 existed in both results
SELECT id, name 
FROM person 
WHERE id = '67318';
-- the murder is 'Jeremy Bowers'

INSERT INTO solution VALUES (1, 'Jeremy Bowers');
SELECT value FROM solution;