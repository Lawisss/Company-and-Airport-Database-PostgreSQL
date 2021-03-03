-- Question 3 :  Tables creation

--------------------------------------------------------------
--       Script PostgreSQL.
--------------------------------------------------------------

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
        children_name Varchar (25) NOT NULL,
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