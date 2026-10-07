--Create University Database

CREATE DATABASE University_DB;
GO
USE University_DB;
GO

--Create Tables
--A. College_Table

CREATE TABLE College_Table (
    College_ID INT PRIMARY KEY,
    College_Name VARCHAR(50),
    College_Area VARCHAR(50)
);

--B. Department_Table (FK from College_Table)

CREATE TABLE Department_Table (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50),
    Dept_Facility VARCHAR(50),
    College_ID INT,
    FOREIGN KEY (College_ID) REFERENCES College_Table(College_ID)
);

---C. Professor_Table

CREATE TABLE Professor_Table (
    Professor_ID INT PRIMARY KEY,
    Professor_Name VARCHAR(50),
    Professor_Subject VARCHAR(50)
);

--D. Student_Table (FK from Professor_Table)

CREATE TABLE Student_Table (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(50),
    Student_Stream VARCHAR(50),
    Professor_ID INT,
    FOREIGN KEY (Professor_ID) REFERENCES Professor_Table(Professor_ID)
);


--3️⃣ Insert Minimum 10 Records
---College_Table

INSERT INTO College_Table VALUES
(1,'City College','Pune'),
(2,'Central College','Mumbai'),
(3,'Modern College','Nashik'),
(4,'Creative College','Nagpur'),
(5,'Classic College','Kolhapur'),
(6,'Unity College','Pune'),
(7,'National College','Delhi'),
(8,'Royal College','Jaipur'),
(9,'Future College','Bangalore'),
(10,'Star College','Hyderabad'));


INSERT INTO Department_Table VALUES
(1,'Computer','Lab',1),
(2,'IT','WiFi',2),
(3,'Mechanical','Workshop',3),
(4,'Civil','Drawing Lab',4),
(5,'Electrical','Equipment',5),
(6,'AI','Research',6),
(7,'ENTC','Lab',7),
(8,'Chemical','Plant',8),
(9,'BioTech','Lab',9),
(10,'Aerospace','Hangar',10);


INSERT INTO Professor_Table VALUES
(1,'Ramesh','DBMS'),
(2,'Suresh','Java'),
(3,'Mahesh','Python'),
(4,'Ganesh','AI'),
(5,'Naresh','ML'),
(6,'Rajesh','Cloud'),
(7,'Dinesh','OS'),
(8,'Kiran','Networks'),
(9,'Anil','Security'),
(10,'Sunil','Data Science');




--🔹 TASK 2
--1.College_ID and College_Name--

SELECT College_ID, College_Name FROM College_Table;


---2. Show Top 5 rows from Student table.

SELECT TOP 5 * FROM Student_Table;


--3. What is the name of professor whose ID is 5

SELECT Professor_Name FROM Professor_Table WHERE Professor_ID = 5;

--4. Convert the name of the Professor into Upper case

SELECT Professor_Name FROM Professor_Table WHERE Professor_ID = 5;

--5. Show me the names of those students whose name is start with a

SELECT * FROM Student_Table WHERE Student_Name LIKE 'A%';


--6. Give the name of those colleges whose end with a

SELECT * FROM College_Table WHERE College_Name LIKE '%a';

--7. Add one Salary Column in Professor_Table

ALTER TABLE Professor_Table ADD Salary INT;

--8. Add one Contact Column in Student_table

ALTER TABLE Student_Table ADD Contact VARCHAR(15);

--9. Find the total Salary of Professor

SELECT SUM(Salary) AS Total_Salary FROM Professor_Table;

--10. Change datatype of any one column of any one Table

ALTER TABLE Student_Table
ALTER COLUMN Student_Name VARCHAR(100);


--TASK 3

--1. Show first 5 records from Students table and Professor table Combine

SELECT TOP 5 Student_Name FROM Student_Table
UNION
SELECT TOP 5 Professor_Name FROM Professor_Table;

--2. Apply Inner join on all 4 tables together(Syntax is mandatory)

SELECT *
FROM College_Table C
INNER JOIN Department_Table D ON C.College_ID = D.College_ID
INNER JOIN Professor_Table P ON P.Professor_ID = D.Dept_ID
INNER JOIN Student_Table S ON S.Professor_ID = P.Professor_ID;

--3. Show Some null values from Department table and Professor table.

SELECT * FROM Department_Table WHERE Dept_Facility IS NULL;
SELECT * FROM Professor_Table WHERE Salary IS NULL;

--4. Create a View from College Table and give those records whose college
--name starts with C

CREATE VIEW College_View AS
SELECT * FROM College_Table
WHERE College_Name LIKE 'C%';

--5. Create Stored Procedure of Professor table whatever customer ID will be
--given by user it should show whole records of it.

CREATE PROCEDURE GetProfessorDetails
@ProfessorID INT
AS
BEGIN
    SELECT * FROM Professor_Table
    WHERE Professor_ID = @ProfessorID;
END;

--6. Rename the College_Table to College_Tables_Data .


EXEC sp_rename 'College_Table', 'College_Tables_Data';
