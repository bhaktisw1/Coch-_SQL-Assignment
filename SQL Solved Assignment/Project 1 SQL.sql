-- HR DATABASE MANAGEMENT SYSTEM
-- COMPLETE SQL PROJECT SOLUTIONS
-- SQL Server / SSMS

-- TASK 1: SELECT
SELECT * FROM employees;

SELECT employee_id, first_name, last_name, hire_date
FROM employees;

SELECT first_name, last_name, salary, salary * 2 AS new_salary
FROM employees;

SELECT employee_id, first_name, last_name, salary, salary * 2 AS New_SALARY
FROM employees;

-- ORDER BY
SELECT employee_id, first_name, last_name, hire_date, salary FROM employees;
SELECT * FROM employees ORDER BY first_name ASC;
SELECT * FROM employees ORDER BY first_name ASC, last_name DESC;
SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY hire_date ASC;
SELECT * FROM employees ORDER BY hire_date DESC;

-- DISTINCT
SELECT DISTINCT salary FROM employees ORDER BY salary DESC;
SELECT DISTINCT salary FROM employees;
SELECT job_id, salary FROM employees;
SELECT DISTINCT job_id, salary FROM employees;
SELECT DISTINCT phone_number FROM employees;

-- TOP
SELECT * FROM employees ORDER BY first_name ASC;
SELECT TOP 5 * FROM employees;
SELECT * FROM employees ORDER BY employee_id OFFSET 3 ROWS FETCH NEXT 5 ROWS ONLY;
SELECT TOP 5 employee_id, first_name, last_name, salary FROM employees ORDER BY salary DESC;
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees WHERE salary < (SELECT MAX(salary) FROM employees));

-- WHERE
SELECT * FROM employees WHERE salary > 14000 ORDER BY salary DESC;
SELECT * FROM employees WHERE department_id = 5;
SELECT * FROM employees WHERE last_name = 'Chen';
SELECT * FROM employees WHERE hire_date > '1999-01-01';
SELECT * FROM employees WHERE hire_date >= '1999-01-01' AND hire_date < '2000-01-01';
SELECT * FROM employees WHERE last_name = 'Himuro';
SELECT * FROM employees WHERE last_name LIKE '%Himuro%';
SELECT * FROM employees WHERE phone_number IS NULL;
SELECT * FROM employees WHERE department_id <> 8;
SELECT * FROM employees WHERE department_id NOT IN (8,10);
SELECT * FROM employees WHERE salary > 10000;
SELECT * FROM employees WHERE department_id = 8 AND salary > 10000;
SELECT * FROM employees WHERE salary < 10000;
SELECT * FROM employees WHERE salary >= 9000;
SELECT * FROM employees WHERE salary <= 9000;

-- ALTER TABLE examples
ALTER TABLE courses ADD credit_hours INT;
ALTER TABLE courses ADD fee DECIMAL(10,2), max_limit INT;
ALTER TABLE courses ALTER COLUMN fee DECIMAL(10,2) NOT NULL;
ALTER TABLE courses DROP COLUMN fee;
ALTER TABLE courses DROP COLUMN max_limit, credit_hours;

-- FOREIGN KEY
ALTER TABLE project_milestones
ADD CONSTRAINT FK_project_milestones_projects
FOREIGN KEY (project_id) REFERENCES projects(project_id);

-- TASK 2
SELECT * FROM employees WHERE salary > 5000 AND salary < 7000;
SELECT * FROM employees WHERE salary IN (7000,8000);
SELECT * FROM employees WHERE phone_number IS NULL;
SELECT * FROM employees WHERE salary BETWEEN 9000 AND 12000;
SELECT * FROM employees WHERE department_id IN (8,9);
SELECT * FROM employees WHERE first_name LIKE 'jo%';
SELECT * FROM employees WHERE first_name LIKE '_h%';

SELECT * FROM employees
WHERE salary > ALL (SELECT salary FROM employees WHERE department_id = 8);

SELECT * FROM employees e
WHERE e.salary > ALL (
    SELECT AVG(e2.salary) FROM employees e2 GROUP BY e2.department_id
);

SELECT e.* FROM employees e
WHERE EXISTS (SELECT 1 FROM dependents d WHERE d.employee_id = e.employee_id);

SELECT * FROM employees WHERE salary BETWEEN 2500 AND 2900;
SELECT * FROM employees WHERE salary NOT BETWEEN 2500 AND 2900;
SELECT * FROM employees WHERE hire_date BETWEEN '1999-01-01' AND '2000-12-31';
SELECT * FROM employees WHERE hire_date NOT BETWEEN '1989-01-01' AND '1999-12-31';
SELECT * FROM employees WHERE hire_date >= '1990-01-01' AND hire_date < '1994-01-01';

SELECT * FROM employees WHERE first_name LIKE 'Da%';
SELECT * FROM employees WHERE first_name LIKE '%er';
SELECT * FROM employees WHERE last_name LIKE '%an%';
SELECT * FROM employees WHERE first_name LIKE 'Jo%' AND LEN(first_name) BETWEEN 2 AND 4;
SELECT * FROM employees WHERE first_name LIKE '%_';
SELECT * FROM employees WHERE first_name LIKE 'S%' AND first_name NOT LIKE 'Sh%';

SELECT * FROM employees WHERE department_id = 5;
SELECT * FROM employees WHERE department_id = 5 AND salary <= 5000;
SELECT * FROM employees WHERE department_id NOT IN (1,2,3);
SELECT * FROM employees WHERE first_name NOT LIKE 'D%';
SELECT * FROM employees WHERE salary NOT BETWEEN 1000 AND 5000;

SELECT e.* FROM employees e
WHERE NOT EXISTS (SELECT 1 FROM dependents d WHERE d.employee_id = e.employee_id);

SELECT * FROM employees WHERE phone_number IS NULL;
SELECT * FROM employees WHERE phone_number IS NOT NULL;

-- TASK 3 JOINS
SELECT d.* FROM departments d WHERE d.department_id IN (1,2,3);

SELECT e.* FROM employees e WHERE e.department_id IN (1,2,3);

SELECT e.first_name, e.last_name, j.job_title, d.department_name
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id IN (1,2,3);

SELECT country_id, country_name FROM countries WHERE country_id IN ('US','UK','CN');

SELECT l.* FROM locations l WHERE l.country_id IN ('US','UK','CN');

SELECT c.country_id, c.country_name, l.location_id, l.city, l.state_province
FROM countries c
LEFT JOIN locations l ON c.country_id = l.country_id;

SELECT c.country_id, c.country_name
FROM countries c
LEFT JOIN locations l ON c.country_id = l.country_id
WHERE l.location_id IS NULL;

SELECT r.region_name, c.country_name, l.location_id, l.city, l.state_province
FROM regions r
JOIN countries c ON r.region_id = c.region_id
LEFT JOIN locations l ON c.country_id = l.country_id
ORDER BY r.region_name, c.country_name;

SELECT e.employee_id, e.first_name + ' ' + e.last_name AS employee_name,
       m.employee_id AS manager_id, m.first_name + ' ' + m.last_name AS manager_name
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;

SELECT e.employee_id, e.first_name + ' ' + e.last_name AS employee_name,
       m.employee_id AS manager_id, m.first_name + ' ' + m.last_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

SELECT b.basket_id, b.basket_name, f.fruit_id, f.fruit_name
FROM baskets b FULL OUTER JOIN fruits f ON b.basket_id = f.basket_id;

SELECT b.basket_id, b.basket_name
FROM baskets b LEFT JOIN fruits f ON b.basket_id = f.basket_id
WHERE f.fruit_id IS NULL;

SELECT f.fruit_id, f.fruit_name FROM fruits f WHERE f.basket_id IS NULL;

SELECT so.sales_org_id, so.sales_org, sc.channel_id, sc.channel
FROM sales_organization so CROSS JOIN sales_channel sc
ORDER BY so.sales_org_id, sc.channel_id;

-- TASK 4 GROUP BY / HAVING
SELECT department_id FROM employees GROUP BY department_id;
SELECT department_id, COUNT(*) AS employee_count FROM employees GROUP BY department_id;
SELECT department_id, COUNT(employee_id) AS employee_count FROM employees GROUP BY department_id;
SELECT department_id, COUNT(*) AS headcount FROM employees GROUP BY department_id ORDER BY headcount DESC;
SELECT department_id, COUNT(*) AS headcount FROM employees GROUP BY department_id HAVING COUNT(*) > 5;
SELECT department_id, MIN(salary) AS minimum_salary, MAX(salary) AS maximum_salary, AVG(salary) AS average_salary
FROM employees GROUP BY department_id;
SELECT department_id, SUM(salary) AS total_salary FROM employees GROUP BY department_id;
SELECT department_id, job_id, COUNT(*) AS employee_count FROM employees GROUP BY department_id, job_id;

SELECT m.employee_id AS manager_id, m.first_name + ' ' + m.last_name AS manager_name,
       COUNT(e.employee_id) AS direct_reports
FROM employees m JOIN employees e ON e.manager_id = m.employee_id
GROUP BY m.employee_id, m.first_name, m.last_name;

SELECT m.employee_id AS manager_id, m.first_name + ' ' + m.last_name AS manager_name,
       COUNT(e.employee_id) AS direct_reports
FROM employees m JOIN employees e ON e.manager_id = m.employee_id
GROUP BY m.employee_id, m.first_name, m.last_name
HAVING COUNT(e.employee_id) >= 5;

SELECT department_id, SUM(salary) AS total_salary
FROM employees GROUP BY department_id
HAVING SUM(salary) BETWEEN 20000 AND 30000;

SELECT department_id, MIN(salary) AS lowest_salary
FROM employees GROUP BY department_id HAVING MIN(salary) > 10000;

SELECT department_id, AVG(salary) AS average_salary
FROM employees GROUP BY department_id
HAVING AVG(salary) BETWEEN 5000 AND 7000;

-- TASK 5
SELECT first_name, last_name FROM employees
UNION
SELECT first_name, last_name FROM dependents
ORDER BY first_name, last_name;

-- Assuming A(id) and B(id) exist:
SELECT id FROM A
INTERSECT
SELECT id FROM B
ORDER BY id DESC;

SELECT e.* FROM employees e
WHERE EXISTS (SELECT 1 FROM dependents d WHERE d.employee_id = e.employee_id);

SELECT e.* FROM employees e
WHERE NOT EXISTS (SELECT 1 FROM dependents d WHERE d.employee_id = e.employee_id);

SELECT employee_id, first_name, last_name, hire_date,
       DATEFROMPARTS(2000, MONTH(hire_date), DAY(hire_date)) AS anniversary_date
FROM employees;

SELECT employee_id, first_name, last_name, salary,
       CASE
         WHEN salary < 3000 THEN 'Low'
         WHEN salary BETWEEN 3000 AND 5000 THEN 'Average'
         WHEN salary > 5000 THEN 'High'
       END AS salary_level
FROM employees;

UPDATE employees
SET last_name = 'Lopez'
WHERE employee_id = 192 AND last_name = 'Bell';

-- FINAL ADVANCED SUBQUERIES
SELECT employee_id, first_name, last_name
FROM employees
WHERE department_id IN (
    SELECT department_id FROM departments WHERE location_id = 1700
)
ORDER BY first_name, last_name;

SELECT employee_id, first_name, last_name
FROM employees
WHERE department_id NOT IN (
    SELECT department_id FROM departments WHERE location_id = 1700
)
ORDER BY first_name, last_name;

SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT d.department_id, d.department_name
FROM departments d
WHERE EXISTS (
    SELECT 1 FROM employees e
    WHERE e.department_id = d.department_id AND e.salary > 10000
);

SELECT d.department_id, d.department_name
FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e
    WHERE e.department_id = d.department_id AND e.salary > 10000
);

SELECT department_id, MIN(salary) AS lowest_salary
FROM employees GROUP BY department_id;

SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > ALL (
    SELECT MIN(salary) FROM employees GROUP BY department_id
);

SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary >= ALL (
    SELECT MAX(salary) FROM employees GROUP BY department_id
);

SELECT department_id, AVG(salary) AS average_salary
FROM employees GROUP BY department_id;

SELECT AVG(department_average) AS average_of_department_averages
FROM (
    SELECT department_id, AVG(salary) AS department_average
    FROM employees GROUP BY department_id
) AS x;

SELECT employee_id, first_name, last_name, salary,
       (SELECT AVG(salary) FROM employees) AS average_salary,
       salary - (SELECT AVG(salary) FROM employees) AS difference_from_average
FROM employees;
