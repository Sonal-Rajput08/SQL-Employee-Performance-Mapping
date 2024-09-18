
#1 Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database from the given resources.
create database employee;
use employee;
show tables;

#2 Create an ER diagram for the given employee database.

#3 Write a query to Write a query tofetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPT from the employee record table, and make a list of employees and details of their department.

Select EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT from emp_record_table
order by DEPT;

#4 Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: less than two,greater than four ,between two and four

Select EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT, EMP_Rating from emp_record_table where emp_rating<2;

Select EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT, EMP_Rating from emp_record_table where emp_rating> 4;
Select EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT, EMP_Rating from emp_record_table where emp_rating between 2 and 4;

#5 Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME.
 
select concat(first_name," ",Last_name) as Name,DEPT from emp_record_table where DEPT="finance";

#6 Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).

select EMP_ID,concat(first_name," ",Last_name) as Employee_Name, Manager_id,Role
from emp_record_table 
where Manager_id  is not null
order by emp_id;



#7 Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.

select Emp_ID,concat(first_name," ",Last_name) as Name,DEPT from emp_record_table where DEPT="finance"
union
select EMP_ID,concat(first_name," ",Last_name) as Name,DEPT from emp_record_table where DEPT="Healthcare";

#8 Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department.


select EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPt, EMP_RATING ,
max(emp_rating) over(partition by dept) as max
from emp_record_table
order by dept;



#9 Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.

 select Role, max(salary) as Max_salary, min(salary) as Min_salary from emp_record_table
 group by role;
 
 #10 Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.
 
 SELECT EMP_ID,FIRST_NAME,LAST_NAME,EXP,
 RANK() OVER(ORDER BY EXP) EXP_RANK
 FROM emp_record_table;

 
 #11 Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.
 
CREATE VIEW employees_sal AS
 select first_name,last_name,country,salary from emp_record_table
 where salary >6000;
 
 select * from employees_sal;
 
 #12 Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.
 
 SELECT EMP_ID,FIRST_NAME,LAST_NAME,EXP FROM emp_record_table
 WHERE EMP_ID IN(SELECT Emp_id FROM emp_record_table where EXP>10);

 
 
 
 #13 Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.
 
 DELIMITER //
 CREATE PROCEDURE get_experience_details()
 BEGIN
 SELECT EMP_ID,FIRST_NAME,LAST_NAME,EXP FROM emp_record_table WHERE EXP>3;
 END //
 CALL get_experience_details();
 
 
 

 
 #14 Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.

# The standard being:For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
#For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
#For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
#For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
#For an employee with the experience of 12 to 16 years assign 'MANAGER'.
 
 
 DELIMITER //
 CREATE FUNCTION Employee_ROLE(EXP int)
 RETURNS VARCHAR(40)
 DETERMINISTIC
 BEGIN
 DECLARE Employee_ROLE VARCHAR(40);
 IF EXP>12 AND 16 THEN SET Employee_ROLE="MANAGER";
 ELSEIF EXP>10 AND 12 THEN
 SET Employee_ROLE ="LEAD DATA SCIENTIST";
 ELSEIF EXP>5 AND 10 THEN SET Employee_ROLE ="SENIOR DATA SCIENTIST";
 ELSEIF EXP>2 AND 5 THEN SET Employee_ROLE ="ASSOCIATE DATA SCIENTIST";
 ELSEIF EXP<=2 THEN
 SET Employee_ROLE ="JUNIOR DATA SCIENTIST";END IF;
 RETURN (Employee_ROLE);
 END //

 SELECT FIRST_NAME,LAST_NAME,EXP,Employee_ROLE(EXP)FROM data_science_team;

 
	

 
 #15 Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.
 
 CREATE INDEX idx_first_name
 ON emp_record_table(FIRST_NAME(20));
 SELECT * FROM emp_record_table
 WHERE FIRST_NAME='Eric';
 

 
 #16 Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).
 
 
 select EMP_ID, concat(FIRST_NAME," ",LAST_NAME) as NAME, EMP_RATING, SALARY,
 (SALARY*0.05)*EMP_RATING as BONUS 
 from emp_record_table;
 
 #17 Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.
 
 
 select continent, country, avg(salary) from emp_record_table
group by continent, country;