SET SQL_SAFE_UPDATES = 0;
USE PakistanCensusDatabase;

-- ============================================================================
-- INNER JOIN 
-- ============================================================================

-- Shows top 5 districts in Pakistan with highest number of households.
CREATE OR REPLACE VIEW Most_Populated_Cities AS
SELECT
    p.province_name,
    d.district_name,
    SUM(cb.estimated_household_count) AS total_population
FROM Province p
INNER JOIN Division dv ON p.province_id = dv.province_id
INNER JOIN District d ON dv.division_id = d.division_id
INNER JOIN Tehsil t ON d.district_id = t.district_id
INNER JOIN Union_Council uc ON t.tehsil_id = uc.tehsil_id
INNER JOIN Census_Block cb ON uc.union_council_id = cb.union_council_id
GROUP BY p.province_name, d.district_name
ORDER BY Total_Population DESC
LIMIT 5;

SELECT * FROM Most_Populated_Cities;

-- -----------------------------------------------------------------------

-- Shows people who have Bachelors, Masters or PhD degree with their job and income.
CREATE OR REPLACE VIEW Highly_Educated_Persons AS
SELECT
    CONCAT(p.first_name, ' ', p.last_name) AS name,
    el.level_name,
    es.status_name,
    o.occupation_name,
    i.industry_name,
    p.monthly_income
FROM Person p
INNER JOIN Education_Level el ON p.education_level_id = el.education_level_id
INNER JOIN Employment_Status es ON p.employment_status_id = es.employment_status_id
INNER JOIN Occupation o ON p.occupation_id = o.occupation_id
INNER JOIN Industry i ON p.industry_id = i.industry_id
WHERE UPPER(el.level_name) IN ('BACHELORS', 'MASTERS', 'PHD');

SELECT * FROM Highly_Educated_Persons;


-- ============================================================================
-- LEFT JOIN 
-- ============================================================================

-- Shows all persons with their education, job, occupation and nationality — even if some info is missing.
CREATE OR REPLACE VIEW Citizen_Record AS
SELECT
    CONCAT(p.first_name, ' ', p.last_name) AS name,
    el.level_name,
    es.status_name AS employment_status,
    o.occupation_name,
    i.industry_name,
    n.country_name
FROM Person p
LEFT JOIN Education_Level el ON p.education_level_id = el.education_level_id
LEFT JOIN Employment_Status es ON p.employment_status_id = es.employment_status_id
LEFT JOIN Occupation o ON p.occupation_id = o.occupation_id
LEFT JOIN Industry i ON p.industry_id = i.industry_id
LEFT JOIN Nationality n ON p.nationality_id = n.nationality_id
ORDER BY el.level_name;

SELECT * FROM Citizen_Record;

-- -----------------------------------------------------------------------

-- Shows all married persons with their household size information.
CREATE OR REPLACE VIEW Household_Analysis AS
SELECT
    CONCAT(p.first_name, ' ', p.last_name) AS name,
    ms.status_name,
    h.household_size
FROM Person p
LEFT JOIN Marital_Status ms ON p.marital_status_id = ms.marital_status_id
LEFT JOIN Household h ON p.household_id = h.household_id
WHERE ms.status_name = 'Married';

SELECT * FROM Household_Analysis;


-- ============================================================================
-- RIGHT JOIN 
-- ============================================================================

-- Shows urban census blocks with more than 300 households and their assigned staff.
CREATE OR REPLACE VIEW Urban_Block AS
SELECT
    CONCAT(cs.first_name, ' ', cs.last_name) AS staff_name,
    cs.staff_role,
    cs.contact_number,
    cb.census_block_code,
    cb.estimated_household_count,
    cb.area_sq_km,
    uc.union_council_name,
    t.tehsil_name,
    d.district_name
FROM Census_Staff cs
RIGHT JOIN Census_Block cb ON cs.assigned_census_block_id = cb.census_block_id
RIGHT JOIN Union_Council uc ON cb.union_council_id = uc.union_council_id
RIGHT JOIN Tehsil t ON uc.tehsil_id = t.tehsil_id
RIGHT JOIN District d ON t.district_id = d.district_id
WHERE cb.is_urban = TRUE AND cb.estimated_household_count > 300 AND (cs.staff_role IN ('Enumerator', 'Supervisor') OR cs.staff_role IS NULL)
ORDER BY cb.estimated_household_count DESC;

SELECT * FROM Urban_Block;

-- -----------------------------------------------------------------------

-- Shows educated and full-time employed persons with their religion and mother tongue profile.
CREATE OR REPLACE VIEW Employed_Person AS
SELECT
    CONCAT(p.first_name, ' ', p.last_name) AS name,
    r.religion_name,
    mt.tongue_name AS mother_tongue,
    el.level_name AS education_level,
    es.status_name AS employment_status,
    p.monthly_income,
    TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) AS age
FROM Religion r
RIGHT JOIN Person p ON r.religion_id = p.religion_id
RIGHT JOIN Household h ON p.household_id = h.household_id
RIGHT JOIN Mother_Tongue mt ON p.mother_tongue_id = mt.mother_tongue_id
RIGHT JOIN Education_Level el ON p.education_level_id = el.education_level_id
LEFT JOIN Employment_Status es ON p.employment_status_id = es.employment_status_id
WHERE UPPER(el.level_name) IN ('INTERMEDIATE', 'BACHELORS', 'MASTERS', 'PHD') AND es.status_name = 'Employed Full-Time' AND p.monthly_income > 30000
ORDER BY p.monthly_income DESC;

SELECT * FROM Employed_Person;


-- ============================================================================
-- NATURAL JOIN 
-- ============================================================================

-- Shows married individuals with an income above 20,000, joined implicitly on marital_status_id.
CREATE OR REPLACE VIEW Person_Marital_Report AS
SELECT 
    p.first_name, 
    p.last_name, 
    p.date_of_birth, 
    p.monthly_income, 
    ms.status_name
FROM Marital_Status ms
NATURAL JOIN (
    SELECT marital_status_id, first_name, last_name, date_of_birth, monthly_income 
    FROM Person
) p
WHERE ms.status_name = 'Married' AND p.monthly_income > 20000
ORDER BY p.monthly_income DESC;

SELECT * FROM Person_Marital_Report;

-- -----------------------------------------------------------------------

-- Shows individuals with premium employment statuses earning over 30,000, joined implicitly on employment_status_id.
CREATE OR REPLACE VIEW Person_Employment_Report AS
SELECT 
    p.first_name, 
    p.last_name, 
    p.monthly_income, 
    p.date_of_birth, 
    es.status_name
FROM Employment_Status es
NATURAL JOIN (
    SELECT employment_status_id, first_name, last_name, monthly_income, date_of_birth 
    FROM Person
) p
WHERE es.status_name IN ('Employed Full-Time', 'Self-Employed') AND p.monthly_income > 30000
ORDER BY p.monthly_income DESC;

SELECT * FROM Person_Employment_Report;


-- ============================================================================
-- SELF JOIN
-- ============================================================================

-- Maps out the internal management hierarchy of the census field staff team.
CREATE OR REPLACE VIEW Census_Workforce_Hierarchy AS
SELECT 
    CONCAT(emp.first_name, ' ', emp.last_name) AS staff_member,
    emp.staff_role AS Staff_Role,
    CONCAT(mgr.first_name, ' ', mgr.last_name) AS direct_supervisor
FROM Census_Staff emp
INNER JOIN Census_Staff mgr ON emp.supervisor_id = mgr.staff_id;

SELECT * FROM Census_Workforce_Hierarchy;

-- -----------------------------------------------------------------------

-- Maps out biological family dynamics by identifying the official household head for each member.
CREATE OR REPLACE VIEW Family_Head_Mapping AS
SELECT 
    CONCAT(member.first_name, ' ', member.last_name) AS family_member,
    member.cnic_number AS Member_CNIC,
    CONCAT(head.first_name, ' ', head.last_name) AS household_head,
    head.cnic_number AS Head_CNIC
FROM Person member
INNER JOIN Person head ON member.head_person_id = head.person_id
WHERE member.person_id <> member.head_person_id;

SELECT * FROM Family_Head_Mapping;


-- ============================================================================
-- NESTED QUERIES (IN, ANY, ALL, NOT IN)
-- ============================================================================

-- Purpose: Retrieves names of citizens who live in crowded families with more than 4 members.
SELECT first_name, last_name
FROM Person
WHERE household_id IN (
    SELECT household_id
    FROM Household
    WHERE household_size > 4
);

-- Purpose: Finds citizens earning more than at least one individual of biological sex is male.
SELECT first_name, monthly_income 
FROM Person
WHERE monthly_income > ANY (
    SELECT monthly_income 
    FROM Person 
    WHERE sex_id = 2
);

-- Purpose: Finds citizens earning more than all females.
SELECT first_name, monthly_income 
FROM Person 
WHERE monthly_income > ALL (
    SELECT monthly_income
    FROM Person 
    WHERE sex_id = 2 AND monthly_income IS NOT NULL
);

-- Purpose: Lists all citizens who have never migrated or shifted their residential district.
SELECT first_name, last_name 
FROM Person 
WHERE person_id NOT IN (
    SELECT person_id 
    FROM Migration_History
);

-- Purpose: Finds citizens earning less than or equal to the absolute lowest salary among males.
SELECT first_name, last_name
FROM Person
WHERE monthly_income <= ALL (
    SELECT monthly_income
    FROM Person
    WHERE sex_id = 1
);

-- Purpose: Finds citizens earning less than or equal to at least one individual of among males.
SELECT first_name, last_name
FROM Person 
WHERE monthly_income <= ANY (
    SELECT monthly_income 
    FROM Person 
    WHERE sex_id = 1
);


-- ============================================================================
-- CORRELATED QUERIES (EXISTS, NOT EXISTS)
-- ============================================================================

-- Purpose: Identifies citizens who have an active internal migration or relocation history record.
SELECT p.first_name, p.last_name
FROM Person p 
WHERE EXISTS (
    SELECT 1 
    FROM Migration_History m 
    WHERE m.person_id = p.person_id
);

-- Purpose: Identifies stable citizens who have zero documented history of changing districts.
SELECT p.first_name, p.last_name
FROM Person p 
WHERE NOT EXISTS (
    SELECT 1 
    FROM Migration_History m 
    WHERE m.person_id = p.person_id
);


-- ============================================================================
-- AGGREGATE QUERIES (COUNT, SUM, AVG, MIN, MAX)
-- ============================================================================

-- Purpose: Calculates the total headcount of recorded citizens in the census system database.
SELECT COUNT(*) AS TotalPopulation
FROM Person;

-- Purpose: Computes the gross combined monthly income of the entire surveyed population.
SELECT SUM(monthly_income) AS TotalIncome
FROM Person;

-- Purpose: Evaluates the national baseline average monthly income across all citizens.
SELECT AVG(monthly_income) AS AverageIncome
FROM Person;

-- Purpose: Pinpoints the absolute lowest recorded individual monthly income entry.
SELECT MIN(monthly_income) AS LowestIncome
FROM Person;

-- Purpose: Pinpoints the absolute highest recorded individual monthly income entry.
SELECT MAX(monthly_income) AS HighestIncome
FROM Person;


-- ============================================================================
-- GROUP BY & HAVING CLAUSES
-- ============================================================================

-- Purpose: Groups and counts total population distribution cleanly across distinct biological sexes.
SELECT b.sex_name, COUNT(*) AS Population 
FROM Person p
INNER JOIN Biological_Sex b ON p.sex_id = b.sex_id 
GROUP BY b.sex_name;

-- Purpose: Filters demographic categories to show only biological sexes with more than 40 individuals.
SELECT sex_id, COUNT(*) AS Population 
FROM Person 
GROUP BY sex_id
HAVING COUNT(*) > 40;

-- Purpose: Breaks down population counts and average monthly income metrics categorized by religion.
SELECT r.religion_name, COUNT(*) AS Population, AVG(monthly_income) AS AvgIncome
FROM Person p 
INNER JOIN Religion r ON p.religion_id = r.religion_id
GROUP BY r.religion_name;


-- ============================================================================
-- SET OPERATIONS (UNION, UNION ALL, INTERSECT, EXCEPT)
-- ============================================================================

-- Purpose: Combines distinct first names from both citizens and field staff, removing duplicate values.
SELECT first_name, last_name FROM Person 
UNION 
SELECT first_name, last_name FROM Census_Staff;

-- Purpose: Combines all first names from citizens and field staff, preserving every duplicate entry.
SELECT first_name, last_name FROM Person 
UNION ALL 
SELECT first_name, last_name FROM Census_Staff;

-- Purpose:  Finds common names shared by both active citizens and field census staff.
SELECT first_name, last_name
FROM Person
WHERE first_name IN (
    SELECT first_name
    FROM Census_Staff
);

-- Purpose: Lists first names unique to citizens that do not exist among census staff.
SELECT first_name, last_name 
FROM Person 
WHERE first_name NOT IN (
    SELECT first_name 
    FROM Census_Staff
);


-- ============================================================================
-- VIEWS
-- ============================================================================

-- Shows a complete profile of each citizen, including their full name, age, education, job, and income in plain words instead of codes.
CREATE OR REPLACE VIEW Citizen_SocioEconomic_Profile AS
SELECT
    p.person_id,
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    p.cnic_number,
    b.sex_name AS biological_sex,
    TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) AS age,
    r.religion_name AS religion,
    el.level_name AS education_level,
    es.status_name AS employment_status,
    o.occupation_name AS occupation,
    i.industry_name AS industry,
    p.monthly_income
FROM Person p
INNER JOIN Biological_Sex b ON p.sex_id = b.sex_id
INNER JOIN Religion r ON p.religion_id = r.religion_id
LEFT JOIN Education_Level el ON p.education_level_id = el.education_level_id
LEFT JOIN Employment_Status es ON p.employment_status_id = es.employment_status_id
LEFT JOIN Occupation o ON p.occupation_id = o.occupation_id
LEFT JOIN Industry i ON p.industry_id = i.industry_id;

SELECT * FROM Citizen_SocioEconomic_Profile;

-- -----------------------------------------------------------------------

-- Shows the living conditions of each home, tracking things like room counts, clean water access, electricity, and whether it is in a city or a village.
CREATE OR REPLACE VIEW Household_Living_Standards AS
SELECT
	h.household_size,
    h.number_of_rooms,
    cb.census_block_code,
    IF(cb.is_urban, 'Urban', 'Rural') AS area_classification,
    st.type_name AS structure_type,
    ws.source_name AS water_supply,
    ls.source_name AS lighting_source,
    cfs.fuel_source_name AS cooking_fuel,
    wrs.status_name AS washroom_type,
    ks.status_name AS kitchen_type
FROM Household h
INNER JOIN Structure s ON h.structure_id = s.structure_id
INNER JOIN Census_Block cb ON s.census_block_id = cb.census_block_id
LEFT JOIN Structure_Type st ON s.structure_type_id = st.structure_type_id
LEFT JOIN Water_Source ws ON s.water_source_id = ws.water_source_id
LEFT JOIN Lighting_Source ls ON s.lighting_source_id = ls.lighting_source_id
LEFT JOIN Cooking_Fuel_Source cfs ON s.fuel_source_id = cfs.fuel_source_id
LEFT JOIN Washroom_Status wrs ON s.washroom_status_id = wrs.washroom_status_id
LEFT JOIN Kitchen_Status ks ON s.kitchen_status_id = ks.kitchen_status_id;

-- How to query this view:
SELECT * FROM Household_Living_Standards 
WHERE area_classification = 'Rural';

-- -----------------------------------------------------------------------

-- Groups Pakistan's geographic areas together to show the total number of census blocks and households in every region at a glance.
CREATE OR REPLACE VIEW Regional_Administrative_Summary AS
SELECT
    p.province_name,
    dv.division_name,
    d.district_name,
    t.tehsil_name,
    uc.union_council_name,
    COUNT(cb.census_block_id) AS total_census_blocks,
    SUM(cb.estimated_household_count) AS gross_estimated_households
FROM Province p
INNER JOIN Division dv ON p.province_id = dv.province_id
INNER JOIN District d ON dv.division_id = d.division_id
INNER JOIN Tehsil t ON d.district_id = t.district_id
INNER JOIN Union_Council uc ON t.tehsil_id = uc.tehsil_id
LEFT JOIN Census_Block cb ON uc.union_council_id = cb.union_council_id
GROUP BY 
    p.province_name, 
    dv.division_name, 
    d.district_name, 
    t.tehsil_name, 
    uc.union_council_name;

SELECT province_name, district_name, SUM(gross_estimated_households) AS total_households
FROM Regional_Administrative_Summary
GROUP BY province_name, district_name
ORDER BY total_households DESC;