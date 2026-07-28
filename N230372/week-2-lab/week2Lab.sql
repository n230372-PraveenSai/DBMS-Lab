-- PART A: verify week-1 database 
USE gram_panchayat_db;
SHOW TABLES;

-- Part B – Built-in String Functions 
# LEVEL 1
-- 1. Display all citizen names in uppercase. 
SELECT UPPER(full_name) as 'Full Name'
FROM citizen;

-- 2. Display all village names in lowercase.
SELECT lower(village_name) as 'village Name'
FROM citizen;

-- 3. Find the length of each citizen's full name.
SELECT full_name, LENGTH(full_name) as 'Length of the name '
FROM citizen;

-- 4. Display the first four characters of every reference number.
SELECT SUBSTRING(reference_number,1,4) 
FROM certificate_application;

-- 5. Concatenate the citizen name with village name.
SELECT CONCAT(full_name,' - ' ,village_name) AS 'citizen - village name'
FROM citizen;

# LEVEL 2
-- 6. Replace the word "Certificate" with "Cert." in certificate names.
SELECT REPLACE(certificate_name, 'Certificate','Cert') AS 'certificate name'
FROM certificate_application ;

-- 7. Remove leading or trailing spaces from certificate names.
SELECT TRIM(certificate_name) as 'Certificate name'
FROM certificate_application;

-- 8. Display only the first name of every citizen.
SELECT SUBSTRING_INDEX(full_name,' ',1) AS 'First name'
FROM citizen;

-- 9. Generate a display string in the following format. Citizen : Ravi Kumar Village : Ramapuram
SELECT CONCAT('Citizen : ',full_name,'\n' ,'Village : ',village_name) AS 'Citizen - village name'
FROM citizen;

-- 10. Display all applications whose reference number begins with "GP2026".
SELECT *
FROM certificate_application
WHERE SUBSTRING(reference_number,1, 6) = 'GP2026';

# Part C – Built-in Numeric Functions
# LEVEL 1
-- 1. Round every application fee.
SELECT *, ROUND(application_fee) as 'Application Fee Round figure'
FROM certificate_application; 

-- 2. Display the absolute value of processing_days - 10 
SELECT processing_days, ABS(processing_days -10) AS 'Abs value of processing_days - 10 '
FROM certificate_type; 

SELECT processing_days, POW(processing_days,2) as 'Squares of processing_days'
FROM certificate_type;

#LEVEL 2
-- 4. Find the remainder when processing days are divided by 3. 
SELECT processing_days, MOD(processing_days,3) as 'Remainder of processing_days divided by 3'
FROM certificate_type;

-- 5. Round application fees to one decimal place.
SELECT ROUND(application_fee,1) 
FROM certificate_type;

-- 6. Display the ceiling and floor values of application fees.
SELECT application_fee, CEILING(application_fee) , FLOOR(application_fee)
FROM certificate_type;

#LEVEL 3
-- 7. Generate a random integer between 1 and 100.
SELECT ROUND(RAND() * (100 - 1) + 1) AS 'Random number between 1 to 100';

-- 8. Display the square root of processing days.
SELECT processing_days,ROUND(SQRT(processing_days),3) as 'SQRT of processing days'
FROM certificate_type;

-- 9. Calculate processing_days × 2 for every certificate.
SELECT processing_days, processing_days * 2 AS 'Processing_days x 2'
FROM certificate_type;

-- Part D – Date Functions
#Level 1
-- 1. Display today's date.
SELECT current_date();

-- 2. Display current date and time.
SELECT NOW() AS 'Current data and time';

-- 3.Display only the year from every application date.
SELECT application_date, YEAR(application_date) as 'application date' 
FROM certificate_application;

-- 4. Display only the month from every application date.
SELECT application_date, MONTH(application_date) as 'application date' 
FROM certificate_application;

-- 5. Display only the day of the month.
SELECT application_date, DAY(application_date) as 'application date' 
FROM certificate_application;

#LEVEL 2
-- 6. Display the expected certificate issue date by adding the processing days to the application date.
SELECT DATE_ADD(application_date,INTERVAL ct.processing_days DAY) AS 'Expected Cert Issue date'
FROM certificate_type as ct
LEFT JOIN certificate_application AS ca
ON ct.certificate_name = ca.certificate_name ; 

-- 7. Display the application date after adding 30 days.
SELECT application_date , DATE_ADD(application_date, INTERVAL 30 DAY) AS '+30 days'
FROM certificate_application;

-- 8. Display the application date before subtracting 7 days.
SELECT application_date , DATE_ADD(application_date, INTERVAL -7 DAY) AS '-7 days'
FROM certificate_application;

-- 9. Calculate the number of days between today's date and the application date.
SELECT DATEDIFF(application_date , NOW()) AS 'No.of days Different'
FROM certificate_application;

-- 10. Display applications submitted within the current year.
SELECT * 
FROM certificate_application 
WHERE YEAR(application_date) = YEAR(CURDATE());

# Part E – Conversion Functions
# LEVEL 1
-- 1. Convert application_fee into INTEGER.
SELECT CAST( application_fee AS SIGNED) AS application_feeInt
FROM certificate_type;

-- 2. Convert processing_days into CHAR.
SELECT CAST(processing_days AS CHAR) AS processing_daysChar
FROM certificate_type;

# Level 2
-- 3. Convert application_date into DATETIME.

SELECT CAST(application_date AS DATETIME) AS application_date
FROM certificate_application;

-- 4. Convert processing_days into DECIMAL.
SELECT CAST(processing_days AS DECIMAL) as processing_daysDecimal
FROM certificate_type;

# LEVEL 3
-- 5. Display application fees as character strings.
SELECT CAST(application_fee AS CHARACTER) AS application_fee
FROM certificate_type;

-- 6. Convert numeric values before performing arithmetic operations.
SELECT CAST(application_fee AS SIGNED ) + 10 AS 'application_fee + 10'
FROM certificate_type;

SELECT CAST(processing_days AS DECIMAL(10,2)) + 7 AS 'Processing_days + 7'
FROM certificate_type;