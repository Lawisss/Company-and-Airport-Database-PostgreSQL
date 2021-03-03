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