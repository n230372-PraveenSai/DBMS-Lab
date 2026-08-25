USE gram_panchayat_db;


SHOW TABLES;

SELECT * FROM citizen;
SELECT * FROM certificate_type;
SELECT * FROM certificate_application;
SELECT * FROM panchayat_office;

#LEVEL 1
-- Task-1 Display the names of citizens along with the certificate types they have applied for.
SELECT full_name AS Name, ct.certificate_name
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id;

-- Task-2 Display the names of citizens along with the Panchayat Office where their applications were submitted.
SELECT full_name AS Name, po.office_name
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN panchayat_office po
ON ca.office_id = po.office_id;

-- Task-3 Display the Application ID, Citizen Name and Application Status for every certificate application.
SELECT ca.application_id as 'Application ID' , full_name AS Name, ca.application_status as 'Application Status'
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id;

-- Task-4 Display the Citizen Name, Certificate Type and Application Date for every certificate application.
SELECT full_name AS'Citizen Name', ct.certificate_name, ca.application_date As 'Application Date'
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id;

/* Task-5 Display the complete details of every certificate
application including Citizen Name, Certificate Type, Panchayat Office and Application Status.
*/
SELECT full_name AS'Citizen Name', ct.certificate_name, po.office_name as "Panchayat Office", ca.application_status 'Application Status'
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
INNER JOIN panchayat_office po
ON ca.office_id = po.office_id;

# Level 2 – Application
-- Task-6 Display all citizens who have applied for an Income Certificate along with the Panchayat Office name.
SELECT full_name AS'Citizen Name', ct.certificate_name , ca.application_id, po.office_name as "Panchayat Office"
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
INNER JOIN panchayat_office po
ON ca.office_id = po.office_id
WHERE ct.certificate_name = 'Income certificate' ;

-- Task-7 Display all certificate applications submitted to Nuzvid Panchayat Office together with citizen details.
SELECT full_name AS'Citizen Name' , ca.application_id AS 'Application ID',ct.certificate_name , po.office_name as "Panchayat Office"
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
INNER JOIN panchayat_office po
ON ca.office_id = po.office_id
WHERE po.village_name = "Nuzvid";

-- Task-8 Display every certificate application together with the certificate description and application status.
SELECT ca.application_id AS 'Application ID', ca.certificate_name ,ct.description as 'Description', ca.application_status
FROM certificate_application ca
JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id;

-- Task-9 Display the Citizen Name, Village, Certificate Type, Panchayat Office and Application Date for every application.
SELECT full_name AS'Citizen Name', ct.certificate_name AS 'Certificate Type', po.office_name as "Panchayat Office", ca.application_date 'Application Date'
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
INNER JOIN panchayat_office po
ON ca.office_id = po.office_id;

/* 
Task-10 Display a complete Gram Panchayat Certificate
Application Report containing Citizen details, Certificate details,
Panchayat Office details and Application information.
*/
SELECT DISTINCT po.office_name as "Panchayat Office", ct.certificate_name AS 'Certificate Type',
 ca.application_date 'Application Date', full_name AS'Citizen Name' , c.village_name AS 'Village Name'
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id
INNER JOIN panchayat_office po
ON ca.office_id = po.office_id;

# LEVEL 3
-- Task-11 Display all citizens including those who have not submitted any certificate applications.
SELECT full_name AS Name, ca.application_id
FROM citizen c
LEFT JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id ;

-- Task-12 Display all certificate types including those that have never been requested by any citizen.
SELECT full_name AS Name,ca.application_id, ct.certificate_name
FROM citizen c
RIGHT JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
RIGHT JOIN certificate_type ct
ON ca.certificate_id = ct.certificate_type_id;

-- Task-13 Display all citizens and all certificate applications, including unmatched records from both tables.
SELECT full_name AS Name,ca.application_id
FROM citizen c
RIGHT JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
UNION
SELECT full_name AS Name,ca.application_id
FROM citizen c
LEFT JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id;

-- Task-14 Generate every possible combination of Citizens and Certificate Types.
SELECT full_name AS 'Citizen' , ct.certificate_name as 'Certificate_Type'
FROM citizen
JOIN certificate_type ct;

-- Task-15 Display pairs of citizens belonging to the same village without displaying the same citizen twice.
SELECT c1.full_name , c1.village_name 
FROM citizen c1
JOIN citizen c2 
ON c1.citizen_id = c2.citizen_id ;