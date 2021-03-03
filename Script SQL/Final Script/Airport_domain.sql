--------------------------------------------------------------
--       Final Script PostgreSQL.
--------------------------------------------------------------

-- Question 3 :  Tables creation

------------------------------------------------------------
-- Table: Airport
------------------------------------------------------------
CREATE TABLE public.Airport(
	name_Airport   VARCHAR (20) NOT NULL,
	CONSTRAINT Airport_PK PRIMARY KEY (name_Airport));

------------------------------------------------------------
-- Table: Technician
------------------------------------------------------------
CREATE TABLE public.Technician(
	name_Technician   VARCHAR (20) NOT NULL,
	salary            INTEGER,
	phone             VARCHAR (15),
	address           VARCHAR (50) NOT NULL,
	name_Airport      VARCHAR (20) NOT NULL,
	CONSTRAINT Technician_PK PRIMARY KEY (name_Technician),
	CONSTRAINT Technician_Airport_FK FOREIGN KEY (name_Airport) REFERENCES public.Airport(name_Airport));

------------------------------------------------------------
-- Table: Test
------------------------------------------------------------
CREATE TABLE public.Test(
	faa             INTEGER  NOT NULL,
	maximum_score   INTEGER,
	name_test       VARCHAR (25),
	CONSTRAINT Test_PK PRIMARY KEY (faa));

------------------------------------------------------------
-- Table: Model
------------------------------------------------------------
CREATE TABLE public.Model(
	ModelNumber   INTEGER  NOT NULL,
	capacity      INTEGER,
	weight        INTEGER,
	CONSTRAINT Model_PK PRIMARY KEY (ModelNumber));


------------------------------------------------------------
-- Table: Plane
------------------------------------------------------------
CREATE TABLE public.Plane(
	RegistrationNumber   INTEGER  NOT NULL,
	ModelNumber          INTEGER  NOT NULL,
	CONSTRAINT Plane_PK PRIMARY KEY (RegistrationNumber),
	CONSTRAINT Plane_Model_FK FOREIGN KEY (ModelNumber) REFERENCES public.Model(ModelNumber));


------------------------------------------------------------
-- Table: Expertises
------------------------------------------------------------
CREATE TABLE public.Expertises(
	name_Technician   VARCHAR (20) NOT NULL,
	ModelNumber       INTEGER  NOT NULL,
	CONSTRAINT Expertises_PK PRIMARY KEY (name_Technician,ModelNumber),
	CONSTRAINT Expertises_Technician_FK FOREIGN KEY (name_Technician) REFERENCES public.Technician(name_Technician),
	CONSTRAINT Expertises_Model0_FK FOREIGN KEY (ModelNumber) REFERENCES public.Model(ModelNumber));


------------------------------------------------------------
-- Table: Tests
------------------------------------------------------------
CREATE TABLE public.Tests(
	RegistrationNumber   INTEGER  NOT NULL,
	faa                  INTEGER  NOT NULL,
	name_Airport         VARCHAR (20) NOT NULL,
	score_test           INTEGER  NOT NULL,
	date_test            DATE  NOT NULL,
	hour_test            TIMETZ  NOT NULL,
	CONSTRAINT Tests_PK PRIMARY KEY (RegistrationNumber,faa,name_Airport),
	CONSTRAINT Tests_Plane_FK FOREIGN KEY (RegistrationNumber) REFERENCES public.Plane(RegistrationNumber),
	CONSTRAINT Tests_Test0_FK FOREIGN KEY (faa) REFERENCES public.Test(faa),
	CONSTRAINT Tests_Airport1_FK FOREIGN KEY (name_Airport) REFERENCES public.Airport(name_Airport));


-- Question 4 :  Data insertion

------------------------------------------------------------
-- Insertion of lines of data for each table
------------------------------------------------------------
    
INSERT INTO Airport(name_Airport)
VALUES('CDG'),
      ('Orly'),
      ('JFK');
	  
INSERT INTO Technician(name_Technician, salary, phone, address, name_Airport)
VALUES('Sophia', 500000, '0645126678', '71 rue pasteur', 'JFK'),
      ('Adrien', 2000000, '0689754122', '45 rue pila',  'CDG'),
      ('Loic', 350000, '0693689412', '22 rue de la caille',  'Orly');
	  
INSERT INTO Test(faa, maximum_score, name_test)
VALUES(123456, 250, 'Airplane test 1'),
      (456789, 990, 'Airplane test 2'),
      (789123, 500, 'Airplane test 3'),
      (532693, 750, 'Airplane test 4');
	  
INSERT INTO Model(ModelNumber, capacity, weight)
VALUES(753159, 1200, 6000),
      (489621, 360, 4200),
      (487322, 240, 1200),
      (625987, 980, 3000);
	  
INSERT INTO Plane(RegistrationNumber, ModelNumber)
VALUES('46', 753159),
      ('24', 489621),
      ('350', 625987),
      ('65', 487322);
      
INSERT INTO Expertises(name_Technician, ModelNumber)
VALUES('Sophia', 625987),
      ('Adrien', 489621),
      ('Loic', 753159);
      
INSERT INTO Tests(RegistrationNumber, faa, name_Airport, date_test, score_test, hour_test)
VALUES('46', 123456, 'CDG','2020-08-13', 45, '06:52:23'),
      ('24', 456789, 'Orly', '2020-07-14', 26, '14:28:49'),
      ('350', 789123, 'Orly', '2020-07-05', 78, '19:17:12'),
      ('65', 532693, 'JFK', '2020-01-26', 102, '12:37:49');
	  

-- Question 5 :  Data queries

------------------------------------------------------------
-- [1] What is the salary of each technicians.
------------------------------------------------------------
SELECT salary FROM Technician;

--------------------------------------------------------------------------------------------------------
-- [2] Give the registration number of each plane that obtain a test lower than 75 points the last year. 
--------------------------------------------------------------------------------------------------------
SELECT Plane.RegistrationNumber FROM Plane
INNER JOIN Tests ON Tests.RegistrationNumber = Plane.RegistrationNumber
INNER JOIN Test ON Test.faa = Tests.faa
WHERE EXTRACT (YEAR FROM Tests.date_test) = 2020 AND Tests.score_test < 75;

-------------------------------------------------------------------------------------
-- [3] How many test are conducted each month the last year.
-------------------------------------------------------------------------------------
SELECT EXTRACT (MONTH FROM date_test) AS test_month, COUNT(*) FROM Tests
WHERE EXTRACT (YEAR FROM date_test) = 2020
GROUP BY EXTRACT (MONTH FROM date_test);

------------------------------------------------------------
-- [4] Give the number of airplanes in each airport.
------------------------------------------------------------
SELECT COUNT(*), Airport.name_Airport FROM Plane
INNER JOIN Tests ON Tests.RegistrationNumber = Plane.RegistrationNumber
INNER JOIN Airport ON Airport.name_Airport = Tests.name_Airport
GROUP BY Airport.name_Airport;

-----------------------------------------------------------------
-- [5] What are the technicians expertise that each airport have.
-----------------------------------------------------------------
SELECT Expertises.ModelNumber,Expertises.name_Technician,Airport.name_Airport FROM Technician
INNER JOIN Expertises ON Expertises.name_Technician = Technician.name_Technician
INNER JOIN Airport ON Airport.name_Airport = Technician.name_Airport
INNER JOIN Model ON Expertises.ModelNumber = Model.ModelNumber;

------------------------------------------------------------------------------------------------
-- [6] What are the airplane models in all the airport sorted by their weight.
-------------------------------------------------------------------------------------------------
SELECT Model.* FROM Model
ORDER BY weight;

-----------------------------------------------------------------------
-- [7]  Give the name of airplane model that have the maximum capacity.
-----------------------------------------------------------------------
SELECT modelnumber, capacity FROM Model
WHERE capacity = (SELECT max (capacity) FROM Model)