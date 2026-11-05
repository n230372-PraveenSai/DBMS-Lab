### DATABASE to be Used

USE gram_panchayath_db;
SHOW TABLES ;

SELECT * FROM citizen ;
SELECT * FROM certificate_type ;
SELECT * FROM certificate_application ;
SELECT * FROM panchayat_office ;


### Part B – Views

-- Level 1 – Understanding

-- Task 1 – Create a View displaying all certificate applications.
CREATE VIEW Certificate_Applications_View AS 
SELECT * FROM certificate_application ;

-- Task 2 – Create a View displaying application ID, citizen ID, and application status.
CREATE VIEW Certificate_Info_View AS 
SELECT application_id , citizen_id , application_date 
FROM certificate_application ;

-- Task 3 – Create a View displaying only approved applications.
CREATE VIEW Approved_Applications AS
SELECT * FROM certificate_application 
WHERE application_status = "Approved" ;

-- Task 4 – Retrieve all records from the approved applications View.
SELECT * FROM Approved_Applications ;

-- Task 5 – Display all Views available in the database.
SHOW FULL TABLES 
WHERE Table_type = 'VIEW' ;


-- Level 2 – Application

-- Task 1 – Create a View displaying certificate name and application date using JOIN.
CREATE VIEW Certificate_Data_View AS 
SELECT ct.certificate_name , ca.application_date 
FROM certificate_application ca 
JOIN certificate_type ct 
ON ca.certificate_id = ct.certificate_type_id ;

-- Task 2 – Create a View displaying citizen name and application status using JOIN.
CREATE VIEW Application_Status_View AS 
SELECT c.full_name , ca.application_status 
FROM certificate_application ca 
JOIN citizen c 
ON ca.citizen_id = c.citizen_id ;

-- Task 3 – Create a View displaying applications submitted to each Panchayat Office.
CREATE VIEW Submitted_Applications_View AS 
SELECT ca.application_id , ca.citizen_id , po.office_id , po.office_name 
FROM certificate_application ca 
JOIN panchayat_office po 
ON ca.office_id = po.office_id ;

-- Task 4 – Create a View displaying the total number of applications for each certificate type.
CREATE VIEW Total_Applications AS 
SELECT ct.certificate_type_id , ct.certificate_name , COUNT(*) as Total_Applications
FROM certificate_type ct 
JOIN certificate_application ca 
ON ct.certificate_type_id = ca.certificate_id 
GROUP BY ( ca.certificate_id );

-- Task 5 – Create a View displaying the total number of applications received by each Panchayat Office.
CREATE VIEW Office_Applications_View AS 
SELECT ca.office_id , po.office_name , COUNT(*) AS Total_Applications
FROM certificate_application ca 
JOIN panchayat_office po 
ON ca.office_id = po.office_id 
GROUP BY (ca.office_id) ;

-- Task 6 – Create a View displaying only pending applications with their certificate names.
CREATE VIEW Pending_Applications_View AS 
SELECT ct.certificate_type_id , ct.certificate_name , ca.application_id
FROM certificate_application ca 
JOIN certificate_type ct 
ON ca.certificate_id = ct.certificate_type_id ;

-- Task 7 – Retrieve selected columns from an existing View using WHERE.
SELECT * FROM Office_Applications_View
WHERE Total_Applications > 3 ;

-- Task 8 – Display the definition of a created View using SHOW CREATE VIEW.
SHOW CREATE VIEW Office_Applications_View ;


-- Level 3 – Medium to Advanced

-- Task 1 – Create a View displaying certificate names and their total application counts.
CREATE VIEW Total_Applications AS 
SELECT ct.certificate_type_id , ct.certificate_name , COUNT(*) as Total_Applications
FROM certificate_type ct 
JOIN certificate_application ca 
ON ct.certificate_type_id = ca.certificate_id 
GROUP BY ( ca.certificate_id );

-- Task 2 – Create a View displaying Panchayat Offices having more than one application.
CREATE VIEW Office_More_Applicaitons_View AS
SELECT ca.office_id , po.office_name , COUNT(*) AS Total_Applications
FROM certificate_application ca 
JOIN panchayat_office po 
ON ca.office_id = po.office_id 
GROUP BY (ca.office_id) 
HAVING COUNT(*) > 1 ;

-- Task 3 – Create a View displaying each certificate type with its earliest and latest application dates.
CREATE VIEW Application_Date_View AS
SELECT ct.certificate_type_id , ct.certificate_name , MAX(application_date) AS Latest_Date , MIN(application_date) AS Earliest_Date
FROM certificate_type ct 
JOIN certificate_application ca 
ON ct.certificate_type_id = ca.certificate_id 
GROUP BY ca.certificate_id ;

-- Task 4 – Create a View displaying citizen names and the number of applications submitted by each citizen.
CREATE VIEW citizen_Total_Applications AS
SELECT c.citizen_id , c.full_name , COUNT(*) as Total_Applications
FROM citizen c
JOIN certificate_application ca 
ON c.citizen_id = ca.citizen_id 
GROUP BY ( ca.citizen_id );

-- Task 5 – Create a View combining citizen, certificate, and application details using multiple JOIN operations.
CREATE VIEW All_Table_Join_View AS
SELECT *
FROM citizen c 
JOIN certificate_application ca
ON ca.citizen_id = c.citizen_id 
JOIN certificate_type ct 
ON ca.certificate_id = ct.certificate_type_id 
JOIN panchayat_office po
ON ca.office_id = po.office_id ; 

-- Task 6 – Create a View displaying approved applications along with citizen names and certificate names.
CREATE VIEW Approved_Application_View AS 
SELECT c.citizen_id , c.full_name , ct.certificate_type_id , ct.certificate_name , ca.application_id , ca.application_status 
FROM certificate_application ca 
JOIN citizen c 
ON ca.citizen_id = c.citizen_id 
JOIN certificate_type ct
ON ct.certificate_type_id = ca.certificate_id 
WHERE ca.application_status = "Approved";

-- Task 7 – Retrieve records from a View using filtering and sorting conditions.
SELECT * FROM Application_Date_View
ORDER BY (Latest_Date);

-- Task 8 – Drop one of the created Views and verify that the View has been removed.
DROP VIEW Approved_Application_View ;
SHOW FULL TABLES 
WHERE Table_type = "VIEW" ;