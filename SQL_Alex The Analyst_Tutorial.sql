/*Create table for employee demographic and salary*/
CREATE TABLE EmployeeDemographics (
EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

CREATE TABLE EmployeeSalary(
EmployeeID int,
Jobtitle varchar(50),
Salary int
)


/*Insert info into each tables*/
INSERT INTO EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'M'),
(1002, 'Pam', 'Beasley', 30, 'F'),
(1003, 'Dwight', 'Schrute', 29, 'M'),
(1004, 'Angela', 'Martin', 31, 'F'),
(1005, 'Toby', 'Flenderson', 32, 'M'),
(1006, 'Michael', 'Scott', 35, 'M'),
(1007, 'Meredith', 'Palmer', 32, 'F'),
(1008, 'Stanley', 'Hudson', 38, 'M'),
(1009, 'Kevin', 'Malone', 31, 'M')


INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)


/*Select, Where, Group By, Order By*/
SELECT TOP 5*
FROM EmployeeDemographics


SELECT DISTINCT(Gender)
FROM EmployeeDemographics


SELECT COUNT(LastName) AS lastNameCount
FROM EmployeeDemographics


SELECT MAX(Salary) AS maxSalary
FROM EmployeeSalary


SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'Jim'


SELECT *
FROM EmployeeDemographics
WHERE Age >30 AND Gender = 'M'


SELECT *
FROM EmployeeDemographics
WHERE LastName Like 'S%'


SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim', 'Pam', 'Angela', 'Stanley')


SELECT 
	Gender,
	COUNT(Gender) AS num_of_gender
FROM EmployeeDemographics
GROUP BY Gender


SELECT Jobtitle, Salary
FROM EmployeeSalary
ORDER BY Salary DESC



INSERT INTO EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'M'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'M')


INSERT INTO EmployeeSalary VALUES
(1010, NULL, 47000),
(NULL, 'Salesman', 43000)


/*Inner, Right, Left, Full Outer Joins*/
SELECT*
FROM EmployeeDemographics AS demo
INNER JOIN EmployeeSalary AS sal
ON demo.EmployeeID = sal.EmployeeID

SELECT*
FROM EmployeeDemographics AS demo
FULL OUTER JOIN EmployeeSalary AS sal
ON demo.EmployeeID = sal.EmployeeID

SELECT*
FROM EmployeeDemographics AS demo
LEFT OUTER JOIN EmployeeSalary AS sal
ON demo.EmployeeID = sal.EmployeeID

SELECT*
FROM EmployeeDemographics AS demo
RIGHT OUTER JOIN EmployeeSalary AS sal
ON demo.EmployeeID = sal.EmployeeID


SELECT 
	demo.EmployeeID,
	FirstName,
	LastName,
	Jobtitle,
	Salary
FROM EmployeeDemographics AS demo
LEFT OUTER JOIN EmployeeSalary AS sal
ON demo.EmployeeID = sal.EmployeeID


CREATE TABLE wareHouseEmployeeDemographics(
EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)


INSERT INTO wareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'M'),
(1050, 'Roy', 'Anderson', 31, 'M'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'M'),
(1052, 'Val', 'Johnson', 31, 'F')


/*Union, Union All*/
SELECT*
FROM EmployeeDemographics
UNION
SELECT*
FROM wareHouseEmployeeDemographics


SELECT*
FROM EmployeeDemographics
UNION ALL
SELECT*
FROM wareHouseEmployeeDemographics
ORDER BY EmployeeID


/*Case statement*/
SELECT FirstName, LastName, Age,
CASE
	WHEN Age > 30 THEN 'Senior'
	ELSE 'Junior'
END AS 'Status'
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age


SELECT FirstName, LastName, Jobtitle, Salary,
CASE
	WHEN Jobtitle = 'Salesman' THEN Salary + (Salary * 0.1)
	WHEN Jobtitle = 'Accountant' THEN Salary + (Salary * 0.05)
	WHEN Jobtitle = 'HR' THEN Salary + (Salary * 0.000001)
	ELSE Salary + (Salary * 0.03)
END AS 'NewSalary'
FROM EmployeeDemographics AS demo
INNER JOIN EmployeeSalary AS sal
ON demo.EmployeeID = sal.EmployeeID


/*Having clause*/
SELECT Jobtitle, COUNT(Jobtitle)
FROM EmployeeDemographics
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY Jobtitle
HAVING COUNT(Jobtitle)>1


SELECT Jobtitle, AVG(Salary) AS average_salary
FROM EmployeeDemographics AS demo
INNER JOIN EmployeeSalary AS sal
ON demo.EmployeeID = sal.EmployeeID
GROUP BY Jobtitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)


/*Updating, Deleting Data*/
SELECT*
FROM EmployeeDemographics

UPDATE EmployeeDemographics
SET EmployeeID = 1012
WHERE FirstName = 'Holly'


/*Partition By*/
SELECT 
	LastName, 
	FirstName, 
	Gender,
	Salary,
	COUNT(Gender) OVER (PARTITION BY Gender) AS totalGender
FROM EmployeeDemographics AS demo
INNER JOIN EmployeeSalary AS sal
ON demo.EmployeeID = sal.EmployeeID


SELECT 
	LastName, 
	FirstName, 
	Gender,
	Salary,
	COUNT(Gender)
FROM EmployeeDemographics AS demo
INNER JOIN EmployeeSalary AS sal
ON demo.EmployeeID = sal.EmployeeID
GROUP BY 
	LastName, 
	FirstName, 
	Gender,
	Salary


/*Common Table Expression (CTE)*/
WITH CTE_Employee AS
(SELECT
	FirstName,
	LastName,
	Gender,
	Salary,
	COUNT(Gender) OVER (PARTITION BY Gender) AS totalGender,
	AVG(Salary) OVER (PARTITION BY Gender) AS avgsalary
FROM EmployeeDemographics AS demo
INNER JOIN EmployeeSalary AS sal
ON demo.EmployeeID = sal.EmployeeID
WHERE Salary > 45000
)
SELECT *
FROM CTE_Employee


/*Temp Table*/
CREATE TABLE #temp_emp(
employeeID int,
jobtitle varchar(50),
salary int
)

INSERT INTO #temp_emp VALUES
(1001, 'HR', 45000)

SELECT*
FROM #temp_emp


INSERT INTO #temp_emp
SELECT *
FROM EmployeeSalary


DROP TABLE IF EXISTS #temp_emp2
CREATE TABLE #temp_emp2(
jobTitle varchar(50),
employeePerJob int,
AvgAge int,
AvgSalary int)


INSERT INTO #temp_emp2
SELECT
	Jobtitle,
	COUNT(Jobtitle),
	AVG(Age),
	AVG(Salary)
FROM EmployeeDemographics 
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY Jobtitle

SELECT *
FROM #temp_emp2



/*Create Global Table with two ## */
CREATE TABLE ##all_female_employees (
EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

INSERT INTO ##all_female_employees
SELECT*
FROM EmployeeDemographics
WHERE Gender = 'F'

SELECT*
FROM ##all_female_employees



/*Select INTO*/ 
-- It is same function as creating temperary table by using #
SELECT *
INTO testing
FROM EmployeeDemographics
WHERE Gender = 'M'

SELECT *
FROM testing



/*String Functions: TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower*/
CREATE TABLE EmployeeErrors(
EmployeeID varchar(50),
FirstName varchar(50),
LastName varchar(50))


INSERT INTO EmployeeErrors VALUES
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')


SELECT *
FROM EmployeeErrors

-- Using Trim, LTRIM, RTRIM
SELECT EmployeeID, TRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors


-- Using Replace
SELECT LastName, REPLACE(LastName, '- Fired', '') AS FixedLastName
FROM EmployeeErrors


-- Using Substring
SELECT FirstName, SUBSTRING(FirstName, 1, 3) AS ExtractedString
FROM EmployeeErrors


SELECT
	err.FirstName,
	SUBSTRING(err.FirstName, 1, 3),
	demo.FirstName,
	SUBSTRING(demo.FirstName, 1, 3)
FROM EmployeeErrors AS err
INNER JOIN EmployeeDemographics AS demo
ON SUBSTRING(err.FirstName, 1, 3) = SUBSTRING(demo.FirstName, 1, 3)


-- Using Lower or Upper
SELECT FirstName, LOWER(FirstName) AS smallName
FROM EmployeeDemographics


SELECT FirstName, UPPER(FirstName) AS bigName
FROM EmployeeDemographics



/*Stored Procedure*/
CREATE PROCEDURE allEmployees
AS
SELECT *
FROM EmployeeDemographics

EXEC allEmployees



CREATE PROCEDURE employeeGender @Gender varchar(50)
AS
SELECT *
FROM EmployeeDemographics
WHERE Gender = @Gender

EXEC employeeGender @Gender = 'M'



CREATE PROCEDURE tempEmployees
AS
DROP TABLE IF EXISTS #temp_emp2
CREATE TABLE #temp_emp2(
jobTitle varchar(50),
employeePerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #temp_emp2
SELECT
	Jobtitle,
	COUNT(Jobtitle),
	AVG(Age),
	AVG(Salary)
FROM EmployeeDemographics 
INNER JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY Jobtitle

SELECT*
FROM #temp_emp2

EXEC tempEmployees @Jobtitle = 'Accountant'



/*Subqueries*/
SELECT*
FROM EmployeeSalary


--Subquery in Select
SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS averageofAll
FROM EmployeeSalary

--Subquery in From
SELECT a.EmployeeID, averageofAll
FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER () AS averageofAll
		FROM EmployeeSalary) AS a

--Subquery in Where
SELECT EmployeeID, Jobtitle, Salary
FROM EmployeeSalary
WHERE EmployeeID IN (
	SELECT EmployeeID
	FROM EmployeeDemographics
	WHERE Age > 30)
