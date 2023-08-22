/*Que 1. You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.
Grades contains the following data:
Grade 1 for marks 0-9
Grade 2 for marks 10-19 and so on.
Similarly Grade 10 for marks 90-100
 
Write a query to Generate a report containing three columns: Name, Grade and Mark. Don’t print the NAMES of those students who received a grade lower than 8.
The report must be in descending order by grade -- i.e., higher grades are entered first.
If there is more than one student with the same grade (8-10) assigned to them, order those students by their name alphabetically.
Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those students by their marks in ascending order.
Sample Input                                                               
Grades:                                                                          
Grade	Min_Mark	Max_Mark
1	0	9
2	10	19
3	20	29
4	30	39
5	40	49
6	50	59
7	60	69
8	70	79
9	80	89
10	90	100
		
		
		
		
Students:-		
ID	Name	Marks
1	IronMan	83
2	Captain	77
3	Thor	100
4	Scarlett	68
5	Hulk	63
6	DrStrange	87
		

Note
Print "NULL" as the name if the grade is less than 8.
*/

USE Test
GO
CREATE TABLE STUDENTS (
ID INT PRIMARY KEY NOT NULL DEFAULT 0,
    Name VARCHAR(50) NOT NULL,
    Marks INT NOT NULL
);
CREATE TABLE Grades (
    Grade INT PRIMARY KEY,
    Lower_Mark INT,
    Upper_Mark INT
);

INSERT INTO Grades (Grade, Lower_Mark, Upper_Mark)
VALUES
    (1, 0, 9),
    (2, 10, 19),
    (3, 20, 29),
    (4, 30, 39),
    (5, 40, 49),
    (6, 50, 59),
    (7, 60, 69),
    (8, 70, 79),
    (9, 80, 89),
    (10, 90, 100);

INSERT INTO Students (ID, Name, Marks)
VALUES
     (1,'IronMan',83),
	 (2,'Captain',77),
	 (3,'Thor',100),
	 (4,'Scarlett',68),
	 (5,'Hulk',63),
	 (6,'DrStrange',87);


SELECT
    CASE 
        WHEN g.Grade < 8 THEN NULL
        ELSE s.Name
    END AS Name,
    g.Grade, s.Marks
FROM STUDENTS s JOIN Grades g ON s.Marks BETWEEN g.Lower_Mark AND g.Upper_Mark
WHERE g.Grade >= 8
UNION ALL
SELECT NULL AS Name, g.Grade, s.Marks
FROM Students s JOIN Grades g ON s.Marks BETWEEN g.Lower_Mark AND g.Upper_Mark
WHERE g.Grade < 8
ORDER BY g.Grade DESC, Name,s.Marks ASC;

/* 
Que 2. 
Employee table
employee_id	first_name	last_name	manager_id
4529	Nancy	Young	4125
4238	John	Simon	4329
4329	Martina	Candreva	4125
4009	Klaus	Koch	4329
4125	Mafalda	Ranieri	NULL
4500	Jakub	Hrabal	4529
4118	Moira	Areas	4952
4012	Jon	Nilssen	4952
4952	Sandra	Rajkovic	4529
4444	Seamus	Quinn	4329
*/
use test
go
CREATE SCHEMA DAY3
Create table DAY3.Employee 
(Employee_id int not null primary key, first_name varchar(50) not null, last_name varchar(50) not null, manager_id int )

insert into DAY3.Employee
values
(4529,'	Nancy',	'Young',	4125),
(4238,'	John'	,'Simon',	4329),
(4329,'	Martina',	'Candreva',	4125),
(4009,'	Klaus',	'Koch'	,4329),
(4125,'	Mafalda',	'Ranieri',	NULL),
(4500,'	Jakub',	'Hrabal',	4529),
(4118,'	Moira',	'Areas',	4952),
(4012,'	Jon',	'Nilssen',	4952),
(4952,'	Sandra',	'Rajkovic',	4529),
(4444,'	Seamus','Quinn',	4329);

--2.1.	Count all employees under each manager
SELECT E1.manager_id AS MANAGER_ID,
E2.first_name AS MANAGER_FIRSTNAME, E2.last_name AS MANAGER_LASTNAME,COUNT(*) AS Employee_under_them
FROM DAY3.EMPLOYEE AS E1
JOIN DAY3.EMPLOYEE AS E2 ON E1.manager_id = E2.Employee_id 
GROUP BY e1.manager_id,E2.first_name,e2.last_name
order by Employee_under_them desc

--2.2.	Find All Direct Subordinates Under Each Manager

SELECT E1.Employee_id, E1.first_name AS EMPLOYEE_FIRSTNAME, E1.last_name AS EMPLOYEE_LASTNAME,E1.manager_id AS MANAGER_ID,
E2.first_name AS MANAGER_FIRSTNAME, E2.last_name AS MANAGER_LASTNAME
FROM DAY3.EMPLOYEE AS E1
JOIN DAY3.EMPLOYEE AS E2 ON E1.manager_id = E2.Employee_id 

SELECT * FROM DAY3.EMPLOYEE
--2.3.	Find Both Direct and Indirect Subordinates Under Each Manager


/*Ques 3*/

Use Test
go
Create TABLE DAY3.SALESMAN (SALESMAN_ID INT NOT NULL PRIMARY KEY DEFAULT 0, NAME VARCHAR(50) NOT NULL, 
CITY VARCHAR(50) NOT NULL, COMMISION float NOT NULL)

INSERT INTO DAY3.SALESMAN (SALESMAN_ID,NAME, CITY, COMMISION)
VALUES
(5001,'James Hoog','New York',0.15),
(502,'Nail Knite','Paris',0.13),
(5005,'Pit Alex','London',0.11),
(5006,'Mc Lyon' ,'Paris',0.14),
(5007,'Paul Adam','Rome',0.13),
(5003,'Lauson Hen','San Jose',0.12);

Create table DAY3.Customer 
(Customer_id int not null primary key default 0,
Cust_name varchar(50) not null,
City varchar(50) not null,
Grade int not null, 
SALESMAN_ID INT
);

INSERT INTO DAY3.Customer (Customer_id,Cust_name,City,Grade,SALESMAN_ID)
VALUES
(3002,'Nick Rimando ','New York ', 100, 5001),
(3007,'Brad Davis ','New York ', 200, 5001),
(3005,'Graham Zusi ','California ', 200, 5001),
(3008,'Julian Green','London ', 300, 5002),
(3004,'Fabian Johnson ','Paris ', 300, 5002),
(3009,'Geoff Cameron ','Berlin ', 100, 5003),
(3003,'Jozy Altidor ','Moscow ', 200, 5007);

--3.1	Write a SQL query to find the salesperson and customer who reside in the same city. Return Salesman, cust_name and city.
Select Sm.NAME as  Salesmaname, C.Cust_name, C.CITY from DAY3.SALESMAN as Sm
inner join DAY3.Customer as C on Sm.CITY = C.City

--3.2 2.	Write a SQL query to find salespeople who received commissions of more than 12 percent from the company. 
--Return Customer Name, customer city, Salesman, commission.

Select  C.Cust_name, C.CITY,Sm.NAME as  Salesmaname, Sm.COMMISION from DAY3.SALESMAN as Sm
inner join DAY3.Customer as C on Sm.SALESMAN_ID = C.SALESMAN_ID
where COMMISION>0.12

/*Que 4.
Table – EmployeeInfo
EmpId	Project	Salary
1	A	1000
2	B	2000
3	A	3000
4	D	4000
5	E	5000
6	F	6000
7	B	7000

Table – EmployeeSalary
EmpId	Name	Manager
1	AA	X
2	BB	Y
3	CC	Z
4	DD	X
5	EE	Y
6	FF	Z
7	GG	X
*/

Use Test
go 
Create table Day3.EmployeeSalary 
(EmpId int primary key not null,
Project Char not null,
Salary money not  null)

Insert into DAY3.EmployeeSalary 
Values
(1,'A',1000),
(2,'B',2000),
(3,'A',3000),
(4,'D',4000),
(5,'E',5000),
(6,'F',6000),
(7,'B',7000);

Create table Day3.Employeeinfo
(EmpId int primary key not null,
Name VarChar(10) not null,
Manager Char not  null)

Insert into DAY3.Employeeinfo
values
(1,'AA','X'),
(2,'BB','Y'),
(3,'CC','Z'),
(4,'DD','X'),
(5,'EE','Y'),
(6,'FF','Z'),
(7,'GG','X');

--1. Sum of salary of Employee who works under Supervisor “X”.

SELECT SUM(ES.Salary) AS SUM_OF_SALARY
FROM DAY3.EmployeeSalary AS ES
INNER JOIN DAY3.Employeeinfo AS EI ON ES.EmpId = EI.EmpId
WHERE Manager = 'X'

--2. Name of Employees whose salary is above average.
SELECT  EI.Name
FROM DAY3.Employeeinfo AS EI
INNER JOIN DAY3.EmployeeSalary AS ES ON EI.EmpId = ES.EmpId
WHERE ES.Salary > (SELECT AVG(Salary) FROM DAY3.EmployeeSalary)

--3.Details of Employees who works on Project “A” and “E” or their manager is “X” and “Y”.
SELECT *
FROM DAY3.Employeeinfo AS EI
INNER JOIN DAY3.EmployeeSalary AS ES ON EI.EmpId = ES.EmpId
WHERE ES.Project IN ('A','E') OR EI.Manager IN ('X','Y')

/*Que 5. 
Consider the following example datasets:
Table: Employees
EmployeeID	FirstName	LastName	DepartmentID
1	John	Doe	101
2	Jane	Smith	102
3	Mike	Johnson	101
4	Emily	Brown	103
Table: Departments
DepartmentID	DepartmentName
101	Sales
102	Marketing
103	Finance
•	INNER JOIN: Write a query to display the FirstName, LastName, and DepartmentName of employees along with their corresponding department names. Exclude employees who are not assigned to any department.
•	LEFT JOIN: Write a query to display the FirstName, LastName, and DepartmentName of all employees, including those who are not assigned to any department. Display NULL for the DepartmentName for employees without a department.
•	RIGHT JOIN: Write a query to display the DepartmentName and the corresponding employee (FirstName and LastName) in the Marketing department. Include the departments even if there are no employees assigned to them.
•	FULL JOIN: Write a query to display the FirstName, LastName, and DepartmentName of all employees and all departments, including those without a match. Display NULL for the FirstName and LastName of departments without any employees.
•	Self-Join: Consider an additional column in the Employees table: ReportsTo (EmployeeID of the manager). Write a query to display the employee's FirstName, LastName, and the FirstName and LastName of their manager.
•	Multiple Joins: Consider an additional table: Projects
Table: Projects
ProjectID	ProjectName	EmployeeID
1	Project A	1
2	Project B	2
3	Project C	3
4	Project D	1
•	Write a query to display the FirstName, LastName, DepartmentName, and ProjectName for each employee who is assigned to a project. If an employee is not assigned to any project, still display their FirstName, LastName, and DepartmentName.
•	Join with Aggregation: Write a query to find the number of employees in each department. Display the DepartmentName and the number of employees in that department.
•	Using JOIN with WHERE Clause: Write a query to find the FirstName, LastName, and DepartmentName of employees working in the Sales department (DepartmentID = 101).
*/

USE Test
GO
CREATE TABLE DAY3.EMPLOYEES 
(EPLOYEEID INT PRIMARY KEY NOT NULL,  
FIRSTNAME VARCHAR(10) NOT NULL,
LASTNAME VARCHAR(10) NOT  NULL,
DEPARTMENTID INT NOT NULL
)

INSERT INTO DAY3.EMPLOYEES
VALUES
(1,'John ', 'Doe ', 101),
(2,'Jane ', 'Smith ',102 ),
(3,'Mike ', 'Johnson ', 101),
(4,'Emily ', 'Brown ', 103);


Create table DAY3.DEPARTMENTS (DEPARTMENTID INT PRIMARY KEY , DEPARTMENTNAME VARCHAR(20) )
INSERT INTO DAY3.DEPARTMENTS
VALUES
(101 ,'SALES'),
(102 ,'MARKETING'),
(103 ,'FINANCE');

--•	INNER JOIN: Write a query to display the FirstName, LastName, and DepartmentName of employees along with their corresponding department names. 
--Exclude employees who are not assigned to any department.

SELECT E.FIRSTNAME,E.LASTNAME,D.DEPARTMENTNAME 
FROM DAY3.EMPLOYEES AS E
INNER JOIN DAY3.DEPARTMENTS AS D ON E.DEPARTMENTID =D.DEPARTMENTID

--Write a query to display the FirstName, LastName, and DepartmentName of all employees, including those who are not assigned to any department. 
--Display NULL for the DepartmentName for employees without a department.
SELECT E.FIRSTNAME,E.LASTNAME,D.DEPARTMENTNAME 
FROM DAY3.EMPLOYEES AS E
LEFT JOIN DAY3.DEPARTMENTS AS D ON E.DEPARTMENTID = D.DEPARTMENTID

-- RIGHT JOIN: Write a query to display the DepartmentName and the corresponding employee (FirstName and LastName) in the Marketing department. 
--Include the departments even if there are no employees assigned to them.
SELECT E.FIRSTNAME,E.LASTNAME,D.DEPARTMENTNAME 
FROM DAY3.EMPLOYEES AS E
RIGHT JOIN DAY3.DEPARTMENTS AS D ON E.DEPARTMENTID = D.DEPARTMENTID
WHERE D.DEPARTMENTNAME = 'MARKETING';

--fuLL JOIN
SELECT E.FIRSTNAME,E.LASTNAME,D.DEPARTMENTNAME 
FROM DAY3.EMPLOYEES AS E
FULL OUTER JOIN DAY3.DEPARTMENTS AS D ON E.DEPARTMENTID = D.DEPARTMENTID

--•	Self-Join: Consider an additional column in the Employees table: ReportsTo (EmployeeID of the manager). 
--Write a query to display the employee's FirstName, LastName, and the FirstName and LastName of their manager.

ALTER TABLE DAY3.EMPLOYEES
ADD REPORTSTO INT NOT NULL DEFAULT 0

UPDATE DAY3.EMPLOYEES SET REPORTSTO = 3 WHERE EMPLOYEES.EPLOYEEID = 1

SELECT E1.FIRSTNAME AS EMPLOYEEFIRSTNMAE, E1.LASTNAME AS EMPLOYEELASTNAME,
E2.FIRSTNAME AS FIRSTNAMEMANAGER, E2.LASTNAME AS LASTNAMEMANAGER
FROM DAY3.EMPLOYEES AS E1 
JOIN DAY3.EMPLOYEES AS E2 ON E1.REPORTSTO =E2.EPLOYEEID

SELECT * FROM DAY3.EMPLOYEES

-- •	Multiple Joins: Consider an additional table: Projects
/* Table: Projects
ProjectID	ProjectName	EmployeeID
1	Project A	1
2	Project B	2
3	Project C	3
4	Project D	1
•	Write a query to display the FirstName, LastName, DepartmentName, and ProjectName for each employee who is assigned to a project. If an employee is not assigned to any project, still display their FirstName, LastName, and DepartmentName.
•	Join with Aggregation: Write a query to find the number of employees in each department. Display the DepartmentName and the number of employees in that department.
•	Using JOIN with WHERE Clause: Write a query to find the FirstName, LastName, and DepartmentName of employees working in the Sales department (DepartmentID = 101).


*/
USE Test
GO
CREATE TABLE DAY3.PROJECTS 
(ProjectID INT PRIMARY KEY,	
ProjectName	VARCHAR(20),
EmployeeID INT)
INSERT INTO DAY3.PROJECTS
VALUES
(1, 'Projects A', 1),
(2, 'Projects B ',2 ),
(3, 'Projects C', 3),
(4, 'Projects D', 1);

--•	Write a query to display the FirstName, LastName, DepartmentName, and ProjectName for each employee who is assigned to a project. 
--If an employee is not assigned to any project, still display their FirstName, LastName, and DepartmentName.

SELECT E.FIRSTNAME,E.LASTNAME,D.DEPARTMENTNAME, P.ProjectName 
FROM DAY3.EMPLOYEES AS E
RIGHT JOIN DAY3.DEPARTMENTS AS D ON E.DEPARTMENTID = D.DEPARTMENTID
FULL OUTER JOIN DAY3.PROJECTS AS P ON E.EPLOYEEID = P.EmployeeID

--Join with Aggregation: Write a query to find the number of employees in each department. 
--Display the DepartmentName and the number of employees in that department.

SELECT D.DEPARTMENTNAME, COUNT(*) AS EMPLOYEESINDEPARTMENT
FROM DAY3.EMPLOYEES AS E
RIGHT JOIN DAY3.DEPARTMENTS AS D ON E.DEPARTMENTID = D.DEPARTMENTID
GROUP BY D.DEPARTMENTNAME

SELECT * FROM DAY3.EMPLOYEES
SELECT * FROM DAY3.DEPARTMENTS
SELECT * FROM DAY3.PROJECTS

--•	Using JOIN with WHERE Clause: Write a query to find the FirstName, LastName, and 
--DepartmentName of employees working in the Sales department (DepartmentID = 101).


SELECT E.FIRSTNAME, E.LASTNAME,D.DEPARTMENTNAME, D.DEPARTMENTID 
FROM DAY3.EMPLOYEES AS E
INNER JOIN DAY3.DEPARTMENTS AS D ON E.DEPARTMENTID = D.DEPARTMENTID
WHERE d.DEPARTMENTID = 101

/*Solve the below Queries using this data set.
Table Name: Employee
Id	Name	Department	Salary
1	Vikas	CS	10000
2	Praveen	CS	10000
3	Abhishek	IT	15000
4	Aakash	EC	5000
5	Vishal	EC	20000
6	Sunil	NULL	25000
7	Vikrant	NULL	2000
*/


--1. Create Table & Insert Data
USE TEST
GO 
CREATE TABLE DAY3.EMPLOYEE3
(Id INT PRIMARY KEY NOT NULL, Name VARCHAR(20) NOT NULL, Department VARCHAR(10) DEFAULT NULL,Salary MONEY NOT NULL)
INSERT INTO DAY3.EMPLOYEE3(Id,	Name,	Department,	Salary)
VALUES
(1, 'Vikas ', 'CS' , 10000),
(2, 'Praveen ', 'CS' ,10000),
(3, 'Abhishek ', 'IT' ,15000),
(4, 'Aakash ', 'EC' , 5000),
(5, 'Vishal ', 'EC' , 20000),
(6, 'Sunil ',NULL, 25000),
(7, 'Vikrant ',NULL, 2000);

--2. Select all the employees in the table in the order of highest to lowest salary if the salary is the same then sort it on the name A-Z.
SELECT * FROM DAY3.EMPLOYEE3
ORDER BY Salary DESC, Name 

--3.	List all the employees the Name start with ‘A’ and end with ‘K’.
SELECT * FROM DAY3.EMPLOYEE3
WHERE Name LIKE 'A%K'

--4.	List all the employees their name starts with ‘V’ OR end with ‘S’.
SELECT Name FROM DAY3.EMPLOYEE3
WHERE Name LIKE 'V%' OR NAME LIKE '%S'

--5.	List all the employees who have 4th Character as ‘A’ in the Name.
SELECT *
FROM DAY3.EMPLOYEE3
WHERE SUBSTRING(Name, 4, 1) = 'A';

--6.	List all the employees having salary between 5000 & 15000.

SELECT  * FROM DAY3.EMPLOYEE3
WHERE Salary BETWEEN 5000 AND 15000

--7.	List all the employees having salary >5000 & Salary <15000.
SELECT  * FROM DAY3.EMPLOYEE3
WHERE Salary > 5000 AND Salary < 15000 

--8.	List all the employees that have department.
SELECT  * FROM DAY3.EMPLOYEE3
WHERE Department IS NOT NULL

--9.	Select all the employees that do not have a department.
SELECT  * FROM DAY3.EMPLOYEE3
WHERE Department IS NULL

--10.	List all the employees where salary >10000 or name starts with ‘A’ with the department or does not have department. 
SELECT  * FROM DAY3.EMPLOYEE3
WHERE Salary > 10000 OR Name LIKE 'A%'

--11.	Order of execution of select query clause. 
--Solution 
/* The execution order of a SQL SELECT query involves several clauses and steps.
Here's a breakdown of the typical order of execution for a basic SELECT query:

1. **FROM Clause:** The query begins with the FROM clause, where you specify the table(s) from which you want to retrieve data.

2. **JOIN Clause:** If there are any JOIN operations in your query, they are performed next. JOINs combine data from multiple tables based on specified conditions.

3. **WHERE Clause:** The WHERE clause filters the rows returned by the FROM and JOIN clauses based on specified conditions. Rows that don't satisfy the conditions are excluded.

4. **GROUP BY Clause:** If you use GROUP BY, the query groups the rows that have the same values in specified columns. This is typically used with aggregate functions like COUNT, SUM, AVG, etc.

5. **HAVING Clause:** If you use GROUP BY, the HAVING clause filters the grouped rows based on specified conditions. It's similar to the WHERE clause but operates on grouped data.

6. **SELECT Clause:** The SELECT clause specifies which columns you want to retrieve from the table(s). If you're using aggregate functions, this is where they are applied.

7. **DISTINCT Clause:** If you use the DISTINCT keyword, it eliminates duplicate rows from the result set.

8. **ORDER BY Clause:** The ORDER BY clause sorts the result set based on specified columns and directions (ASC or DESC).

9. **LIMIT / OFFSET / FETCH Clause:** If you're working with databases that support it, these clauses allow you to limit the number of rows returned or skip a certain number of rows.

*/

--12.	List system function and identify their use cases.




--13.	Select count of employees that start with same letters. 
SELECT LEFT(Name, 1) AS FirstLetter, COUNT(*) AS EmployeeCount
FROM DAY3.EMPLOYEE3
GROUP BY LEFT(Name, 1)
ORDER BY FirstLetter;  

--14.	Select count of employee for initial character of the name where count is >1 and salary are greater than 5000.
SELECT LEFT(Name, 1) AS FirstLetter, COUNT(*) AS EmployeeCount
FROM DAY3.EMPLOYEE3
WHERE Salary > 5000
GROUP BY LEFT(Name, 1)
HAVING COUNT(*) > 1 

--15.	Select the count of an employee for the initial character of the name where the count is >1 and salary less than 5000.
SELECT LEFT(Name, 1) AS FirstLetter, COUNT(*) AS EmployeeCount
FROM DAY3.EMPLOYEE3
WHERE Salary < 5000
GROUP BY LEFT(Name, 1)
HAVING COUNT(*) > 1 

--16.	List of all employees in the ascending order of department and descending order of salary. (Treat NULL as unknown) 
SELECT ID,NAME,ISNULL(Department,'UNKNOWN') AS department, Salary FROM DAY3.EMPLOYEE3
ORDER BY Department, Salary DESC 

--17.	List of all employees in the descending order of department and descending order of salary. (Treat NULL as unknown) 
SELECT ID,NAME,ISNULL(Department,'UNKNOWN') AS department, Salary FROM DAY3.EMPLOYEE3
ORDER BY Department DESC, Salary DESC 

--18.	Get department wise Max. Salary and Min. Salary. 
SELECT E.Department, MAX(SALARY) AS MAX_SALARY, MIN(SALARY) MIN_SALARY FROM DAY3.EMPLOYEE3 AS E
GROUP BY E.Department

--19.	List of employees where Max. Salary <20000 and Min. Salary >5000.
SELECT * FROM DAY3.EMPLOYEE3
WHERE Department IN (SELECT Department FROM DAY3.EMPLOYEE3 GROUP BY Department HAVING MAX(SALARY) < 20000 AND MIN(SALARY) > 5000)



