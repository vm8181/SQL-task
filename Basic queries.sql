use task

-- to check tables
select * from sys.tables

-- Basic queries
-- 1. Select firstname, lastname, title, age, salary for everyone in your employee table.
Select firstname, lastname, title, age, salary from Employee

--2. Select firstname, age and salary for everyone in your employee table.
Select firstname, age ,salary from Employee

--3. Selct firstname and display as 'Name' for everyone in your employee table
Select firstname as Name from Employee

-- 4. Select firstname and lastname as 'Name' for everyone. Use " " (space) to separate firstname and last
Select firstname +' '+ lastname as Name from Employee


-- Where clause
-- 5. Select all columns for everyone with a salary over 38000.
Select * from Employee where salary > 38000

-- 6. Select first and last names for everyone that's under 24 years old.
Select firstname, lastname from Employee where Age < 24

-- 7. Select first name, last name, and salary for anyone with "Programmer" in their title.
Select firstname, lastname, salary from Employee where title = 'Programmer'

--8. Select all columns for everyone whose last name contains "O".
Select * from Employee where lastname like '%o%'

--9. Select the lastname for everyone whose first name equals "Kelly".
Select lastname from Employee where firstname = 'Kelly'

-- 10. Select all columns for everyone whose last name ends in "Moore".
Select * from Employee where lastname like '%Moore%'

--11. Select all columns for everyone who are 35 and above.
Select * from Employee where Age >= 35

-- Multiple where clauses
-- 12. Select firstname ,lastname,age and salary of everyone whose age is above 24 and below 43.
Select firstname, lastname, age , salary from Employee where Age > 24 and Age < 43

--13. Select firstname, title and lastname whose age is in the range 28 and 62 and salary greater than 31250
Select firstname, title, lastname from Employee where  ( Age between 28 and 62 ) and salary > 31250

--14. Select all columns for everyone whose age is not more than 48 and salary not less than 21520
Select * from Employee where Age <= 48 and Salary >= 21520

-- 15. Select firstname and age of everyone whose firstname starts with "John" and salary in the range 25000 and 35000
Select firstname, Age from Employee where firstname = 'John' and Salary between 25000 and 35000

-- ordery by queries
--16. Select all columns for everyone by their ages in descending order.
Select * from Employee order by Age desc

-- 17. Select all columns for everyone by their ages in ascending order.
Select * from Employee order by Age

-- 18. Select all columns for everyone by their salaries in descending order.
Select * from Employee order by Salary desc

-- 19. Select all columns for everyone by their salaries in ascending order.
Select * from Employee order by Salary asc

-- 20. Select all columns for everyone by their salaries in ascending order whose age not less than 17.
Select * from Employee where Age > = 17 order by Salary

--21. Select all columns for everyone by their salaries in descending order whose age not more than 34.
Select * from Employee where Age <= 34 order by Salary desc

-- Miscellaneous queries

-- 22. Select all columns for everyone by their length of firstname in ascending order.
Select * from Employee order by LEN(firstname)

--23. Select the number of employees whose age is above 45
Select count(firstname) as [No of Employees] from Employee where Age > 45

-- 24. Show the results by adding 5 to ages and removing 250 from salaries of all employees
Select Firstname, Lastname, Title, Age+5 as Age , Salary-250 as Salary from Employee

--25. Select the number of employees whose lastname ends with "re" or "ri" or "ks"
Select count(firstname) as [No of Employees]
from Employee where lastname like '%re' or lastname like '%ri' or lastname like '%ks'

--26.Select the average salary of all your employees
Select AVG(Salary) as Average_Salary from Employee

--27. Select the average salary of Freshers
select AVG(Salary) as Average_Fresher_Salary from Employee where Title = 'Fresher'

--28. Select the average age of Programmers
Select AVG(Age) as Average_Age
from Employee where Title = 'Programmer'

--29. Select the average salary of employees whose age is not less than 35 and not more than 50
Select AVG(Salary) as Average_Salary
from Employee where Age between 35 and 50

--30. Select the number of Freshers
Select  count(*) as [Number of Freshers]
from Employee where Title = 'Fresher'

-- 31. What percentage of programmers constitute your employees
Select CAST( count(Title)*100 / (Select Count(*) from Employee) as varchar) +' Percent' as Programmers
from Employee where Title = 'Programmer'

-- 32. What is the combined salary that you need to pay to the employees whose age is not less than 40
Select sum(salary) as combined_salary from Employee where Age > = 40

--33. What is the combined salary that you need to pay to all the Freshers and Programmers for 1 month
Select sum(salary) as combined_salary from Employee where Title IN ('Fresher','Programmer')

--34. What is the combined salary that you need to pay to all the Freshers whose age is greater than 27 for 3years
Select sum(salary)*36 as combined_salary from Employee where Age > 27 and Title = 'Fresher'


-- subqueries
--35. Select the eldest employee's firstname, lastname and age whose salary is less than 35000

select Top 1 FirstName, LastName, Age from Employee where Salary < 35000  order by Age desc

-- 36.Who is the youngest General Manager
select Top 1 FirstName + ' ' +LastName as General_Manager from Employee where Age = (Select MIN(Age) from Employee where Title = 'General Manager')

-- 37. Select the eldest fresher whose salary is less than 35000
Select distinct Top 1 * from Employee 
where Age = (Select Max(Age) from Employee where Salary < 35000 and Title = 'Fresher')

--38. Select firstname and age of everyone whose firstname starts with "John" or "Michael" and salary in the range 17000 and 26000
Select distinct FirstName, Age from Employee where FirstName in ('John','Michael') and salary between 17000 and 26000

-- group by and having clause

-- 39. How many employees are having each unique title. Select the title and display the number of employees present in ascending order
Select Title, count(*) as 'No of employees'
from Employee
group by Title
order by count(*)
--40. What is the average salary of each unique title of the employees. Select the title and display the average salary of employees in each
Select Title, AVG(salary) as average_salary from Employee group by Title

-- 41. What is the average salary of employees excluding Freshers
select AVG(salary) as average_salary from Employee where Title <> 'Fresher'

-- 42. What is the average age of employees of each unique title.
Select Title, AVG(Age) as average_age from Employee group by Title

-- 43. In the age range of 25 to 40 get the number of employees under each unique title.
Select Title, Count(*) as Employeecount from Employee where Age between 25 and 40 group by title order by Employeecount

--44. Show the average salary of each unique title of employees only if the average salary is not less than 25000
Select Title,AVG(salary) as average_salary from Employee group by title having avg(salary) > = 25000 order by average_salary

--45. Show the sum of ages of each unique title of employee only if the sum of age is greater than 30
Select Title, SUM(Age) as Totalage from Employee group by title having SUM(Age) > 30 order by Totalage

-- Using 'Update'
-- Lisa Ray just got married to Michael Moore. She has requested that her last name be updated to Moore.
Update Employee Set LastName = 'Moore' where FirstName = 'Lisa' and LastName = 'Ray' -- no rows available for name lisa ray

--select * from Employee where FirstName = 'Lisa'
-- Ginger Finger's birthday is today, add 1 to his age and a bonus of 5000

Update Employee Set Age = Age + 1 , Salary = Salary + 5000 where FirstName like 'Ginger' and LastName = 'Finger' -- updated

-- All 'Programmer's are now called "Engineer"s. Update all titles accordingly.

update Employee set Title = 'Engineer' where Title = 'Programmer' --updated.

-- Everyone whose making under 30000 are to receive a 3500 bonus.
update Employee set salary = Salary + 3500 where Salary >30000  --updated.

--Everyone whose making over 35500 are to be deducted 15% of their salaries
update Employee set salary = Salary -0.15*salary where salary>35500  -- updated.











