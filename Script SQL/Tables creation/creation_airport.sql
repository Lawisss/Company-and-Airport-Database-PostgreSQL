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
	date_test       DATE  NOT NULL,
	score_test      INTEGER  NOT NULL,
	hour_test       TIME  NOT NULL,
	number_test     INTEGER  NOT NULL,
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
	CONSTRAINT Tests_PK PRIMARY KEY (RegistrationNumber,faa,name_Airport),
	CONSTRAINT Tests_Plane_FK FOREIGN KEY (RegistrationNumber) REFERENCES public.Plane(RegistrationNumber),
	CONSTRAINT Tests_Test0_FK FOREIGN KEY (faa) REFERENCES public.Test(faa),
	CONSTRAINT Tests_Airport1_FK FOREIGN KEY (name_Airport) REFERENCES public.Airport(name_Airport));
