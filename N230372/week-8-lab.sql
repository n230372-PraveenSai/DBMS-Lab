use gram_panchayat_db;

-- part A
SELECT * FROM citizen ;
SELECT * FROM certificate_type ;
SELECT * FROM certificate_application ;
SELECT * FROM panchayat_office ;

-- TASK -1 Task 1 – Disable AUTOCOMMIT, verify the setting, start a transaction, update one certificate application, and verify the record.
SET AUTOCOMMIT = 0 ;
SELECT @@AUTOCOMMIT;

START TRANSACTION;

UPDATE certificate_application
SET application_status = 'Approved'
WHERE application_id = 1008 ;

COMMIT;

-- Task 2 – Update one certificate application's status and remarks, COMMIT the changes, and verify them.

START TRANSACTION;

UPDATE certificate_application
SET application_status = 'Approved'
WHERE application_id = 1001 ;

COMMIT;

-- Task 3 – Modify an application, use ROLLBACK, and verify that the original values are restored.
START TRANSACTION;

UPDATE certificate_application
SET application_status = 'Rejected'
WHERE application_id = 1018 ;

ROLLBACK;

-- Task 4 – Insert a new certificate application, verify it, ROLLBACK, and confirm that it no longer exists.
START TRANSACTION;

