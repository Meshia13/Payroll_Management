# Author: Carmeshia Lazzana
# Description: Payroll Management Database for a company's employees


DROP DATABASE IF EXISTS PAYROLL_MANAGEMENT;
CREATE DATABASE PAYROLL_MANAGEMENT;
USE PAYROLL_MANAGEMENT;

DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS DEPARTMENT;
DROP TABLE IF EXISTS TITLE;
DROP TABLE IF EXISTS EMP_STATUS;
DROP TABLE IF EXISTS STATE;
DROP TABLE IF EXISTS PAY_RATE;
DROP TABLE IF EXISTS STATE_TAX;
DROP TABLE IF EXISTS FEDERAL_TAX;
DROP TABLE IF EXISTS TIME_SHEET;
DROP TABLE IF EXISTS CHECK_HISTORY;
DROP TABLE IF EXISTS TIME_DIMENSION;
DROP TABLE IF EXISTS PAYROLL_FACT;


CREATE TABLE DEPARTMENT (
	Department_ID INTEGER AUTO_INCREMENT NOT NULL,
    Dept_Name VARCHAR(50),
    CONSTRAINT DepartmentID_PK PRIMARY KEY (Department_ID)
);
INSERT INTO DEPARTMENT 
(Dept_Name)
VALUES
('Human Resources'),
('Engineering'),
('Production'),
('Marketing'),
('Sales');

SELECT * FROM DEPARTMENT;

CREATE TABLE TITLE (
	Title_ID INTEGER AUTO_INCREMENT NOT NULL,
    Title_Name VARCHAR(50),
    CONSTRAINT TitleID_PK PRIMARY KEY (Title_ID)
);
INSERT INTO TITLE
(Title_Name)
VALUES
('Employee'),
('Manager');

SELECT * FROM TITLE;

CREATE TABLE EMP_STATUS (
	Status_ID INTEGER AUTO_INCREMENT NOT NULL,
    Status_Name VARCHAR(50),
    Descrip VARCHAR(50),
    CONSTRAINT StatusID_PK PRIMARY KEY (Status_ID)
);
INSERT INTO EMP_STATUS
(Status_Name, Descrip)
VALUES
('ACTIVE', 'Employee is working'),
('NOT ACTIVE', 'Employee is not working');

SELECT * FROM EMP_STATUS;

CREATE TABLE STATE (
	State_ID INTEGER AUTO_INCREMENT NOT NULL,
    State_Name VARCHAR(50),
    State_Abbrev CHAR(2),
	CONSTRAINT StateID_PK PRIMARY KEY (State_ID)
);
INSERT INTO STATE
  (State_Name, State_Abbrev)
 VALUES
	('California', 'CA'),
    ('Georgia', 'GA'),
    ('Michigan', 'MI'),
    ('New York', 'NY'),
    ('Texas', 'TX');
     
SELECT * FROM STATE;
      
CREATE TABLE STATE_TAX (
	StateTax_ID INTEGER AUTO_INCREMENT NOT NULL,
    State_ID INTEGER,
    Percentage FLOAT(5,2) DEFAULT NULL,
	CONSTRAINT StateTxID_PK PRIMARY KEY (StateTax_ID),
    CONSTRAINT StateID_FK FOREIGN KEY (State_ID) REFERENCES STATE(State_ID)
    ON UPDATE CASCADE
	ON DELETE CASCADE
);
INSERT INTO STATE_TAX
(State_ID, Percentage)
VALUES
(1, 7.25),
(2, 4.00),
(3, 4.25),
(4, 8.52),
(5, 6.25);

SELECT * FROM STATE_TAX;

CREATE TABLE FEDERAL_TAX (
	FederalTax_ID INTEGER AUTO_INCREMENT NOT NULL,
    Percentage FLOAT(10,2),
	CONSTRAINT FedTaxID_PK PRIMARY KEY (FederalTax_ID)
);
INSERT INTO FEDERAL_TAX  
(Percentage)
VALUES
(6.5);
  
 SELECT * FROM FEDERAL_TAX; 
  
CREATE TABLE EMPLOYEE (
	Employee_ID INTEGER AUTO_INCREMENT NOT NULL,
    FName VARCHAR(50) NOT NULL, 
    LName VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    SSN INTEGER(9) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    City VARCHAR(50) NOT NULL,
    State CHAR(2) NOT NULL,
    Zip CHAR(10) NOT NULL,
    Phone VARCHAR(50) NULL,
    Email VARCHAR(50) NULL,
    Title INTEGER NULL,
    Dept_ID INTEGER NOT NULL,
    Emp_StatusID INTEGER NULL,
    Start_Date DATE NULL,
    End_Date DATE NULL,
    CONSTRAINT EmployeeID_PK PRIMARY KEY (Employee_ID),
    CONSTRAINT StatusID_FK FOREIGN KEY (Emp_StatusID) REFERENCES EMP_STATUS(Status_ID),
    CONSTRAINT DeptID_FK FOREIGN KEY (Emp_StatusID) REFERENCES DEPARTMENT(Department_ID),
    CONSTRAINT SSN UNIQUE(SSN)
);
INSERT INTO EMPLOYEE 
  (LName, FName, DOB, SSN, Address, City, State, Zip, Phone, Email, Title, Dept_ID, Emp_StatusID, Start_Date, End_Date)
 VALUES
  ('Dill', 'Ann', '1959-05-22', 0993871234, '2658 Westchester', 'Detroit','MI', '48752', '5864789856','dillinger@comcast.net', 1, 2, 1, '2016-04-15', null),
  ('Quigl','Mary', '1975-03-15', 123456789,'6921 King','Atlanta','GA', '48138','5865597777', 'QuigM@yahoo.com', 1, 4, 1, '2016-04-23', null),
  ('Rope','Andy', '2002-06-17', 098127364, '86 Chu Ave','Houston','TX', '48138','5865598764', 'RopA@gmail.com', 1, 3, 1, '2023-05-23', null),
  ('Samuels','Martin', '1984-05-12', 848289490, '34 Maiden Lane','Detroit','MI','48157','5865559867', 'SamTheMan@gmailcom', 2, 1, 1, '2020-07-04', null),
  ('Timothy','Althea', '1967-11-02', 283495954, '210 West 101st','Vitorville','CA','48056','5865557654', 'Atim@comcast.net', 1, 2, 1, '2016-04-15', null),
  ('Turner','Theodore', '1998-07-04', 367184929, '254 Bleeker','Clinton Twp.','MI','48153','5865559876', 'Turner@gmail.com', 2, 2, 1, '2022-04-15', null),
  ('Barney','Judy', '1976-08-13', 409174926, '518 West 120th','Clinton Twp.','MI','48151','5865553872', null, 1, 5, 1, '2016-04-15', null),
  ('Tanner','Warren', '1984-09-22', 501735491, '56 10th Avenue','Houston','TX','48657','5865551873', 'WarrenT@att.net', 1, 1, 1, '2019-08-23', null),
  ('Scott','Bob', '2000-10-28', 357653246, '100 East 87th','Atlanta','GA','48765','5865551298', 'Scottie@comcast.net', 2, 5, 1, '2023-04-29', null),
  ('Menchu','Roberta', '1977-02-14', 686734578, 'Boulevard de Waterloo 41',' New York', 'NY', '48138','5865042228', null, 1, 2, 2, '2016-09-15', '2023-05-07'),
  ('Lancer', 'Jack', '1970-06-04', 985356890, '48795 Champagne', 'Duluth', 'GA', '48795', '5866984258', 'ljach@gmail.com', 1, 5, 1, '2021-10-08', null),
  ('Jones', 'Patricia', '1983-05-13', 043456788, '34 Sixth Ave','Clinton Twp.', 'MI','48150','5865559876', 'PattyCake @gmail.com', 1, 1, 1, '2023-06-01', null), 
  ('Griffen','Jackie', '1994-11-15', 246654678,'Box 86', 'Warren', 'MI', '11368', '5865558329', 'Grifyndor@yahoo.com', 2, 4, 1, '2021-02-22', null),
  ('Gregory', 'Jeff',  '1996-02-22', 676543235, '478 E. Russel', 'Los Angeles', 'CA', '48204', '5864781245', 'Jgreg@yahoo.com', 1, 3, 2, '2023-03-25', '2023-05-28'), 
  ('Lefbowitz','Michael', '1973-09-10', 987006423, '1438 E 100th St', 'New York', 'NY', '48257', '5865559847', 'MLeaf@comcast.net', 1, 5, 1, '2019-05-30', null),
  ('Axch','Ben', '2001-01-08', 365782323, '144-70 41st Ave. #4T', 'Atlanta', 'GA', '11355', '5865554763', null, 1, 4, 1, '2021-11-11', null),
  ('Cook','Jason', '1988-04-01', 023213456, '320 John St', 'Dallas', 'TX', '07029', '5865553893', null, 1, 2, 1, '2022-09-13', null),
  ('Griffen','Thomas', '1997-12-25', 874094432, 'Box 86', 'Warren', 'MI', '11368', '5865558329', 'Griffie@comcast.net', 2, 3, 1, '2019-06-11', null),
  ('Kingston','Jason', '1999-08-26', 890023567, '100 East 87th','Victorville', 'CA', '48765','5865551298', 'TheKing@yahoo.com', 1, 5, 1, '2022-05-13', null),
  ('Blake', 'Jacob', '1969-06-09', 786345621, '518 West 120th','Los Angeles', 'CA', '48759','5865553987', 'BlackJac@gmail.com', 1, 3, 1, '2016-09-15', null);
	
SELECT * FROM EMPLOYEE;
 
CREATE TABLE PAY_RATE (
	Pay_ID INTEGER AUTO_INCREMENT NOT NULL,
    Emp_ID INTEGER,
    Hourly_Rate DECIMAL(15,2),
    Salary DECIMAL(15,2),
    CONSTRAINT PayID_PK PRIMARY KEY (Pay_ID),
    CONSTRAINT EmpID_FK FOREIGN KEY (Emp_ID) REFERENCES EMPLOYEE(Employee_ID)
);
INSERT INTO PAY_RATE
(Emp_ID, Hourly_Rate, Salary)
VALUES
(1, 45.20, 94016.00),
(2, 31.25, 65000),
(3, 18.25, 37960.00),
(4, 67.50, 140400.00),
(5, 40.00, 83200.00),
(6, 84.00, 174720.00),
(7, 16.35, 34008.00),
(8, 46.50, 96720.00),
(9, 37.50, 78000.00),
(10, 55.30, 115024.00),
(11, 18.75, 39000.00),
(12, 45.65, 94952.00),
(13, 42.80, 89024.00),
(14, 21.15, 43992.00),
(15, 20.50, 42640.00),
(16, 34.60, 71968.00),
(17, 62.50, 130000.00),
(18, 32.50, 67600.00), 
(19, 26.00, 54080.00),
(20, 34.60, 71968.00);

SELECT * FROM PAY_RATE;

CREATE TABLE TIME_SHEET (
	Time_ID INTEGER AUTO_INCREMENT NOT NULL,
    Employee_ID INTEGER,
    Hours_Worked DECIMAL(15,2),
	CONSTRAINT TimeID_PK PRIMARY KEY (Time_ID),
    CONSTRAINT EmployID_FK FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID)
);
INSERT INTO TIME_SHEET
(Employee_ID, Hours_Worked)
VALUES
(1, 40.00),
(2, 40.00),
(3, 36.50),
(4, 25.00),
(5, 40.00),
(6, 44.50),
(7, 32.00),
(8, 24.00),
(9, 32.25),
(10, null),
(11, 40.00),
(12, 40.00),
(13, 40.00),
(14, null),
(15, 42.50),
(16, 40.00),
(17, 40.00),
(18, 40.00),
(19, 40.00),
(20, 40.00);

SELECT * FROM TIME_SHEET;

CREATE TABLE CHECK_HISTORY (
	Check_ID INTEGER AUTO_INCREMENT NOT NULL,
    Employee_ID INTEGER,
    Check_Date DATETIME,
    StateTax_ID INTEGER,
    FedTax_ID INTEGER,
    CONSTRAINT CheckID_PK PRIMARY KEY (Check_ID),
    CONSTRAINT EmpCkID_FK FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID),
    CONSTRAINT StateCkID_FK FOREIGN KEY (StateTax_ID) REFERENCES STATE_TAX(StateTax_ID),
    CONSTRAINT FedCkID_FK FOREIGN KEY (FedTax_ID) REFERENCES FEDERAL_TAX(FederalTax_ID)
);
INSERT INTO CHECK_HISTORY
(Employee_ID, Check_Date, StateTax_ID, FedTax_ID)
VALUES
(1, '2023-06-17', 3, 1),
(2, '2023-06-17', 2, 1),
(3, '2023-06-17', 5, 1),
(4, '2023-06-17', 3, 1),
(5, '2023-06-17', 1, 1),
(6, '2023-06-17', 3, 1),
(7, '2023-06-17', 3, 1),
(8, '2023-06-17', 5, 1),
(9, '2023-06-17', 2, 1),
(10, '2023-05-13', 4, 1),
(11, '2023-06-17', 2, 1),
(12, '2023-06-17', 3, 1),
(13, '2023-06-17', 3, 1),
(14, '2023-06-03', 1, 1),
(15, '2023-06-17', 4, 1),
(16, '2023-06-17', 2, 1),
(17, '2023-06-17', 5, 1),
(18, '2023-06-17', 3, 1),
(19, '2023-06-17', 1, 1),
(20, '2023-06-17', 1, 1);

SELECT * FROM CHECK_HISTORY;

CREATE TABLE TIME_DIMENSION (
	TimeKey INTEGER NOT NULL ,
    Date DATE,
    DAY INTEGER,
    DAY_NAME VARCHAR(10),
    MONTH INTEGER,
    MONTH_NAME VARCHAR(10),
    Year INTEGER,
    CONSTRAINT TimeKeyPK PRIMARY KEY (TimeKey)
)ENGINE=InnoDB AUTO_INCREMENT=1000;

SELECT * FROM TIME_DIMENSION;

CREATE TABLE PAYROLL_FACT (
	Employee_ID INTEGER,
    Department_ID INTEGER,
    Title_ID INTEGER,
    Status_ID INTEGER,
    State_ID INTEGER,
    Pay_ID INTEGER,
    StateTax_ID INTEGER,
    FederalTax_ID INTEGER,
    Time_ID INTEGER,
    Check_ID INTEGER,
    TimeKey INTEGER,
    Employee_Count INTEGER,
    New_Hire_Count INTEGER,
    Overtime_Pay FLOAT(15,2),
    Gross_Amt FLOAT(15,2),
    CONSTRAINT EmpIDFK FOREIGN KEY (Employee_ID) REFERENCES EMPLOYEE(Employee_ID),
    CONSTRAINT DepIDFK FOREIGN KEY (Department_ID) REFERENCES DEPARTMENT(Department_ID),
    CONSTRAINT TitleIDFK FOREIGN KEY (Title_ID) REFERENCES TITLE(Title_ID),
    CONSTRAINT StatusIDFK FOREIGN KEY (Status_ID) REFERENCES EMP_STATUS(Status_ID),
    CONSTRAINT StateIDFK FOREIGN KEY (State_ID) REFERENCES STATE(State_ID),
    CONSTRAINT PayIDFK FOREIGN KEY (Pay_ID) REFERENCES PAY_RATE(Pay_ID),
    CONSTRAINT STaxIDFK FOREIGN KEY (StateTax_ID) REFERENCES STATE_TAX(StateTax_ID),
    CONSTRAINT FTaxIDFK FOREIGN KEY (FederalTax_ID) REFERENCES FEDERAL_TAX(FederalTax_ID),
    CONSTRAINT TimeIDFK FOREIGN KEY (Time_ID) REFERENCES TIME_SHEET(Time_ID),
    CONSTRAINT CheckIDFK FOREIGN KEY (Check_ID) REFERENCES CHECK_HISTORY(Check_ID),
    CONSTRAINT TimeKeyIDFK FOREIGN KEY (TimeKey) REFERENCES TIME_DIMENSION(TImeKey)
);
INSERT INTO PAYROLL_FACT
(Employee_ID, Department_ID, Title_ID, Status_ID, State_ID, Pay_ID, StateTax_ID, FederalTax_ID, Time_ID,
Check_ID, TimeKey, Employee_Count, New_Hire_Count, Overtime_Pay, Gross_Amt)
VALUES
(1, 2, 1, 1, 3, 1,3, 1, 1, 1, null, null, null, null, null),
(2, 4, 1, 1, 2, 2, 2, 1, 2, 2, null, null, null, null, null),
(3, 3, 1, 1, 5, 3, 5, 1, 3, 3, null, null, null, null, null),
(4, 1, 2, 1, 3, 4, 3, 1, 4, 4, null, null, null, null, null),
(5, 2, 1, 1, 1, 5, 1, 1, 5, 5, null, null, null, null, null),
(6, 2, 2, 1, 3, 6, 3, 1, 6, 6, null, null, null, null, null),
(7, 5, 1, 1, 3, 7, 3, 1, 7, 7, null, null, null, null, null),
(8, 1, 1, 1, 5, 8, 5, 1, 8, 8, null, null, null, null, null),
(9, 5, 2, 1, 2, 9, 2, 1, 9, 9, null, null, null, null, null),
(10, 2, 1, 2, 4, 10, 4, 1, 10, 10, null, null, null, null, null),
(11, 5, 1, 1, 2, 11, 2, 1, 11, 11, null, null, null, null, null),
(12, 1, 1, 1, 3, 12, 3, 1, 12, 12, null, null, null, null, null),
(13, 4, 2, 1, 3, 13, 3, 1, 13, 13, null, null, null, null, null),
(14, 3, 1, 2, 1, 14, 1, 1, 14, 14, null, null, null, null, null),
(15, 5, 1, 1, 4, 15, 4, 1, 15, 15, null, null, null, null, null),
(16, 4, 1, 1, 2, 16, 2, 1, 16, 16, null, null, null, null, null),
(17, 2, 2, 1, 5, 17, 5, 1, 17, 17, null, null, null, null, null),
(18, 3, 1, 1, 3, 18, 3, 1, 18, 18, null, null, null, null, null),
(19, 5, 1, 1, 1, 19, 1, 1, 19, 19, null, null, null, null, null),   
(20, 3, 1, 1, 1, 20, 1, 1, 20, 20, null, null, null, null, null);

SELECT * FROM PAYROLL_FACT;