--------Database------------
create database Employee;

CREATE TABLE EmployeeDetails (
EmpId INT PRIMARY KEY,
FullName VARCHAR(100),
ManagerId INT,
DateOfJoining DATE,
City VARCHAR(100)
);

CREATE TABLE EmployeeSalary (
EmpId INT,
Project VARCHAR(50),
Salary DECIMAL(10, 2),
Variable DECIMAL(10, 2),
FOREIGN KEY (EmpId) REFERENCES
EmployeeDetails(EmpId)
);


INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId,
DateOfJoining, City) VALUES
(101, 'Alice Johnson', 321, '2022-05-15', 'New York'),
(102, 'Bob Smith', 876, '2020-03-12', 'Los Angeles'),
(103, 'Charlie Brown', 986, '2021-08-23', 'Chicago'),
(104, 'David Williams', 876, '2019-11-05', 'Houston'),
(105, 'Eve Davis', 321, '2023-01-07', 'Phoenix'),
(106, 'Frank Miller', 986, '2018-12-19', 'Philadelphia'),
(107, 'Grace Wilson', 876, '2022-03-28', 'San Antonio'),
(108, 'Hank Moore', 321, '2021-09-14', 'San Diego'),
(109, 'Ivy Taylor', 986, '2020-02-11', 'Dallas'),
(110, 'Jack Anderson', 876, '2022-11-30', 'San Jose'),
(111, 'Karen Thomas', 321, '2021-07-16', 'Austin'),
(112, 'Liam Jackson', 986, '2023-04-21', 'Fort Worth'),
(113, 'Mia White', 876, '2019-06-03', 'Columbus'),
(114, 'Noah Harris', 321, '2020-12-10', 'Charlotte'),
(115, 'Olivia Martin', 986, '2021-10-25', 'San Francisco'),
(116, 'Paul Garcia', 876, '2023-07-18', 'Indianapolis'),
(117, 'Quinn Martinez', 321, '2022-09-07', 'Seattle'),
(118, 'Rachel Rodriguez', 986, '2020-01-15', 'Denver'),
(119, 'Steve Clark', 876, '2021-03-19', 'Washington'),
(120, 'Tina Lewis', 321, '2019-08-31', 'Boston');




INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable)
VALUES
(101, 'P1', 7500, 500),
(102, 'P2', 9200, 700),
(103, 'P1', 6700, 600),
(104, 'P3', 8300, 900),
(105, 'P2', 7800, 800),
(106, 'P3', 9100, 1000),
(107, 'P1', 6200, 400),
(108, 'P2', 8800, 750),
(109, 'P3', 9500, 1100),
(110, 'P1', 7200, 650),
(111, 'P2', 8700, 850),
(112, 'P3', 9300, 1200),
(113, 'P1', 7900, 550),
(114, 'P2', 6800, 450),
(115, 'P3', 8400, 900),
(116, 'P1', 7600, 500),
(117, 'P2', 8900, 1000),
(118, 'P3', 9200, 1100),
(119, 'P1', 8100, 600),
(120, 'P2', 8300, 750);

select * from EmployeeDetails;

select * from EmployeeSalary;


-----basic  question----- PART 1



--Q1 Records in one table but not another

SELECT d.*
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON d.EmpId = s.EmpId
WHERE s.EmpId IS NULL;

---Q2 Employees not working on any project

SELECT d.*
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON d.EmpId = s.EmpId
WHERE s.Project IS NULL;

--Q3 Employees who joined in 2020

SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;


---Q4 Employees that have salary record

SELECT d.*
FROM EmployeeDetails d
INNER JOIN EmployeeSalary s ON d.EmpId = s.EmpId;

--Q5 Project-wise employee count

SELECT Project, COUNT(EmpId) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project;

---Q6 Names and salary even if salary not present

SELECT d.FullName, s.Salary
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON d.EmpId = s.EmpId;

---Q7 Employees who are also managers

SELECT DISTINCT d.EmpId, d.FullName
FROM EmployeeDetails d
INNER JOIN EmployeeDetails e ON d.EmpId = e.ManagerId;


---Q8 Duplicate records from EmployeeDetails

SELECT FullName, ManagerId, DateOfJoining, City, COUNT(*) AS Cnt
FROM EmployeeDetails
GROUP BY FullName, ManagerId, DateOfJoining, City
HAVING COUNT(*) > 1;

---Q9 Fetch only odd rows

WITH CTE AS (
    SELECT *, ROW_NUMBER() OVER (ORDER BY EmpId) AS rn
    FROM EmployeeDetails
)
SELECT * FROM CTE WHERE rn % 2 = 1;


--Q10 3rd highest salary without TOP/LIMIT

WITH CTE AS (
    SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk
    FROM EmployeeSalary
)
SELECT DISTINCT Salary
FROM CTE
WHERE rnk = 3;


---part 2 questions ---

--Ques1 Employees under Manager 986


SELECT EmpId, FullName
FROM EmployeeDetails
WHERE ManagerId = 986;


--Ques2 Different projects

SELECT DISTINCT Project
FROM EmployeeSalary;

--Ques3 Count of employees in P1

SELECT COUNT(*) AS P1Count
FROM EmployeeSalary
WHERE Project = 'P1';

--Ques4 Max, Min, Avg salary

SELECT MAX(Salary) AS MaxSalary,
       MIN(Salary) AS MinSalary,
       AVG(Salary) AS AvgSalary
FROM EmployeeSalary;

--Ques5 Salary range 9000–15000

SELECT EmpId
FROM EmployeeSalary
WHERE Salary BETWEEN 9000 AND 15000;

--Ques6 Live in Toronto AND Manager 321

SELECT *
FROM EmployeeDetails
WHERE City = 'Toronto' AND ManagerId = 321;

--Ques7 Live in California OR Manager 321

SELECT *
FROM EmployeeDetails
WHERE City = 'California' OR ManagerId = 321;

---Ques8 Work on projects other than P1

SELECT *
FROM EmployeeSalary
WHERE Project <> 'P1';

---Ques9 Total salary (Salary + Variable)

SELECT EmpId, (Salary + Variable) AS TotalSalary
FROM EmployeeSalary;

--Ques10 Name pattern: 2 chars + "hn" + anything

SELECT *
FROM EmployeeDetails
WHERE FullName LIKE '__hn%';

--part 3---

--Ques1 EmpIds in either table

SELECT EmpId FROM EmployeeDetails
UNION
SELECT EmpId FROM EmployeeSalary;

--Ques2 Common records

SELECT d.*
FROM EmployeeDetails d
INNER JOIN EmployeeSalary s ON d.EmpId = s.EmpId;

--Ques3 Present in one but not another

SELECT d.*
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON d.EmpId = s.EmpId
WHERE s.EmpId IS NULL;

--Ques4 EmpIds in both tables

SELECT d.EmpId
FROM EmployeeDetails d
INNER JOIN EmployeeSalary s ON d.EmpId = s.EmpId;

--Ques5 EmpIds in Details but not in Salary

SELECT d.EmpId
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON d.EmpId = s.EmpId
WHERE s.EmpId IS NULL;


--Ques6 Replace space in name with underscore

SELECT EmpId, REPLACE(FullName, ' ', '_') AS FullNameNoSpace
FROM EmployeeDetails;

--Ques7 Position of character "o" in FullName

SELECT EmpId, FullName, CHARINDEX('o', FullName) AS PositionIndex
FROM EmployeeDetails;

--Ques8 Display EmpId and ManagerId together

SELECT EmpId, ManagerId, CONCAT(EmpId, '-', ManagerId) AS Emp_Manager
FROM EmployeeDetails;

--Ques9 Fetch only first name

SELECT EmpId, LEFT(FullName, CHARINDEX(' ', FullName + ' ') - 1) AS FirstName
FROM EmployeeDetails;

---Ques10 Uppercase name, lowercase city

SELECT EmpId,
       UPPER(FullName) AS FullNameUpper,
       LOWER(City) AS CityLower
FROM EmployeeDetails;


--PART 4

--Ques1 Count occurrences of 'n' in FullName

SELECT FullName,
       (LEN(FullName) - LEN(REPLACE(FullName, 'n', ''))) AS N_Count
FROM EmployeeDetails;


--Ques2 Trim leading/trailing spaces (update)

UPDATE EmployeeDetails
SET FullName = TRIM(FullName);


--Ques3 Employees not working on any project

SELECT d.*
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON d.EmpId = s.EmpId
WHERE s.Project IS NULL;

---Ques4 Salary between 5000–10000

SELECT d.FullName, s.Salary
FROM EmployeeDetails d
INNER JOIN EmployeeSalary s ON d.EmpId = s.EmpId
WHERE s.Salary BETWEEN 5000 AND 10000;


---Ques5 Current date-time

SELECT CURRENT_TIMESTAMP AS CurrentDateTime;

---Ques6 Employee details joined 2020

SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;

---Ques7 Employees having salary record

SELECT d.*
FROM EmployeeDetails d
INNER JOIN EmployeeSalary s ON d.EmpId = s.EmpId;

---Ques8 Project-wise count sorted DESC

SELECT Project, COUNT(EmpId) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project
ORDER BY COUNT(EmpId) DESC;



--Ques9 Names and salary even if salary not present

SELECT d.FullName, s.Salary, s.Variable
FROM EmployeeDetails d
LEFT JOIN EmployeeSalary s ON d.EmpId = s.EmpId;


----Ques10 Join 3 tables


SELECT d.EmpId, d.FullName, s.Project, s.Salary
FROM EmployeeDetails d
INNER JOIN EmployeeSalary s ON d.EmpId = s.EmpId
CROSS JOIN (SELECT 1 AS DummyCol) t;
