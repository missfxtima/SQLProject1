-- Create a new table with cleaned data
CREATE TABLE cleaned_insurance AS
SELECT
    CAST(age AS INTEGER) AS age,
    sex,
    CAST(bmi AS DECIMAL(5,2)) AS bmi,
    CAST(children AS INTEGER) AS children,
    smoker,
    region,
    CAST(REPLACE(charges, ',', '') AS DECIMAL(10,2)) AS charges
FROM
    insurance;

-- Remove any rows with NULL values
DELETE FROM cleaned_insurance
WHERE age IS NULL
   OR sex IS NULL
   OR bmi IS NULL
   OR children IS NULL
   OR smoker IS NULL
   OR region IS NULL
   OR charges IS NULL;

-- Create age groups
ALTER TABLE cleaned_insurance ADD COLUMN age_group VARCHAR(20);
UPDATE cleaned_insurance
SET age_group = CASE
    WHEN age < 20 THEN 'Under 20'
    WHEN age BETWEEN 20 AND 29 THEN '20-29'
    WHEN age BETWEEN 30 AND 39 THEN '30-39'
    WHEN age BETWEEN 40 AND 49 THEN '40-49'
    WHEN age BETWEEN 50 AND 59 THEN '50-59'
    ELSE '60 and above'
END;

-- Create BMI categories
ALTER TABLE cleaned_insurance ADD COLUMN bmi_category VARCHAR(20);
UPDATE cleaned_insurance
SET bmi_category = CASE
    WHEN bmi < 18.5 THEN 'Underweight'
    WHEN bmi BETWEEN 18.5 AND 24.9 THEN 'Normal'
    WHEN bmi BETWEEN 25 AND 29.9 THEN 'Overweight'
    ELSE 'Obese'
END;

-- Create a charge_category column
ALTER TABLE cleaned_insurance ADD COLUMN charge_category VARCHAR(20);
UPDATE cleaned_insurance
SET charge_category = CASE
    WHEN charges < 5000 THEN 'Low'
    WHEN charges BETWEEN 5000 AND 15000 THEN 'Medium'
    WHEN charges BETWEEN 15001 AND 30000 THEN 'High'
    ELSE 'Very High'
END;
