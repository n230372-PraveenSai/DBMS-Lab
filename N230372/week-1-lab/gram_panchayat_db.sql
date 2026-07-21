CREATE DATABASE gram_panchayat_db;
USE gram_panchayat_db;

CREATE TABLE Citizen(
	citizen_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) NOT NULL,
    mobile_number VARCHAR(10) UNIQUE NOT NULL,
    occupation VARCHAR(50) ,
    village_name VARCHAR(50) NOT NULL,
    is_active BOOLEAN NOT NULL
);


CREATE TABLE Certificate_type(
	certificate_type_id INT PRIMARY KEY,
    certificate_name VARCHAR(100) UNIQUE NOT NULL,
    description VARCHAR(200) NOT NULL,
    processing_days INT NOT NULL,
    application_fee DECIMAL(8,2) NOT NULL,
    is_available BOOLEAN NOT NULL
);


CREATE TABLE Certificate_Application(
	application_id INT PRIMARY KEY,
    citizen_id INT NOT NULL,
    certificate_name VARCHAR(100) NOT NULL,
    application_date DATE NOT NULL,
    purpose VARCHAR(200) NOT NULL,
    application_status VARCHAR(30) NOT NULL,
    fee_paid DECIMAL(8,2) NOT NULL,
    reference_number VARCHAR(30) UNIQUE NOT NULL
);


CREATE TABLE Panchayat_Office(
	office_id INT PRIMARY KEY,
    office_name VARCHAR(100) NOT NULL,
    village_name VARCHAR(50) NOT NULL,
    pincode VARCHAR(6) NOT NULL,
    contact_number VARCHAR(15) UNIQUE,
    office_email VARCHAR(100) UNIQUE,
    opening_time TIME NOT NULL,
    is_operational BOOLEAN NOT NULL
);


  
INSERT INTO Certificate_Application
(application_id,citizen_id,certificate_name,application_date,purpose,application_status,fee_paid,reference_number)
VALUES
( 1001 , 101 , "Residence Certificate" , "2026-07-01" , "Bank Account Documentation" , "Submitted" , 30.00 , "GP20260001" ),
( 1002 , 102 , "Family Member Certificate" , "2026-07-02" , "Welfare Scheme Application" , "Under Review" , 40.00 , "GP20260002" ),
( 1003 , 103 , "Property Certificate" , "2026-07-03" , "Property Documentation" , "Submitted" , 50.00 , "GP20260003" ),
( 1004 , 104 , "Residence Certificate" , "2026-07-04" , "College Admission" , "Approved" , 30.00 , "GP20260004" ),
( 1005 , 105 , "No-Dues Certificate" , "2026-07-05" , "Local Service Requirement" , "Under Review" , 25.00 , "GP20260005" ),
( 1006 , 106 , "Birth Record Requests" , "2026-07-06" , "Personal Documentation" , "Rejected" , 20.00 , "GP20260006" );

INSERT INTO citizen 
(citizen_id, full_name, date_of_birth, gender, mobile_number, occupation, village_name, is_active)
VALUES
(101,"Ravi Kumar",'1995-06-15','Male','9876500001','Farmer','Ramapuram',TRUE),
(102,"Lakshmi Devi",'1988-11-22','Female','9876500002','Tailor',"Ramapuram",TRUE),
(103,"Suresh Babu",'1992-03-10','Male',9876500003,"Shopkeeper","Seethampeta",TRUE),
(104,"Anjali rao",'2000-08-05',"Female",'987650004',"Student",'Ramapuram',TRUE),
(105,"Kiran kumar",'1985-01-18',"Male",9876500005,"Electrician",'Seethampeta',TRUE),
(106,'Meena Kumari','1995-12-30',"Female",9876500006,'Teacher','Lakshmipuram',FALSE);

INSERT INTO Certificate_type
(certificate_type_id,certificate_name,description,processing_days,application_fee,is_available)
VALUES 
( 1 , "Residence Certificate" , "Certifies the declared place of residence" , 7 , 30.00 , TRUE ),
( 2 , "Birth Record Request" , "Request for a locally maintained birth record" , 5 , 20.00 , TRUE ),
( 3 , "Death Record Request" , "Request for a locally maintained death record" , 5 , 20.00 , TRUE ),
( 4 , "Family Member Certificate" , "Records Declared Family-Member Information" , 10 , 40.00 , TRUE ),
( 5 , "Property Certificate" , "Certificate Related to Locally Maintained Property Records" , 15 , 50.00 , TRUE ),
( 6 , "No-Dues Certificate" , "Indicates Applicable Local dues status" , 7 , 25.00 , FALSE );

INSERT INTO Panchayat_Office 
(office_id,office_name,village_name,pincode,contact_number,office_email,opening_time,is_operational)
VALUES
(1,'Ramapuram Gram Panchayat','Ramapuram','521101','0866000001','ramapuram@gmail.example','09:00:00',TRUE),
(2,'Seethampeta Gram Panchayat','Seethampeta','521102','0866000002','seethampeta@gmail.example','09:30:00',TRUE),
(3,'Lakshmipuram Gram Panchayat','Lakshmipuram','521103','0866000003','lakshmipuram@gmail.example','09:00:00',TRUE),
(4,'Krishnapuram Gram Panchayat','Krishnapuram','521104','0866000004','krishnapuram@gmail.example','10:00:00',TRUE),
(5,'Venkatapuram Gram Panchayat','Venkatapuram','521105','0866000005','venkatapuram@gmail.example','09:30:00',TRUE),
(6,'Gopalapuram Gram Panchayat','Gopalapuram','521106','0866000006','gopalapuram@gmail.example','09:00:00',FALSE);

-- DML TASKS
-- 1. Add a new citizen with citizen_id = 107.
INSERT INTO citizen 
VALUES
(107,'PDVVT Nandagul','2008-03-15','Male','9540288372','Software Engineer','Hyderabad',TRUE);

-- 2. Add a new certificate service called Income Certificate with appropriate values.
INSERT INTO Certificate_type
VALUES
(7,'Income Certificate',"verifies an individual's or family's total earnings",10,50.00,TRUE);

-- 3. Change application 1001 from Submitted to Under Review.
UPDATE certificate_application 
SET application_status = 'Under Review'
WHERE application_id = 1001 ;

-- 4. Change application 1002 from Under Review to Approved. 
UPDATE certificate_application 
SET application_status = 'Approved'
WHERE application_id = 1002 ;

-- 5.Change the occupation of citizen 105 from Electrician to Electrical Technician.
UPDATE citizen 
SET occupation = 'Electrical Technician'
WHERE citizen_id = 105;

-- 6. Change the processing time of Property Certificate from 15 days to 12 days.
UPDATE certificate_type
SET processing_days = 12
WHERE certificate_name = 'Property Certificate';

-- 7. Mark the No-Dues Certificate service as available.
UPDATE certificate_type
SET is_available = TRUE
WHERE certificate_name = 'No-Dues Certificate';

-- 8. Delete the newly inserted citizen with citizen_id = 107.
DELETE FROM citizen
WHERE citizen_id = 107;

-- DDL TASKS 
-- 1. Add a new column named address to the Citizen table.

ALTER TABLE citizen
ADD COLUMN address VARCHAR(100) NOT NULL;

-- 2. Add a new column named issued_date to the Certificate_Application table.
ALTER TABLE certificate_application 
ADD issued_date DATE ;

-- 3. Increase the maximum size of the purpose column in Certificate_Application.
ALTER TABLE certificate_application 
MODIFY purpose VARCHAR(300) NOT NULL;

-- 4. Add a new column named closing_time to Panchayat_Office.
ALTER TABLE panchayat_office
ADD COLUMN closing_time TIME NOT NULL;

-- Part F --TRUNCATE and DROP


CREATE TABLE temporary_Request(
	request_id INT PRIMARY KEY ,
    request_name VARCHAR(50) NOT NULL,
    request_date DATE NOT NULL
);

INSERT INTO temporary_Request
VALUES
(101,'DBMS','2007-12-03'),
(102,'DAA','2008-03-18'),
(103,'PS','2008-11-15'); 

-- 1. Display the table elements
SELECT * FROM temporary_Request;

-- 2.Use TRUNCATE to remove all records.
TRUNCATE TABLE temporary_Request;

-- 3.Observe that the table still exists.
SHOW TABLES;

-- 4.Use DROP to remove the entire table. 
DROP TABLE temporary_Request;

-- Part G : Constraint Experiments
-- Experiment 1 : Try inserting a citizen with citizen_id 101

INSERT INTO citizen 
(citizen_id, full_name, date_of_birth, gender, mobile_number, occupation, village_name, is_active,address)
VALUES
(101,"PDVVT Nandagul",'2008-03-15','Male','9876543211','Director','Visakhapatnam',TRUE, 'Gajuwaka');

-- Error Code: 1062. Duplicate entry '101' for key 'citizen.PRIMARY'

-- Experiment 2 : Unique Constraint . Try adding a citizen with already existing mobile_number = ' 98765000001'
INSERT INTO citizen 
(citizen_id, full_name, date_of_birth, gender, mobile_number, occupation, village_name, is_active,address)
VALUES
(107,"PDVVT Nandagul",'2008-03-15','Male','9876500001','Director','Visakhapatnam',TRUE,'nuzvid');
-- Error Code: 1062. Duplicate entry '9876500001' for key 'citizen.mobile_number'

-- Experiment 3 : NOT NULL . Try adding a certificate type wihout a certificate_name
INSERT INTO certificate_type
(certificate_type_id,description,processing_days, application_fee, is_available)
VALUES
(7, "Bank account documentation", 10, 50.00,TRUE);
-- ERROR : Error Code: 1364. Field 'certificate_name' doesn't have a default value	

-- Experiment 4: Unique Reference Number , Try inserting another application with: reference_number = GP20260001

INSERT INTO certificate_application 
(application_id,citizen_id,certificate_name,application_date,purpose,application_status,fee_paid,reference_number)
VALUES
(1011,111, 'Birth certificate ','2026-11-09' ,'personal information','pending',  50.00, 'GP20260001');
 -- Error Code: 1062. Duplicate entry 'GP20260001' for key 'certificate_application.reference_number'
 