Create Database ASS_Test

Use Ass_Test
go

/*Question1 
WORKER_
ID
FIRST_NA
ME
LAST_NAM
E
SALARY JOINING_DATE DEPARTMEN
T
001 Monika Arora 100000 2014-02-20 09:00:00 HR
002 Niharika Verma 80000 2014-06-11 09:00:00 Admin
003 Vishal Singhal 300000 2014-02-20 09:00:00 HR
004 Amitabh Singh 500000 2014-02-20 09:00:00 Admin
005 Vivek Bhati 500000 2014-06-11 09:00:00 Admin
006 Vipul Diwan 200000 2014-06-11 09:00:00 Account
007 Satish Kumar 75000 2014-01-20 09:00:00 Account
008 Geetika Chauhan 90000 2014-04-11 09:00:00 Admin
Table – Bonus
WORKER
_REF_ID
BONUS_DATE BONUS_A
MOUNT
1 2016-02-20 00:00:00 5000
2 2016-06-11 00:00:00 3000
3 2016-02-20 00:00:00 4000
1 2016-02-20 00:00:00 4500
2 2016-06-11 00:00:00 3500
Table – Title
WORKER
_REF_ID
WORKER_TITLE AFFECTED_FROM
1 Manager 2016-02-20 00:00:00
2 Executive 2016-06-11 00:00:00
8 Executive 2016-06-11 00:00:00
5 Manager 2016-06-11 00:00:00
4 Asst. Manager 2016-06-11 00:00:00
7 Executive 2016-06-11 00:00:00
6 Lead 2016-06-11 00:00:00
3 Lead 2016-06-11 00:00:00

*/

cREATE SCHEMA QUE1

CREATE TABLE QUE1.WORKER (WORKER_ID INT PRIMARY KEY IDENTITY(001,1),
FIRST_NAME VARCHAR(20),
LAST_NAME VARCHAR(20),
SALARY MONEY,
JOINING_DATE DATETIME,
DEPARTMENT VARCHAR(20))

INSERT INTO QUE1.WORKER
VALUES
('Monika', 'Arora' ,100000 ,'2014-02-20 9:00:00', 'HR'),
('Niharika', 'Verma' ,80000 ,'2014-06-11 9:00:00','Admin'), 
('Vishal', 'Singhal' ,300000,'2014-02-20 9:00:00','HR'),     
('Amitabh', 'Singh' ,500000,  '2014-02-20 9:00:00' ,'Admin'),  
('Vivek', 'Bhati' ,  500000,  '2014-06-11 9:00:00' ,'Admin' ),  
('Vipul', ' Diwan' , 200000 ,  '2014-06-11 9:00:00' ,'Account' ) ,  
('Satish', 'Kumar' , 75000 ,  '2014-01-20 09:00:00' ,'Account' ) ,  
('Geetika', 'Chauhan' ,90000,  '2014-04-11 09:00:00' ,'Admin');   

SELECT * FROM QUE1.WORKER
CREATE TABLE QUE1.BONUS (WORKER_REF_ID INT, 
BONUS_DATE DATETIME, 
BONUS_AMOUNT MONEY,
Foreign Key (WORKER_REF_ID) REFERENCES QUE1.WORKER(WORKER_ID)
)

CREATE TABLE QUE1.Title (WORKER_REF_ID INT,
WORKER_TITLE VARCHAR(20),
AFFECTED_FROM DATETIME,
Foreign Key (WORKER_REF_ID) REFERENCES QUE1.WORKER(WORKER_ID)
)


INSERT INTO QUE1.BONUS
VALUES		   
(1,'2016-02-20 00:00:00', 5000),
(2,'2016-06-11 00:00:00', 3000),
(3,'2016-02-20 00:00:00', 4000),
(1,'2016-02-20 00:00:00', 4500),
(2,'2016-06-11 00:00:00', 3500);

INSERT INTO QUE1.Title
VALUES
(1, 'Manager'   , '2016-02-20 00:00:00'),
(2, 'Executive' , '2016-06-11 00:00:00'),
(8, 'Executive' , '2016-06-11 00:00:00'),
(5, 'Manager'   , '2016-06-11 00:00:00'),
(4,'Asst. Manager', '2016-06-11 00:00:00'),
(7,'Executive' ,'2016-06-11 00:00:00'),
(6,'Lead' ,'2016-06-11 00:00:00'),
(3,'Lead' ,'2016-06-11 00:00:00');

--1.Write an SQL query to print details of the Workers who are also Managers.
SELECT * FROM QUE1.WORKER AS W
INNER JOIN QUE1.Title  AS T ON w.WORKER_ID = T.WORKER_REF_ID
WHERE t.WORKER_TITLE = 'Manager'


--2. Write an SQL query to show only odd rows from Worker table.

SELECT * FROM QUE1.WORKER
WHERE WORKER_ID %2 =1


--3. Write an SQL query to print the name of employees having the highest salary in each department
SELECT w.FIRST_NAME,W.LAST_NAME, DEPARTMENT, SALARY FROM QUE1.WORKER AS W
WHERE W.SALARY IN (SELECT MAX(SALARY) AS MAX_SALARY FROM QUE1.WORKER
GROUP BY DEPARTMENT)


--4. Write an SQL query to fetch three max salaries from a table
SELECT TOP 3 * FROM QUE1.WORKER 
ORDER BY SALARY DESC


/*Que 2.
Write a query identifying the type of each record in the TRIANGLES table using its three side 
lengths. Output one of the following statements for each record in the table:
• Equilateral: It's a triangle with sides of equal length.
• Isosceles: It's a triangle with sides of equal length.
• Scalene: It's a triangle with sides of differing lengths.
• Not A Triangle: The given values of A, B, and C don't form a triangle.
Input Format
The TRIANGLES table is described as follows:
Each row in the table denotes the lengths of each of a triangle's three sides.
*/

CREATE SCHEMA QUE2

CREATE TABLE QUE2.TRIANGLE ( A INT, B INT , C INT )
INSERT INTO QUE2.TRIANGLE
VALUES
(20 , 20, 23 ),
(20 , 20, 20 ),
(20 , 21, 22 ),
(13 , 14, 30 );

SELECT 
CASE 
   WHEN A=B AND B=C 
   THEN 'Equilateral'
   WHEN A=B or A=C or B=C 
   Then 'Isosceles'
   when A!=B and A!=C AND b!=C AND A+B >C AND B+C > A AND A+C >B
   THEN 'SCALENE'
ELSE
'NOT A TRIANGLE'
END AS TYPE_OF_TRIANGLE, A, B, C FROM QUE2.TRIANGLE

CREATE SCHEMA QUE3
CREATE TABLE QUE3.PROFESSION ( NAME VARCHAR(20) , OCCUPATION VARCHAR(20))
INSERT INTO QUE3.PROFESSION
VALUES
( 'Samantha' , 'Doctor' ),
( 'Julia' , 'Actor' ),
( 'Maria' , 'Actor' ),
( 'Meera' , 'Singer' ),
( 'Ashely' , 'Professor' ),
( 'Keety' , 'Professor' ),
( 'Christeen' , 'Professor' ),
( 'Jane' , 'Actor' ),
( 'Jenny' , 'Doctor' ),
( 'Priya' , 'Singer' );

Select Name From QUE3.PROFESSION 

/* Que 4.
The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a 
query to print the hacker_id, name, and total score of the hackers ordered by the descending 
score. If more than one hacker achieved the same total score, then sort the result by ascending 
hacker_id. Exclude all hackers with a total score of from your result.
Input Format
The following tables contain contest data:
• Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker. 
• Submissions: The submission_id is the id of the submission, hacker_id is the id of the 
hacker who made the submission, challenge_id is the id of the challenge for which the 
submission belongs to, and score is the score of the submission.*/

Create schema QUE4
 
CREATE TABLE QUE4.HACKER
(HACKER_ID INT PRIMARY KEY, NAME VARCHAR(20))



Create table QUE4.SUBMISSION
(Submission_id int primary key, hacker_id int, challenge_id int, score int,
foreign key (hacker_id) references QUE4.HACKER ( HACKER_ID))

INSERT INTO QUE4.HACKER
VALUES
(4071  , 'Rose'),
(4806  , 'Angela'),
(26071  , 'Frank'),
(49438  , 'Patrick'),
(74842  , 'Lisa'),
(80305  , 'Kimberly'),
(84072  , 'Bonnie'),
(87868  , 'Michael'),
(92118  , 'Todd'),
(95895, 'Joe');

insert into QUE4.SUBMISSION
values
(67194,74842,63132,76),
(64479,74842,19797,98),
(40742,26071,49593,20),
(17513,4806,49593,32),
(69846,80305,19797,19),
(41002,26071,89343,36);

SELECT * FROM QUE4.HACKER
SELECT * FROM QUE4.SUBMISSION

SELECT H.NAME,SUM(S.SCORE) AS TOTAL_SCORE FROM QUE4.HACKER AS H
INNER JOIN QUE4.SUBMISSION  AS S ON H.HACKER_ID = S.hacker_id
GROUP BY S.hacker_id,H.NAME
ORDER BY TOTAL_SCORE DESC, S.hacker_id

/*You are given three tables: Students, Friends and Packages. Students contains two columns: ID
and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). 
Packages contain two columns: ID and Salary (offered salary in $ thousands per month).*/

CREATE SCHEMA QUE6
CREATE TABLE QUE6.STUDENTS(ID INT PRIMARY KEY, NAME VARCHAR(20))
CREATE TABLE QUE6.FRIENDS (ID INT PRIMARY KEY, FRIEND_ID INT,
FOREIGN KEY(FRIEND_ID) REFERENCES QUE6.STUDENTS(ID))
CREATE TABLE QUE6.PACKAGES (ID INT, SALARY MONEY, FOREIGN KEY(ID) REFERENCES QUE6.FRIENDS(ID))


INSERT INTO QUE6.STUDENTS 
VALUES
(1,'ASHELY'),
(2,'SAMANTHA'),
(3,'JULIA'),
(4,'SCARLET');

INSERT INTO QUE6.FRIENDS
VALUES
(1,2),
(2,3),
(3,4),
(4,1);

INSERT INTO	QUE6.PACKAGES
VALUES
(1,15.20),
(2,10.06),
(3,11.55),
(4,12.12);

SELECT * FROM QUE6.STUDENTS
SELECT * FROM QUE6.FRIENDS
SELECT * FROM QUE6.PACKAGES

SELECT *
FROM QUE6.STUDENTS s
JOIN QUE6.FRIENDS AS F ON s.ID = f.ID
JOIN QUE6.PACKAGES p1 ON f.Friend_ID = p1.ID
JOIN QUE6.PACKAGES p2 ON s.ID = p2.ID
WHERE p1.Salary > p2.Salary
ORDER BY p1.Salary





create schema que7 
CREATE TABLE	que7.Customers(Cutomer_id int primary key identity(1,1),
CutomerName varchar(20),
City varchar(20))


CREATE TABLE que7.orders (orderid  int primary key,  customerid int , 
orderdate date )

insert into que7.Customers
values
('Alice','NewYork'),
('Bob', 'Los Angeles'),
('Charlie' , 'Chicago');

insert into que7.orders
values
(101,1,'2023-01-10'),
(102,2,'2023-02-15'),
(103,1,'2023-02-20');

Select c.CutomerName,
COALESCE(o.OrderDate, '1900-01-01') AS OrderDate
from que7.Customers as c left join 
que7.orders as o on c.Cutomer_id= o.customerid

--ques 8

SELECT E1.EMPLOYEENMAE AS EMPLOYEENAME,
E2.EMPLOYEENMAE AS MANAGERNAME
FROM EMPLOYEES AS E1 
JOIN EMPLOYEES AS E2 ON E1.MANAGERID = E2.EPLOYEEID


--QUES9

--1.

SELECT S.STUDENTNAME, C.CourseName FROM STUDENTS AS S
INNER JOIN ENROLLMENTS AS E ON E.StudentId =S.StudentId
inner join courses as c on e.courseID = c.courseID

--2.
SELECT S.STUDENTNAME, C.CourseName, count(e.studentID) as Total_Courses FROM STUDENTS AS S
INNER JOIN ENROLLMENTS AS E ON E.StudentId =S.StudentId
inner join courses as c on e.courseID = c.courseID
group by e.studentID


--10
use Test
go

Select * from day3.PROJECTS
Select * from day3.EMPLOYEES
Select * from day3.DEPARTMENTS
Select * from day3.EmployeeProjects

Create table day3.EmployeeProjects
(Employeeid int , Project_id int)

Insert into DAY3.EmployeeProjects
values
(1,1),
(2,2),
(1,3),
(3,1),
(2,4);

SELECT  e.FIRSTNAME+ ' '+e.LASTNAME AS NAMEOFEMPLOYEE , D.DEPARTMENTNAME,P.ProjectName  
FROM day3.EMPLOYEES as e 
inner join DAY3.DEPARTMENTS as d on e.DEPARTMENTID = d.DEPARTMENTID
inner join DAY3.EmployeeProjects as ep on e.EPLOYEEID = ep.Employeeid
inner join DAY3.PROJECTS AS P ON P.ProjectID = EP.Project_id


--OR
-- I TRIED IT FIRST WITH sP BUT IT IS NOT WORKING DONT COSIDER IT BUT HELP ME TO FIND MY MISTAKE
CREATE PROCEDURE tspGetEmployee
@emp_id int,
@emp_Name VARCHAR(50) OUTPUT,
@depname VARCHAR(50) OUTPUT,
@project varchar OUTPUT
AS
BEGIN
SELECT  @emp_Name= e.FIRSTNAME+ ' '+e.LASTNAME, @depname= D.DEPARTMENTNAME,@project= P.ProjectName  
FROM day3.EMPLOYEES as e 
inner join DAY3.DEPARTMENTS as d on e.DEPARTMENTID = d.DEPARTMENTID
inner join DAY3.EmployeeProjects as ep on e.EPLOYEEID = ep.Employeeid
inner join DAY3.PROJECTS AS P ON P.ProjectID = EP.Project_id
END

DECLARE @emp_Name VARCHAR(50) OUTPUT,
		@depname VARCHAR(50) OUTPUT,
	    @project varchar OUTPUT

EXEC tspGetEmployee 
		@emp_id = 1,
		@emp_Name VARCHAR(50) OUTPUT,
		@depname VARCHAR(50) OUTPUT,
	    @project varchar OUTPUT;


SELECT @Name AS EmployeeName,
       @Title AS JobTitle,
       @Date AS HireDate;


--11.
CREATE SCHEMA QUE11

CREATE TABLE QUE11.ORDERS(ORDERID INT PRIMARY KEY IDENTITY(1,1), PRODUCTID INT , 
QUANTITY INT,UnitPrice DECIMAL(5,2))
INSERT INTO QUE11.ORDERS
VALUES
(101 , 2 ,10.00 ),
(102 , 3 , 5.00),
(101 , 5 ,8.00 ),
(103 , 1 ,20.00 );

SELECT * FROM QUE11.ORDERS

CREATE FUNCTION udfCalculateTotalPrice(@OrderID INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalPrice DECIMAL(18, 2);

    SELECT @TotalPrice = SUM(Quantity * UnitPrice) 
    FROM QUE11.ORDERS
    WHERE OrderID = @OrderID;

    RETURN @TotalPrice;
END;

Select *, dbo.udfCalculateTotalPrice(orderid)  as total_price from QUE11.ORDERS

cREATE SCHEMA QUE12
CREATE TABLE QUE12.ORDERS(ORDERID INT PRIMARY KEY IDENTITY(1,1),TOTALPRICE DECIMAL(5,2))
INSERT INTO QUE12.ORDERS
VALUES
(25.00 ),
(15.00),
(40.00 ),
(10.00 );



CREATE FUNCTION GetHighValueOrders(@Threshold DECIMAL(18, 2))
RETURNS TABLE
AS
RETURN
(
    SELECT o.OrderID, O.TOTALPRICE AS GREATERTHANTHRESOLD
 
	FROM QUE12.ORDERS AS O
    WHERE O.TOTALPRICE > @Threshold
);

SELECT * FROM DBO.GetHighValueOrders(15.00)

CREATE FUNCTION UDFGetEmployeesByDepartment(@dEPID INT)
RETURNS TABLE
AS 
RETURN
(
 SELECT E.FIRSTNAME+ ' ' +E.LASTNAME AS EMPLOYEENAME, E.DEPARTMENTID
 FROM DAY3.EMPLOYEES AS E
 WHERE  @dEPID =E.DEPARTMENTID
);

SELECT * FROM DBO.UDFGetEmployeesByDepartment(101)


CREATE SCHEMA QUE14

CREATE TABLE QUE14.PRODUCTS(PRODUCTD INT , PRODUCTNAME VARCHAR(20), PRICE MONEY)
CREATE TABLE QUE14.PRODUCTUPDATES(PRODUCTD INT , PRODUCTNAME VARCHAR(20), PRICE MONEY)


INSERT INTO QUE14.PRODUCTS
VALUES
(101,'APPLE',1.00),
(102,'BANANA',0.75),
(103,'ORANGE',0.50);

INSERT INTO QUE14.PRODUCTUPDATES
VALUES
(102,'BANANA',0.80),
(104,'GRAPE',1.20),
(103,'PINEAPPLE',2.50);

SELECT * FROM QUE14.PRODUCTS
SELECT * FROM QUE14.PRODUCTUPDATES

MERGE QUE14.PRODUCTS AS S
USING QUE14.PRODUCTUPDATES AS T
ON (S.PRODUCTID = T.PRODUCTID)

WHEN MATCHED THEN UPDATE SET
T.PRICE = S.PRICE

WHEN NOT MATCHED BY TARGET 
THEN INSERT (PRICE)
VALUES
(S.PRICE);






Pivot Syntax-
SELECT <non-pivoted column>,
    [first pivoted column] AS <column name>,
    [second pivoted column] AS <column name>,
    ...
    [last pivoted column] AS <column name>
FROM
    (<SELECT query that produces the data>)
    AS <alias for the source query>
PIVOT
(
    <aggregation function>(<column being aggregated>)
FOR
[<column that contains the values that will become column headers>]
    IN ( [first pivoted column], [second pivoted column],
    ... [last pivoted column])
) AS <alias for the pivot table>
<optional ORDER BY clause>;
Unpivot Syntax
SELECT VendorID, Employee, Orders
FROM
   (SELECT VendorID, Emp1, Emp2, Emp3, Emp4, Emp5
   FROM pvt) p
UNPIVOT
   (Orders FOR Employee IN
      (Emp1, Emp2, Emp3, Emp4, Emp5)
)AS unpvt; 