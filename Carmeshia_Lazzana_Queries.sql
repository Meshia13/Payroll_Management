# This is the queries and procedures connected to the Payroll database

USE payroll_management;

# --------------------------------------------------------------------------------------------------------------#
# --------------------------------------------------------------------------------------------------------------#

/*Prepare an example query with group by and having to demonstrate how to extract data from your DB for analysis*/
	# Determine which department pays their employees over $100,000 on average
	# Join department, employee and pay_rate tables

SELECT 
	Dept_Name, 
    AVG(salary)
FROM department
Join employee ON dept_ID = department_ID
JOIN pay_rate ON emp_ID = Employee_ID
Group by dept_name
Having AVG(salary) >100000
Order by dept_name;

# --------------------------------------------------------------------------------------------------------------#
# --------------------------------------------------------------------------------------------------------------#

/*Using any type of the joins create a view that combines multiple tables in a logical way*/ 
	# View the days worked for all employees and their current status
    # All employees who have worked less than a year are considered NEW
    # Those who've worked longer are SEASONED

CREATE OR REPLACE VIEW VW_Worked
AS    
SELECT 
	CONCAT(FName, ' ', LName) AS Name,
    start_date,
    CURDATE(),
    Status_Name,
    (Curdate() - start_date) AS DaysWorked,
	CASE
		WHEN (Curdate() - start_date) <= 365 THEN 'NEW'
        WHEN (Curdate() - start_date) > 365 THEN 'SEASONED'
        ELSE NULL
	END AS NEW_HIRE
    From Employee
    JOIN emp_status ON status_ID = emp_statusID
    ORDER BY DaysWorked;
     
SELECT * FROM VW_Worked;

# --------------------------------------------------------------------------------------------------------------#
# --------------------------------------------------------------------------------------------------------------#
    
/*Create a view that uses at least 3-4 base tables; prepare and demonstrate a query 
that uses the view to produce a logically arranged result set for analysis.*/
	# Give all managers a 15% raise to their salary on update
	# employee, pay_rate, title, status
    
DROP view VW_Salary;    
CREATE OR REPLACE VIEW VW_Salary
AS
SELECT 
	FName,
    LName,
    Title_Name,
    salary
FROM pay_rate
JOIN employee ON emp_ID = Employee_ID
JOIN emp_status ON status_ID = Emp_StatusID
JOIN title ON Title_ID = employee.Title;

SELECT * FROM VW_Salary
ORDER BY Title_Name DESC;

UPDATE VW_Salary
SET salary = (1.15*salary) 
WHERE title_Name = 'Manager';

SELECT * FROM VW_Salary
ORDER BY Title_Name DESC;

# --------------------------------------------------------------------------------------------------------------#
# --------------------------------------------------------------------------------------------------------------#

/*In your database, create a stored function that can be applied to a query in your DB*/
	# Create function that concats first and last name
    
CREATE FUNCTION full_name(first_n CHAR(30), last_n CHAR(30))
RETURNS CHAR(70) DETERMINISTIC 
RETURN CONCAT(first_n, ' ', last_n); 

SELECT Employee_ID, full_name(FName, LName) AS 'Full Name'
FROM employee
LIMIT 5;
 

# --------------------------------------------------------------------------------------------------------------#
# --------------------------------------------------------------------------------------------------------------#

/*Prepare an example query with a subquery to demonstrate how to extract data from your DB for analysis*/
	# Find employees who are no longer active
 
SELECT
	FName,
    LNAME
FROM employee
WHERE Emp_StatusID IN
(SELECT status_ID FROM emp_status
WHERE Status_Name = 'NOT ACTIVE');

# --------------------------------------------------------------------------------------------------------------#
# --------------------------------------------------------------------------------------------------------------#

/*In your database, create a stored procedure and demonstrate how it runs*/
	# Insert values into States table
 
DELIMITER $$
CREATE PROCEDURE insert_state
( 
IN st_name VARCHAR(50),
IN st_abbr VARCHAR(50)
)
BEGIN 
INSERT INTO state(State_Name, State_Abbrev)
VALUES (st_name, st_abbr);
END $$
DELIMITER ;

CALL insert_state
('Hawaii', 'HI');

SELECT * FROM state;

# --------------------------------------------------------------------------------------------------------------#
# --------------------------------------------------------------------------------------------------------------#

/*In your database, create a trigger and demonstrate how it runs*/
	# Set a trigger to calculate hourly_rate by 2080
	# Update trigger to give every employee a $2 raise

SELECT * FROM pay_rate;

CREATE TRIGGER before_hourly_rate_update
BEFORE UPDATE ON pay_rate
FOR EACH ROW 
SET NEW.Salary = (NEW.Hourly_Rate * 2080);

SET SQL_SAFE_UPDATES = 0; # Temporarily turning off SQL Safe Update Mode
UPDATE pay_rate
SET Hourly_Rate = Hourly_Rate + 2;
SET SQL_SAFE_UPDATES = 1; # Turning back on Safe Update Mode

SELECT * FROM pay_rate;


# --------------------------------------------------------------------------------------------------------------#
# --------------------------------------------------------------------------------------------------------------#
	#Another practice of stored procedures

 DELIMITER $$
 CREATE PROCEDURE get_salary()
 BEGIN
	SELECT
		FName, 
		LName,
		Dept_Name,
		Salary
	FROM Employee 
	JOIN Department ON Department.Department_ID = Employee.Dept_ID
	JOIN Pay_Rate ON Pay_Rate.Emp_ID = Employee.Employee_ID;
END $$
DELIMITER ;

CALL get_salary();

