USE gram_panchayat_db;

SHOW TABLES;
SELECT * FROM citizen;
SELECT * FROM certificate_type;
SELECT * FROM certificate_application;
SELECT * FROM panchayat_office;

#Activity 2
ALTER TABLE certificate_application
DROP COLUMN certificate_name;

# Activity 2
ALTER TABLE certificate_application 
ADD COLUMN certificate_id INT NOT NULL,
ADD COLUMN office_id INT NOT NULL;

# Activity 3
UPDATE certificate_application CA 
JOIN certificate_type CT
ON CA.certificate_name = CT.certificate_name
SET CA.certificate_id = CT.certificate_type_id; 

UPDATE certificate_application as ca
JOIN citizen as ci
ON ci.citizen_id = ca.citizen_id
JOIN panchayat_office as po
ON po.village_name = ci.village_name 
SET ca.office_id = po.office_id;

# Activity 4
ALTER TABLE certificate_application
ADD CONSTRAINT 
FOREIGN KEY (citizen_id)
REFERENCES citizen (citizen_id);

ALTER TABLE certificate_application
ADD CONSTRAINT 
FOREIGN KEY (certificate_id)
REFERENCES certificate_type (certificate_type_id),
ADD CONSTRAINT 
FOREIGN KEY (office_id)
REFERENCES panchayat_office (office_id);

# Activity 5
-- Verify the created Foreign Key Constraints using an appropriate SQL command.
SHOW CREATE TABLE certificate_application;

ALTER TABLE certificate_application 
DROP FOREIGN KEY certificate_application_ibfk_5;

# Activity 6
-- Insert a certificate application with a non-existing citizen_id.
INSERT INTO certificate_application 
(application_id, citizen_id, certificate_name, application_date, purpose, application_status, fee_paid, reference_number, issued_date,certificate_id, office_id)
VALUES 
(1100, 110, 'Marks memo', '2026-07-30', 'Proof of marks obtained', 'pending', 50.00, 'GP20267009', '2026-08-15', 7,1);
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 

-- Insert a certificate application with a non-existing certificate_id.
INSERT INTO certificate_application 
(application_id, citizen_id, certificate_name, application_date, purpose, application_status, fee_paid, reference_number, issued_date,certificate_id, office_id)
VALUES 
(1100, 110, 'Marks memo', '2026-07-30', 'Proof of marks obtained', 'pending', 50.00, 'GP20267009', '2026-08-15', 4,9);
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails 

-- Delete a citizen whose certificate applications already exist.
DELETE FROM citizen
WHERE citizen_id = 105;

-- Delete a certificate type that is referenced in the Certificate_Application table.
DELETE FROM certificate_application 
WHERE certificate_id = 4;

-- Part C – SQL Query Practice
-- 1. Display all records from the Citizen table.
SELECT * FROM citizen;

-- 2. Display all records from the Certificate_Application table.
SELECT * FROM certificate_application ;

-- 3. Display the names of all citizens in ascending order.
SELECT full_name 
FROM citizen
ORDER BY full_name;

-- 4. Display all unique villages using DISTINCT.
SELECT DISTINCT village_name 
FROM citizen ;

-- 5. Display all unique certificate types using DISTINCT. 
SELECT DISTINCT certificate_name
FROM certificate_type;

-- 6. Display all unique Panchayat Offices using DISTINCT.
SELECT DISTINCT office_name
FROM panchayat_office;

-- 7. Display certificate applications whose status is 'Pending'.
SELECT application_id, certificate_name 
FROM certificate_application
WHERE application_status = 'Pending';

-- 8. Display citizens belonging to Ramapuram village.
SELECT full_name 
FROM citizen
WHERE village_name = 'Ramapuram';

-- 9. Display certificate applications submitted during the year 2026.
SELECT application_id , certificate_name
FROM certificate_application
WHERE YEAR( application_date) = '2026';

-- 10. Display certificate applications ordered by Application_Date in descending order.
SELECT application_id , certificate_name, application_date
FROM certificate_application
ORDER BY application_date DESC;

-- 11. Display all applications processed by Nuzvid Panchayat Office.
SELECT certificate_name 
FROM certificate_application ca
JOIN panchayat_office po 
ON ca.office_id = po.office_id
WHERE po.office_name = 'Nuzvid panchayat office';

-- 12. Display the names of citizens who applied for an Income Certificate.
SELECT full_name 
FROM citizen c 
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id 
JOIN certificate_type ct
ON ct.certificate_type_id = ca.certificate_id
WHERE ct.certificate_name ='Income Certificate';

-- 13. Display the citizens who applied for either an income or Residence certificate using UNION
SELECT full_name 
FROM citizen c 
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id 
JOIN certificate_type ct
ON ct.certificate_type_id = ca.certificate_id
WHERE ct.certificate_name ='Income Certificate'

UNION  

SELECT full_name 
FROM citizen c 
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id 
JOIN certificate_type ct
ON ct.certificate_type_id = ca.certificate_id
WHERE ct.certificate_name ='Residence Certificate';

-- 14. Display certificate applications submitted during Januar and February using union
SELECT * 
FROM certificate_application 
WHERE MONTH(application_date)= '01'
UNION 
SELECT * 
FROM certificate_application 
WHERE MONTH(application_date)= '02';

-- 15. Display citizens belonging to Ramapuram and Lakshmipuram villages using union
SELECT * 
FROM citizen 
WHERE village_name = 'Ramapuram'
UNION
SELECT * 
FROM citizen 
WHERE village_name = 'Lakshmipuram';

-- 16. Display citizens who hav applied for Both Income Certificate and a Residence Certificate using intersect
SELECT full_name 
FROM citizen c 
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id 
JOIN certificate_type ct
ON ct.certificate_type_id = ca.certificate_id
WHERE ct.certificate_name IN('Income Certificate','Residence Certificate')
GROUP BY c.citizen_id
HAVING COUNT(DISTINCT ct.certificate_name) = 2;

-- 17. Display citizens who submitted certificate applications during both 2025 and 2026 using INTERSECT.
SELECT full_name 
FROM citizen c 
JOIN certificate_application ca 
ON c.citizen_id = ca.citizen_id 
WHERE YEAR(ca.application_date) IN('2025', '2026')
GROUP BY c.citizen_id, c.full_name
HAVING COUNT(DISTINCT YEAR(ca.application_date)) = 2;

-- 18. Display citizens who applied for an Income Certificate but not for a Residence Certificate using EXCEPT (MINUS).
SELECT full_name 
FROM citizen c 
JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id 
JOIN certificate_type ct
ON ct.certificate_type_id = ca.certificate_id
WHERE ct.certificate_name ='Income Certificate' AND 
	c.citizen_id NOT IN(
		SELECT c.citizen_id 
	FROM citizen c 
	JOIN certificate_application ca
	ON c.citizen_id = ca.citizen_id 
	JOIN certificate_type ct
	ON ct.certificate_type_id = ca.certificate_id
	WHERE ct.certificate_name ='Residence Certificate'
    );

-- 19. Display certificate applications submitted during 2026 but not during 2025 using EXCEPT (MINUS).
SELECT full_name 
FROM citizen c
JOIN certificate_application ca 
ON c.citizen_id = ca.citizen_id 
WHERE YEAR(application_date) = '2026' AND c.citizen_id NOT IN (SELECT citizen_id from certificate_application
																WHERE YEAR(application_date)='2025');

/*20 .Attempt to insert a certificate application using an invalid citizen_id.
Record the system-generated error and explain why the insertion is rejected.
*/
INSERT INTO certificate_application()
VALUES
(1109, 11, 'Death certificate','2025-11-11','Proof of death','Approved',100.0,'123', '2025-12-03', 9, 4);

-- Error Code: 1452. Cannot add or update a child row.
-- when we try to insert an invalid citizenId it shows error because of the connection between parent and child tables

/*
21. Attempt to delete a citizen whose certificate applications already exist.
Record the system-generated error and explain the role of Referential
Integrity.
*/

DELETE FROM citizen
WHERE citizen_id = 101;
-- 	Error Code: 1451. Cannot delete or update a parent row. a foreign key constraint fails.

# Level 2 – Nested Queries & Comparison Operators
-- 23. Display the names of citizens who have submitted at least one certificate application using IN.
SELECT full_name 
FROM citizen 
WHERE citizen_id IN ( SELECT citizen_id FROM certificate_application );

-- 24. Display citizens belonging to villages where Income Certificate applications have been submitted using IN.
SELECT full_name 
FROM citizen 
WHERE village_name IN (
	SELECT c.village_name 
    FROM certificate_type ct
    JOIN certificate_application ca
    ON ca.certificate_id = ct.certificate_type_id
    JOIN citizen c
    ON c.citizen_id = ca.citizen_id
);

-- 25. Display citizens who have not submitted any certificate applications using NOT IN.
SELECT full_name 
FROM citizen
WHERE citizen_id NOT IN( SELECT citizen_id FROM certificate_application);

-- 27. Display citizens for whom at least one certificate application exists using EXISTS.
SELECT full_name 
FROM citizen c
WHERE EXISTS(
		SELECT 1
        FROM certificate_application ca
        WHERE c.citizen_id = ca.citizen_id
		);
        
-- 29. Display citizens who do not have any certificate applications using NOT EXISTS.
SELECT full_name 
FROM citizen c
WHERE NOT EXISTS(
		SELECT 1
        FROM certificate_application ca
        WHERE c.citizen_id = ca.citizen_id
		);
        
-- 31. Display citizens whose age is greater than ANY citizen belonging to Ramapuram using ANY.
SELECT full_name 
FROM citizen
WHERE date_of_birth > ANY(SELECT date_of_birth
FROM citizen 
WHERE village_name = 'Ramapuram') AND village_name <> 'Ramapuram';

-- 33. Display citizens whose age is greater than ALL citizens belonging to Ramapuram using ALL.
SELECT full_name 
FROM citizen
WHERE date_of_birth > ALL(SELECT date_of_birth
FROM citizen 
WHERE village_name = 'Ramapuram') AND village_name <> 'Ramapuram';

-- 35. Display the citizen who has submitted the highest number of certificate applications.
SELECT full_name 
FROM citizen 
WHERE citizen_id =(
SELECT citizen_id 
FROM certificate_application 
GROUP BY(citizen_id) 
HAVING COUNT(*) =(
	SELECT MAX(num)
	FROM 
	(SELECT COUNT(application_id) as num
	FROM certificate_application 
	GROUP BY (citizen_id)) as maxCount));
    
-- 36. Display the Panchayat Office that has processed the maximum number of certificate applications.
SELECT office_name 
FROM panchayat_office 
WHERE office_id IN(    
	SELECT office_id
	FROM certificate_application
	GROUP BY office_id
	HAVING COUNT(*) =(
		SELECT MAX(num)
		FROM (
			SELECT COUNT(application_id) AS num
			FROM certificate_application 
			GROUP BY (office_id)) as maxCount
	)
);

-- 37. Display certificate types for which more than five applications have been submitted.
SELECT DISTINCT certificate_name 
FROM certificate_application 
WHERE certificate_id IN (
	SELECT certificate_id 
	FROM certificate_application 
	GROUP BY certificate_id
	HAVING COUNT(DISTINCT application_id)>2
    );
#38
SELECT village_name 
FROM citizen 
WHERE village_name IN (
	SELECT village_name 
    FROM certificate_application ca
    JOIN panchayat_office po
    ON ca.office_id = po.office_id
);

#32 
SELECT * 
FROM certificate_type
WHERE processing_days > ANY(
		SELECT processing_days 
        FROM certificate_type ct
        JOIN certificate_application ca
        ON ct.certificate_type_id = ca.certificate_id
        JOIN panchayat_office po 
        ON po.office_id = ca.office_id
        WHERE po.office_name = 'Nuzvid Panchayat Office'
    );