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

INSERT INTO Test(faa, maximum_score, name_test, date_test, score_test, hour_test, number_test)
VALUES(123456, 250, 'Airplane test 1', '2020-08-13', 45, '06:52:23', 1),
	  (456789, 990, 'Airplane test 2' , '2020-07-14', 26, '14:28:49', 2),
	  (789123, 500, 'Airplane test 3', '2020-07-05', 78, '19:17:12', 3),
	  (532693, 750, 'Airplane test 4', '2020-01-26', 102, '12:37:49', 4);

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
	  
INSERT INTO Tests(RegistrationNumber, faa, name_Airport)
VALUES('46', 123456, 'CDG'),
	  ('24', 456789, 'Orly'),
	  ('350', 789123, 'Orly'),
	  ('65', 532693, 'JFK');