create database EDGEquiz
use EDGEquiz
-- quiz 1
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
-- create student table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dob DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
-- ans 1
SELECT * 
FROM Students
WHERE dob > '2003-01-01'
ORDER BY name DESC;

-- ans 2
select distinct department_name from Departments;
-- ans 3
select s.name, d.department_name from Students s join Departments d on s.department_id=d.department_id;
-- ans 4
INSERT INTO Students (student_id, name, dob, department_id)
VALUES ('205', 'Rafiq', '2004-11-10', '2') ;


-- quiz 2

CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL, designation varchar(100), salary int, dept_id int, FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);
CREATE TABLE Projects (
    proj_id INT PRIMARY KEY,
    proj_name VARCHAR(100) NOT NULL, dept_id int, FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);
CREATE TABLE Assignments (
    emp_id INT,
    proj_id INT, hours_worked varchar(10), FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),FOREIGN KEY (proj_id) REFERENCES Projects(proj_id));

-- ans 1
select emp_name from Employees where salary >'50000';
-- ans 2
SELECT e.emp_name, p.proj_name
FROM Employees e
JOIN Assignments a ON e.emp_id = a.emp_id
JOIN Projects p ON a.proj_id = p.proj_id;
-- ans 3
SELECT d.dept_name, COUNT(p.proj_id) AS total_projects
FROM Departments d
JOIN Projects p ON d.dept_id = p.dept_id
GROUP BY d.dept_name;
-- ans 4
SELECT e.emp_name
FROM Employees e
LEFT JOIN Assignments a ON e.emp_id = a.emp_id
WHERE a.proj_id IS NULL;


