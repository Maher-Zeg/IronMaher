-- check content in tables 
SELECT * FROM publications.authors;
SELECT * FROM publications.titles;
SELECT * FROM publications.publishers;

-- Challenge 1

CREATE TEMPORARY TABLE publications.www

SELECT a.au_id AS "AUTHOR ID", a.au_lname AS "LAST NAME", a.au_fname AS "FIRST NAME", t. title AS TITLE, p.pub_name AS PUBLISHER
-- for authors's id, 1st, last name
FROM publications.authors AS a
-- for title
JOIN publications.titleauthor AS ta
ON ta.au_id = a.au_id
JOIN publications.titles AS t
ON ta.title_id = t.title_id
-- for publisher
JOIN publications.publishers AS p
ON t.pub_id = p.pub_id;

-- check results with titleauthor to verify the answer 
SELECT * FROM publications.titleauthor;

-- Challenge 2 - Who Have Published How Many At Where?

SELECT * FROM publications.www;
SELECT `AUTHOR ID`, MIN(`LAST NAME`) , MIN(`FIRST NAME`), `PUBLISHER`, COUNT(`AUTHOR ID`) AS "TITLE COUNT"
FROM publications.www
GROUP BY `AUTHOR ID`, `PUBLISHER`
ORDER BY `AUTHOR ID` DESC;

-- Challenge 3 - Best Selling Authors
-- Your output should be ordered based on TOTAL from high to low. Only output the top 3 best selling authors.

SELECT * FROM publications.sales;

CREATE TEMPORARY TABLE publications.bestseller

SELECT a.au_id AS "AUTHOR ID", a.au_lname AS "AUTHOR lAST NAME", a.au_fname AS "FIRST NAME", s.qty AS TOTAL
-- for authors's id, 1st, last name
FROM publications.authors AS a
-- for qty of titles
JOIN publications.titleauthor AS ta
ON ta.au_id = a.au_id
JOIN publications.titles AS t
ON ta.title_id = t.title_id
JOIN publications.sales AS s
ON s.title_id = t.title_id;

SELECT * FROM publications.bestseller;

SELECT MIN(`AUTHOR ID`), MIN(`AUTHOR lAST NAME`), MIN(`FIRST NAME`),SUM(TOTAL) AS "TOTAL TITLES QTY SOLD"
FROM publications.bestseller
GROUP BY `AUTHOR ID`
ORDER BY SUM(TOTAL) DESC
LIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking

CREATE TEMPORARY TABLE publications.title_QTY_sold_list

SELECT a.au_id AS "AUTHOR ID", a.au_lname AS "AUTHOR lAST NAME", a.au_fname AS "FIRST NAME", s.qty AS TOTAL

FROM publications.authors AS a
LEFT JOIN publications.titleauthor AS ta
ON ta.au_id = a.au_id
LEFT JOIN publications.titles AS t
ON ta.title_id = t.title_id
LEFT JOIN publications.sales AS s
ON s.title_id = t.title_id;

SELECT * FROM publications.title_QTY_sold_list;

SELECT `AUTHOR ID`, MIN(`AUTHOR lAST NAME`), MIN(`FIRST NAME`), SUM(COALESCE(`TOTAL`, 0)) AS `TOTAL_QTY_SOLD`
FROM publications.title_QTY_sold_list
GROUP BY `AUTHOR ID`
ORDER BY `TOTAL_QTY_SOLD` DESC;
SELECT COALESCE(`TOTAL`, 0) FROM publications.title_QTY_sold_list;