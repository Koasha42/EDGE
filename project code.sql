CREATE DATABASE EDGE2;
USE EDGE2;
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



-- project
-- part A
CREATE VIEW TopStudents AS
SELECT 
    s.student_id,
    s.name,
    AVG(e.grade) AS average_grade
FROM 
    Students s
JOIN 
    Enrollments e ON s.student_id = e.student_id
GROUP BY 
    s.student_id, s.name
HAVING 
    AVG(e.grade) > 3.5;

DELIMITER $$

CREATE PROCEDURE IncreaseGrade(IN courseId INT)
BEGIN
    UPDATE Enrollments
    SET grade = CASE 
                    WHEN grade + 0.5 > 4.0 THEN 4.0
                    ELSE grade + 0.5
                END
    WHERE course_id = courseId;
END $$

DELIMITER ;

SELECT DISTINCT s.student_id, s.name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.grade = (
    SELECT MAX(e2.grade)
    FROM Enrollments e2
    WHERE e2.course_id = e.course_id
);

-- part B
SELECT 
    d.department_name,
    COUNT(DISTINCT s.student_id) AS total_students,
    AVG(e.grade) AS average_grade,
    COUNT(DISTINCT c.course_id) AS number_of_courses
FROM 
    Departments d
JOIN 
    Courses c ON d.department_id = c.department_id
JOIN 
    Enrollments e ON c.course_id = e.course_id
JOIN 
    Students s ON s.student_id = e.student_id
GROUP BY 
    d.department_id, d.department_name
HAVING 
    COUNT(DISTINCT c.course_id) >= 2
ORDER BY 
    average_grade DESC;



