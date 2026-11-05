SHOW DATABASES;

### DATABASE to be Used

USE gram_panchayath_db;
SHOW TABLES ;

SELECT * FROM citizen ;
SELECT * FROM certificate_type ;
SELECT * FROM certificate_application ;
SELECT * FROM panchayat_office ;

### Part B – Subqueries

-- Level 1 – Understanding

-- Task 1 – Display the latest application date using MAX() inside a subquery
SELECT application_date FROM certificate_application 
WHERE application_date = ( SELECT MAX(application_date) FROM certificate_application ) ;

-- Task 2 – Display the earliest application date using MIN() inside a subquery.
SELECT application_date FROM certificate_application 
WHERE application_date = ( SELECT MIN(application_date) FROM certificate_application ) ;

-- Task 3 – Display the application having the latest application date.
SELECT * FROM certificate_application 
WHERE application_date = ( SELECT MAX(application_date) FROM certificate_application ) ;

-- Task 4 – Display the application having the earliest application date.
SELECT * FROM certificate_application 
WHERE application_date = ( SELECT MIN(application_date) FROM certificate_application ) ;

-- Task 5 – Display all citizens who have at least one approved application.
SELECT c.citizen_id as 'CID' , c.full_name as 'Name' 
FROM citizen c 
WHERE c.citizen_id IN ( SELECT ca.citizen_id FROM certificate_application ca
						WHERE ca.application_status = 'Approved' ) ;
                        
                        
-- Level 2 – Application

-- Task 1 – Display applications submitted after the earliest application date.
SELECT * FROM certificate_application 
WHERE application_date > ( SELECT MIN(application_date) FROM certificate_application ) ;

-- Task 2 – Display applications submitted before the latest application date
SELECT * FROM certificate_application 
WHERE application_date < ( SELECT MAX(application_date) FROM certificate_application ) ;

-- Task 3 – Display citizens who have submitted at least one application.
SELECT * FROM citizen c
WHERE c.citizen_id IN ( SELECT ca.citizen_id FROM certificate_application ca ) ;

-- Task 4 – Display citizens who have not submitted any approved application.
SELECT * FROM citizen c
WHERE c.citizen_id NOT IN ( SELECT ca.citizen_id FROM certificate_application ca 
								WHERE application_status = 'approved') ;

-- Task 5 – Display certificate types that have at least one approved application.
SELECT certificate_type_id, certificate_name   FROM certificate_type ct 
WHERE ct.certificate_type_id IN ( SELECT ca.certificate_id FROM certificate_application ca 
								WHERE application_status = 'approved') ;
                                
-- Task 6 – Display certificate types that have no approved applications.
SELECT * FROM certificate_type ct 
WHERE ct.certificate_type_id NOT IN ( SELECT ca.certificate_id FROM certificate_application ca 
								WHERE application_status = 'approved') ;
                                
-- Task 7 – Display applications having a date later than a calculated reference date using a subquery.





-- Task 8 – Display the certificate name and application date of the latest application.
SELECT ct.certificate_name as 'CertName', ca.application_date as 'Date' 
FROM certificate_type ct 
JOIN certificate_application ca 
ON ct.certificate_type_id = ca.certificate_id 
WHERE application_date = ( SELECT MAX(application_date) 
							FROM certificate_application );
                            

-- Level 3 – Medium to Advanced

-- Task 1 – Display the certificate type having the highest number of applications.
SELECT certificate_name
FROM certificate_type
WHERE certificate_type_id = (
	SELECT certificate_id 
	FROM certificate_application
	GROUP BY certificate_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
    );

-- Task 2 – Display the Panchayat Office having the highest number of applications.
SELECT office_name
FROM panchayat_office
WHERE office_id = (
	SELECT office_id 
	FROM certificate_application
	GROUP BY office_id
	ORDER BY COUNT(*) DESC
	LIMIT 1
    );
    
-- Task 3 – Display certificate types having more applications than the average number of applications per certificate type.
SELECT ct.certificate_name
FROM certificate_type ct
JOIN certificate_application ca 
  ON ct.certificate_type_id = ca.certificate_id
GROUP BY ct.certificate_type_id, ct.certificate_name
HAVING COUNT(ca.application_id) > (
    SELECT AVG(app_count)
    FROM (
        SELECT COUNT(*) AS app_count
        FROM certificate_application
        GROUP BY certificate_id
    ) AS subquery
);
-- Task 4 – Display Panchayat Offices having more applications than at least one other Panchayat Office.
SELECT office_name 
FROM panchayat_office
WHERE office_id IN (SELECT office_id 
FROM certificate_application 
GROUP BY office_id
HAVING COUNT(application_id) > ANY (SELECT COUNT(application_id) 
									FROM certificate_application
                                    GROUP BY office_id));
                                    
-- Task 5 – Display Panchayat Offices having more applications than every other Panchayat Office.
SELECT office_name 
FROM panchayat_office
WHERE office_id IN (SELECT office_id 
FROM certificate_application 
GROUP BY office_id
HAVING COUNT(application_id) > ALL (SELECT COUNT(application_id) 
									FROM certificate_application
                                    GROUP BY office_id));
		
-- Task 6 – Display the certificate type associated with the latest application.
SELECT certificate_name
FROM certificate_type
WHERE certificate_type_id = (
SELECT certificate_id 
FROM certificate_application
WHERE application_date = (SELECT MAX(application_date)
						FROM certificate_application));
                        
-- Task 7 – Display citizens who have submitted more than one certificate application.
SELECT full_name 
FROM citizen 
WHERE citizen_id IN (
SELECT citizen_id 
FROM certificate_application
GROUP BY citizen_id
HAVING COUNT(application_id)>1);

-- Task 8 – Display the application status having the highest number of applications.
SELECT application_status 
FROM certificate_application 
GROUP BY application_status
ORDER BY COUNT(*) DESC
LIMIT 1;