--1.Second Highest Salary

USE test 
GO 
Create Schema Company
Create table Company.Salary(ID int not Null primary key,FirstName varchar(20)not null,LastName varchar(20)not null,Gender Char, Salary Money noT Null);

Insert into Company.Salary 
(ID,FirstName,LastName,Gender,Salary)
Values
(8,	'John',	'Stanmore',	'M'	,80000),
(1,	'Ben',	'Hoskins',	'M',70000),
(4,	'Ben',	'Hoskins',	'M',70000),
(2,	'Mark',	'Hastings',	'M'	,60000),
(3,	'Steve','Pound','M'	,45000),
(5,	'Philip','Hastings','M',45000),
(7,	'Valarie','Vikings','F',35000),
(6,	'Mary','Lambeth','F',30000);


SELECT MAX(CS.Salary) AS Second_high_salary
from Company.Salary as CS
where CS.Salary < (Select MAx(CS.Salary) from Company.Salary as CS)

--or

Select * from Company.Salary
Order by Company.Salary.Salary DESC
OFFSET 1 ROWS FETCH NEXT 1 ROWS ONLY;

--2.Find the date and the day for the current decade.

Select GETDATE() as Date_Of_today, DATENAME(WEEKDAY, GETDATE()) As Day_of_week

--3.Write the Query to get the first 3 Alphabets of Column State Input-
use AdventureWorksLT2017
go
Select LEFT(SalesLT.Address.CountryRegion,3) as FirstThreeLetters  from SalesLT.Address 


--4.Que 4. Write a query to display the first day of the month (in datetime format) 
--three months before the current month.

Select DATEadd(MONTH,-1, DATEadd(Day,1,EOMONTH(GEtdate(),-3))) AS First_Day_of_week_Three_month_Ago

--5.Que 5. Write a query to display the last day of the month (in datetime format) three months before the current month.

SELECT EOMONTH(GEtdate(),-3) AS laST_Day_of_week_Three_month_Ago

--6.Que 6. Write a query to get the first day of the current year.

SELECT DATEADD(DAY ,1,EOMONTH(GETDATE(),-MONTH(GETDATE()))) AS fIRST_dAY_OF_CURRENT_YEAR

--7.Write a query to calculate the age in year

USE AdventureWorksDW2017
GO
SELECT S.FirstName,S.LastName,S.BirthDate ,dATEDIFF(YEAR, S.BirthDate,GETDATE()) -
CASE
	WHEN DATEADD(YEAR, dATEDIFF(YEAR,S.BirthDate, GETDATE()), S.BirthDate ) > GETDATE()
	THEN 1
	ELSE 0
END AS AGE
FROM DimEmployee AS S

--8.Que 8. Write a query to get the current date in the following format.
--Input - 2014-09-04
--Output Format - September 4, 2014

Select CONVERT(Varchar(20),Getdate(),107) as different_format

--9.Que 9. Write a query to extract the year from the current date.
Select DATENAME(Year, Getdate()) as Current_Year

--10.Que 10. Find the Index of ‘@’ in the Given String adventureworks@database.com

Select Charindex('@' , 'adventureworks@database.com') as index_of_@

--11.Que 11. Extract the Domain from the Email Id.
--Input-
use Test
go
Create table Email ( E_mail varchar(50) not null)
insert into Email(E_mail)
values
('Abc@xyz.com'),

('Assds@adbcs.com'),

('Dsdadff@sfgreesa.com'),

('Fgrfsderee@dfsdfecdadsc.com'),

('Dfsfrtfgrewwwvvfbf@a.com'),

('A@c.in'),

('Aseec@asec.inc');

Select SUBSTRING(Email.E_mail, Charindex('@',Email.E_mail)+1, Len(Email.E_mail)) as Domain_Name
from Email
where E_mail like '%@%'

--or 

USE AdventureWorksDW2017
GO
SELECT SUBSTRING(DE.EmailAddress, CHARINDEX('@', DE.EmailAddress) + 1, LEN(DE.EmailAddress)) as Domain_Name
FROM DimEmployee as DE
WHERE DE.EmailAddress LIKE '%@%';

--12.
Use Test 
gO
CREATE TABLE TestSchema.Employee (EmployeeId int not null primary Key, Name varchar(50) not null, Salary money not null, 
EmailId Varchar(50) not null ) 
 insert into TestSchema.Employee (EmployeeId,Name,Salary,EmailId)
 values
(1,	'John',	1000,	'John@abc.com'),
(2,	'Ben',	2000,	'Ben@xyz.com'),
(3,	'Mark',	3000,	'Mark@abc.com'),
(4,	'Steve',2000,	'Steve@xyz.com'),
(5,	'Philip',5000,	'Philip@xyz.com'),
(6,	'Mary',	6000,	'Mary@qwe.com');
--12.1Count of Employees who have same Domain

SELECT SUBSTRING(DE.EmailId, CHARINDEX('@', DE.EmailId) + 1, LEN(DE.EmailId)) as Domain_Name,
Count(*) as EmployeeCount
FROM TestSchema.Employee as DE
Group by SUBSTRING(DE.EmailId, CHARINDEX('@', DE.EmailId) + 1, LEN(DE.EmailId))
Having Count(*)>1

--12.2 Count of Employee who have same salary.

Select Count(*) as Same_salary, Salary 
from TestSchema.Employee
group by Salary 
having Count(*)>1

--12.3 Count of Employee who have same domain and same salary



--12.4 Select Name and Id of Employee who have same domain.
SELECT e1.EmailId as Email1,e1.Name as Name1, e2.EmailId as Email2, e2.Name as Name2
from TestSchema.Employee as e1
join TestSchema.Employee as e2 
on SUBSTRING(e1.EmailId, CHARINDEX('@', e1.EmailId) + 1, LEN(e1.EmailId)) = 
SUBSTRING(e2.EmailId, CHARINDEX('@', e2.EmailId) + 1, LEN(e2.EmailId))
and e1.EmployeeId < e2.EmployeeId

/*Que 13. Create a Table named ‘Example’ which have the following structure:
id	name	dob	gender
1	Student1	2023-02-20	MALE
2	Student2	1999-01-01	FEMALE

If User doesn’t fill gender or dob, make sure those values are set to today’s date and ‘Male’ by default.
No Column should have null values, and id column should be the primary key. */

Use Test 
gO
CREATE TABLE TestSchema.Students (Id int not null primary Key, Stu_Name varchar(50) not null, DOB date not null default GetDate(), 
Gender varchar(10) not null default 'Male') 

/*Que 14. Select all the records from the table for which the state Column starts with alphabet W
Input Table
supplier_id	supplier_name		city	state
100	Microsoft                                         		Redmond                                           	Washington                                        
200	Google                                            		Mountain View                                     	California                                        
300	Oracle                                            		Redwood City                                      	California                                        
400	Kimberly-Clark                                    		Irving                                            	Texas                                             
500	Tyson Foods                                       		Springdale                                        	Arkansas                                          
600	SC Johnson                                        		Racine                                            	Wisconsin                                         
700	Dole Food Company                                 		Westlake Village                                  	California                                        
800	Flowers Foods                                     		Thomasville                                       	Georgia                                           
900	Electronic Arts                                   		Redwood City                                      	California                                        
*/

Use Test
go 
Create Table Testschema.ComSupplier 
(supplier_id int not null primary key,supplier_name varchar(50) not null,city varchar(50) not null,	state varchar(50) not null)
Insert into TestSchema.ComSupplier(supplier_id,supplier_name,city,state)
values
(100,'Microsoft','Redmond', 'Washington'),                                        
(200,'Google','Mountain View','California'),                                        
(300,'Oracle','Redwood City' , 'California'),                                        
(400,'Kimberly-Clark','Irving','Texas'),                                            
(500,'Tyson Foods','Springdale','Arkansas'),                                         
(600,'SC Johnson', 'Racine', 'Wisconsin'),                                      
(700,'Dole Food Company','Westlake', 'Village California' ) ,                                      
(800,'Flowers Foods', 'Thomasville', 'Georgia'  ),                                         
(900,'Electronic Arts','Redwood City', 'California' );    

SELECT * FROM TestSchema.ComSupplier AS S
WHERE S.state LIKE 'W%'


/* Que 15. You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.
Column	Type
Id	Integer 
Start_Date	Date
End_Date	Date
	

If the End_Date of the tasks are consecutive, then they are part of the same project. Suraj is interested in finding the total number of different projects completed.
Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more 
than one project that have the same number of completion days, then order by the start date of the project.
Sample Input
Id	Start_Date	End_Date
1	10/01/2023	11/01/2023
2	11/01/2023	12/01/2023
3	12/01/2023	13/01/2023
4	25/01/2023	26/01/2023
5	26/01/2023	27/01/2023
6	30/01/2023	31/01/2023
7	01/02/2023	02/02/2023
*/

USE Test
GO
CREATE TABLE TestSchema.Project (id int not null primary key, Start_date date not null , End_DATE DATE NOT NULL)
sET dATEFORMAT DMY
INSERT INTO TestSchema.Project
VALUES
(1,	'10/01/2023',	'11/01/2023'),
(2,	'11/01/2023',	'12/01/2023'),
(3,	'12/01/2023',	'13/01/2023'),
(4,	'25/01/2023',	'26/01/2023'),
(5,	'26/01/2023',	'27/01/2023'),
(6,	'30/01/2023',	'31/01/2023'),
(7,	'01/02/2023',	'02/02/2023');

--Solve these Following Queries by Using Adventure Works Database

--1. List of Customer Contact, Name and number of orders they place
use AdventureWorksDW2017
go
Select  SC.CustomerKey,SC.FirstName, Sc.LastName, Sc. MiddleName, Count(S.SalesOrderNumber) as Total_NO_OF_Orders 
from DimCustomer as SC
inner Join FactInternetSales as S on Sc.CustomerKey=S.CustomerKey
Group by  Sc.CustomerKey,SC.FirstName, Sc.LastName, Sc. MiddleName
order by Total_NO_OF_Orders Desc;

--2. 2.	List of customer contact,names who have placed more than 3 orders
use AdventureWorksDW2017
go
Select  SC.CustomerKey,SC.FirstName, Sc.LastName, Sc. MiddleName, Count(S.SalesOrderNumber) as Total_NO_OF_Orders 
from DimCustomer as SC
inner Join FactInternetSales as S on Sc.CustomerKey=S.CustomerKey
Group by  Sc.CustomerKey,SC.FirstName, Sc.LastName, Sc. MiddleName
Having Count(S.SalesOrderNumber) >3
Order by Total_NO_OF_Orders 

--3.	List of discontinued products which were ordered between 1/1/1997 and 1/1/1998

SELECT * FROM FactInternetSales
WHERE FactInternetSales.DiscountAmount > 0 AND OrderDate BETWEEN '1/1/1997' AND '1/1/1998'

--4.	List of employees firsname, lastName, superviser FirstName, LastName

SELECT e1.EmployeeKey, e1.FirstName as  EmployeeFirstName , E1.LastName as EmployeeLastName, 
E2.FirstName AS Superviser_FirstName, e2.LastName AS Superviser_LastName
FROM DimEmployee AS E1
left JOIN DimEmployee AS E2 ON E1.ParentEmployeeKey = e2.EmployeeKey

--5.	List of Employees id and total sale condcuted by employee

Select FactSalesQuota.EmployeeKey, SUM(FactSalesQuota.SalesAmountQuota) AS TotalSales
FROM FactSalesQuota
GROUP BY FactSalesQuota.EmployeeKey 

--6.	list of employees whose FirstName contains character a

SELECT DimEmployee.FirstName FROM DimEmployee
WHERE DimEmployee.FirstName LIKE '%a%'

--7.	List of managers who have more than four people reporting to them.
SELECT  Count(*) as Count_of_employee,
E2.FirstName AS Superviser_FirstName, e2.LastName AS Superviser_LastName
FROM DimEmployee AS E1
left JOIN DimEmployee AS E2 ON E1.ParentEmployeeKey = e2.EmployeeKey
group by E2.FirstName, e2.LastName
having Count(*) > 4

--8.	List of Orders and ProductNames
use AdventureWorksLT2017
GO
SELECT SOD.ProductID, SP.Name AS ProductNames ,SOD.SalesOrderID, sod.OrderQty,SOD.UnitPrice, sod.LineTotal
FROM SalesLT.SalesOrderDetail AS sod
LEFT jOIN SalesLT.Product AS SP ON SOD.ProductID=SP.ProductID 

--9.	List of orders place by the best customer


--10.	List of orders placed by customers who do not have a Fax number


--11.	List of Postal codes where the product Tofu was shipped


--12.	List of product Names that were shipped to France
Use AdventureWorksDW2017
go
Select P.EnglishProductName, t.SalesTerritoryCountry from FactInternetSales as S
inner join DimSalesTerritory as T on S.SalesTerritoryKey = T.SalesTerritoryKey
inner join DimProduct as P on S.ProductKey=p.ProductKey
Where T.SalesTerritoryCountry = 'France'

--13.	List of ProductNames and Categories for the supplier 'Specialty Biscuits, Ltd.
--14.	List of products that were never ordered
Select p.ProductKey, p.EnglishProductName AS PRODUCTSNEVERORDERED from DimProduct as p
Left join FactInternetSales  as S on P.ProductKey = S.ProductKey
Where S.ProductKey is Null

--15.	List of products where units in stock is less than 10 and units on order are 0.
--16.	List of top 10 countries by sales
Use AdventureWorksDW2017
go
Select top 10 Sum(S.SalesAmount) as Sales, t.SalesTerritoryCountry from FactInternetSales as S
inner join DimSalesTerritory as T on S.SalesTerritoryKey = T.SalesTerritoryKey
Group By T.SalesTerritoryCountry
order by Sales Desc

--17.	Number of orders each employee has taken for customers with CustomerIDs between A and AO
Use AdventureWorksDW2017
go
Select * from DimCustomer 

--18.	Orderdate of most expensive order

use AdventureWorksLT2017
go 
Select Top 1 S.OrderDate, S.TotalDue From SalesLT.SalesOrderHeader as S
Order by S.TotalDue desc

--19.	Product name and total revenue from that product
use AdventureWorksLT2017
go
Select P.Name, sum(Soh.TotalDue) as ToatalRevenue
from SalesLT.SalesOrderHeader as Soh 
inner join SalesLt.SalesOrderDetail  as SOD on Soh.SalesOrderID = sod.SalesOrderID
inner join SalesLT.Product as P on SOD.ProductID = p.ProductID
Group By P.Name

Select * 
from SalesLT.SalesOrderHeader
Select * from SalesLT.SalesOrderDetail


--20.	Supplierid and number of products offered


--21.	Top ten customers based on their business
USE AdventureWorksLT2017
GO
SELECT C.FirstName,C.LastName, SUM(SOH.TotalDue) as Total_amt FROM SalesLT.Customer AS C
INNER JOIN SalesLT.SalesOrderHeader AS SOH ON C.CustomerID=SOH.CustomerID
gROUP BY C.FirstName,C.LastName
order By Total_amt Desc
OFFSET 0 ROWS FETCH FIRST 10 ROWS ONLY

--22.	What is the total revenue of the company.
Use AdventureWorksLT2017
go 
Select C.CompanyName, Sum(Soh.TotalDue) as Total_Revenue
from SalesLT.Customer as C
inner join SalesLT.SalesOrderHeader as Soh on C.CustomerID = Soh.CustomerID
Group  by C.CompanyName

Select * from SalesLT.SalesOrderHeader

--23.	Count of Employees who joined in Same month.
Use AdventureWorksDW2017 
go
Select StartDate , Count(*) as No_of_Employee from DimEmployee
Group by StartDate
having COUNT(*) > 1


--24.	Count of Employees who share same month in their Birth Date.
Use AdventureWorksDW2017 
go
Select BirthDate , Count(*) as No_of_Employee from DimEmployee
Group by BirthDate
having COUNT(*) > 1

--25.	Count of Employees Gender Wise.
Use AdventureWorksDW2017 
go
Select Gender , Count(*) from DimEmployee
Group by Gender
