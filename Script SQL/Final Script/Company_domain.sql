--------------------------------------------------------------
--       Final Script PostgreSQL.
--------------------------------------------------------------

-- Question 3 :  Tables creation

------------------------------------------------------------
-- Table: employees
------------------------------------------------------------
CREATE TABLE employees(
        ssn Varchar (10) NOT NULL,
	    employees_name Varchar (25) NOT NULL,
        salary Integer,
        phone  Varchar (15),
    CONSTRAINT employees_PK PRIMARY KEY (ssn));

------------------------------------------------------------
-- Table: departments
------------------------------------------------------------
CREATE TABLE departments(
        department_no Integer NOT NULL,
        department_name Varchar (20),
        budget    Integer NOT NULL,
	    ssn_manager Varchar (10) NOT NULL,
     CONSTRAINT departments_PK PRIMARY KEY (department_no),
	 CONSTRAINT departments_employees_FK FOREIGN KEY (ssn_manager) REFERENCES employees(ssn));

------------------------------------------------------------
-- Table: Children
------------------------------------------------------------
CREATE TABLE Children(
        children_name Varchar (25) NOT NULL ,
        age  Integer,
        ssn Varchar (10) NOT NULL,
	CONSTRAINT Children_PK PRIMARY KEY (children_name),
	CONSTRAINT Children_employees_FK FOREIGN KEY (ssn) REFERENCES employees(ssn));

-----------------------------------------------------------
-- Table: works
------------------------------------------------------------
CREATE TABLE works(
        ssn Varchar (10) NOT NULL,
        department_no Integer NOT NULL,
	CONSTRAINT works_PK PRIMARY KEY (ssn,department_no),
	CONSTRAINT works_employees_FK FOREIGN KEY (ssn) REFERENCES employees(ssn),
	CONSTRAINT works_departments0_FK FOREIGN KEY (department_no) REFERENCES departments(department_no));
	
-- Question 4 :  Data insertion

------------------------------------------------------------
-- Insertion of lines of data for each table
------------------------------------------------------------

INSERT INTO employees(ssn, employees_name, salary, phone)
VALUES('123456', 'Stowe', 2500, '0645126678'),
      ('789101','Drew', 4500,'0689754122'),
      ('121314','Popeye', 3000,'0689754122'),
      ('134714','Clock', 40000,'0689754122'),
      ('196714','Chibadi', 6000,'0693689412');
	  
INSERT INTO departments(department_no, department_name, budget, ssn_manager)
VALUES('123', 'Marketing', 500000,'123456'),
      ('456', 'Trading', 2000000,'121314'),
      ('789', 'DSI', 350000,'789101');
	  
INSERT INTO Children(children_name, age, ssn)
VALUES('Kevin', 25, '123456'),
      ('Momo', 8, '121314'),
      ('Couhande', 21, '789101'),
      ('Nicolas', 22, '789101'),
      ('Oussama', 7, '789101');
	  
INSERT INTO works(ssn, department_no)
VALUES('123456', '123'),
      ('789101', '789'),
      ('121314', '456'),
      ('134714', '456'),
      ('196714', '123');
	  
-- Question 5 :  Data queries

------------------------------------------------------------
-- [1] Give the DSI department employees names.
------------------------------------------------------------
SELECT employees_name FROM employees 
INNER JOIN  works ON works.ssn = employees.ssn
INNER JOIN  departments ON works.department_no = departments.department_no 
WHERE department_name = 'DSI';

-----------------------------------------------------------------
-- [2] which department employs the maximum number of employees. 
-----------------------------------------------------------------
SELECT departments.* FROM departments
INNER JOIN works ON works.department_no = departments.department_no
GROUP BY departments.department_no
ORDER BY COUNT(works.ssn) DESC LIMIT 1;

-------------------------------------------------------------------------------------
-- [3] List all department with the number of employees that each department employs.
-------------------------------------------------------------------------------------
SELECT COUNT(works.ssn) as numberofemployees, departments.* FROM departments
INNER JOIN works ON works.department_no = departments.department_no
GROUP BY departments.department_no;

------------------------------------------------------------
-- [4] What is the name of STOWE’s children.
------------------------------------------------------------
SELECT Children_name FROM Children
INNER JOIN employees on employees.ssn = Children.ssn
WHERE employees_name = 'Stowe';

-------------------------------------------------------------
-- [5] List all department that have a budget greater than 100k.
-------------------------------------------------------------
SELECT * FROM departments
WHERE budget > 100000;

------------------------------------------------------------------------------------------------
-- [6] Give the ssn, salary and department name of all employees that have more than 2 children.
-------------------------------------------------------------------------------------------------
SELECT employees.ssn, salary, department_name FROM employees
INNER JOIN works on works.ssn = employees.ssn
INNER JOIN departments on departments.department_no = works.department_no
INNER JOIN Children on employees.ssn = Children.ssn
GROUP BY (employees.ssn,departments.department_no)
HAVING COUNT(Children.ssn)>2;

------------------------------------------------------------------
-- [7] What is the average salary of each department.
------------------------------------------------------------------
SELECT AVG(salary) FROM employees
INNER JOIN works on works.ssn = employees.ssn
GROUP BY works.department_no;

------------------------------------------------------------------------------------------------------------------------------------------------------
-- [8] Give the name of each department manager, the manager salary, the number of children and the number of employees that this department contains.
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT (employees_name) as manager_name, salary,COUNT(employees.ssn) as numberofemployees, COUNT(Children.ssn) as numberofchildren FROM employees
INNER JOIN works on works.ssn = employees.ssn
INNER JOIN departments ON works.ssn = departments.ssn_manager
INNER JOIN Children on employees.ssn = Children.ssn
GROUP BY (departments.department_no,employees.ssn);