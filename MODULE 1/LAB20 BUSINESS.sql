CREATE DATABASE demo;
CREATE TABLE demo.students (id varchar(2), name varchar(255), c_id varchar(255));
CREATE TABLE demo.courses (course_name varchar(255), description varchar(255));
INSERT INTO demo.students (id, name, c_id)
VALUES (1, 'John', 'DA');
INSERT INTO demo.students 
VALUES (2, 'Kate', 'WEB');
INSERT INTO demo.students 
VALUES (3, 'Ann', 'DA');
INSERT INTO demo.students 
VALUES (4, 'Misa', 'WEB');
INSERT INTO demo.courses 
VALUES ('DA', 'Data');
INSERT INTO demo.courses 
VALUES ('WEB', 'Web Dev');
INSERT INTO demo.courses 
VALUES ('UX', 'Design');
SELECT * FROM demo.courses;

SELECT c.description, s.name
FROM demo.students s
LEFT JOIN demo.courses c
ON s.c_id = c.course_name;

SELECT c.description, count(s.name) AS num_student
FROM demo.courses c
LEFT JOIN demo.students s
ON s.c_id = c.course_name
GROUP BY c.description;
