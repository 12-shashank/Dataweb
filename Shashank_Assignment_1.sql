/*Que 1. Create a Database with Name “Test”*/

Create Database Test;

/*QUE 2. Create a Schema under the Database Test with Name “TestSchema”*/

Use Test
Create Schema TestSchema

/*Que 3. Create a Table with Name “Students” in “Test” Database with scheme “TestSchema”. Table will should have following columns – StudentId, Name, DOB, AdmissionDate.*/
Create Table TestSchema.Students (StudentId int primary Key Not Null,
Name varchar(50) Not Null, DOB Date Not Null, AdmissionDate date not null);

/*Que 4. 
1.	Create Table Employee Containing Columns EmployeeId, Name, Salary, ManagerId, JobRole and insert the data.
2.	Add Columns in Employee Table Mail_id and Grade and insert the data for two newly added columns.
3.	Truncate the Employee Table.
4.	Delete a specific record from a table.
5.	DROP the Employee Table.
*/
--1.
Create Table Employee(EmployeeId int primary Key Not Null Default 0, 
E_name varchar(50) not null, Salary int not null, ManagerId int Not Null, 
JobRole varchar(20) not Null);

Insert into Employee (EmployeeId,E_name, Salary, ManagerId,JobRole)
values
(1,'Ram' ,10000,3,'Intern'),
(2,'shyam',8000,1,'Junior_intern'),
(3,'Mohan',15000,4,'Developer'),
(4,'Jon',20000,0,'head');

--2.
Alter table Employee 
add Mail_id varchar(50), Grade char;

UPDATE Employee SET Mail_id = 'ram@g.com', Grade = 'C' WHERE EmployeeId=1;
UPDATE Employee SET Mail_id = 'syam@g', Grade = 'C' WHERE EmployeeId=2;
UPDATE Employee SET Mail_id = 'moh@g.com', Grade = 'B' WHERE EmployeeId=3;
UPDATE Employee SET Mail_id = 'jon@g.com', Grade = 'A' WHERE EmployeeId=4;

--4.

Delete from Employee where EmployeeId=1;

--3.
Truncate Table Employee

--5.

DROP TABLE Employee

/*
Que 5. Write an Update statement change the Supplier_name to google for id 600,700 and 800*/

Create Table TestSchema.Supplier (Supplier_id int not null Primary key,
Supplier_name varchar(50) not null,
City varchar(20) not null,
State varchar(30) not null);

Insert into TestSchema.Supplier (Supplier_id,Supplier_name, City,State)
values
(100,'Microsoft', 'Redmond', 'Washington'),
(200,'Google', 'Mountain View', 'Califonia'),
(300, 'Oracle', 'Redwood City','Califonia'),
(400,'Kimberly-Clark', 'Irving', 'Texas'),
(500,'Tyson Foods', 'Springdale' , 'Arkansas'),
(600, 'SC Johnson',	'Racine',	'Wisconsin'),
(700,'Dole Food Company','Westlake Village','California'),
(800,'Flowers Foods','Thomasville','Georgia'),
(900,'Electronic Arts',	'Redwood City','California');

Select * from TestSchema.Supplier

Update  TestSchema.Supplier Set supplier_name = 'Google' 
WhERE Supplier_id IN (600,700,800) 
 
 Select * from TestSchema.Supplier

/*Que 6. Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than $2000 per month 
who have been employees for less than 10 months. Sort your result by ascending employee_id.
Input- The Employee table containing employee data for a company is described as follows:
*/

CREATE TABLE TestSchema.Employee (Emp_id int Not Null Primary Key, E_name varchar(50) not null, month int not null,Salary int not null);



Insert into TestSchema.Employee( Emp_id, E_name,month, Salary)
Values
(12228,	'Rose', 15, 1968),
(33645,	'Angela', 1, 3443),
(45692,	'Frank', 17, 1608),
(56118,	'Patrick',7, 1345),
(59725,	'Lisa',	11,	2330),
(74197,	'Kimberly',	16, 4372),
(78454,	'Bonnie', 8, 1771),
(83565,	'Michael', 6, 2017),
(98607,	'Todd', 5, 3396),
(99989,	'Joe', 9, 3573);


Select E_name from TestSchema.Employee
where Salary > 2000 and month < 10
order by Emp_id ;

/* Solve these Following Queries by Using Adventure Works Database
1.	List of all customers
2.	list of all customers where company name ending in N
3.	list of all customers who live in Berlin or London
4.	list of all customers who live in UK or USA
5.	list of all products sorted by product name.
6.	list of all products where product name starts with an A
7.	List of customers who ever placed an order.
8.	list of Customers who live in London and have bought chain.
9.	List of customers who never place an order.
10.	List of customers who ordered Tofu.
11.	Details of first order of the system
12.	Find the details of most expensive order date.
13.	For each order get the OrderID and Average quantity of items in that order
14.	For each order get the orderID, minimum quantity and maximum quantity for that order
15.	Get a list of all managers and total number of employees who report to them.
16.	Get the OrderID and the total quantity for each order that has a total quantity of greater than 300
17.	list of all orders placed on or after 1996/12/31
18.	list of all orders shipped to Canada
19.	list of all orders with order total > 200
20.	List of countries and sales made in each country
*/

USE AdventureWorksLT2017
--1.
sELECT * FROM [SalesLT].[Customer]
--2.
sELECT * FROM [SalesLT].[Customer]
where  CompanyName like '%n'
--3.
Select SC.CustomerID, SC.FirstName, SC.MiddleName, SC.LastName, SA.City 
from SalesLT.Customer as SC
inner join SalesLT.CustomerAddress as SCA
on SC.CustomerID= SCA.CustomerID 
inner join SalesLT.Address as SA
on SCA.AddressID = SA.AddressID
where SA.City in ('London','Berlin') 

/*or*/
Select SC.CustomerID, SC.FirstName, SC.MiddleName, SC.LastName, SA.City 
from SalesLT.Customer as SC
inner join SalesLT.CustomerAddress as SCA
on SC.CustomerID= SCA.CustomerID 
inner join SalesLT.Address as SA
on SCA.AddressID = SA.AddressID
where SA.City='London' or SA.City = 'Berlin'

--4.
Select SC.CustomerID, SC.FirstName, SC.MiddleName, SC.LastName, SA.CountryRegion
from SalesLT.Customer as SC
inner join SalesLT.CustomerAddress as SCA
on SC.CustomerID= SCA.CustomerID 
inner join SalesLT.Address as SA
on SCA.AddressID = SA.AddressID
where SA.CountryRegion = 'United States'or SA.CountryRegion = 'United Kingdom'

--5.
Select * from SalesLT.Product as SP
order by SP.Name

--6.
Select * from SalesLT.Product
where Name like 'A%'

--7.
Select SC.CustomerID, SC.FirstName, SC.LastName
from SalesLT.Customer as SC
inner join SalesLT.SalesOrderHeader as SOH 
on SC.CustomerID = SOH.CustomerID 
--Group by SalesLT.Customer.CustomerID, SalesLT.Customer.FirstName, SalesLT.Customer.LastName;

--8.
Select SC.CustomerID, SC.FirstName, SC.MiddleName, SC.LastName, SA.City 
from SalesLT.Customer as SC
inner join SalesLT.CustomerAddress as SCA
on SC.CustomerID= SCA.CustomerID 
inner join SalesLT.Address as SA
on SCA.AddressID = SA.AddressID
where SA.City='London' 

--9.
Select SC.CustomerID, SC.FirstName, SC.LastName
from SalesLT.Customer as SC
Full Outer join SalesLT.SalesOrderHeader as SOH 
on SC.CustomerID = SOH.CustomerID 
where SC.CustomerID is Null or 
SOH.CustomerID is Null

--10.
SELECT SC.CustomerID, SC.FirstName, SC.LastName
FROM SalesLT.Customer AS SC
INNER JOIN SalesLT.SalesOrderHeader AS SOH ON SC.CustomerID = SOH.CustomerID
INNER JOIN SalesLT.SalesOrderDetail AS SOD ON SOH.SalesOrderID = SOD.SalesOrderID
INNER JOIN SalesLT.Product AS SP ON SOD.ProductID = SP.ProductID
WHERE SP.Name = 'Tofu'

--11.
Select * from SalesLT.SalesOrderHeader
order by OrderDate ASC
OFFSET 0 ROWS FETCH FIRST 1 ROWS ONLY


--12.
Select * from SalesLT.SalesOrderHeader
order by TotalDue dESC
OFFSET 0 ROWS FETCH FIRST 1 ROWS ONLY

--13.

Select SalesOrderID,AVG(OrderQty) as AvgOrderQuantity 
from SalesLT.SalesOrderDetail
Group by SalesOrderID 

--14.
Select SalesOrderId, Max(OrderQty) as MAXquantity, 
Min(OrderQty) as Minquantity 
from SalesLT.SalesOrderDetail
Group by SalesOrderID 

--15.Get a list of all departments and total number of employees who report to them.
Use AdventureWorksDW2017
go
Select DepartmentName,Count(*) as Total_Employee_in_Dept from [dbo].[DimEmployee] 
group by DepartmentName 


--16.
Use AdventureWorksLT2017
go
Select SalesOrderId, SUm(OrderQty) as Total_Order_QTY
from SalesLT.SalesOrderDetail
Group by SalesOrderID 
having Sum(OrderQty)>

--17.
Use AdventureWorksLT2017
go
Select * from SalesLT.SalesOrderHeader
where OrderDate >= 1996-12-31

--18.
Use AdventureWorksLT2017
go
SELECT O.SalesOrderID, O.OrderDate, A.CountryRegion
FROM SalesLT.SalesOrderHeader AS O
INNER JOIN SalesLT.CustomerAddress AS CA ON O.CustomerID = CA.CustomerID
inner join SalesLT.Address as A On CA.AddressID = A.AddressID
WHERE A.CountryRegion = 'Canada'

--19.
	Use AdventureWorksLT2017
	go
Select * from SalesLT.SalesOrderHeader
WHERE TotalDue >200 

--20.
Use AdventureWorksLT2017
go
SELECT A.CountryRegion, Sum(O.TotalDue) as total_Sales
FROM SalesLT.SalesOrderHeader AS O
INNER JOIN SalesLT.CustomerAddress AS CA ON O.CustomerID = CA.CustomerID
inner join SalesLT.Address as A On CA.AddressID = A.AddressID
GROUP bY A.CountryRegion
