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