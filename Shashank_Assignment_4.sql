--Stored Procedure Practice Questions

/*1.Basic Stored Procedure: Write a simple stored procedure named 
--GetEmployeeCount that returns the total number of employees in the 
"Employees" table.*/

uSE Test
GO
CREATE PROCEDURE spGetEmployeeCount
AS 
BEGIN
SELECT COUNT(ID) AS EmployeeCount FROM DAY3.EMPLOYEE3
END

EXEC spGetEmployeeCount

/* 2.Input Parameters: Create a stored procedure named 
GetEmployeesByDepartment that takes a department name as input and 
returns all the employees who belong to that department. */

USE Test
GO
CREATE PROC GetEmployeesByDepartment
@DEP_NAME NVARCHAR(20)
AS
BEGIN
SELECT  E.EPLOYEEID,E.FIRSTNAME,E.LASTNAME,D.DEPARTMENTNAME FROM DAY3.EMPLOYEES AS e
INNER JOIN DAY3.DEPARTMENTS AS D
ON E.DepartmentID = D.DepartmentiD
WHERE D.DEPARTMENTNAME = @DEP_NAME
END

EXEC GetEmployeesByDepartment @DEP_NAME = 'SALES'


 /* 3. Output Parameters: Write a stored procedure named GetEmployeeInfo 
that takes an employee ID as input and returns the employee's name, job 
title, and hire date using output parameters.*/
USE AdventureWorksDW2017
GO 
CREATE PROCEDURE spGetEmployeeInfo
@emp_id int,
@emp_Name NVARCHAR(50) OUTPUT,
@JobTitle NVARCHAR(50) OUTPUT,
@HireDate DATE OUTPUT
AS
BEGIN
SELECT  @emp_Name = FirstName+ ' '+LastName , @JobTitle = Title, @HireDate = HireDate FROM DimEmployee
WHERE EmployeeKey=@emp_id
END

DECLARE @Name NVARCHAR(50),
        @Title NVARCHAR(50),
        @Date DATE;

EXEC spGetEmployeeInfo @emp_id = 1,
                     @emp_Name = @Name OUTPUT,
                     @JobTitle = @Title OUTPUT,
                     @HireDate = @Date OUTPUT;

SELECT @Name AS EmployeeName,
       @Title AS JobTitle,
       @Date AS HireDate;

-- Error Handling: Create a stored procedure named InsertEmployee that inserts a new employee into the "Employees" table. 
--However, if the insertion fails due to duplicate employee ID or any other reason, the procedure should return an error message.



-- Transactions: Design a stored procedure named TransferFunds that transfers a specified amount from one bank account to another. 
--The procedure should handle transactions to ensure data consistency in case of failures.

Use test
go
Create table a1 ( aid int, bid int, cid int)
Create table b1 (bid int)
create table c1 (cid int)

insert into a1 
values
(1,1,null),
(2,null,null),
(3,2,null),
(4,null,1)

insert into b1 
values
(1),
(2),
(3),
(4);

insert into c1
values
(1),
(2),
(3),
(4);

Select a1.aid, b1.bid, c1.cid
from a1
left join b1 on a1.bid=b1.bid
inner join c1 on a1.cid = c1.cid

Select * from a1
Select * from b1
Select * from c1
Truncate table a
Truncate table b
Truncate table c

--Dynamic SQL: Write a stored procedure named GetEmployeeByFilter that allows the user to search for employees based on different filters, 
--such as name, job title, and department. The procedure should use dynamic SQL to construct the query based on the provided filter values.


-- Recursive Stored Procedure: Implement a stored procedure named GetEmployeeHierarchy that takes an employee ID as input and returns 
--the hierarchical structure of employees under the given employee. Assume that the "Employees" table has a self-referencing foreign key to represent the manager-subordinate relationship.


-- Table-Valued Parameters: Create a stored procedure named InsertEmployees that takes a table-valued parameter containing employee 
--data (employee ID, name, department, etc.) and inserts multiple employees into the "Employees" table in a single call.


-- Returning Resultsets: Write a stored procedure named GetEmployeeProjects that takes an employee ID as input and returns two result sets:
--1.The first result set should contain the employee's details (name, department, etc.).
--2.The second result set should contain all the projects the employee is currently working on.
--3.Dynamic Resultsets: Design a stored procedure named GetEmployeesByProject that takes a project ID as input and returns the employees who are working on that project. The number of columns and their data types should be dynamic, based on the number and types of attributes in the "Employees" table.

--User Defined Functions Practice Questions

--1.	Create a UDF named GetFullName that concatenates the first name and last name of an employee with a space in between and 
--Write a query to get the full names of all employees using the GetFullName UDF.
Use Test
go
Create Function udfFullNameEmp(@Limit int)
returns Table
as 
return 
(
  Select top(@Limit) first_name + ' ' + last_name as Full_Name from DAY3.Employee
);

Select * from udfFullNameEmp(4)


--2.	Create a UDF named GetSalaryGrade that takes an employee's salary as input and returns their salary grade based on the following conditions:
--a.	If the salary is less than 50000, return 'Low'.
--b.	If the salary is between 50000 and 80000 (inclusive), return 'Medium'.
--c.	If the salary is greater than 80000, return 'High'.
--d.	Write a query to get the EmployeeID, FullName, and SalaryGrade for all employees using the GetSalaryGrade UDF.
Use Test
go
Create function udfGetSalaryGrade(@SALARY MONEY)
returns Table
as 
return 
(
Select Id,Name, Department, 
case 
    when @SALARY < 5000 THEN 'LOW'
	WHEN @SALARY BETWEEN 5000 AND 8000 THEN 'MEDIUM'
	ELSE 'HIGH'
end AS SALARYGRADE
from [DAY3].[EMPLOYEE3]
WHERE SALARY = @SALARY

);

SELECT * FROM udfGetSalaryGrade(5000)
SELECT * FROM udfGetSalaryGrade(15000)

--3.	Create a UDF named GetAverageSalary that calculates and returns the average salary of all employees and Write a query to get the average salary of all employees using the GetAverageSalary UDF.
USE Test
GO
CREATE FUNCTION udfGetAverageSalary()
RETURNS INT
AS BEGIN

RETURN(SELECT AVG(SALARY) FROM [DAY3].[EMPLOYEE3])

END;

SELECT dbo.udfGetAverageSalary() AS AvgSalary_of_Employees

--4.	Create a Scalar UDF to calculate the discounted price for a product. The discount percentage is 10% and Use the Scalar UDF to get the discounted prices for all products.
Use AdventureWorksLT2017
go
CREATE FUNCTION dbo.udfGetDiscountedPrice (@originalPrice FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @discountPercentage FLOAT = 0.10; 
	DECLARE @discountedPrice FLOAT;
    SET @discountedPrice = @originalPrice - (@originalPrice * @discountPercentage);

    RETURN @discountedPrice;
END;


SELECT Name as ProductName, ListPrice , dbo.udfGetDiscountedPrice(ListPrice) AS DiscountedPrice
FROM [SalesLT].[Product]



--5.	Create a Table-Valued UDF to return all products within a specific price range and Use the Table-Valued UDF to get products within a price range.
Create Function udfPricceBetweenRange(@limitlow money, @limithigh money)
returns table
as
return
(

Select P.Name as ProductName, P.ListPrice as Pricce from SalesLT.Product as P
where P.ListPrice between @limitlow and @limithigh
);

Select * from udfPricceBetweenRange(500, 1000)

--6.	Create an Inline Table-Valued UDF to get all products in a specific category and Use the Inline Table-Valued UDF to get all products from a specific category.
USE AdventureWorksLT2017
GO
create function udfSpecificCategory( @category varchar(50))
returns table 
as 
Return
(
	Select PC.Name as CategoryName, P.Name as ProductName from SalesLT.ProductCategory as PC 
	inner join SalesLT.Product as P on PC.ProductCategoryID = P.ProductCategoryID
	where PC.Name = @category
);

Select * from dbo.udfSpecificCategory('Vests')

uSE Test
GO


--- Index Practice
CREATE INDEX SALARIED_INDEX
ON DAY3.EMPLOYEE3(SALARY ASC)


DROP INDEX SALARIED_INDEX ON  DAY3.EMPLOYEE3

EXECUTE sp_helpindex 'DAY3.EMPLOYEE3'

SELECT * FROM [DAY3].[EMPLOYEE3]

-- 