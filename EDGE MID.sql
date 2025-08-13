create database EDGEMID;
use EDGEMID
-- Part A
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) DEFAULT 'Dhaka'
);

INSERT INTO Departments (dept_id, dept_name, location)
VALUES (101, 'IT', 'Chattogram');

SELECT *
FROM Employees
WHERE salary > 50000;

SELECT DISTINCT designation
FROM Employees;

DELETE FROM Employees
WHERE dept_id = 103;

-- Part B
SELECT e.emp_name, d.dept_name, d.location
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;

SELECT e.*
FROM Employees e
LEFT JOIN Assignments a ON e.emp_id = a.emp_id
WHERE a.proj_id IS NULL;

SELECT dept_id, AVG(salary) AS avg_salary
FROM Employees
GROUP BY dept_id
HAVING AVG(salary) > 60000;


SELECT p.proj_name, SUM(a.hours_worked) AS total_hours
FROM Projects p
JOIN Assignments a ON p.proj_id = a.proj_id
GROUP BY p.proj_name;

SELECT e.*
FROM Employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM Employees
    WHERE dept_id = e.dept_id
);

-- Part C
SELECT d.dept_name,
       COUNT(p.proj_id) AS number_of_projects,
       SUM(p.budget) AS total_budget
FROM Departments d
JOIN Projects p ON d.dept_id = p.dept_id
GROUP BY d.dept_name
HAVING COUNT(p.proj_id) > 2
   AND SUM(p.budget) > 5000000
ORDER BY total_budget DESC;





