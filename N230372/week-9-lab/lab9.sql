USE gram_panchayat_db;

SHOW TABLES;

SELECT * FROM citizen;
SELECT * FROM certificate_application;
SELECT * FROM certificate_type;
SELECT * FROM panchayat_office;

DELIMITER //
CREATE PROCEDURE hello()
BEGIN 
SELECT 'Hello world';
END //

CALL hello();

DELIMITER //
CREATE PROCEDURE getName(IN p_citizen_id INT)
BEGIN 
	SELECT full_name
    FROM citizen
    WHERE citizen_id = p_citizen_id;
END//

CALL getName(101);

-- Task A
-- Task 2 
DELIMITER //
CREATE PROCEDURE welcome_panchayat()
BEGIN 
SELECT 'Welcome to Gram Panchayat Certificate System ' as MSG;
END //

CALL welcome_panchayat();

-- TASK 4
DELIMITER //
CREATE PROCEDURE getCitizenName(IN p_citizen_id INT)
BEGIN 
	SELECT full_name
    FROM citizen
    WHERE citizen_id = p_citizen_id;
END//

CALL getCitizenName(104);

-- TASK 5
DELIMITER //
CREATE PROCEDURE getApplicationDetails(IN applicationID INT)
BEGIN 
    SELECT application_id, application_status
    FROM certificate_application
    WHERE applicationID = application_id;
END //

CALL getApplicationDetails(1001);

-- LEVEL 0
-- TASK 1

DELIMITER //
CREATE PROCEDURE getCitizenDetails(IN p_citizen_id INT)
BEGIN 
	SELECT p_citizen_id ,full_name
    FROM citizen
    WHERE citizen_id = p_citizen_id;
END//

CALL getCitizenDetails(104);

-- Task 2
DELIMITER //
CREATE PROCEDURE getCitizenFullDetails(IN p_citizen_id INT)
BEGIN 
	SELECT *
    FROM citizen
    WHERE citizen_id = p_citizen_id;
END//

CALL getCitizenFullDetails(104);

-- Task 3

DELIMITER //
CREATE PROCEDURE convertStatus(IN appStatus VARCHAR(100))
BEGIN 
	IF appStatus='Approved' THEN
		SELECT 'Application Approved' AS message;
    
    ELSEIF appStatus = 'Pending' THEN 
		SELECT 'Application Under Processing' AS message;
    
    ELSEIF appStatus = 'Rejected' THEN
		SELECT 'Application Rejected' AS message;
    
    ELSE 
		SELECT 'Application status Error' AS message;
	END IF;
END //

CALL convertStatus('Approved');
CALL convertStatus('Rejected');
CALL convertStatus('Pending');    

-- TASK 4 : Return application status
DELIMITER //
CREATE PROCEDURE getApplicationStatus(IN appID INT)
BEGIN 
	SELECT application_id, application_status
    FROM certificate_application
    WHERE application_id = appID;
END //
DELIMITER //
-- DROP PROCEDURE getApplicationStatus;


CALL getApplicationStatus(1001);

-- TASK 5 : dispay number 1 ,2 , 3 , 4, 5 using loop
DELIMITER //
CREATE PROCEDURE printNum(IN n INT)
BEGIN 
	DECLARE count INT DEFAULT 1;
    count : LOOP 
		SELECT count as number;
		SET count = count + 1;
		IF count > 5 THEN
			LEAVE count;
		END IF;
    END LOOP;
END //

CALL printNum(5);    

-- LEVEL 1
-- TASK 1 : citizen details from citizen id
DELIMITER //
CREATE PROCEDURE getApplicationDetails2(IN appID INT)
BEGIN 
	DECLARE a_status VARCHAR(50);
    SELECT application_status INTO a_status 
    FROM certificate_application 
    WHERE application_id = appID; 
    
    IF a_status = 'Approved' THEN 
		SELECT 'Certificate Ready' AS Status ;
	ELSEIF a_status = 'Pending' THEN
		SELECT 'Verification Processing required' AS Status ;
	ELSE 
		SELECT 'Application Rejected' AS Status;
	END IF;
END //

CALL getApplicationDetails2(1009);

-- TASK 2 : citizen Applcation count 
DELIMITER //
CREATE PROCEDURE getApplicationCount(IN citizenID INT)
BEGIN 
	DECLARE count INT;
    SELECT COUNT(*) INTO count 
    FROM certificate_application 
    GROUP BY citizen_id
    HAVING citizen_id = citizenID;
	SELECT count AS NoOfApplications;
END //

CALL getApplicationCount(101);


-- LEVEL 2 
-- TASK 1: Display appId, CitizenID, AppStatus using CURSOR
DELIMITER //
CREATE PROCEDURE pending_applications()
BEGIN 
	DECLARE v_application_id INT;
    DECLARE v_citizen_id INT;
    DECLARE v_application_status VARCHAR(30);
    
    DECLARE application_cursor CURSOR FOR 
		SELECT application_id, citizen_id, application_status
        FROM certificate_Application
        WHERE application_status = 'Pending';
        
	DECLARE CONTINUE HANDLER FOR NOT FOUND 
		SET completed = TRUE;
        
	OPEN application_cursor;
        read_loop:LOOP
		FETCH v_application_cursor
		INTO v_application_id, v_citizen_id, v_application_status;
            
		IF completed THEN
			LEAVE read_loop;
		END IF;
	END LOOP;
	SELECT v_application_id, v_citizen_id, v_application_status;
	CLOSE application_cursor;
END //
DELIMITER //

CALL pending_applications();
-- TASK 2 : Exception handling of applications
DELIMITER //
CREATE PROCEDURE application_exception(IN appId INT)
BEGIN 
	DECLARE v_status VARCHAR(30);
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    BEGIN
		SELECT 'Application Not Found' AS message;
	END;
SELECT application_status INTO v_status
FROM certificate_application
WHERE application_id = appId;

SELECT appId ,v_status AS application_status ;
END //

CALL application_exception(1101);