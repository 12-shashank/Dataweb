/*Que 1. Find the names of students who got GPA above the average GPA of all students (Use Having clause)
Input Table: STUDENTDETAILS
StudentId	StudentName	GPA	Branch	Section
159103036	Mohit Agarwal	8.9	CCE	A
159103037	Rohit Agarwal	5.2	CCE	A
159103038	Shohit Garg		7.1	CCE	B
159103039	Mrinal Malhotra	7.9	CCE	A
159103040	Mehreet Singh	5.6	CCE	A
159103041	Arjun Tehlan	9.2	CCE	B
*/
Use Day5
go
Create Schema Practice

--
Use Day5
go
Create Table Practice.StudentDetails
(StudentId int not null primary key identity(159103036,1),
StudentName varchar(50) not null,
GPA decimal(2,1) not Null,
Branch varchar(3) not null,
Section char not null)

Insert into Practice.StudentDetails
(StudentName, GPA,Branch,Section)
values 
('Mohit Agarwal', 8.9, 'CCE', 'A'),
('Rohit Agarwal',5.2 , 'CCE', 'A'),
('Shohit Garg', 7.1, 'CCE', 'B'),
('Mrinal Malhotra', 7.9 , 'CCE', 'A'),
('Mehreet Singh',5.6, 'CCE', 'A'),
('Arjun Tehlan',9.2, 'CCE', 'B');

Insert into Practice.StudentDetails
(StudentName, GPA,Branch,Section)
values 
('Mohit Agarwal', 8.9, 'CCE', 'A'),

Use Day5
go
SELECT StudentId, StudentName, GPA
FROM Practice.StudentDetails
Group by StudentId, StudentName, GPA
Having GPA > (select AVG(GPA) from Practice.StudentDetails)

--Que 2. - Count Section wise Students

SELECT SECTION, COUNT(Section)AS NO_OF_STUDENTS 
FROM Practice.StudentDetails
GROUP BY Section

-- Que 3. Create a Clustered Index on Table Employee on Id Column. 
--This table have other columns such as Name, DOB, Salary.
USE Day5
GO
Create Table Practice.Employee(
Employee int primary key,
Name VARCHAR(50) NOT NULL,
DOB DATE NOT NULL,
SALARY MONEY NOT NULL
)

EXEC sp_helpindex 'Practice.Employee'

--Ques 4.Que 4. Create a Non-Clustered Index on Employee Table for Columns Salary in ascending and Gender Descending. 
--This table have columns such as- EmployeeId, Name, DOB, Salary, Gender.

ALTER TABLE Practice.Employee
ADD GENDER VARCHAR(10) NOT NULL

CREATE INDEX SALRIEDINDEX
ON Practice.Employee(SALARY ASC)




/*
Database Management System – Assignments Session 2
Assignment 1:
With respect to StoreFront applications identify, apply, and list the constraints you would apply on the columns for the tables created.


Assignment 2:
Write SQL scripts for the following:
➢	Display the list of products (Id, Title, Count of Categories) which fall in more than one Category.
➢	Display Count of products as per below price range:

Range in Rs.	Count
0 - 100	
101 - 500	
Above 500	

➢	Display the Categories along with number of products under each category.

Assignment 3:
Write SQL scripts for the following:
➢	Display Shopper’s information along with number of orders he/she placed during last 30 days.
➢	Display the top 10 Shoppers who generated maximum numbers of revenue in last 30 days.
➢	Display top 20 Products which are ordered most in last 60 days along with numbers.
➢	Display Monthly sales revenue of the StoreFront for last 6 months. It should display each month’s sale.
➢	Mark the products as Inactive which have not been ordered in the last 90 days.
➢	Given a category search keyword, display all the Products present in these category/categories. 
➢	Display top 10 Items which were cancelled most.

Assignment 4:
Consider a form where providing a Zip Code populates associated City and
State. 
➢	Create appropriate tables and relationships for the same and write SQL.
         query for that returns a Resultset containing Zip Code, City Names and
         States ordered by State Name and City Name.
(Create 3 tables to store State, District/City & Zip code separately)

Assignment 5:
➢	Create a view displaying the order information (Id, Title, Price, Shopper’s name, Email, Orderdate, Status) with latest ordered items should be displayed first for last 60 days.
➢	Use the above view to display the Products (Items) which are in ‘shipped’ state.
➢	Use the above view to display the top 5 most selling products.

*/



