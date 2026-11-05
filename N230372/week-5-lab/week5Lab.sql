USE gram_panchayat_db;
SHOW TABLES;

SELECT * FROM citizen;
SELECT * FROM certificate_type;
SELECT * FROM certificate_application;
SELECT * FROM panchayat_office;

-- Inserting recommended data into table 
INSERT INTO Certificate_Application
()
VALUES
(1013, 101, 'Death Record Request', '2026-07-08', 'Legal Documentation', 'Submitted', 20.00, 'GP202600072', NULL, 3, 4),
(1008, 102, 'Family Member Certificate','2026-07-02', 'Welfare Scheme Application','Under Review', 40.00, 'GP202600021',NULL, 4, 1),
(1009, 103, 'Property Certificate','2026-07-03', 'Property Documentation', 'Submitted', 50.00, 'GP202600033',NULL, 5, 2),
(1010, 104, 'Residence Certificate','2026-07-04', 'College Admission', 'Approved', 30.00, 'GP202600042','2026-07-10', 1, 2),
(1019, 105, 'No-Dues Certificate','2026-07-05', 'Local Service Requirement', 'Under Review', 25.00, 'GP202600059', NULL, 6, 3),
(1012, 106, 'Birth Record Request', '2026-07-06', 'Personal Documentation', 'Rejected', 20.00, 'GP202600065',NULL, 2, 3),
(1014, 102, 'Family Member Certificate','2026-07-09', 'Government Scheme Application','Approved', 40.00, 'GP202600088', '2026-07-18', 4, 4),
(1016, 104, 'No-Dues Certificate', '2026-07-11', 'Property Transaction','Rejected', 25.00, 'GP20260015',NULL, 6, 5),
(1017, 105, 'Birth Record Request','2026-07-12', 'Passport Documentation', 'Approved', 20.00, 'GP20260014','2026-07-17', 2, 6),
(1018, 106, 'Death Record Request','2026-07-13', 'Insurance Documentation','Under Review', 20.00, 'GP20260019',NULL, 3, 6);

# Laboratory Activites
# Part A

-- Task 1 Display the total number of certificate applications.
SELECT COUNT(*)
FROM certificate_application;

-- Task 2 Display the total number of citizens registered in the database.
SELECT COUNT(*)
FROM citizen;

-- Task 3 Display the number of different certificate types available.
SELECT COUNT(DISTINCT certificate_type_id) as 'Different Certificate types'
FROM certificate_type;

-- Task 4 Display the earliest application date recorded in the database.
/*
SELECT * 
FROM certificate_application
ORDER BY application_date
LIMIT 1;
 */
 
SELECT application_id, application_date 'Earliest application date'
FROM certificate_application
WHERE application_date = (SELECT MIN(application_date) FROM certificate_application);

-- Task 5 Display the latest application date recorded in the database. 
SELECT application_id, application_date AS 'Latest application sate'
FROM certificate_application
WHERE application_date = (SELECT MAX(application_date) FROM certificate_application);

# LEVEL 2
-- Task 1 Display the number of certificate applications for each application status. 
SELECT application_status , COUNT(*) as 'Number of applications'
FROM certificate_application
GROUP BY application_status;

-- Task 2 Display the number of certificate applications for each certificate type. 
SELECT certificate_id, COUNT(*) 'Number of applications'
FROM certificate_application 
GROUP BY certificate_id;

-- Task 3 Display the number of certificate applications submitted at each Panchayat Office. 
SELECT office_id , COUNT(*) 'Number of applications'
FROM certificate_application
GROUP BY office_id;

-- Task 4 Display the number of citizens in each village. 
SELECT village_name , COUNT(citizen_id) 'Number of citizens'
FROM citizen
GROUP BY village_name;

-- Task 5 Display the number of applications submitted on each application date. 
SELECT application_date , COUNT(*)  
FROM certificate_application
GROUP BY application_date;

-- Display the number of applications for each certificate type at each Panchayat Office.
SELECT certificate_id, office_id , COUNT(*) 'Number of applications' 
FROM certificate_application 
GROUP BY certificate_id, office_id;

-- Task 7 Display the number of applications for each certificate type, showing the certificate name 
SELECT ct.certificate_name , ca.certificate_id, COUNT(certificate_id) 'Number of applications'
FROM certificate_application ca 
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
GROUP BY ca.certificate_id;

-- Task 8 Display the number of applications received by each Panchayat Office, showing the office name instead of the office ID. 
SELECT po.office_name, COUNT(application_id)
FROM certificate_application ca 
JOIN panchayat_office po 
ON po.office_id = ca.office_id
GROUP BY ca.office_id;

# Medium to Advanced 
-- Task 1 Display only those certificate types that have more than two applications. 
SELECT ca.certificate_id 'Certificate_types' , ct.certificate_name
FROM certificate_application ca
JOIN certificate_type ct
ON ct.certificate_type_id = ca.certificate_id
GROUP BY certificate_id
HAVING COUNT(*) >2;

-- Task 2 Display only those Panchayat Offices that have received more than two applications
SELECT po.office_name 
FROM certificate_application ca 
JOIN panchayat_office po
ON ca.office_id = po.office_id 
GROUP BY(ca.office_id) 
HAVING COUNT(*)>2;

-- Task 3 Display certificate types in descending order of the number of applications. 
SELECT ct.certificate_name , ca.certificate_id, COUNT(certificate_id) 'Number of applications'
FROM certificate_application ca 
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
GROUP BY ca.certificate_id
ORDER BY COUNT(certificate_id) DESC;

-- Task 4 Display Panchayat Offices in ascending order of the number of applications received. 
SELECT po.office_name, COUNT(application_id) AS NumberOfApplications
FROM certificate_application ca 
JOIN panchayat_office po 
ON po.office_id = ca.office_id
GROUP BY ca.office_id
ORDER BY NumberOfApplications;

-- Task 5 Display certificate types having more than two applications and arrange them from highest number of applications to lowest. 
SELECT ca.certificate_id 'Certificate_types' , ct.certificate_name
FROM certificate_application ca
JOIN certificate_type ct
ON ct.certificate_type_id = ca.certificate_id
GROUP BY certificate_id
HAVING COUNT(*) >2
ORDER BY COUNT(*) DESC;

-- Task 6 Display the certificate type and Panchayat Office combination having the highest number of applications. 
SELECT certificate_id, office_id , COUNT(*) NumberOfApplications
FROM certificate_application 
GROUP BY certificate_id, office_id 
ORDER BY NumberOfApplications DESC;


-- Task 7 Display the application status having the highest number of applications. 
SELECT application_status , COUNT(*) 'Highest Count'
FROM certificate_application ca
GROUP BY application_status 
HAVING COUNT(*) = ((SELECT COUNT(application_id) FROM certificate_application GROUP BY application_status ORDER BY COUNT(application_id) DESC 
					LIMIT 1));
                    
-- Task 8 Display the application status having the lowest number of applications.
SELECT application_status , COUNT(*) 'Lowest application Count'
FROM certificate_application ca
GROUP BY application_status 
HAVING COUNT(*) = ((SELECT COUNT(application_id) FROM certificate_application GROUP BY application_status ORDER BY COUNT(DISTINCT application_id) 
					LIMIT 1));