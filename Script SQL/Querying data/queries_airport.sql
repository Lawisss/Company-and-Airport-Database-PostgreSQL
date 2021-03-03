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
SELECT ModelNumber FROM Model
ORDER BY capacity DESC LIMIT 1;