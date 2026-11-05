CREATE DATABASE healthcare_db;
USE healthcare_db;
DESCRIBE patients;
ALTER TABLE patients
CHANGE COLUMN `ï»¿Patient ID` Patient_ID INT;
DESCRIBE doctor;
ALTER TABLE doctor
CHANGE COLUMN `ï»¿Doctor ID` Doctor_ID INT
DESCRIBE "lab result";
DESCRIBE `lab result`;
ALTER TABLE `lab result`
CHANGE COLUMN `ï»¿Lab Result ID` Labresult_ID INT;
ALTER TABLE visit
CHANGE COLUMN `ï»¿Visit ID` Visit_ID INT;
-- Q1 Total patients
SELECT COUNT(DISTINCT Patient_ID) AS Total_Patients
FROM patients;

-- Q2 Total doctors
select count(distinct Doctor_Id) as Total_Patients
from doctor;

-- Q3 Total visits
select count(distinct Visit_Id) as Total_Visits
from visit;

-- Q4 Avg age of patients
select avg(Age) as Avg_age_of_pateints
from patients;

-- Q5 Top 5 diagnosed conditions
SELECT
    Diagnosis,
    COUNT(*) AS Total_Cases
FROM visit
GROUP BY Diagnosis
ORDER BY Total_Cases DESC
LIMIT 5;

-- Q6 Follow up rate4
SELECT
    ROUND(
        (SUM(CASE
            WHEN `Follow Up Required` = 'Yes' THEN 1
            ELSE 0
        END) * 100.0) / COUNT(*),
        2
    ) AS Follow_Up_Rate_Percentage
FROM visit;

-- Q7 Avg treatment cost per visit
select (`Treatment cost`) as Avg_treatment_cost
from treatments;

-- Q8 Total alb tests conducted
SELECT COUNT(LabResult_ID) AS Total_Lab_Tests_Conducted
FROM `lab result`;

-- Q9 Percentage of abnormal results
SELECT
    ROUND(
        SUM(CASE
                WHEN `Test Result` = 'Abnormal' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
        2
    ) AS Abnormal_Result_Percentage
FROM `lab result`;

-- Q9 Doctor workload
SELECT
    d.`Doctor Name`,
    COUNT(DISTINCT v.`Patient ID`) AS Patients_Handled
FROM doctor d
JOIN visit v
ON d.Doctor_ID = v.`Doctor ID`
GROUP BY d.Doctor_ID, d.`Doctor Name`
ORDER BY Patients_Handled DESC;

-- Q10 total revenue
SELECT
    ROUND(SUM(`Treatment Cost`), 2) AS Total_Revenue
FROM treatments;

-- Year wise revenue
SELECT
    YEAR(STR_TO_DATE(v.`Visit Date`, '%d/%m/%Y')) AS Year,
    ROUND(SUM(t.`Treatment Cost`), 2) AS Total_Revenue
FROM visit v
INNER JOIN treatments t
ON v.Visit_ID = t.`Visit ID`
GROUP BY YEAR(STR_TO_DATE(v.`Visit Date`, '%d/%m/%Y'))
ORDER BY Year;

