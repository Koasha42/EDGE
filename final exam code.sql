CREATE DATABASE EDGE1;
USE EDGE1;
-- part A

-- create department table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
-- create student table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    dob DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
-- value insert
INSERT INTO Departments (department_id, department_name)
VALUES 
(1, 'Department 1'),
(2, 'Department 2');


INSERT INTO Students (student_id, name, email, dob, department_id)
VALUES 
('101', 'John Doe', 'john@example.com', '2002-06-15', '2'),
('102', 'Jane Smith', 'jane@example.com', '2001-10-30', '1');

-- ans 3
SELECT * 
FROM Students
WHERE dob > '2002-01-01'
ORDER BY name DESC;

-- 4 ans

SELECT department_id, COUNT(*) AS total_students
FROM Students
GROUP BY department_id;

-- 5 ans

DELETE FROM Students
WHERE dob < '2000-01-01';


-- part B
-- 6 ans
SELECT S.name, D.department_name
FROM Students S
JOIN Departments D ON S.department_id = D.department_id;

-- 7 ans
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    grade DECIMAL(3,1),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
INSERT INTO Courses (course_id, course_name, department_id)
VALUES
(201, 'Mathematics', 1),
(202, 'Statistics', 1),
(203, 'Computer Science', 2),
(204, 'Data Science', 2);
INSERT INTO Enrollments (enrollment_id, student_id, course_id, grade)
VALUES
(1, 101, 201, 3.5),
(2, 101, 203, 4.0),
(3, 102, 202, 2.8),
(4, 102, 204, 3.6);

-- 7 ans
SELECT C.course_name, AVG(E.grade) AS avg_grade
FROM Enrollments E
JOIN Courses C ON E.course_id = C.course_id
GROUP BY C.course_name
HAVING AVG(E.grade) > 3.0;

-- 8 ans
SELECT S.*
FROM Students S
LEFT JOIN Enrollments E ON S.student_id = E.student_id
WHERE E.enrollment_id IS NULL;

-- 9 ans
SELECT C.course_name, COUNT(E.student_id) AS total_enrolled
FROM Courses C
LEFT JOIN Enrollments E ON C.course_id = E.course_id
GROUP BY C.course_name
ORDER BY total_enrolled DESC;

-- 10 ans
SELECT S.name, E.course_id, E.grade
FROM Enrollments E
JOIN Students S ON E.student_id = S.student_id
WHERE E.grade > (
    SELECT AVG(E2.grade)
    FROM Enrollments E2
    WHERE E2.course_id = E.course_id
);









