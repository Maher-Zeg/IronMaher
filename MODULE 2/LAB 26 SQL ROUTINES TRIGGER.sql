USE employees_mod;

DELIMITER $$
DROP PROCEDURE avg_sal$$

CREATE PROCEDURE avg_sal()
BEGIN
	SELECT avg(salary)
	FROM t_salaries;
END $$

DELIMITER ;

-- TESTING THE SCRIPT
CALL avg_sal();
-- 

DELIMITER $$
DROP PROCEDURE emp_info$$

CREATE PROCEDURE emp_info(first_name varchar(14), last_name varchar(14))
BEGIN
	SELECT emp_no
    FROM t_employees e
    WHERE first_name = e.first_name
    AND last_name = e.last_name;
END$$

DELIMITER ;

-- TESTING THE SCRIPT
CALL emp_info('Amalendu', 'Nyrup');
--

DELIMITER $$
DROP FUNCTION emp_info$$

CREATE FUNCTION emp_info(p_first_name varchar(14), p_last_name varchar(14))
RETURNS DECIMAL (10,2)
DETERMINISTIC
BEGIN 
	DECLARE v_max_from_date date;
    DECLARE v_salary DECIMAL (10,2);
    
    SELECT MAX(from_date)
	INTO v_max_from_date 
    FROM t_employees e
    JOIN t_salaries s 
    ON e.emp_no = s.emp_no
	WHERE e.first_name = p_first_name
    AND e.last_name = p_last_name;
    
	SELECT MAX(salary)
    INTO v_salary
    FROM t_salaries s
    LEFT JOIN t_employees e
    ON e.emp_no = s.emp_no
    WHERE first_name = e.first_name
    AND last_name = e.last_name
    AND s.from_date = v_max_from_date;
	RETURN v_salary;
END $$
DELIMITER ;

-- TESTING THE SCRIPT
SELECT emp_info('Amalendu', 'Nyrup');
-- 

DELIMITER $$

CREATE TRIGGER date_check
BEFORE INSERT ON t_employees
FOR EACH ROW
BEGIN
	IF NEW.hire_date > current_date() THEN
		SET NEW.hire_date = current_date();
    END IF;
END $$

DELIMITER ;

-- TESTING THE SCRIPT
INSERT INTO t_employees
VALUES(10009,'1958-02-19','TEST','TEST','M','2024-09-15');
-- 

CREATE INDEX test
ON t_employees(hire_date);

DROP INDEX test
ON t_employees;

--

SELECT salary
FROM t_salaries
WHERE salary > 89000;

CREATE INDEX index_sal
ON t_salaries(salary);

--

SELECT e.emp_no, e.first_name, e.last_name, 
CASE
	WHEN e.emp_no = m.emp_no THEN "Yes"
    ELSE "No"
END AS Manager
FROM t_employees e
JOIN t_dept_manager m
ON m.emp_no = e.emp_no
WHERE e.emp_no > 109990
GROUP BY emp_no;

--

CREATE TEMPORARY TABLE manager_raise
SELECT e.emp_no, e.first_name, e.last_name, (MAX(salary)-MIN(salary)) AS sal_diff,
CASE
	WHEN (MAX(salary)-MIN(salary)) > 30000 THEN "HIGH"
    ELSE "NOT"
END AS sal_raise
FROM t_employees e
JOIN t_dept_manager m
ON m.emp_no = e.emp_no
JOIN t_salaries s
ON s.emp_no = e.emp_no
GROUP BY emp_no;

--

SELECT r.emp_no, r.first_name, r.last_name,
CASE
	WHEN d.to_date < current_date() THEN "Not an employee anymore"
    ELSE "Is still employed"
END AS "current_employee"
FROM manager_raise r
JOIN t_dept_emp d
ON d.emp_no = r.emp_no
GROUP BY r.emp_no
ORDER BY r.emp_no
LIMIT 100;