CREATE DATABASE STAT_FONDATION;
USE STAT_FONDATION; 
CREATE TABLE LAB3_PART3(
			student_id int,
            score int);

avg(score) FROM lab3_part3;
	-- Mean = 79.93
SELECT sum(score) FROM lab3_part3;
	-- Sum = 1199
	
SELECT std(score) FROM lab3_part3;
	-- Standard deviation = 14.69
SELECT variance(score) FROM lab3_part3;
	-- Variance = 215.93
SELECT score FROM lab3_part3
ORDER BY score LIMIT 1;
	-- MIN = 56
SELECT score FROM lab3_part3
ORDER BY score DESC LIMIT 1;
	-- MAX = 98
