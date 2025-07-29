USE KRG_2B;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(200),
    credits INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

INSERT INTO Departments (department_id, department_name, location) VALUES
(1, 'Computer Science', 'Building A'),
(2, 'Electrical Engineering', 'Building B'),
(3, 'Mechanical Engineering', 'Building C'),
(4, 'Civil Engineering', 'Building D'),
(5, 'Humanities', 'Building E');

INSERT INTO Courses (course_id, course_name, credits, department_id) VALUES
(101, 'Data Structures', 3, 1),
(102, 'Algorithms', 4, 1),
(103, 'Operating Systems', 3, 1),
(104, 'Digital Logic Design', 3, 2),
(105, 'Microprocessors', 4, 2),
(106, 'Thermodynamics', 3, 3),
(107, 'Fluid Mechanics', 3, 3),
(108, 'Structural Analysis', 4, 4),
(109, 'Engineering Ethics', 2, 5),
(110, 'Technical Writing', 3, 5),
(111, 'Database Management', 4, 1),
(112, 'Communication Systems', 3, 2);

-- Use a subquery to count the number of courses under each department.
SELECT d.department_name,(SELECT COUNT(c.course_id) 
    FROM Courses c 
    WHERE c.department_id = d.department_id) AS CoursesOffered
FROM Departments d;

-- Filter and retrieve only those departments that offer more than two courses.
SELECT d.department_name, d.location
FROM Departments d
WHERE (SELECT COUNT(c.course_id) 
    FROM Courses c 
    WHERE c.department_id = d.department_id) > 2;

-- Grant SELECT-only access on the courses table to a specific user
GRANT SELECT ON Courses TO student_user;