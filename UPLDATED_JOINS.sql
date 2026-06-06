SET SQL_SAFE_UPDATES = 0;

-- ============================================================================
-- LEVEL 0: PAKISTAN CENSUS DATABASE  
-- ============================================================================

-- DROP DATABASE PakistanCensusDatabase;
CREATE DATABASE IF NOT EXISTS PakistanCensusDatabase;
USE PakistanCensusDatabase;

-- ============================================================================
-- LEVEL 01: ADMINISTRATIVE & UTILITY MASTER LOOKUPS  
-- ============================================================================

CREATE TABLE IF NOT EXISTS Water_Source (
    water_source_id TINYINT AUTO_INCREMENT,
    source_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_water_source PRIMARY KEY (water_source_id)
);
-- insert: tap water, hand pump, motor/borehole, protected well, unprotected well, tanker, river/canals

CREATE TABLE IF NOT EXISTS Lighting_Source (
    lighting_source_id TINYINT AUTO_INCREMENT,
    source_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_lighting_source PRIMARY KEY (lighting_source_id)
);
-- insert: electricity grid, solar power, gas lamp, kerosene oil, candles, generator

CREATE TABLE IF NOT EXISTS Cooking_Fuel_Source (
    fuel_source_id TINYINT AUTO_INCREMENT,
    fuel_source_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_fuel_source_id PRIMARY KEY (fuel_source_id)
);
-- insert: natural gas piping, lpg cylinder, firewood, dung cake, charcoal, electricity

CREATE TABLE IF NOT EXISTS Washroom_Status (
    washroom_status_id TINYINT AUTO_INCREMENT,
    status_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_washroom_status PRIMARY KEY (washroom_status_id)
);
-- insert: flush connected to public sewerage, flush connected to septic tank, pit latrine, open field

CREATE TABLE IF NOT EXISTS Kitchen_Status (
    kitchen_status_id TINYINT AUTO_INCREMENT,
    status_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_kitchen_status PRIMARY KEY (kitchen_status_id)
);
-- insert: separate indoor kitchen, shared indoor kitchen, outdoor cooking space, no kitchen space

CREATE TABLE IF NOT EXISTS Household_Category (
    household_category_id TINYINT AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    CONSTRAINT pk_household_category PRIMARY KEY (household_category_id)
);
-- insert: regular family, institutional quarters, transient homeless

CREATE TABLE IF NOT EXISTS Residential_Status_Type (
    residential_status_type_id TINYINT AUTO_INCREMENT,
    status_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    CONSTRAINT pk_residential_status_type PRIMARY KEY (residential_status_type_id)
);
-- insert: owned, rented, rent free, government allotted

-- --------------------------------------------------

CREATE TABLE IF NOT EXISTS Biological_Sex (
    sex_id TINYINT AUTO_INCREMENT,  
    sex_name VARCHAR(30) NOT NULL UNIQUE,  
    CONSTRAINT pk_biological_sex PRIMARY KEY (sex_id)
);
-- insert: male, female, transgender, other

CREATE TABLE IF NOT EXISTS Religion (
    religion_id TINYINT AUTO_INCREMENT,
    religion_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_religion PRIMARY KEY (religion_id)
);
-- insert: islam, hinduism, christianity, ahmadiyya, sikhism, buddhism

CREATE TABLE IF NOT EXISTS Mother_Tongue (
    mother_tongue_id TINYINT AUTO_INCREMENT,
    tongue_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_mother_tongue PRIMARY KEY (mother_tongue_id)
);
-- insert: urdu, punjabi, pashto, sindhi, balochi, saraiki, hindko, brahui, english

CREATE TABLE IF NOT EXISTS Education_Level (
    education_level_id TINYINT AUTO_INCREMENT,
    level_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_education_level_id PRIMARY KEY (education_level_id)
);
-- insert: uneducated primary, middle, matriculation, intermediate, bachelors, masters, doctorate

CREATE TABLE IF NOT EXISTS Employment_Status (
    employment_status_id TINYINT AUTO_INCREMENT,
    status_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_employment_status PRIMARY KEY (employment_status_id)
);
-- insert: employed, unemployed looking for work, unemployed not looking, student, retired

CREATE TABLE IF NOT EXISTS Marital_Status (
    marital_status_id TINYINT AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT pk_marital_status PRIMARY KEY (marital_status_id)
);
-- insert: single, married, widowed, divorced, separated

CREATE TABLE IF NOT EXISTS Disability_Type (
    disability_type_id TINYINT AUTO_INCREMENT,
    disability_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_disability_type_id PRIMARY KEY (disability_type_id)
);
-- insert: visual impairment, hearing impairment, physical mobility, mental illness, multiple disabilities

CREATE TABLE IF NOT EXISTS Occupation (
    occupation_id SMALLINT AUTO_INCREMENT,
    occupation_name VARCHAR(150) NOT NULL UNIQUE,
    CONSTRAINT pk_occupation PRIMARY KEY (occupation_id)
);
-- insert: crop farm laborer, shop keeper, primary school teacher, software developer, domestic helper, driver

CREATE TABLE IF NOT EXISTS Industry (
    industry_id SMALLINT AUTO_INCREMENT,
    industry_name VARCHAR(150) NOT NULL UNIQUE,
    CONSTRAINT pk_industry PRIMARY KEY (industry_id)
);
-- insert: agriculture and farming, wholesale and retail trade, education, health and social work, public administration

CREATE TABLE IF NOT EXISTS Relationship_Type (
    relationship_type_id TINYINT AUTO_INCREMENT,
    relationship_name VARCHAR(50) NOT NULL UNIQUE, 
    CONSTRAINT pk_relationship_type PRIMARY KEY (relationship_type_id)
);
-- insert: head of household, spouse, biological child, adopted child, parent, sibling, grandchild, non relative

-- --------------------------------------------------

CREATE TABLE IF NOT EXISTS Nationality (
    nationality_id TINYINT AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL UNIQUE,
    citizenship_status ENUM('Citizen', 'Foreign_Expat', 'Refugee', 'Stateless') NOT NULL,
    CONSTRAINT pk_nationality PRIMARY KEY (nationality_id)
);
-- examples to insert: pakistan, afghanistan, china, bangladesh, iran

CREATE TABLE IF NOT EXISTS Union_Council_Classification (
    union_council_classification_id TINYINT AUTO_INCREMENT,  
    classification_name VARCHAR(100) NOT NULL UNIQUE, 
    description TEXT,
    CONSTRAINT pk_uc_classification PRIMARY KEY (union_council_classification_id)
);
-- insert: municipal committee urban, town committee, rural council

CREATE TABLE IF NOT EXISTS Census_Cycle (
    census_id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    census_year INT NOT NULL UNIQUE,
    census_title VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE
);
-- insert: 2017 national census pakistan, 2023 digital census pakistan 

CREATE TABLE IF NOT EXISTS Structure_Type (
    structure_type_id TINYINT AUTO_INCREMENT,
    type_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    CONSTRAINT pk_structure_type PRIMARY KEY (structure_type_id)
);
-- insert: pure residential, commercial only, mixed use residential commercial, institutional property, vacant shell

CREATE TABLE IF NOT EXISTS Commercial_Sector_Type (
    commercial_type_id TINYINT AUTO_INCREMENT,
    commercial_type_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    CONSTRAINT pk_commercial_sector_type PRIMARY KEY (commercial_type_id)
);
-- insert: retail or wholesale market, manufacturing factory, financial bank branch, logistics warehouse, hospitality hotel


-- ============================================================================
-- LEVEL 02: GEOGRAPHIC HIERARCHY  
-- ============================================================================

CREATE TABLE IF NOT EXISTS Province (
    province_id TINYINT AUTO_INCREMENT,
    province_name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT pk_province PRIMARY KEY (province_id)
);
-- insert: punjab, sindh, khyber pakhtunkhwa, balochistan, islamabad capital territory, gilgit baltistan, azad kashmir

CREATE TABLE IF NOT EXISTS Division (
    division_id SMALLINT AUTO_INCREMENT,
    division_name VARCHAR(100) NOT NULL,
    province_id TINYINT NOT NULL,
    CONSTRAINT pk_division PRIMARY KEY (division_id),
    CONSTRAINT fk_province FOREIGN KEY (province_id) REFERENCES Province(province_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT uq_division_per_province UNIQUE (division_name, province_id)
);
-- insert: lahore division under punjab, karachi division under sindh, rawalpindi division under punjab

CREATE TABLE IF NOT EXISTS District (
    district_id SMALLINT AUTO_INCREMENT,
    district_name VARCHAR(100) NOT NULL,
    division_id SMALLINT NOT NULL,
    CONSTRAINT pk_district PRIMARY KEY (district_id),
    CONSTRAINT fk_division FOREIGN KEY (division_id) REFERENCES Division(division_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT uq_district_per_division UNIQUE (district_name, division_id)
);
-- insert: peshawar district under peshawar division, quetta district under quetta division

CREATE TABLE IF NOT EXISTS Tehsil (
    tehsil_id SMALLINT AUTO_INCREMENT,
    tehsil_name VARCHAR(100) NOT NULL,
    district_id SMALLINT NOT NULL,
    CONSTRAINT pk_tehsil PRIMARY KEY (tehsil_id),
    CONSTRAINT fk_district FOREIGN KEY (district_id) REFERENCES District(district_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT uq_tehsil_per_district UNIQUE (tehsil_name, district_id)
);
-- insert: lahore cantt tehsil under lahore district, gujranwala city tehsil under gujranwala district

CREATE TABLE IF NOT EXISTS Union_Council (
    union_council_id INT AUTO_INCREMENT,
    union_council_name VARCHAR(100) NOT NULL,
    union_council_classification_id TINYINT NOT NULL,
    tehsil_id SMALLINT NOT NULL,
    CONSTRAINT pk_union_council PRIMARY KEY (union_council_id),
    CONSTRAINT fk_union_council_class FOREIGN KEY (union_council_classification_id) REFERENCES Union_Council_Classification(union_council_classification_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_tehsil FOREIGN KEY (tehsil_id) REFERENCES Tehsil(tehsil_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT uq_uc_per_tehsil UNIQUE (union_council_name, tehsil_id)
);
-- insert: uc 45 model town under lahore city tehsil, uc 12 dummba goth under malir tehsil

CREATE TABLE IF NOT EXISTS Census_Block (
    census_block_id INT AUTO_INCREMENT,
    census_block_code VARCHAR(20) UNIQUE NOT NULL,
    estimated_household_count INT DEFAULT 0 CHECK (estimated_household_count >= 0),
    is_urban BOOLEAN NOT NULL,        
    area_sq_km DECIMAL(10, 2),           
    union_council_id INT NOT NULL,
    CONSTRAINT pk_census_block PRIMARY KEY (census_block_id),
    CONSTRAINT fk_union_council FOREIGN KEY (union_council_id) REFERENCES Union_Council(union_council_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- geographic enumeration boundaries drawn  


-- ============================================================================
-- LEVEL 03: ADMINISTRATIVE PERSONNEL & BASE STRUCTURE DATA
-- ============================================================================

CREATE TABLE IF NOT EXISTS Census_Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    staff_role ENUM('Supervisor', 'Enumerator', 'Quality_Checker', 'Data_Entry_Operator') NOT NULL,
    contact_number VARCHAR(20),
    email VARCHAR(100),
    assigned_census_block_id INT,
    supervisor_id INT,
    employment_date DATE NOT NULL,
    CONSTRAINT fk_census_block FOREIGN KEY (assigned_census_block_id) REFERENCES Census_Block(census_block_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_staff_supervisor FOREIGN KEY (supervisor_id) REFERENCES Census_Staff(staff_id) ON DELETE SET NULL ON UPDATE CASCADE
);
-- management ledger cataloging operational field survey agents and field management supervisors

CREATE TABLE IF NOT EXISTS Structure (
    structure_id INT AUTO_INCREMENT,
    structure_address_no VARCHAR(50) NOT NULL,
    gps_latitude DECIMAL(9, 6),
    gps_longitude DECIMAL(9, 6),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    census_block_id INT NOT NULL,
    structure_type_id TINYINT NOT NULL,
    water_source_id TINYINT,
    lighting_source_id TINYINT,
    fuel_source_id TINYINT,
    washroom_status_id TINYINT,
    kitchen_status_id TINYINT,
    
    CONSTRAINT pk_structure PRIMARY KEY (structure_id),
    CONSTRAINT fk_census_block_struct FOREIGN KEY (census_block_id) REFERENCES Census_Block(census_block_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_structure_type FOREIGN KEY (structure_type_id) REFERENCES Structure_Type(structure_type_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_struct_water FOREIGN KEY (water_source_id) REFERENCES Water_Source(water_source_id),
    CONSTRAINT fk_struct_lighting FOREIGN KEY (lighting_source_id) REFERENCES Lighting_Source(lighting_source_id),
    CONSTRAINT fk_struct_fuel FOREIGN KEY (fuel_source_id) REFERENCES Cooking_Fuel_Source(fuel_source_id),
    CONSTRAINT fk_struct_washroom FOREIGN KEY (washroom_status_id) REFERENCES Washroom_Status(washroom_status_id),
    CONSTRAINT fk_struct_kitchen FOREIGN KEY (kitchen_status_id) REFERENCES Kitchen_Status(kitchen_status_id)
);
-- foundational property inventory mapping physical coordinates housing conditions and domestic utility availability


-- ============================================================================
-- LEVEL 04: INHERITED STRUCTURAL BRANCHES 
-- ============================================================================

CREATE TABLE IF NOT EXISTS Structure_Institution (
    structure_id INT NOT NULL,
    institution_type VARCHAR(100) NOT NULL, 
    organization_name VARCHAR(150) NOT NULL,
    population_count INT DEFAULT 0,
    is_government BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT pk_structure_institution PRIMARY KEY (structure_id),
    CONSTRAINT fk_structure_institution FOREIGN KEY (structure_id) REFERENCES Structure(structure_id) ON DELETE CASCADE
);
-- extension registry cataloging specialized collective dwellings like prisons shelters hospitals and religious boarding schools

CREATE TABLE IF NOT EXISTS Structure_Commercial (
    structure_id INT NOT NULL,
    commercial_type_id TINYINT NOT NULL,
    business_name VARCHAR(200) DEFAULT 'Unregistered',
    estimated_active_employees INT DEFAULT 0 CHECK (estimated_active_employees >= 0),
    has_industrial_power_connection BOOLEAN NOT NULL DEFAULT FALSE,
    has_active_license BOOLEAN NOT NULL DEFAULT FALSE,
    
    CONSTRAINT pk_structure_commercial PRIMARY KEY (structure_id),
    CONSTRAINT fk_structure_comm FOREIGN KEY (structure_id) REFERENCES Structure(structure_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_commercial_sector_type FOREIGN KEY (commercial_type_id) REFERENCES Commercial_Sector_Type(commercial_type_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- specialized commercial asset profiling to gauge local economic footprints enterprise operations and commercial density

CREATE TABLE IF NOT EXISTS Structure_Residential (
    structure_id INT NOT NULL, 
    total_residential_units INT DEFAULT 1, 
    
    CONSTRAINT pk_structure_residential PRIMARY KEY (structure_id),
    CONSTRAINT fk_structure_res FOREIGN KEY (structure_id) REFERENCES Structure(structure_id) ON DELETE CASCADE
);
-- pure domestic asset tracking displaying total standalone self contained flats tenements or sub apartments within a property


-- ============================================================================
-- LEVEL 05: HOUSEHOLD & DOMESTIC COMPONENT REGISTRIES
-- ============================================================================

CREATE TABLE IF NOT EXISTS Household (
    household_id INT AUTO_INCREMENT,
    structure_id INT NOT NULL, 
    census_id SMALLINT NOT NULL,      
    household_sub_token VARCHAR(10) NOT NULL DEFAULT '1', 
    
    household_category_id TINYINT NOT NULL,
    residential_status_type_id TINYINT NOT NULL,
    owner_sex_id TINYINT DEFAULT NULL, 
    
    number_of_rooms INT NOT NULL CHECK (number_of_rooms >= 1),
    household_size INT DEFAULT 0 CHECK (household_size >= 0),
    
    data_entry_operator_id INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_household PRIMARY KEY (household_id),
    CONSTRAINT fk_household_structure FOREIGN KEY (structure_id) REFERENCES Structure(structure_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_household_census_cycle FOREIGN KEY (census_id) REFERENCES Census_Cycle(census_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_household_category FOREIGN KEY (household_category_id) REFERENCES Household_Category(household_category_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_household_res_status FOREIGN KEY (residential_status_type_id) REFERENCES Residential_Status_Type(residential_status_type_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_household_owner_sex FOREIGN KEY (owner_sex_id) REFERENCES Biological_Sex(sex_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_household_staff_operator FOREIGN KEY (data_entry_operator_id) REFERENCES Census_Staff(staff_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT unique_household_per_cycle UNIQUE (structure_id, census_id, household_sub_token)
);
-- social eating and cooking family units residing as standalone economic entities inside physical real estate assets


-- ============================================================================
-- LEVEL 06: INDIVIDUAL CITIZEN REGISTRY & HISTORIES
-- ============================================================================

CREATE TABLE IF NOT EXISTS Person (
    person_id INT AUTO_INCREMENT,
    household_id INT NOT NULL, 
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    cnic_number VARCHAR(20) UNIQUE NOT NULL,
    sex_id TINYINT NOT NULL,
    date_of_birth DATE NOT NULL,
    nationality_id TINYINT NOT NULL DEFAULT 1,
    religion_id TINYINT NULL,
    mother_tongue_id TINYINT,
    marital_status_id TINYINT NOT NULL,
    relationship_type_id TINYINT NOT NULL, 
    head_person_id INT NULL, 
    
    is_literate BOOLEAN NOT NULL DEFAULT FALSE,
    education_level_id TINYINT,
    currently_attending_school BOOLEAN DEFAULT FALSE,
    
    employment_status_id TINYINT,
    occupation_id SMALLINT,
    industry_id SMALLINT,
    monthly_income DECIMAL(10, 2) NULL,
    
    data_entry_operator_id INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT pk_person PRIMARY KEY (person_id),
    CONSTRAINT fk_person_household FOREIGN KEY (household_id) REFERENCES Household(household_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_person_sex FOREIGN KEY (sex_id) REFERENCES Biological_Sex(sex_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_person_nationality FOREIGN KEY (nationality_id) REFERENCES Nationality(nationality_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_person_religion FOREIGN KEY (religion_id) REFERENCES Religion(religion_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_person_mother_tongue FOREIGN KEY (mother_tongue_id) REFERENCES Mother_Tongue(mother_tongue_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_person_marital FOREIGN KEY (marital_status_id) REFERENCES Marital_Status(marital_status_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_person_relationship FOREIGN KEY (relationship_type_id) REFERENCES Relationship_Type(relationship_type_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_person_head FOREIGN KEY (head_person_id) REFERENCES Person(person_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_person_edu_lvl FOREIGN KEY (education_level_id) REFERENCES Education_Level(education_level_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_person_employment FOREIGN KEY (employment_status_id) REFERENCES Employment_Status(employment_status_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_person_occ FOREIGN KEY (occupation_id) REFERENCES Occupation(occupation_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_person_ind FOREIGN KEY (industry_id) REFERENCES Industry(industry_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_person_operator FOREIGN KEY (data_entry_operator_id) REFERENCES Census_Staff(staff_id) ON DELETE SET NULL ON UPDATE CASCADE
);
-- core demographic engine containing verified vital statistics scholastic milestones and financial standings per resident

CREATE TABLE IF NOT EXISTS Person_Disability (
    person_disability_id INT AUTO_INCREMENT,
    person_id INT NOT NULL,
    disability_type_id TINYINT NOT NULL,

    CONSTRAINT pk_person_disability PRIMARY KEY (person_disability_id),
    CONSTRAINT fk_person_dis_link FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE CASCADE,
    CONSTRAINT fk_disability_type_link FOREIGN KEY (disability_type_id) REFERENCES Disability_Type(disability_type_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT unique_person_disability UNIQUE (person_id, disability_type_id)
);
-- intersection table supporting composite physical profiling for individuals mapping multiple concurrent health challenges

CREATE TABLE IF NOT EXISTS Migration_History (
    migration_id INT AUTO_INCREMENT,
    person_id INT NOT NULL,
    previous_district_id SMALLINT,
    migration_reason VARCHAR(100),
    year_of_migration INT,
    CONSTRAINT pk_migration_history PRIMARY KEY (migration_id),
    CONSTRAINT fk_person_mig_link FOREIGN KEY (person_id) REFERENCES Person(person_id) ON DELETE CASCADE,
    CONSTRAINT fk_district_mig_link FOREIGN KEY (previous_district_id) REFERENCES District(district_id) ON DELETE RESTRICT ON UPDATE CASCADE
);
-- track records documenting internal resettlement geographic displacement driving factors and timeline shifts of individuals

-- ============================================================================
-- INDEX OPTIMIZATIONS
-- ============================================================================

-- 1. individual citizen demographic composite indexes
-- optimizes national population tables grouped by sex, religion, and nationality without full table scans
-- CREATE INDEX idx_person_demographic_metrics 
-- ON Person (sex_id, religion_id, nationality_id);

-- 2. education, literacy, and age-cohort slicing covering index
-- includes date_of_birth to evaluate age-brackets dynamically alongside literacy metrics
-- CREATE INDEX idx_person_education_literacy_age 
-- ON Person (education_level_id, is_literate, date_of_birth);

-- 3. economic workforce profiling covering index
-- optimizes multi-table group-by pipelines running analytics across industries, jobs, and earnings
-- CREATE INDEX idx_person_economic_profile 
-- ON Person (employment_status_id, occupation_id, industry_id, monthly_income);

-- 4. geographical drill-down lookups (covering index pattern)
-- allows fast indexing down the chain without jumping into data blocks prematurely
-- CREATE INDEX idx_division_province ON Division (province_id, division_name);
-- CREATE INDEX idx_district_division ON District (division_id, district_name);
-- CREATE INDEX idx_tehsil_district   ON Tehsil (district_id, tehsil_name);
-- CREATE INDEX idx_uc_tehsil_class   ON Union_Council (tehsil_id, union_council_classification_id);

-- 5. internal migration stream tracer composite index
-- pairs origin district with the destination citizen id to trace cross-provincial displacement vectors
-- CREATE INDEX idx_migration_origin_stream 
-- ON Migration_History (previous_district_id, person_id);

-- 6. complex multi-household structural metrics composite index
-- optimizes building-density surveys where structural utility access correlates with the census block
-- CREATE INDEX idx_structure_block_utilities 
-- ON Structure (census_block_id, structure_type_id, water_source_id, lighting_source_id);

-- 7. multi-tenant residential & tracking analytics index
-- helps match sub-tokens and category classifications instantaneously during household processing runs
-- CREATE INDEX idx_household_cycle_category 
-- ON Household (census_id, household_category_id, residential_status_type_id);

SET SQL_SAFE_UPDATES = 0;

-- ============================================================================
-- LEVEL 0: PAKISTAN CENSUS DATABASE  
-- ============================================================================

USE PakistanCensusDatabase;


-- ============================================================================
-- LEVEL 01: ADMINISTRATIVE & UTILITY MASTER LOOKUPS  
-- ============================================================================

INSERT INTO Water_Source (source_name) VALUES 
('Tap Water'), ('Hand Pump'), ('Motor/Borehole'), ('Protected Well'), ('Unprotected Well'), 
('Tanker'), ('River/Canals'),('Collected Rainwater'), ('Spring Water'), ('Tube Well');

INSERT INTO Lighting_Source (source_name) VALUES 
('Electricity Grid'), ('Solar Power'), ('Gas Lamp'), 
('Kerosene Oil'), ('Candles'), ('Generator'), ('No Lighting');

INSERT INTO Cooking_Fuel_Source (fuel_source_name) VALUES 
('Natural Gas Piping'), ('LPG Cylinder'), ('Firewood'), 
('Dung Cake'), ('Charcoal'), ('Electricity'), ('Biogas'),
('No Cooking Facility');

INSERT INTO Washroom_Status (status_name) VALUES 
('Flush connected to public sewerage'), ('Flush connected to septic tank'), 
('Pit Latrine'), ('Open Field'), ('Bucket System');

INSERT INTO Kitchen_Status (status_name) VALUES 
('Separate indoor kitchen'), ('Shared indoor kitchen'), 
('Outdoor cooking space'), ('No kitchen space');

INSERT INTO Household_Category (category_name, description) VALUES
('Regular Family', 'Normal residential family household'),
('Institutional Quarters', 'Employees/staff living in institutional premises'),
('Transient/Homeless', 'Persons with no fixed residence'),
('Extended Family', 'Multiple related family units sharing structure'),
('Single Person Household', 'Individual living alone');

INSERT INTO Residential_Status_Type (status_name, description) VALUES 
('Owned', 'Property owned by a household member'), 
('Rented', 'Property rented for a fixed amount'), 
('Rent Free', 'Living with permission without paying rent'), 
('Government Allotted', 'Official residence provided by state or employer');

-- --------------------------------------------------

INSERT INTO Biological_Sex (sex_name) VALUES 
('Male'), ('Female'), ('Transgender'), ('Other');

INSERT INTO Religion (religion_name) VALUES 
('Islam'), ('Hinduism'), ('Christianity'), ('Ahmadiyya'), ('Sikhism'), ('Buddhism'), ('Other');

INSERT INTO Mother_Tongue (tongue_name) VALUES 
('Urdu'), ('Punjabi'), ('Pashto'), ('Sindhi'), ('Balochi'), 
('Saraiki'), ('Hindko'), ('Brahui'), ('English'),('Kashmiri'),
('Shina'), ('Burushaski'), ('Turi'), ('Wakhi');

INSERT INTO Education_Level (level_name) VALUES 
('Uneducated'), ('Primary'), ('Middle'), ('Matriculation'), 
('Intermediate'), ('Bachelors'), ('Masters'), ('Doctorate');

INSERT INTO Employment_Status (status_name) VALUES
('Employed Full-Time'), ('Employed Part-Time'), ('Self-Employed'),
('Unemployed - Seeking Work'), ('Unemployed - Not Seeking Work'),
('Student'), ('Retired'), ('Homemaker'), ('Disabled - Unable to Work');

INSERT INTO Marital_Status (status_name) VALUES 
('Single'), ('Married'), ('Widowed'), ('Divorced'), ('Separated');

INSERT INTO Disability_Type (disability_name) VALUES 
('Visual Impairment'), ('Hearing Impairment'), ('Physical Mobility Impairment'), 
('Mental Illness'), ('Multiple Disabilities'), ('Speech Impairment');

INSERT INTO Occupation (occupation_name) VALUES
('Crop Farm Laborer'), ('Shopkeeper/Retail Merchant'), ('Primary School Teacher'), ('Software Developer'),
('Domestic Helper/Maid'), ('Driver/Transport Worker'), ('Construction Laborer'), ('Doctor/Medical Professional'),
('Factory Worker'), ('Agricultural Farmer'), ('Business Owner'), ('Government Official'), ('Engineer'),
('Nurse'), ('Tailor/Seamstress'), ('Electrician'), ('Plumber'), ('Carpenter'), ('Security Guard'), ('Chef/Cook'), 
('Mechanic'), ('Rickshaw Driver'), ('Hawker/Street Vendor'), ('Textile Worker'), ('Mining Worker'), ('Fisherman'),
('Journalist'), ('Lawyer'), ('Accountant'), ('Barber'), ('Religious Scholar'), ('Farmer (Landowner)'),
('Textile Artisan'), ('Carpet Weaver'), ('Labor/Unskilled'), ('Unemployed');

INSERT INTO Industry (industry_name) VALUES
('Agriculture and Farming'), ('Wholesale and Retail Trade'), ('Education'), ('Health and Social Work'),
('Public Administration'), ('Manufacturing - Textiles'), ('Manufacturing - Other'), ('Construction'),
('Transportation and Logistics'), ('Financial Services'), ('Hospitality and Tourism'), ('Telecommunications'),
('Mining and Quarrying'), ('Utilities (Water/Electricity)'), ('Real Estate'), ('Professional Services'),
('Arts and Entertainment'), ('Domestic Service');

INSERT INTO Relationship_Type (relationship_name) VALUES 
('Head of household'), ('Spouse'), ('Biological child'), ('Adopted child'), 
('Parent'), ('Sibling'), ('Grandchild'), ('Grandparent'), 
('In-Law'), ('Non-Relative'), ('Servant/Employee');

-- --------------------------------------------------

INSERT INTO Nationality (country_name, citizenship_status) VALUES
('Pakistan', 'Citizen'),
('Afghanistan', 'Foreign_Expat'),
('China', 'Foreign_Expat'),
('Bangladesh', 'Foreign_Expat'),
('Iran', 'Foreign_Expat'),
('India', 'Foreign_Expat'),
('Saudi Arabia', 'Foreign_Expat'),
('United Arab Emirates', 'Foreign_Expat'),
('Stateless', 'Stateless');

INSERT INTO Union_Council_Classification (classification_name, description) VALUES
('Municipal Committee', 'Urban administrative unit'),
('Town Committee', 'Semi-urban administrative unit'),
('Cantonment Board', 'Military administered urban area'),
('Rural Council', 'Rural administrative unit'),
('Metropolitan Corporation', 'Large metropolitan administrative unit');

INSERT INTO Census_Cycle (census_year, census_title, start_date, end_date) VALUES 
(2017, '2017 National Census Pakistan', '2017-03-15', '2017-05-24'), 
(2023, '2023 Digital Census Pakistan', '2023-03-01', '2023-05-22');

INSERT INTO Structure_Type (type_name, description) VALUES 
('Pure Residential', 'Exclusively used for living (House, Flat)'), 
('Commercial Only', 'Exclusively used for business (Shop, Office)'), 
('Mixed Use Residential Commercial', 'Business on ground floor, living above'), 
('Institutional Property', 'Schools, Hospitals, Mosques'), 
('Vacant Shell', 'Empty, abandoned, or under-construction building');

INSERT INTO Commercial_Sector_Type (commercial_type_name, description) VALUES
('Retail or Wholesale Market', 'General merchandise retail/wholesale'),
('Manufacturing Factory', 'Industrial production facility'),
('Financial Bank Branch', 'Banking and financial services'),
('Logistics Warehouse', 'Storage and distribution center'),
('Hospitality Hotel', 'Hotel, guest house, restaurant'),
('Office Complex', 'Corporate/professional offices'),
('Medical Clinic', 'Private medical facility'),
('Educational Institution', 'School, college, university'),
('Transport Terminal', 'Bus/truck station or similar');


-- ============================================================================
-- LEVEL 02: GEOGRAPHIC HIERARCHY  
-- ============================================================================

INSERT INTO Province (province_id, province_name) VALUES 
(1, 'Punjab'), (2, 'Sindh'), (3, 'Khyber Pakhtunkhwa'), (4, 'Balochistan'), 
(5, 'Islamabad Capital Territory'), (6, 'Gilgit Baltistan'), (7, 'Azad Kashmir');

INSERT INTO Division (division_id, division_name, province_id) VALUES 
(1, 'Lahore Division', 1), (2, 'Rawalpindi Division', 1), (3, 'Faisalabad Division', 1), 
(4, 'Multan Division', 1), (5, 'Bahawalpur Division', 1),
(6, 'Karachi Division', 2), (7, 'Hyderabad Division', 2), (8, 'Sukkur Division', 2), 
(9, 'Larkana Division', 2),
(10, 'Peshawar Division', 3), (11, 'Malakand Division', 3), (12, 'Hazara Division', 3), 
(13, 'Mardan Division', 3),
(14, 'Quetta Division', 4), (15, 'Makran Division', 4), (16, 'Kalat Division', 4),
(17, 'Islamabad Division', 5), (18, 'Gilgit Division', 6);

INSERT INTO District (district_id, district_name, division_id) VALUES 
(1, 'Lahore', 1), (2, 'Kasur', 1), (3, 'Sheikhupura', 1),
(4, 'Rawalpindi', 2), (5, 'Attock', 2), (6, 'Jhelum', 2),
(7, 'Faisalabad', 3), (8, 'Jhang', 3), (9, 'Toba Tek Singh', 3),
(10, 'Multan', 4), (11, 'Khanewal', 4), (12, 'Vehari', 4),
(13, 'Bahawalpur', 5), (14, 'Bahawalnagar', 5), (15, 'Rahim Yar Khan', 5),
(16, 'Karachi South', 6), (17, 'Karachi East', 6), (18, 'Karachi Central', 6),
(19, 'Hyderabad', 7), (20, 'Dadu', 7), (21, 'Jamshoro', 7),
(22, 'Sukkur', 8), (23, 'Khairpur', 8), (24, 'Ghotki', 8),
(25, 'Larkana', 9), (26, 'Shikarpur', 9), (27, 'Jacobabad', 9),
(28, 'Peshawar', 10), (29, 'Charsadda', 10), (30, 'Nowshera', 10),
(31, 'Swat', 11), (32, 'Lower Dir', 11), (33, 'Chitral', 11),
(34, 'Abbottabad', 12), (35, 'Mansehra', 12), (36, 'Haripur', 12),
(37, 'Mardan', 13), (38, 'Swabi', 13), (39, 'Rustam (Proposed)', 13),
(40, 'Quetta', 14), (41, 'Pishin', 14), (42, 'Chaman', 14),
(43, 'Gwadar', 15), (44, 'Kech (Turbat)', 15), (45, 'Panjgur', 15),
(46, 'Kalat', 16), (47, 'Khuzdar', 16), (48, 'Mastung', 16),
(49, 'Islamabad Urban', 17), (50, 'Islamabad Rural', 17), (51, 'Capital Territory East', 17),
(52, 'Gilgit', 18), (53, 'Hunza', 18), (54, 'Nagar', 18);

INSERT INTO Tehsil (tehsil_id, tehsil_name, district_id) VALUES 
(1, 'Lahore City', 1), (2, 'Lahore Cantt', 1),
(3, 'Kasur City', 2), (4, 'Pattoki', 2),
(5, 'Sheikhupura City', 3), (6, 'Ferozewala', 3),
(7, 'Rawalpindi City', 4), (8, 'Gujar Khan', 4),
(9, 'Attock City', 5), (10, 'Hasan Abdal', 5),
(11, 'Jhelum City', 6), (12, 'Dina', 6),
(13, 'Faisalabad City', 7), (14, 'Jaranwala', 7),
(15, 'Jhang City', 8), (16, 'Shorkot', 8),
(17, 'Toba Tek Singh City', 9), (18, 'Gojra', 9),
(19, 'Multan City', 10), (20, 'Shujabad', 10),
(21, 'Khanewal City', 11), (22, 'Mian Channu', 11),
(23, 'Vehari City', 12), (24, 'Burewala', 12),
(25, 'Bahawalpur City', 13), (26, 'Ahmadpur East', 13),
(27, 'Bahawalnagar City', 14), (28, 'Chishtian', 14),
(29, 'Rahim Yar Khan City', 15), (30, 'Sadiqabad', 15),
(31, 'Saddar (KHI South)', 16), (32, 'Aram Bagh', 16),
(33, 'Gulshan-e-Iqbal', 17), (34, 'Ferozabad', 17),
(35, 'Gulberg (KHI)', 18), (36, 'Liaquatabad', 18),
(37, 'Hyderabad City', 19), (38, 'Qasimabad', 19),
(39, 'Dadu City', 20), (40, 'Mehar', 20),
(41, 'Kotri', 21), (42, 'Sehwan', 21),
(43, 'Sukkur City', 22), (44, 'Rohri', 22),
(45, 'Khairpur City', 23), (46, 'Gambat', 23),
(47, 'Ghotki City', 24), (48, 'Mirpur Mathelo', 24),
(49, 'Larkana City', 25), (50, 'Ratodero', 25),
(51, 'Shikarpur City', 26), (52, 'Garhi Yasin', 26),
(53, 'Jacobabad City', 27), (54, 'Thul', 27),
(55, 'Peshawar City', 28), (56, 'Shah Alam', 28),
(57, 'Charsadda City', 29), (58, 'Tangi', 29),
(59, 'Nowshera City', 30), (60, 'Pabbi', 30),
(61, 'Babuzai (Mingora)', 31), (62, 'Matta', 31),
(63, 'Timergara', 32), (64, 'Samahni', 32),
(65, 'Chitral City', 33), (66, 'Drosh', 33),
(67, 'Abbottabad City', 34), (68, 'Havelian', 34),
(69, 'Mansehra City', 35), (70, 'Balakot', 35),
(71, 'Haripur City', 36), (72, 'Ghazi', 36),
(73, 'Mardan City', 37), (74, 'Takht Bhai', 37),
(75, 'Swabi City', 38), (76, 'Topi', 38),
(77, 'Rustam Central', 39), (78, 'Bakhshali', 39),
(79, 'Quetta City', 40), (80, 'Zarghoon', 40),
(81, 'Pishin City', 41), (82, 'Barshore', 41),
(83, 'Chaman City', 42), (84, 'Spin Boldak border area', 42),
(85, 'Gwadar City', 43), (86, 'Ormara', 43),
(87, 'Turbat City', 44), (88, 'Dasht', 44),
(89, 'Panjgur City', 45), (90, 'Paroom', 45),
(91, 'Kalat City', 46), (92, 'Surab', 46),
(93, 'Khuzdar City', 47), (94, 'Wadh', 47),
(95, 'Mastung City', 48), (96, 'Khad Koocha', 48),
(97, 'F-Series Sectors', 49), (98, 'G-Series Sectors', 49),
(99, 'Tarlai', 50), (100, 'Bhara Kahu', 50),
(101, 'Nilore', 51), (102, 'Humak', 51),
(103, 'Gilgit City', 52), (104, 'Danyor', 52),
(105, 'Aliabad', 53), (106, 'Gojal', 53),
(107, 'Nagar Khas', 54), (108, 'Chalt', 54);

INSERT INTO Union_Council (union_council_id, union_council_name, union_council_classification_id, tehsil_id) VALUES 
(1, 'UC Anarkali', 1, 1), (2, 'UC Islampura', 1, 1),
(3, 'UC Defence', 1, 2), (4, 'UC Barki', 4, 2),
(5, 'UC Kasur Central', 1, 3), (6, 'UC Qadiwind', 4, 3),
(7, 'UC Pattoki City', 2, 4), (8, 'UC Habibabad', 4, 4),
(9, 'UC SKP Central', 1, 5), (10, 'UC Manawala', 4, 5),
(11, 'UC Ferozewala City', 2, 6), (12, 'UC Kot Abdul Malik', 1, 6),
(13, 'UC Saddar RWP', 1, 7), (14, 'UC Satellite Town', 1, 7),
(15, 'UC Gujar Khan City', 2, 8), (16, 'UC Mandra', 4, 8),
(17, 'UC Attock Central', 1, 9), (18, 'UC Kamra', 3, 9),
(19, 'UC Hasan Abdal City', 2, 10), (20, 'UC Burhan', 4, 10),
(21, 'UC Jhelum Central', 1, 11), (22, 'UC Kala Gujran', 4, 11),
(23, 'UC Dina City', 2, 12), (24, 'UC Mangla', 4, 12),
(25, 'UC D Ground', 1, 13), (26, 'UC Ghulam Muhammad Abad', 1, 13),
(27, 'UC Jaranwala City', 2, 14), (28, 'UC Khurrianwala', 4, 14),
(29, 'UC Jhang Central', 1, 15), (30, 'UC Bagh', 4, 15),
(31, 'UC Shorkot City', 2, 16), (32, 'UC Shorkot Cantt', 3, 16),
(33, 'UC TTS Central', 1, 17), (34, 'UC Rajana', 4, 17),
(35, 'UC Gojra City', 2, 18), (36, 'UC Nawan Lahore', 4, 18),
(37, 'UC Mumtazabad', 1, 19), (38, 'UC Shah Rukn e Alam', 1, 19),
(39, 'UC Shujabad City', 2, 20), (40, 'UC Jalalpur Pirwala', 4, 20),
(41, 'UC Khanewal Central', 1, 21), (42, 'UC Kabirwala', 4, 21),
(43, 'UC Mian Channu City', 2, 22), (44, 'UC Tulamba', 4, 22),
(45, 'UC Vehari Central', 1, 23), (46, 'UC Karampur', 4, 23),
(47, 'UC Burewala City', 2, 24), (48, 'UC Gaggo Mandi', 4, 24),
(49, 'UC BWP Central', 1, 25), (50, 'UC Satellite Town BWP', 1, 25),
(51, 'UC Ahmadpur City', 2, 26), (52, 'UC Uch Sharif', 4, 26),
(53, 'UC BWN Central', 1, 27), (54, 'UC Dunga Bunga', 4, 27),
(55, 'UC Chishtian City', 2, 28), (56, 'UC Dahranwala', 4, 28),
(57, 'UC RYK Central', 1, 29), (58, 'UC Khanpur', 4, 29),
(59, 'UC Sadiqabad City', 2, 30), (60, 'UC Bhong', 4, 30),
(61, 'UC Clifton', 1, 31), (62, 'UC Lyari', 1, 31),
(63, 'UC Saddar KHI', 1, 32), (64, 'UC Kharadar', 1, 32),
(65, 'UC Gulshan Central', 1, 33), (66, 'UC Pehlwan Goth', 1, 33),
(67, 'UC PECHS', 1, 34), (68, 'UC Tariq Road', 1, 34),
(69, 'UC Federal B Area', 1, 35), (70, 'UC Azizabad', 1, 35),
(71, 'UC Liaquatabad Central', 1, 36), (72, 'UC Nazimabad', 1, 36),
(73, 'UC Latifabad', 1, 37), (74, 'UC Hirabad', 1, 37),
(75, 'UC Qasimabad Central', 1, 38), (76, 'UC Hussainabad', 1, 38),
(77, 'UC Dadu Central', 1, 39), (78, 'UC Khudabad', 4, 39),
(79, 'UC Mehar City', 2, 40), (80, 'UC Radhan', 4, 40),
(81, 'UC Kotri City', 2, 41), (82, 'UC SITE Kotri', 1, 41),
(83, 'UC Sehwan City', 2, 42), (84, 'UC Bhan Syedabad', 4, 42),
(85, 'UC Sukkur Central', 1, 43), (86, 'UC Bunder Road', 1, 43),
(87, 'UC Rohri City', 2, 44), (88, 'UC Ali Wahan', 4, 44),
(89, 'UC Khairpur Central', 1, 45), (90, 'UC Babarloi', 4, 45),
(91, 'UC Gambat City', 2, 46), (92, 'UC Ranipur', 4, 46),
(93, 'UC Ghotki Central', 1, 47), (94, 'UC Adilpur', 4, 47),
(95, 'UC Mirpur Mathelo City', 2, 48), (96, 'UC Jarwar', 4, 48),
(97, 'UC Larkana Central', 1, 49), (98, 'UC Dari', 1, 49),
(99, 'UC Ratodero City', 2, 50), (100, 'UC Naudero', 4, 50),
(101, 'UC Shikarpur Central', 1, 51), (102, 'UC Stuart Gunj', 1, 51),
(103, 'UC Garhi Yasin City', 2, 52), (104, 'UC Dakhan', 4, 52),
(105, 'UC Jacobabad Central', 1, 53), (106, 'UC Garhi Khairo', 4, 53),
(107, 'UC Thul City', 2, 54), (108, 'UC Mirpur Buriro', 4, 54),
(109, 'UC Hayatabad', 1, 55), (110, 'UC University Town', 1, 55),
(111, 'UC Daudzai', 4, 56), (112, 'UC Khazana', 4, 56),
(113, 'UC Charsadda Central', 1, 57), (114, 'UC Utmanzai', 4, 57),
(115, 'UC Tangi City', 2, 58), (116, 'UC Umarzai', 4, 58),
(117, 'UC Nowshera Cantt', 3, 59), (118, 'UC Risalpur', 3, 59),
(119, 'UC Pabbi City', 2, 60), (120, 'UC Akbarpura', 4, 60),
(121, 'UC Mingora City', 1, 61), (122, 'UC Saidu Sharif', 1, 61),
(123, 'UC Matta City', 2, 62), (124, 'UC Khwaza Khela', 4, 62),
(125, 'UC Timergara City', 2, 63), (126, 'UC Balambat', 4, 63),
(127, 'UC Samahni City', 4, 64), (128, 'UC Munda', 4, 64),
(129, 'UC Chitral Central', 1, 65), (130, 'UC Ayun', 4, 65),
(131, 'UC Drosh City', 2, 66), (132, 'UC Arandu', 4, 66),
(133, 'UC Nawan Shehr', 1, 67), (134, 'UC Kehal', 1, 67),
(135, 'UC Havelian City', 2, 68), (136, 'UC Langra', 4, 68),
(137, 'UC Mansehra Central', 1, 69), (138, 'UC Baffa', 4, 69),
(139, 'UC Balakot City', 2, 70), (140, 'UC Kaghan', 4, 70),
(141, 'UC Haripur Central', 1, 71), (142, 'UC Khalabat Township', 1, 71),
(143, 'UC Ghazi City', 2, 72), (144, 'UC Tarbela', 3, 72),
(145, 'UC Mardan Central', 1, 73), (146, 'UC Hoti', 1, 73),
(147, 'UC Takht Bhai City', 2, 74), (148, 'UC Shergarh', 4, 74),
(149, 'UC Swabi Central', 1, 75), (150, 'UC Zaida', 4, 75),
(151, 'UC Topi City', 2, 76), (152, 'UC Tarbela Dam Sector', 3, 76),
(153, 'UC Rustam City', 4, 77), (154, 'UC Surkh Dheri', 4, 77),
(155, 'UC Bakhshali Central', 4, 78), (156, 'UC Gujrat (Mardan)', 4, 78),
(157, 'UC Nawa Killi', 1, 79), (158, 'UC Satellite Town QTA', 1, 79),
(159, 'UC Zarghoon Central', 1, 80), (160, 'UC Hanna Urak', 4, 80),
(161, 'UC Pishin Central', 1, 81), (162, 'UC Khanozai', 4, 81),
(163, 'UC Barshore Central', 4, 82), (164, 'UC Toba Kakari', 4, 82),
(165, 'UC Chaman City', 1, 83), (166, 'UC Boghra', 4, 83),
(167, 'UC Border Area 1', 4, 84), (168, 'UC Border Area 2', 4, 84),
(169, 'UC Gwadar Port', 1, 85), (170, 'UC Sur Bandar', 4, 85),
(171, 'UC Ormara City', 2, 86), (172, 'UC Basol', 4, 86),
(173, 'UC Turbat Central', 1, 87), (174, 'UC Absar', 1, 87),
(175, 'UC Dasht Central', 4, 88), (176, 'UC Nigwar', 4, 88),
(177, 'UC Panjgur Central', 1, 89), (178, 'UC Chitkan', 1, 89),
(179, 'UC Paroom Central', 4, 90), (180, 'UC Gichk', 4, 90),
(181, 'UC Kalat Central', 1, 91), (182, 'UC Mangochar', 4, 91),
(183, 'UC Surab City', 2, 92), (184, 'UC Gidar', 4, 92),
(185, 'UC Khuzdar Central', 1, 93), (186, 'UC Zehri', 4, 93),
(187, 'UC Wadh City', 2, 94), (188, 'UC Aranji', 4, 94),
(189, 'UC Mastung Central', 1, 95), (190, 'UC Kanak', 4, 95),
(191, 'UC Khad Koocha', 4, 96), (192, 'UC Dasht Mastung', 4, 96),
(193, 'UC F-7', 1, 97), (194, 'UC F-8', 1, 97),
(195, 'UC G-9', 1, 98), (196, 'UC G-10', 1, 98),
(197, 'UC Tarlai Kalan', 4, 99), (198, 'UC Alipur', 4, 99),
(199, 'UC Bhara Kahu Central', 2, 100), (200, 'UC Phulgran', 4, 100),
(201, 'UC Nilore Central', 4, 101), (202, 'UC Chirah', 4, 101),
(203, 'UC Humak Town', 2, 102), (204, 'UC Sihala', 4, 102),
(205, 'UC Gilgit Central', 1, 103), (206, 'UC Jutial', 1, 103),
(207, 'UC Danyor City', 2, 104), (208, 'UC Jalalabad', 4, 104),
(209, 'UC Aliabad Central', 2, 105), (210, 'UC Murtazaabad', 4, 105),
(211, 'UC Gulmit', 4, 106), (212, 'UC Passu', 4, 106),
(213, 'UC Nagar Khas', 4, 107), (214, 'UC Hopar', 4, 107),
(215, 'UC Chalt Central', 4, 108), (216, 'UC Sikandarabad', 4, 108);

INSERT INTO Census_Block (census_block_id, census_block_code, estimated_household_count, is_urban, area_sq_km, union_council_id) VALUES 
(1, 'BLK-UC001', 350, TRUE, 2.5, 1), (2, 'BLK-UC002', 400, TRUE, 3.1, 2), (3, 'BLK-UC003', 500, TRUE, 4.0, 3), (4, 'BLK-UC004', 150, FALSE, 12.5, 4), (5, 'BLK-UC005', 300, TRUE, 2.8, 5), (6, 'BLK-UC006', 120, FALSE, 15.0, 6),
(7, 'BLK-UC007', 250, TRUE, 3.5, 7), (8, 'BLK-UC008', 140, FALSE, 18.2, 8), (9, 'BLK-UC009', 320, TRUE, 2.9, 9), (10, 'BLK-UC010', 110, FALSE, 22.1, 10), (11, 'BLK-UC011', 280, TRUE, 3.2, 11), (12, 'BLK-UC012', 390, TRUE, 2.6, 12),
(13, 'BLK-UC013', 450, TRUE, 1.8, 13), (14, 'BLK-UC014', 420, TRUE, 2.1, 14), (15, 'BLK-UC015', 210, TRUE, 4.5, 15), (16, 'BLK-UC016', 130, FALSE, 25.0, 16), (17, 'BLK-UC017', 380, TRUE, 2.2, 17), (18, 'BLK-UC018', 600, TRUE, 5.5, 18),
(19, 'BLK-UC019', 240, TRUE, 3.6, 19), (20, 'BLK-UC020', 100, FALSE, 30.5, 20), (21, 'BLK-UC021', 310, TRUE, 2.7, 21), (22, 'BLK-UC022', 125, FALSE, 28.0, 22), (23, 'BLK-UC023', 270, TRUE, 3.8, 23), (24, 'BLK-UC024', 90, FALSE, 35.2, 24),
(25, 'BLK-UC025', 480, TRUE, 1.5, 25), (26, 'BLK-UC026', 460, TRUE, 1.7, 26), (27, 'BLK-UC027', 290, TRUE, 3.0, 27), (28, 'BLK-UC028', 160, FALSE, 20.4, 28), (29, 'BLK-UC029', 330, TRUE, 2.4, 29), (30, 'BLK-UC030', 115, FALSE, 26.8, 30),
(31, 'BLK-UC031', 260, TRUE, 3.9, 31), (32, 'BLK-UC032', 550, TRUE, 6.2, 32), (33, 'BLK-UC033', 340, TRUE, 2.3, 33), (34, 'BLK-UC034', 145, FALSE, 21.5, 34), (35, 'BLK-UC035', 285, TRUE, 3.1, 35), (36, 'BLK-UC036', 105, FALSE, 32.0, 36),
(37, 'BLK-UC037', 410, TRUE, 1.9, 37), (38, 'BLK-UC038', 430, TRUE, 2.0, 38), (39, 'BLK-UC039', 255, TRUE, 4.1, 39), (40, 'BLK-UC040', 135, FALSE, 24.5, 40), (41, 'BLK-UC041', 360, TRUE, 2.5, 41), (42, 'BLK-UC042', 155, FALSE, 19.8, 42),
(43, 'BLK-UC043', 275, TRUE, 3.4, 43), (44, 'BLK-UC044', 120, FALSE, 27.5, 44), (45, 'BLK-UC045', 390, TRUE, 2.1, 45), (46, 'BLK-UC046', 110, FALSE, 31.2, 46), (47, 'BLK-UC047', 295, TRUE, 2.9, 47), (48, 'BLK-UC048', 140, FALSE, 22.8, 48),
(49, 'BLK-UC049', 440, TRUE, 1.6, 49), (50, 'BLK-UC050', 425, TRUE, 1.8, 50), (51, 'BLK-UC051', 245, TRUE, 4.2, 51), (52, 'BLK-UC052', 105, FALSE, 33.5, 52), (53, 'BLK-UC053', 370, TRUE, 2.3, 53), (54, 'BLK-UC054', 165, FALSE, 18.5, 54),
(55, 'BLK-UC055', 265, TRUE, 3.7, 55), (56, 'BLK-UC056', 125, FALSE, 29.0, 56), (57, 'BLK-UC057', 400, TRUE, 2.0, 57), (58, 'BLK-UC058', 115, FALSE, 30.5, 58), (59, 'BLK-UC059', 280, TRUE, 3.3, 59), (60, 'BLK-UC060', 150, FALSE, 21.0, 60),
(61, 'BLK-UC061', 800, TRUE, 4.5, 61), (62, 'BLK-UC062', 950, TRUE, 2.1, 62), (63, 'BLK-UC063', 750, TRUE, 1.8, 63), (64, 'BLK-UC064', 850, TRUE, 1.5, 64), (65, 'BLK-UC065', 680, TRUE, 3.2, 65), (66, 'BLK-UC066', 710, TRUE, 2.8, 66),
(67, 'BLK-UC067', 620, TRUE, 2.5, 67), (68, 'BLK-UC068', 640, TRUE, 2.4, 68), (69, 'BLK-UC069', 880, TRUE, 1.9, 69), (70, 'BLK-UC070', 920, TRUE, 1.7, 70), (71, 'BLK-UC071', 810, TRUE, 1.6, 71), (72, 'BLK-UC072', 830, TRUE, 1.4, 72),
(73, 'BLK-UC073', 520, TRUE, 3.5, 73), (74, 'BLK-UC074', 490, TRUE, 3.8, 74), (75, 'BLK-UC075', 460, TRUE, 4.2, 75), (76, 'BLK-UC076', 440, TRUE, 4.5, 76), (77, 'BLK-UC077', 350, TRUE, 5.1, 77), (78, 'BLK-UC078', 180, FALSE, 25.0, 78),
(79, 'BLK-UC079', 310, TRUE, 4.8, 79), (80, 'BLK-UC080', 160, FALSE, 28.5, 80), (81, 'BLK-UC081', 380, TRUE, 3.6, 81), (82, 'BLK-UC082', 550, TRUE, 5.2, 82), (83, 'BLK-UC083', 290, TRUE, 4.5, 83), (84, 'BLK-UC084', 150, FALSE, 32.0, 84),
(85, 'BLK-UC085', 470, TRUE, 2.8, 85), (86, 'BLK-UC086', 450, TRUE, 3.1, 86), (87, 'BLK-UC087', 320, TRUE, 4.0, 87), (88, 'BLK-UC088', 170, FALSE, 26.5, 88), (89, 'BLK-UC089', 410, TRUE, 3.2, 89), (90, 'BLK-UC090', 140, FALSE, 35.0, 90),
(91, 'BLK-UC091', 340, TRUE, 3.9, 91), (92, 'BLK-UC092', 190, FALSE, 22.5, 92), (93, 'BLK-UC093', 380, TRUE, 3.5, 93), (94, 'BLK-UC094', 160, FALSE, 29.0, 94), (95, 'BLK-UC095', 300, TRUE, 4.6, 95), (96, 'BLK-UC096', 150, FALSE, 31.5, 96),
(97, 'BLK-UC097', 530, TRUE, 2.4, 97), (98, 'BLK-UC098', 510, TRUE, 2.6, 98), (99, 'BLK-UC099', 280, TRUE, 4.8, 99), (100, 'BLK-UC100', 130, FALSE, 36.5, 100), (101, 'BLK-UC101', 490, TRUE, 2.7, 101), (102, 'BLK-UC102', 470, TRUE, 2.9, 102),
(103, 'BLK-UC103', 310, TRUE, 4.3, 103), (104, 'BLK-UC104', 170, FALSE, 28.0, 104), (105, 'BLK-UC105', 420, TRUE, 3.1, 105), (106, 'BLK-UC106', 180, FALSE, 24.5, 106), (107, 'BLK-UC107', 330, TRUE, 4.1, 107), (108, 'BLK-UC108', 160, FALSE, 30.0, 108),
(109, 'BLK-UC109', 580, TRUE, 3.5, 109), (110, 'BLK-UC110', 560, TRUE, 3.8, 110), (111, 'BLK-UC111', 190, FALSE, 25.5, 111), (112, 'BLK-UC112', 200, FALSE, 23.0, 112), (113, 'BLK-UC113', 440, TRUE, 3.0, 113), (114, 'BLK-UC114', 150, FALSE, 32.5, 114),
(115, 'BLK-UC115', 350, TRUE, 4.2, 115), (116, 'BLK-UC116', 140, FALSE, 34.0, 116), (117, 'BLK-UC117', 600, TRUE, 6.5, 117), (118, 'BLK-UC118', 580, TRUE, 7.0, 118), (119, 'BLK-UC119', 370, TRUE, 3.9, 119), (120, 'BLK-UC120', 160, FALSE, 29.5, 120),
(121, 'BLK-UC121', 510, TRUE, 2.8, 121), (122, 'BLK-UC122', 490, TRUE, 3.1, 122), (123, 'BLK-UC123', 320, TRUE, 4.4, 123), (124, 'BLK-UC124', 180, FALSE, 26.0, 124), (125, 'BLK-UC125', 390, TRUE, 3.4, 125), (126, 'BLK-UC126', 150, FALSE, 33.0, 126),
(127, 'BLK-UC127', 170, FALSE, 28.5, 127), (128, 'BLK-UC128', 160, FALSE, 30.5, 128), (129, 'BLK-UC129', 430, TRUE, 3.3, 129), (130, 'BLK-UC130', 140, FALSE, 36.0, 130), (131, 'BLK-UC131', 340, TRUE, 4.1, 131), (132, 'BLK-UC132', 130, FALSE, 38.5, 132),
(133, 'BLK-UC133', 480, TRUE, 2.9, 133), (134, 'BLK-UC134', 460, TRUE, 3.2, 134), (135, 'BLK-UC135', 360, TRUE, 3.8, 135), (136, 'BLK-UC136', 150, FALSE, 31.0, 136), (137, 'BLK-UC137', 540, TRUE, 2.6, 137), (138, 'BLK-UC138', 190, FALSE, 24.0, 138),
(139, 'BLK-UC139', 310, TRUE, 4.5, 139), (140, 'BLK-UC140', 120, FALSE, 40.0, 140), (141, 'BLK-UC141', 450, TRUE, 3.1, 141), (142, 'BLK-UC142', 430, TRUE, 3.4, 142), (143, 'BLK-UC143', 330, TRUE, 4.3, 143), (144, 'BLK-UC144', 520, TRUE, 6.0, 144),
(145, 'BLK-UC145', 570, TRUE, 2.5, 145), (146, 'BLK-UC146', 550, TRUE, 2.7, 146), (147, 'BLK-UC147', 380, TRUE, 3.7, 147), (148, 'BLK-UC148', 160, FALSE, 29.0, 148), (149, 'BLK-UC149', 500, TRUE, 3.0, 149), (150, 'BLK-UC150', 170, FALSE, 27.5, 150),
(151, 'BLK-UC151', 350, TRUE, 4.0, 151), (152, 'BLK-UC152', 580, TRUE, 5.5, 152), (153, 'BLK-UC153', 180, FALSE, 26.5, 153), (154, 'BLK-UC154', 190, FALSE, 25.0, 154), (155, 'BLK-UC155', 150, FALSE, 32.0, 155), (156, 'BLK-UC156', 140, FALSE, 34.5, 156),
(157, 'BLK-UC157', 620, TRUE, 2.2, 157), (158, 'BLK-UC158', 600, TRUE, 2.4, 158), (159, 'BLK-UC159', 460, TRUE, 3.2, 159), (160, 'BLK-UC160', 130, FALSE, 37.0, 160), (161, 'BLK-UC161', 390, TRUE, 3.6, 161), (162, 'BLK-UC162', 150, FALSE, 33.5, 162),
(163, 'BLK-UC163', 160, FALSE, 31.0, 163), (164, 'BLK-UC164', 170, FALSE, 29.5, 164), (165, 'BLK-UC165', 410, TRUE, 3.4, 165), (166, 'BLK-UC166', 140, FALSE, 35.5, 166), (167, 'BLK-UC167', 120, FALSE, 42.0, 167), (168, 'BLK-UC168', 110, FALSE, 45.0, 168),
(169, 'BLK-UC169', 340, TRUE, 4.2, 169), (170, 'BLK-UC170', 180, FALSE, 27.0, 170), (171, 'BLK-UC171', 280, TRUE, 4.8, 171), (172, 'BLK-UC172', 150, FALSE, 32.5, 172), (173, 'BLK-UC173', 440, TRUE, 3.1, 173), (174, 'BLK-UC174', 420, TRUE, 3.3, 174),
(175, 'BLK-UC175', 160, FALSE, 30.0, 175), (176, 'BLK-UC176', 170, FALSE, 28.5, 176), (177, 'BLK-UC177', 370, TRUE, 3.8, 177), (178, 'BLK-UC178', 350, TRUE, 4.0, 178), (179, 'BLK-UC179', 140, FALSE, 34.5, 179), (180, 'BLK-UC180', 130, FALSE, 36.0, 180),
(181, 'BLK-UC181', 400, TRUE, 3.5, 181), (182, 'BLK-UC182', 150, FALSE, 31.5, 182), (183, 'BLK-UC183', 310, TRUE, 4.6, 183), (184, 'BLK-UC184', 160, FALSE, 29.0, 184), (185, 'BLK-UC185', 470, TRUE, 2.9, 185), (186, 'BLK-UC186', 180, FALSE, 26.5, 186),
(187, 'BLK-UC187', 290, TRUE, 4.9, 187), (188, 'BLK-UC188', 140, FALSE, 35.0, 188), (189, 'BLK-UC189', 360, TRUE, 3.9, 189), (190, 'BLK-UC190', 170, FALSE, 28.0, 190), (191, 'BLK-UC191', 150, FALSE, 33.0, 191), (192, 'BLK-UC192', 160, FALSE, 30.5, 192),
(193, 'BLK-UC193', 750, TRUE, 2.0, 193), (194, 'BLK-UC194', 720, TRUE, 2.2, 194), (195, 'BLK-UC195', 680, TRUE, 2.5, 195), (196, 'BLK-UC196', 650, TRUE, 2.8, 196), (197, 'BLK-UC197', 220, FALSE, 20.5, 197), (198, 'BLK-UC198', 230, FALSE, 19.0, 198),
(199, 'BLK-UC199', 420, TRUE, 3.4, 199), (200, 'BLK-UC200', 180, FALSE, 26.0, 200), (201, 'BLK-UC201', 190, FALSE, 24.5, 201), (202, 'BLK-UC202', 170, FALSE, 27.5, 202), (203, 'BLK-UC203', 380, TRUE, 3.7, 203), (204, 'BLK-UC204', 160, FALSE, 30.0, 204),
(205, 'BLK-UC205', 450, TRUE, 3.1, 205), (206, 'BLK-UC206', 430, TRUE, 3.3, 206), (207, 'BLK-UC207', 320, TRUE, 4.4, 207), (208, 'BLK-UC208', 150, FALSE, 32.5, 208),(209, 'BLK-UC209', 280, TRUE, 4.8, 209), (210, 'BLK-UC210', 140, FALSE, 35.0, 210),
(211, 'BLK-UC211', 160, FALSE, 29.5, 211), (212, 'BLK-UC212', 130, FALSE, 38.0, 212), (213, 'BLK-UC213', 170, FALSE, 28.0, 213), (214, 'BLK-UC214', 150, FALSE, 33.5, 214), (215, 'BLK-UC215', 180, FALSE, 26.5, 215), (216, 'BLK-UC216', 160, FALSE, 31.0, 216);


-- ============================================================================
-- LEVEL 03: ADMINISTRATIVE PERSONNEL & BASE STRUCTURE DATA
-- ============================================================================

INSERT INTO Census_Staff (first_name, last_name, staff_role, contact_number, email, assigned_census_block_id, supervisor_id, employment_date) VALUES 
('Ahmed', 'Raza', 'Supervisor', '0300-1000001', 's1@census.pk', NULL, NULL, '2026-01-01'), ('Fatima', 'Bibi', 'Supervisor', '0300-1000002', 's2@census.pk', NULL, NULL, '2026-01-01'),
('Tariq', 'Mehmood', 'Supervisor', '0300-1000003', 's3@census.pk', NULL, NULL, '2026-01-01'), ('Ali', 'Hassan', 'Enumerator', '0321-1000004', 'e1@census.pk', 1, 1, '2026-02-01'),
('Zainab', 'Noor', 'Enumerator', '0321-1000005', 'e2@census.pk', 2, 1, '2026-02-01'), ('Bilal', 'Khan', 'Enumerator', '0333-1000006', 'e3@census.pk', 3, 2, '2026-02-01'),
('Maria', 'Siddiqui', 'Enumerator', '0333-1000007', 'e4@census.pk', 4, 2, '2026-02-01'), ('Omar', 'Farooq', 'Enumerator', '0345-1000008', 'e5@census.pk', 5, 3, '2026-02-01'),
('Sana', 'Javed', 'Enumerator', '0345-1000009', 'e6@census.pk', 6, 3, '2026-02-01'), ('Usman', 'Ghani', 'Enumerator', '0312-1000010', 'e7@census.pk', 7, 1, '2026-02-01'),
('Hina', 'Naz', 'Enumerator', '0312-1000011', 'e8@census.pk', 8, 1, '2026-02-01'), ('Imran', 'Shah', 'Enumerator', '0300-1000012', 'e9@census.pk', 9, 2, '2026-02-01'),
('Sadaf', 'Ali', 'Enumerator', '0300-1000013', 'e10@census.pk', 10, 2, '2026-02-01'), ('Hamza', 'Rehman', 'Enumerator', '0300-1000014', 'e11@census.pk', 11, 3, '2026-02-01'),
('Aqsa', 'Iqbal', 'Enumerator', '0300-1000015', 'e12@census.pk', 12, 3, '2026-02-01'), ('Kashif', 'Latif', 'Data_Entry_Operator', '0300-1000016', 'd1@census.pk', 13, 1, '2026-03-01'),
('Rabia', 'Basri', 'Data_Entry_Operator', '0300-1000017', 'd2@census.pk', 14, 1, '2026-03-01'), ('Waqas', 'Ahmed', 'Data_Entry_Operator', '0300-1000018', 'd3@census.pk', 15, 2, '2026-03-01'),
('Nadia', 'Gul', 'Data_Entry_Operator', '0300-1000019', 'd4@census.pk', 16, 2, '2026-03-01'), ('Zeeshan', 'Malik', 'Data_Entry_Operator', '0300-1000020', 'd5@census.pk', 17, 3, '2026-03-01'),
('Amna', 'Parveen', 'Data_Entry_Operator', '0300-1000021', 'd6@census.pk', 18, 3, '2026-03-01'), ('Salman', 'Farsi', 'Quality_Checker', '0300-1000022', 'q1@census.pk', 19, 1, '2026-03-15'),
('Sadia', 'Imran', 'Quality_Checker', '0300-1000023', 'q2@census.pk', 20, 1, '2026-03-15'), ('Faizan', 'Aslam', 'Quality_Checker', '0300-1000024', 'q3@census.pk', 21, 2, '2026-03-15'),
('Sidra', 'Munir', 'Quality_Checker', '0300-1000025', 'q4@census.pk', 22, 2, '2026-03-15'), ('Adnan', 'Sami', 'Quality_Checker', '0300-1000026', 'q5@census.pk', 23, 3, '2026-03-15'),
('Madiha', 'Khalid', 'Quality_Checker', '0300-1000027', 'q6@census.pk', 24, 3, '2026-03-15'), ('Shahid', 'Afidi', 'Enumerator', '0300-1000028', 'e13@census.pk', 25, 1, '2026-02-01'),
('Mehwish', 'Hayat', 'Enumerator', '0300-1000029', 'e14@census.pk', 26, 1, '2026-02-01'), ('Daniyal', 'Arshad', 'Enumerator', '0300-1000030', 'e15@census.pk', 27, 2, '2026-02-01'),
('Arooj', 'Fatima', 'Enumerator', '0300-1000031', 'e16@census.pk', 28, 2, '2026-02-01'), ('Bilal', 'Saeed', 'Enumerator', '0300-1000032', 'e17@census.pk', 29, 3, '2026-02-01'),
('Anum', 'Zehra', 'Enumerator', '0300-1000033', 'e18@census.pk', 30, 3, '2026-02-01'), ('Naveed', 'Ul-Haq', 'Enumerator', '0300-1000034', 'e19@census.pk', 31, 1, '2026-02-01'),
('Bushra', 'Ansari', 'Enumerator', '0300-1000035', 'e20@census.pk', 32, 1, '2026-02-01'), ('Junaid', 'Jamshed', 'Enumerator', '0300-1000036', 'e21@census.pk', 33, 2, '2026-02-01'),
('Sumaira', 'Khan', 'Enumerator', '0300-1000037', 'e22@census.pk', 34, 2, '2026-02-01'), ('Fahad', 'Mustafa', 'Enumerator', '0300-1000038', 'e23@census.pk', 35, 3, '2026-02-01'),
('Maryam', 'Nawaz', 'Enumerator', '0300-1000039', 'e24@census.pk', 36, 3, '2026-02-01'), ('Saqib', 'Mehmood', 'Enumerator', '0300-1000040', 'e25@census.pk', 37, 1, '2026-02-01'),
('Saba', 'Qamar', 'Enumerator', '0300-1000041', 'e26@census.pk', 38, 1, '2026-02-01'), ('Waseem', 'Akram', 'Enumerator', '0300-1000042', 'e27@census.pk', 39, 2, '2026-02-01'),
('Sofia', 'Khan', 'Enumerator', '0300-1000043', 'e28@census.pk', 40, 2, '2026-02-01'), ('Yasir', 'Shah', 'Enumerator', '0300-1000044', 'e29@census.pk', 41, 3, '2026-02-01'),
('Ambar', 'Bashir', 'Enumerator', '0300-1000045', 'e30@census.pk', 42, 3, '2026-02-01'), ('Zahid', 'Iqbal', 'Enumerator', '0300-1000046', 'e31@census.pk', 43, 1, '2026-02-01'),
('Shazia', 'Parveen', 'Enumerator', '0300-1000047', 'e32@census.pk', 44, 1, '2026-02-01'), ('Asif', 'Ali', 'Enumerator', '0300-1000048', 'e33@census.pk', 45, 2, '2026-02-01'),
('Nazia', 'Hassan', 'Enumerator', '0300-1000049', 'e34@census.pk', 46, 2, '2026-02-01'), ('Rizwan', 'Sheikh', 'Enumerator', '0300-1000050', 'e35@census.pk', 47, 3, '2026-02-01');

INSERT INTO Structure (structure_address_no, gps_latitude, gps_longitude, census_block_id, structure_type_id, water_source_id, lighting_source_id, fuel_source_id, washroom_status_id, kitchen_status_id) VALUES 
('10-B, Model Town', 31.4812, 74.3315, 1, 1, 1, 1, 1, 1, 1), ('Shop 5, Anarkali', 31.5600, 74.3100, 2, 2, 1, 1, 6, 1, 4),
('Plot 22, Defence V', 31.4700, 74.4000, 3, 1, 3, 1, 1, 2, 1), ('15-C, Johar Town', 31.4500, 74.2800, 4, 1, 3, 1, 1, 2, 1),
('Flat 9, Saddar', 24.8600, 67.0100, 5, 1, 1, 1, 2, 1, 2), ('Bunglow 4, Clifton', 24.8000, 67.0300, 6, 1, 1, 1, 1, 1, 1),
('H-44, Gulshan-e-Iqbal', 24.9200, 67.1000, 7, 1, 2, 1, 2, 2, 1), ('Shop 12, Mingora', 34.7700, 72.3500, 8, 3, 2, 2, 3, 3, 3),
('Village House 102', 34.1800, 71.5000, 9, 1, 2, 2, 3, 3, 3), ('Market Plaza, Peshawar', 34.1850, 71.5100, 10, 3, 1, 1, 1, 1, 1),
('House 55, Bahria Town', 31.4000, 74.2500, 1, 1, 3, 1, 1, 1, 1), ('Shop 88, Hall Road', 31.5700, 74.3200, 2, 2, 1, 1, 1, 1, 4),
('Apt 202, Liberty', 31.5100, 74.3400, 3, 1, 1, 1, 1, 1, 1), ('House 7, Gulberg II', 31.5200, 74.3500, 3, 1, 1, 1, 1, 1, 1),
('Farm H-1, Raiwind', 31.3500, 74.2000, 4, 1, 2, 2, 3, 3, 3), ('Office 1, Blue Area', 33.7000, 73.0500, 11, 2, 1, 1, 6, 1, 4),
('Flat 5, F-7/2', 33.7200, 73.0400, 11, 1, 1, 1, 1, 1, 1), ('House 99, F-10/4', 33.7300, 73.0200, 12, 1, 1, 1, 1, 1, 1),
('Villa 3, G-6/1', 33.7100, 73.0600, 12, 1, 1, 1, 1, 1, 1), ('Store 2, Melody Mkt', 33.7150, 73.0650, 12, 2, 1, 1, 6, 1, 4),
('House 1, Quetta City', 30.1800, 67.0000, 13, 1, 2, 2, 3, 2, 3), ('Shop 4, Liaquat Mkt', 30.1900, 67.0100, 13, 3, 2, 2, 3, 3, 3),
('Village 50, Pishin', 30.5000, 66.9000, 14, 1, 4, 4, 3, 4, 4), ('House 22, Gwadar', 25.1200, 62.3200, 15, 1, 3, 1, 2, 1, 1),
('Port Office, Gwadar', 25.1300, 62.3300, 15, 2, 1, 1, 1, 1, 2), ('House 10, Sukkur', 27.7000, 68.8500, 16, 1, 3, 1, 2, 2, 1),
('Shop 9, Sukkur Mkt', 27.7100, 68.8600, 16, 2, 1, 1, 1, 1, 4), ('H-78, Latifabad', 25.3800, 68.3500, 17, 1, 1, 1, 1, 1, 1),
('Plot 3, Hyderabad', 25.3900, 68.3600, 17, 1, 1, 1, 1, 1, 1), ('Apt 4, Cantt Hyd', 25.4000, 68.3700, 17, 1, 1, 1, 1, 1, 1),
('House 11, Abbottabad', 34.1500, 73.2200, 18, 1, 2, 1, 3, 2, 1), ('Hotel 1, Mall Rd', 34.1600, 73.2300, 18, 3, 1, 1, 1, 1, 2),
('H-2, Mingora', 34.7800, 72.3600, 8, 1, 2, 2, 3, 3, 3), ('House 101, Swat', 34.8000, 72.3800, 8, 1, 2, 2, 3, 3, 3),
('Shop 21, Bannu', 32.9900, 70.6000, 19, 2, 2, 2, 3, 3, 3), ('House 5, Mirpur', 33.1500, 73.7500, 20, 1, 1, 1, 1, 1, 1),
('Apt 12, Muzaffarabad', 34.3600, 73.4700, 21, 1, 1, 1, 1, 1, 1), ('House 8, Skardu', 35.3000, 75.6300, 22, 1, 4, 2, 3, 3, 3),
('House 9, Hunza', 36.3100, 74.6500, 23, 1, 4, 2, 3, 3, 3), ('Office 3, Gilgit', 35.9200, 74.3000, 24, 2, 1, 1, 6, 1, 4),
('House 33, Faisalabad', 31.4200, 73.0800, 25, 1, 1, 1, 1, 1, 1), ('Factory 1, Millat Rd', 31.4300, 73.0900, 25, 2, 1, 1, 1, 1, 4),
('Shop 10, Jhang Rd', 31.4400, 73.0700, 25, 2, 1, 1, 1, 1, 4), ('House 12, Multan', 30.1900, 71.4700, 26, 1, 1, 1, 1, 1, 1),
('Shop 5, Ghanta Ghar', 30.2000, 71.4800, 26, 2, 1, 1, 1, 1, 4), ('House 8, Bahawalpur', 29.3900, 71.6700, 27, 1, 1, 1, 1, 1, 1),
('Apt 2, Dera Ghazi', 30.0500, 70.6300, 28, 1, 1, 1, 1, 1, 1), ('House 44, Gujrat', 32.5700, 74.0800, 29, 1, 1, 1, 1, 1, 1),
('Shop 3, Sialkot', 32.4900, 74.5200, 30, 2, 1, 1, 1, 1, 4), ('House 2, Sargodha', 32.0800, 72.6700, 31, 1, 1, 1, 1, 1, 1),
('House 6, Larkana', 27.5500, 68.2100, 32, 1, 2, 1, 2, 2, 3), ('House 7, Nawabshah', 26.2500, 68.4000, 33, 1, 3, 1, 2, 2, 1),
('Shop 1, Mirpur Khas', 25.5300, 69.0100, 34, 2, 1, 1, 1, 1, 4), ('House 9, Jacobabad', 28.2800, 68.4400, 35, 1, 2, 2, 3, 3, 3),
('House 2, Khuzdar', 27.8100, 66.6200, 36, 1, 4, 2, 3, 3, 3), ('Shop 5, Turbat', 26.0000, 63.0500, 37, 2, 2, 2, 3, 3, 3),
('House 4, Chaman', 30.9200, 66.4500, 38, 1, 2, 2, 3, 3, 3), ('Apt 1, Rawalpindi', 33.6000, 73.0500, 39, 1, 1, 1, 1, 1, 1),
('Shop 6, Pindi Mkt', 33.6100, 73.0600, 39, 2, 1, 1, 1, 1, 4), ('House 8, Jhelum', 32.9300, 73.7300, 40, 1, 1, 1, 1, 1, 1),
('House 1, Attock', 33.7600, 72.3600, 41, 1, 1, 1, 1, 1, 1), ('Shop 4, Chakwal', 32.9300, 72.8500, 42, 2, 1, 1, 1, 1, 4),
('House 5, Mianwali', 32.6800, 71.5300, 43, 1, 2, 1, 2, 2, 1), ('House 7, Bhakkar', 31.6200, 71.0700, 44, 1, 2, 2, 3, 3, 3),
('Shop 2, Layyah', 30.9600, 70.9500, 45, 2, 2, 2, 3, 3, 3), ('House 3, Muzaffargarh', 30.0700, 71.1900, 46, 1, 2, 1, 2, 2, 1),
('House 6, Rajanpur', 29.1000, 70.3300, 47, 1, 2, 2, 3, 3, 3), ('Apt 9, Vehari', 30.0400, 72.3500, 48, 1, 1, 1, 1, 1, 1),
('House 2, Lodhran', 29.5300, 71.6300, 49, 1, 1, 1, 1, 1, 1), ('House 1, Khanewal', 30.3000, 71.9300, 50, 1, 1, 1, 1, 1, 1),
('Shop 3, Pakpattan', 30.3400, 73.3900, 51, 2, 1, 1, 1, 1, 4), ('House 8, Okara', 30.8100, 73.4500, 52, 1, 1, 1, 1, 1, 1),
('House 4, Kasur', 31.1100, 74.4500, 53, 1, 1, 1, 1, 1, 1), ('Apt 2, Sheikhupura', 31.7100, 73.9800, 54, 1, 1, 1, 1, 1, 1),
('House 5, Nankana', 31.4500, 73.7000, 55, 1, 1, 1, 1, 1, 1), ('House 6, Hafizabad', 32.0700, 73.6800, 56, 1, 1, 1, 1, 1, 1),
('Shop 1, Mandi Baha', 32.5800, 73.4900, 57, 2, 1, 1, 1, 1, 4), ('House 9, Narowal', 32.1000, 74.8700, 58, 1, 1, 1, 1, 1, 1),
('House 3, Toba Tek', 30.9700, 72.4800, 59, 1, 1, 1, 1, 1, 1), ('Apt 4, Chiniot', 31.7200, 72.9800, 60, 1, 1, 1, 1, 1, 1),
('House 2, Malakand', 34.5700, 71.9300, 61, 1, 2, 2, 3, 3, 3), ('Shop 5, Dir Upper', 35.2000, 72.0500, 62, 2, 4, 2, 3, 3, 3),
('House 8, Dir Lower', 34.8200, 71.8700, 63, 1, 4, 2, 3, 3, 3), ('House 1, Chitral', 35.8500, 71.7800, 64, 1, 4, 2, 3, 3, 3),
('Shop 7, Kohistan', 35.2500, 73.1200, 65, 3, 4, 4, 3, 4, 4), ('House 3, Shangla', 34.8900, 72.6700, 66, 1, 2, 2, 3, 3, 3),
('House 6, Buner', 34.5000, 72.3300, 67, 1, 2, 2, 3, 3, 3), ('Shop 2, Haripur', 33.9900, 72.9300, 68, 2, 1, 1, 1, 1, 4),
('House 4, Swabi', 34.1200, 72.4700, 69, 1, 1, 1, 1, 1, 1), ('House 9, Mardan', 34.2000, 72.0400, 70, 1, 1, 1, 1, 1, 1),
('Apt 3, Nowshera', 34.0000, 71.9800, 71, 1, 1, 1, 1, 1, 1), ('House 2, Charsadda', 34.1500, 71.7300, 72, 1, 1, 1, 1, 1, 1),
('Shop 1, Hangu', 33.5300, 71.0600, 73, 2, 2, 2, 3, 3, 3), ('House 5, Karak', 33.1100, 71.0900, 74, 1, 2, 2, 3, 3, 3),
('House 8, Lakki Marwat', 32.6100, 70.9100, 75, 1, 2, 2, 3, 3, 3), ('Shop 4, Tank', 32.2200, 70.3800, 76, 2, 2, 2, 3, 3, 3),
('House 7, D.I. Khan', 31.8200, 70.9000, 77, 1, 2, 1, 2, 2, 1), ('House 1, Killa Saif', 30.7000, 67.8000, 78, 1, 4, 2, 3, 4, 4),
('Shop 6, Zhob', 31.3300, 69.4500, 79, 2, 2, 2, 3, 3, 3), ('House 2, Loralai', 30.3700, 68.6000, 80, 1, 2, 2, 3, 3, 3),
('House 9, Musakhel', 30.8700, 69.8300, 81, 1, 4, 2, 3, 4, 4), ('House 3, Barkhan', 29.8900, 69.5200, 82, 1, 4, 2, 3, 4, 4),
('Apt 5, Sibi', 29.5500, 67.8700, 83, 1, 1, 1, 1, 1, 1), ('House 8, Bolan', 29.5600, 67.6000, 84, 1, 2, 2, 3, 3, 3),
('Shop 2, Nasirabad', 28.4300, 68.3200, 85, 2, 1, 1, 2, 1, 1), ('House 4, Jaffarabad', 28.2200, 68.1700, 86, 1, 1, 1, 2, 1, 1),
('House 1, Jhal Magsi', 28.3100, 67.5300, 87, 1, 4, 2, 3, 4, 4), ('House 6, Kalat', 29.0200, 66.5800, 88, 1, 2, 2, 3, 3, 3),
('Shop 3, Mastung', 29.8000, 66.8500, 89, 2, 1, 1, 2, 1, 1), ('House 7, Kharan', 28.5800, 65.4100, 90, 1, 4, 2, 3, 4, 4),
('House 9, Panjgur', 26.9600, 64.1000, 91, 1, 2, 2, 3, 3, 3), ('Apt 1, Kech', 26.0000, 63.0000, 92, 1, 2, 2, 3, 3, 3),
('House 2, Lasbela', 26.2200, 66.3100, 93, 1, 1, 1, 2, 1, 1), ('House 4, Awaran', 26.4600, 65.2300, 94, 1, 4, 2, 3, 4, 4),
('Shop 8, Chaghai', 29.2800, 64.7500, 95, 2, 4, 2, 3, 4, 4), ('House 5, Nushki', 29.5500, 66.0100, 96, 1, 2, 2, 3, 3, 3),
('House 3, Qilla Abd', 30.7200, 66.6500, 97, 1, 2, 2, 3, 3, 3), ('House 1, Pishin', 30.5800, 66.9900, 98, 1, 2, 2, 3, 3, 3),
('Apt 6, Quetta', 30.1800, 67.0100, 99, 1, 1, 1, 1, 1, 1), ('House 7, Ziarat', 30.3800, 67.7300, 100, 1, 2, 2, 3, 3, 3),
('House 9, Harnai', 30.1000, 67.9300, 101, 1, 2, 2, 3, 3, 3);


-- ============================================================================
-- LEVEL 04: INHERITED STRUCTURAL BRANCHES 
-- ============================================================================

INSERT INTO Structure_Residential (structure_id, total_residential_units) VALUES 
(1, 1), (3, 1), (4, 1), (5, 4), (6, 1), (7, 1), (9, 1), (11, 1), (13, 8), (14, 1),
(17, 6), (18, 1), (19, 1), (21, 1), (23, 1), (24, 1), (26, 1), (28, 1), (29, 1), (30, 12),
(31, 1), (33, 1), (34, 1), (36, 1), (37, 1), (38, 1), (39, 1), (41, 1), (44, 1), (46, 1),
(47, 1), (48, 1), (50, 1), (51, 1), (52, 1), (53, 1), (55, 1), (56, 1), (58, 1), (59, 1),
(60, 1), (61, 1), (63, 1), (64, 1), (66, 1), (67, 1), (69, 1), (70, 1), (71, 4), (72, 1),
(73, 1), (74, 1), (75, 1), (76, 1), (77, 1), (78, 1), (79, 1), (80, 1), (81, 1), (82, 1),
(83, 1), (84, 1), (86, 1), (87, 1), (88, 1), (89, 1), (90, 1), (91, 1), (92, 10), (93, 1),
(94, 1), (95, 1), (96, 1), (97, 1), (98, 1), (99, 12);

INSERT INTO Structure_Commercial (structure_id, commercial_type_id, business_name, estimated_active_employees, has_industrial_power_connection, has_active_license) VALUES 
(2, 1, 'Anarkali General Store', 3, FALSE, TRUE), (8, 1, 'Mingora Cloth Market', 5, FALSE, TRUE),
(10, 1, 'Peshawar Electronic Plaza', 12, TRUE, TRUE), (12, 1, 'Hall Road Tech Hub', 8, TRUE, TRUE),
(16, 1, 'Blue Area Corporate Suites', 20, TRUE, TRUE), (20, 1, 'Melody Market Stationery', 2, FALSE, TRUE),
(22, 1, 'Liaquat Market Grocery', 4, FALSE, TRUE), (25, 2, 'Gwadar Port Logistics', 45, TRUE, TRUE),
(27, 1, 'Sukkur Wholesale Grain', 6, FALSE, TRUE), (32, 5, 'Mall Road Tourist Hotel', 25, TRUE, TRUE),
(35, 1, 'Bannu Bazaar Trade Center', 10, FALSE, TRUE), (40, 2, 'Gilgit Industrial Mill', 30, TRUE, TRUE),
(42, 2, 'Millat Road Auto Factory', 55, TRUE, TRUE), (43, 1, 'Jhang Road Retail Zone', 7, FALSE, TRUE),
(45, 1, 'Ghanta Ghar Fabrics', 5, FALSE, TRUE), (50, 1, 'Sialkot Sports Export House', 15, TRUE, TRUE),
(54, 1, 'Mirpur Khas Trading Co', 3, FALSE, TRUE), (57, 1, 'Turbat Local Market', 2, FALSE, TRUE),
(60, 1, 'Pindi Electronics Depot', 9, TRUE, TRUE), (63, 1, 'Chakwal Mining Supplies', 12, TRUE, TRUE),
(66, 1, 'Layyah Agro Commodities', 4, FALSE, TRUE), (72, 1, 'Pakpattan Retail Traders', 5, FALSE, TRUE),
(78, 1, 'Mandi Bahauddin Spare Parts', 3, FALSE, TRUE), (86, 1, 'Nasirabad Farm Implements', 2, FALSE, TRUE),
(89, 1, 'Mastung General Trading', 4, FALSE, TRUE), (96, 1, 'Awaran Supplies Market', 2, FALSE, TRUE),
(97, 3, 'Chaghai Banking Branch', 10, TRUE, TRUE), (103, 1, 'Lahore Food Street Stall', 2, FALSE, FALSE);

INSERT INTO Structure_Institution (structure_id, institution_type, organization_name, population_count, is_government) VALUES 
(81, 'School', 'Govt High School', 250, TRUE), (82, 'Hospital', 'City Health Clinic', 45, FALSE),
(83, 'Religious', 'Central Masjid Boarding', 120, FALSE), (84, 'Shelter', 'Dar-ul-Aman', 35, TRUE),
(85, 'Educational', 'Public Degree College', 400, TRUE), (86, 'Hospital', 'District General Hospital', 150, TRUE),
(87, 'Orphanage', 'Edhi Foundation Home', 60, FALSE), (88, 'Government', 'Tehsil Municipal Office', 30, TRUE),
(89, 'Correctional', 'District Jail Facility', 500, TRUE), (90, 'Educational', 'Technical Training Institute', 120, TRUE),
(91, 'Hospital', 'Community Maternity Centre', 25, FALSE), (92, 'Religious', 'Madrasa Taleem-ul-Quran', 90, FALSE),
(93, 'Government', 'Census Regional Office', 15, TRUE), (94, 'Shelter', 'Old Age Care Home', 20, FALSE),
(95, 'Educational', 'Govt Primary School', 100, TRUE), (96, 'Hospital', 'Rural Dispensary', 10, TRUE),
(97, 'Institutional', 'University Hostel', 200, TRUE), (98, 'Religious', 'Shrine Guest House', 40, FALSE),
(99, 'Government', 'Police Training School', 300, TRUE), (100, 'Hospital', 'Childrens Care Unit', 50, TRUE);


-- ============================================================================
-- LEVEL 05: HOUSEHOLD & DOMESTIC COMPONENT REGISTRIES
-- ============================================================================

INSERT INTO Household (structure_id, census_id, household_category_id, residential_status_type_id, number_of_rooms, household_size) VALUES 
(1, 1, 1, 1, 3, 5), (2, 1, 1, 1, 4, 4), (3, 1, 1, 1, 2, 4), (4, 1, 1, 2, 2, 4), (5, 1, 1, 1, 5, 3), (6, 1, 1, 1, 3, 4), (7, 1, 1, 2, 2, 3), (8, 1, 1, 1, 4, 3), (9, 1, 1, 1, 6, 3), (10, 1, 1, 1, 3, 3), 
(11, 1, 1, 1, 4, 3), (12, 1, 1, 1, 2, 3), (13, 1, 1, 1, 3, 3), (14, 1, 1, 1, 5, 3), (15, 1, 1, 1, 2, 3), (16, 1, 1, 1, 3, 3), (17, 1, 1, 1, 4, 3), (18, 1, 1, 1, 2, 3), (19, 1, 1, 1, 4, 3), (20, 1, 1, 1, 6, 3),  
(21, 1, 1, 1, 3, 3), (22, 1, 1, 1, 2, 3), (23, 1, 1, 1, 5, 3), (24, 1, 1, 1, 3, 3), (25, 1, 1, 1, 4, 3), (26, 1, 1, 1, 2, 3), (27, 1, 1, 1, 3, 3), (28, 1, 1, 1, 4, 3), (29, 1, 1, 1, 2, 3), (30, 1, 1, 1, 3, 3),   
(31, 1, 1, 1, 5, 3), (32, 1, 1, 1, 2, 3);  


-- ============================================================================
-- LEVEL 06: INDIVIDUAL CITIZEN REGISTRY & HISTORIES
-- ============================================================================

INSERT INTO Person (household_id, first_name, last_name, cnic_number, sex_id, date_of_birth, nationality_id, religion_id, mother_tongue_id, marital_status_id, relationship_type_id, head_person_id, is_literate, education_level_id, currently_attending_school, employment_status_id, occupation_id, industry_id, monthly_income, data_entry_operator_id, created_date) VALUES
(1, 'Muhammad', 'Khan', '12345-6000001-1', 1, '1965-03-15', 1, 1, 1, 2, 1, NULL, 1, 4, 0, 1, 8, 5, 45000.00, 31, '2023-02-20 08:00:00'),
(1, 'Fatima', 'Khan', '12345-6000002-3', 2, '1970-05-22', 1, 1, 1, 2, 2, 1, 1, 3, 0, 8, NULL, NULL, NULL, 31, '2023-02-20 08:05:00'),
(1, 'Ali', 'Khan', '12345-6000003-5', 1, '1995-08-10', 1, 1, 1, 1, 3, 1, 1, 5, 1, 6, 12, 2, 0.00, 31, '2023-02-20 08:10:00'),
(1, 'Ayesha', 'Khan', '12345-6000004-7', 2, '1998-11-03', 1, 1, 1, 1, 3, 1, 1, 5, 1, 6, NULL, NULL, 0.00, 31, '2023-02-20 08:15:00'),
(1, 'Hassan', 'Khan', '12345-6000005-9', 1, '2002-02-28', 1, 1, 1, 1, 3, 1, 1, 2, 1, 6, NULL, NULL, 0.00, 31, '2023-02-20 08:20:00'),

(2, 'Ahmed', 'Ali', '12345-6000006-0', 1, '1968-07-19', 1, 1, 1, 2, 1, NULL, 1, 4, 0, 1, 6, 1, 38000.00, 31, '2023-02-20 08:25:00'),
(2, 'Noor', 'Ali', '12345-6000007-2', 2, '1972-09-24', 1, 1, 1, 2, 2, 6, 1, 3, 0, 8, NULL, NULL, NULL, 31, '2023-02-20 08:30:00'),
(2, 'Karim', 'Ali', '12345-6000008-4', 1, '1993-12-05', 1, 1, 1, 1, 3, 6, 1, 5, 0, 1, 2, 4, 32000.00, 31, '2023-02-20 08:35:00'),
(2, 'Sara', 'Ali', '12345-6000009-6', 2, '2001-04-16', 1, 1, 1, 1, 3, 6, 1, 2, 1, 6, NULL, NULL, 0.00, 31, '2023-02-20 08:40:00'),

(3, 'Rashid', 'Hassan', '12345-6000010-8', 1, '1960-01-22', 1, 1, 2, 2, 1, NULL, 1, 3, 0, 1, 1, 1, 42000.00, 32, '2023-02-20 08:45:00'),
(3, 'Zainab', 'Hassan', '12345-6000011-0', 2, '1965-06-18', 1, 1, 2, 2, 2, 10, 1, 2, 0, 8, NULL, NULL, NULL, 32, '2023-02-20 08:50:00'),
(3, 'Malik', 'Hassan', '12345-6000012-2', 1, '1992-10-30', 1, 1, 2, 1, 3, 10, 1, 5, 0, 1, 3, 14, 35000.00, 32, '2023-02-20 08:55:00'),
(3, 'Hina', 'Hassan', '12345-6000013-4', 2, '2000-03-12', 1, 1, 2, 1, 3, 10, 1, 4, 1, 6, NULL, NULL, 0.00, 32, '2023-02-20 09:00:00'),

(4, 'Nasir', 'Hussain', '12345-6000014-6', 1, '1962-11-05', 1, 1, 2, 2, 1, NULL, 1, 3, 0, 1, 7, 8, 48000.00, 32, '2023-02-20 09:05:00'),
(4, 'Amina', 'Hussain', '12345-6000015-8', 2, '1967-02-14', 1, 1, 2, 2, 2, 14, 0, 1, 0, 8, NULL, NULL, NULL, 32, '2023-02-20 09:10:00'),
(4, 'Imran', 'Hussain', '12345-6000016-1', 1, '1995-07-22', 1, 1, 2, 1, 3, 14, 1, 4, 0, 1, 5, 5, 28000.00, 32, '2023-02-20 09:15:00'),
(4, 'Leila', 'Hussain', '12345-6000017-3', 2, '2003-09-08', 1, 1, 2, 1, 3, 14, 1, 2, 1, 6, NULL, NULL, 0.00, 32, '2023-02-20 09:20:00'),

(5, 'Samir', 'Khan', '12345-6000018-5', 1, '1970-04-20', 1, 1, 1, 2, 1, NULL, 1, 4, 0, 1, 9, 6, 52000.00, 33, '2023-02-20 09:25:00'),
(5, 'Maha', 'Khan', '12345-6000019-7', 2, '1975-08-03', 1, 1, 1, 2, 2, 18, 1, 3, 0, 8, NULL, NULL, NULL, 33, '2023-02-20 09:30:00'),
(5, 'Bashir', 'Khan', '12345-6000020-9', 1, '1998-01-17', 1, 1, 1, 1, 3, 18, 1, 5, 1, 6, 13, 2, 0.00, 33, '2023-02-20 09:35:00'),

(6, 'Waqar', 'Ahmed', '12345-6000021-0', 1, '1955-12-10', 1, 1, 1, 2, 1, NULL, 1, 2, 0, 5, 4, 10, 65000.00, 33, '2023-02-20 09:40:00'),
(6, 'Rania', 'Ahmed', '12345-6000022-2', 2, '1960-05-25', 1, 1, 1, 2, 2, 21, 1, 2, 0, 8, NULL, NULL, NULL, 33, '2023-02-20 09:45:00'),
(6, 'Khalid', 'Ahmed', '12345-6000023-4', 1, '1985-09-13', 1, 1, 1, 1, 3, 21, 1, 6, 0, 1, 15, 9, 55000.00, 33, '2023-02-20 09:50:00'),
(6, 'Dina', 'Ahmed', '12345-6000024-6', 2, '1988-02-07', 1, 1, 1, 1, 3, 21, 1, 5, 0, 1, NULL, NULL, 25000.00, 33, '2023-02-20 09:55:00'),

(7, 'Jamal', 'Malik', '12345-6000025-8', 1, '1972-06-18', 1, 1, 3, 2, 1, NULL, 1, 4, 0, 1, 11, 12, 41000.00, 34, '2023-02-20 10:00:00'),
(7, 'Lia', 'Malik', '12345-6000026-1', 2, '1978-10-12', 1, 1, 3, 2, 2, 25, 0, 1, 0, 8, NULL, NULL, NULL, 34, '2023-02-20 10:05:00'),
(7, 'Amir', 'Malik', '12345-6000027-3', 1, '2001-03-25', 1, 1, 3, 1, 3, 25, 1, 3, 1, 6, NULL, NULL, 0.00, 34, '2023-02-20 10:10:00'),

(8, 'Tariq', 'Hassan', '12345-6000028-5', 1, '1963-08-29', 1, 1, 1, 2, 1, NULL, 1, 3, 0, 1, 10, 11, 39000.00, 34, '2023-02-20 10:15:00'),
(8, 'Nadia', 'Hassan', '12345-6000029-7', 2, '1968-12-04', 1, 1, 1, 2, 2, 28, 1, 2, 0, 8, NULL, NULL, NULL, 34, '2023-02-20 10:20:00'),
(8, 'Farhan', 'Hassan', '12345-6000030-9', 1, '1994-05-16', 1, 1, 1, 1, 3, 28, 1, 5, 0, 1, 6, 3, 31000.00, 34, '2023-02-20 10:25:00'),

(9, 'Yousef', 'Ali', '12345-6000031-0', 1, '1958-01-08', 1, 1, 2, 2, 1, NULL, 1, 2, 0, 5, 2, 1, 72000.00, 34, '2023-02-20 10:30:00'),
(9, 'Hana', 'Ali', '12345-6000032-2', 2, '1963-07-21', 1, 1, 2, 2, 2, 31, 1, 2, 0, 8, NULL, NULL, NULL, 34, '2023-02-20 10:35:00'),
(9, 'Rasheed', 'Ali', '12345-6000033-4', 1, '1990-11-14', 1, 1, 2, 1, 3, 31, 1, 4, 0, 1, 14, 2, 29000.00, 34, '2023-02-20 10:40:00'),

(10, 'Saad', 'Khan', '12345-6000034-6', 1, '1966-04-17', 1, 1, 1, 2, 1, NULL, 1, 3, 0, 1, 8, 5, 37000.00, 35, '2023-02-20 10:45:00'),
(10, 'Luna', 'Khan', '12345-6000035-8', 2, '1971-09-06', 1, 1, 1, 2, 2, 34, 1, 2, 0, 8, NULL, NULL, NULL, 35, '2023-02-20 10:50:00'),
(10, 'Aziz', 'Khan', '12345-6000036-1', 1, '1999-02-19', 1, 1, 1, 1, 3, 34, 1, 3, 1, 6, NULL, NULL, 0.00, 35, '2023-02-20 10:55:00'),

(11, 'Adnan', 'Ahmed', '12345-6000037-3', 1, '1961-10-25', 1, 1, 1, 2, 1, NULL, 1, 3, 0, 1, 7, 14, 46000.00, 35, '2023-02-20 11:00:00'),
(11, 'Yasmin', 'Ahmed', '12345-6000038-5', 2, '1966-03-11', 1, 1, 1, 2, 2, 37, 0, 1, 0, 8, NULL, NULL, NULL, 35, '2023-02-20 11:05:00'),
(11, 'Rana', 'Ahmed', '12345-6000039-7', 1, '1996-06-28', 1, 1, 1, 1, 3, 37, 1, 4, 0, 1, 5, 4, 24000.00, 35, '2023-02-20 11:10:00'),

(12, 'Wasim', 'Malik', '12345-6000040-9', 1, '1969-07-09', 1, 1, 3, 2, 1, NULL, 1, 4, 0, 1, 10, 6, 51000.00, 35, '2023-02-20 11:15:00'),
(12, 'Rena', 'Malik', '12345-6000041-0', 2, '1974-11-15', 1, 1, 3, 2, 2, 40, 1, 3, 0, 8, NULL, NULL, NULL, 35, '2023-02-20 11:20:00'),
(12, 'Naeem', 'Malik', '12345-6000042-2', 1, '2000-08-30', 1, 1, 3, 1, 3, 40, 1, 2, 1, 6, NULL, NULL, 0.00, 35, '2023-02-20 11:25:00'),

(13, 'Mohan', 'Hassan', '12345-6000043-4', 1, '1957-05-12', 1, 2, 4, 2, 1, NULL, 1, 2, 0, 1, 4, 1, 58000.00, 36, '2023-02-20 11:30:00'),
(13, 'Anjali', 'Hassan', '12345-6000044-6', 2, '1962-09-27', 1, 2, 4, 2, 2, 43, 0, 1, 0, 8, NULL, NULL, NULL, 36, '2023-02-20 11:35:00'),
(13, 'Rohan', 'Hassan', '12345-6000045-8', 1, '1992-01-05', 1, 2, 4, 1, 3, 43, 1, 5, 0, 1, 16, 5, 26000.00, 36, '2023-02-20 11:40:00'),

(14, 'Deepak', 'Ali', '12345-6000046-1', 1, '1964-02-22', 1, 2, 5, 2, 1, NULL, 1, 3, 0, 1, 11, 11, 44000.00, 36, '2023-02-20 11:45:00'),
(14, 'Priya', 'Ali', '12345-6000047-3', 2, '1969-06-08', 1, 2, 5, 2, 2, 46, 1, 2, 0, 8, NULL, NULL, NULL, 36, '2023-02-20 11:50:00'),
(14, 'Arjun', 'Ali', '12345-6000048-5', 1, '1997-03-19', 1, 2, 5, 1, 3, 46, 1, 4, 1, 6, NULL, NULL, 0.00, 36, '2023-02-20 11:55:00'),

(15, 'Siddiqui', 'Khan', '12345-6000049-7', 1, '1961-09-30', 1, 1, 2, 2, 1, NULL, 1, 3, 0, 1, 1, 1, 35000.00, 36, '2023-02-20 12:00:00'),
(15, 'Gulnar', 'Khan', '12345-6000050-9', 2, '1966-12-17', 1, 1, 2, 2, 2, 49, 0, 1, 0, 8, NULL, NULL, NULL, 36, '2023-02-20 12:05:00'),
(15, 'Farah', 'Khan', '12345-6000051-0', 2, '1993-04-23', 1, 1, 2, 1, 3, 49, 1, 4, 0, 1, NULL, NULL, 18000.00, 36, '2023-02-20 12:10:00'),

(16, 'Zahir', 'Ahmad', '12345-6000052-2', 1, '1960-06-14', 1, 1, 1, 2, 1, NULL, 1, 2, 0, 1, 6, 2, 62000.00, 37, '2023-02-20 12:15:00'),
(16, 'Meena', 'Ahmad', '12345-6000053-4', 2, '1965-10-21', 1, 1, 1, 2, 2, 52, 1, 2, 0, 8, NULL, NULL, NULL, 37, '2023-02-20 12:20:00'),
(16, 'Kamil', 'Ahmad', '12345-6000054-6', 1, '1996-02-10', 1, 1, 1, 1, 3, 52, 1, 5, 0, 1, 17, 7, 33000.00, 37, '2023-02-20 12:25:00'),

(17, 'Ibrahim', 'Raza', '12345-6000055-8', 1, '1959-08-03', 1, 1, 3, 2, 1, NULL, 1, 3, 0, 1, 8, 8, 40000.00, 37, '2023-02-20 12:30:00'),
(17, 'Saira', 'Raza', '12345-6000056-1', 2, '1964-01-19', 1, 1, 3, 2, 2, 55, 1, 2, 0, 8, NULL, NULL, NULL, 37, '2023-02-20 12:35:00'),
(17, 'Kashan', 'Raza', '12345-6000057-3', 1, '1995-07-07', 1, 1, 3, 1, 3, 55, 1, 4, 0, 1, 9, 6, 23000.00, 37, '2023-02-20 12:40:00'),

(18, 'Babar', 'Khan', '12345-6000058-5', 1, '1962-11-28', 1, 1, 6, 2, 1, NULL, 1, 3, 0, 1, 10, 10, 43000.00, 37, '2023-02-20 12:45:00'),
(18, 'Mariam', 'Khan', '12345-6000059-7', 2, '1968-04-14', 1, 1, 6, 2, 2, 58, 0, 1, 0, 8, NULL, NULL, NULL, 37, '2023-02-20 12:50:00'),
(18, 'Danial', 'Khan', '12345-6000060-9', 1, '1994-09-11', 1, 1, 6, 1, 3, 58, 1, 5, 0, 1, 7, 5, 27000.00, 37, '2023-02-20 12:55:00'),

(19, 'Habib', 'Malik', '12345-6000061-0', 1, '1967-03-06', 1, 1, 1, 2, 1, NULL, 1, 4, 0, 1, 11, 9, 49000.00, 38, '2023-02-20 13:00:00'),
(19, 'Zara', 'Malik', '12345-6000062-2', 2, '1972-07-20', 1, 1, 1, 2, 2, 61, 1, 3, 0, 8, NULL, NULL, NULL, 38, '2023-02-20 13:05:00'),
(19, 'Karim', 'Malik', '12345-6000063-4', 1, '1999-05-18', 1, 1, 1, 1, 3, 61, 1, 3, 1, 6, NULL, NULL, 0.00, 38, '2023-02-20 13:10:00'),

(20, 'Faisal', 'Hassan', '12345-6000064-6', 1, '1956-12-17', 1, 3, 7, 2, 1, NULL, 1, 2, 0, 1, 2, 15, 68000.00, 38, '2023-02-20 13:15:00'),
(20, 'Iqra', 'Hassan', '12345-6000065-8', 2, '1961-05-03', 1, 3, 7, 2, 2, 64, 1, 2, 0, 8, NULL, NULL, NULL, 38, '2023-02-20 13:20:00'),
(20, 'Hamza', 'Hassan', '12345-6000066-1', 1, '1991-10-22', 1, 3, 7, 1, 3, 64, 1, 5, 0, 1, 18, 12, 34000.00, 38, '2023-02-20 13:25:00'),

(21, 'Salim', 'Ahmed', '12345-6000067-3', 1, '1965-02-09', 1, 1, 2, 2, 1, NULL, 1, 4, 0, 1, 9, 13, 47000.00, 38, '2023-02-20 13:30:00'),
(21, 'Saba', 'Ahmed', '12345-6000068-5', 2, '1970-08-24', 1, 1, 2, 2, 2, 67, 1, 3, 0, 8, NULL, NULL, NULL, 38, '2023-02-20 13:35:00'),
(21, 'Hassam', 'Ahmed', '12345-6000069-7', 1, '2000-12-10', 1, 1, 2, 1, 3, 67, 1, 2, 1, 6, NULL, NULL, 0.00, 38, '2023-02-20 13:40:00'),

(22, 'Riaz', 'Ali', '12345-6000070-9', 1, '1958-07-15', 1, 1, 1, 2, 1, NULL, 1, 3, 0, 1, 3, 4, 55000.00, 39, '2023-02-20 13:45:00'),
(22, 'Bushra', 'Ali', '12345-6000071-0', 2, '1963-11-28', 1, 1, 1, 2, 2, 70, 0, 1, 0, 8, NULL, NULL, NULL, 39, '2023-02-20 13:50:00'),
(22, 'Imad', 'Ali', '12345-6000072-2', 1, '1998-06-13', 1, 1, 1, 1, 3, 70, 1, 4, 1, 6, NULL, NULL, 0.00, 39, '2023-02-20 13:55:00'),

(23, 'Nadim', 'Khan', '12345-6000073-4', 1, '1968-09-02', 1, 1, 3, 2, 1, NULL, 1, 4, 0, 1, 12, 17, 53000.00, 39, '2023-02-20 14:00:00'),
(23, 'Suhana', 'Khan', '12345-6000074-6', 2, '1973-01-18', 1, 1, 3, 2, 2, 73, 1, 3, 0, 8, NULL, NULL, NULL, 39, '2023-02-20 14:05:00'),
(23, 'Shiraz', 'Khan', '12345-6000075-8', 1, '2002-04-26', 1, 1, 3, 1, 3, 73, 1, 2, 1, 6, NULL, NULL, 0.00, 39, '2023-02-20 14:10:00'),

(24, 'Qasim', 'Malik', '12345-6000076-1', 1, '1960-10-11', 1, 1, 1, 2, 1, NULL, 1, 3, 0, 1, 5, 8, 39000.00, 39, '2023-02-20 14:15:00'),
(24, 'Hafsa', 'Malik', '12345-6000077-3', 2, '1965-03-27', 1, 1, 1, 2, 2, 76, 1, 2, 0, 8, NULL, NULL, NULL, 39, '2023-02-20 14:20:00'),
(24, 'Taufiq', 'Malik', '12345-6000078-5', 1, '1997-01-31', 1, 1, 1, 1, 3, 76, 1, 5, 0, 1, 13, 9, 22000.00, 39, '2023-02-20 14:25:00'),

(25, 'Akhtar', 'Hassan', '12345-6000079-7', 1, '1963-04-08', 1, 1, 2, 2, 1, NULL, 1, 4, 0, 1, 11, 11, 50000.00, 40, '2023-02-20 14:30:00'),
(25, 'Rabia', 'Hassan', '12345-6000080-9', 2, '1968-06-19', 1, 1, 2, 2, 2, 79, 1, 3, 0, 8, NULL, NULL, NULL, 40, '2023-02-20 14:35:00'),
(25, 'Mansoor', 'Hassan', '12345-6000081-0', 1, '1996-02-14', 1, 1, 2, 1, 3, 79, 1, 4, 0, 1, 6, 5, 28000.00, 40, '2023-02-20 14:40:00'),

(26, 'Manzoor', 'Ahmad', '12345-6000082-2', 1, '1969-05-21', 1, 1, 1, 2, 1, NULL, 1, 4, 0, 1, 7, 2, 48000.00, 40, '2023-02-20 14:45:00'),
(26, 'Aida', 'Ahmad', '12345-6000083-4', 2, '1974-09-05', 1, 1, 1, 2, 2, 82, 1, 3, 0, 8, NULL, NULL, NULL, 40, '2023-02-20 14:50:00'),
(26, 'Sarmad', 'Ahmad', '12345-6000084-6', 1, '2001-07-17', 1, 1, 1, 1, 3, 82, 1, 3, 1, 6, NULL, NULL, 0.00, 40, '2023-02-20 14:55:00'),

(27, 'Shabir', 'Khan', '12345-6000085-8', 1, '1958-01-25', 1, 1, 6, 2, 1, NULL, 1, 2, 0, 1, 4, 12, 60000.00, 40, '2023-02-20 15:00:00'),
(27, 'Noreen', 'Khan', '12345-6000086-1', 2, '1962-08-11', 1, 1, 6, 2, 2, 85, 0, 1, 0, 8, NULL, NULL, NULL, 40, '2023-02-20 15:05:00'),
(27, 'Mir', 'Khan', '12345-6000087-3', 1, '1994-03-29', 1, 1, 6, 1, 3, 85, 1, 5, 0, 1, 14, 8, 32000.00, 40, '2023-02-20 15:10:00'),

(28, 'Nawaz', 'Ali', '12345-6000088-5', 1, '1964-07-06', 1, 1, 7, 2, 1, NULL, 1, 4, 0, 1, 10, 5, 46000.00, 41, '2023-02-20 15:15:00'),
(28, 'Munira', 'Ali', '12345-6000089-7', 2, '1969-02-12', 1, 1, 7, 2, 2, 88, 1, 3, 0, 8, NULL, NULL, NULL, 41, '2023-02-20 15:20:00'),
(28, 'Rizwan', 'Ali', '12345-6000090-9', 1, '1999-10-08', 1, 1, 7, 1, 3, 88, 1, 3, 1, 6, NULL, NULL, 0.00, 41, '2023-02-20 15:25:00'),

(29, 'Feroz', 'Malik', '12345-6000091-0', 1, '1961-11-20', 1, 1, 1, 2, 1, NULL, 1, 3, 0, 1, 8, 3, 44000.00, 41, '2023-02-20 15:30:00'),
(29, 'Safia', 'Malik', '12345-6000092-2', 2, '1966-04-09', 1, 1, 1, 2, 2, 91, 1, 2, 0, 8, NULL, NULL, NULL, 41, '2023-02-20 15:35:00'),
(29, 'Abbas', 'Malik', '12345-6000093-4', 1, '1992-08-15', 1, 1, 1, 1, 3, 91, 1, 5, 0, 1, 15, 6, 30000.00, 41, '2023-02-20 15:40:00'),

(30, 'Zubair', 'Hassan', '12345-6000094-6', 1, '1966-03-14', 1, 1, 2, 2, 1, NULL, 1, 4, 0, 1, 9, 4, 51000.00, 41, '2023-02-20 15:45:00'),
(30, 'Seema', 'Hassan', '12345-6000095-8', 2, '1971-07-23', 1, 1, 2, 2, 2, 94, 1, 3, 0, 8, NULL, NULL, NULL, 41, '2023-02-20 15:50:00'),
(30, 'Suleman', 'Hassan', '12345-6000096-1', 1, '2003-05-30', 1, 1, 2, 1, 3, 94, 1, 2, 1, 6, NULL, NULL, 0.00, 41, '2023-02-20 15:55:00'),

(31, 'Rashad', 'Ahmed', '12345-6000097-3', 1, '1959-09-19', 1, 1, 1, 2, 1, NULL, 1, 2, 0, 1, 1, 15, 71000.00, 42, '2023-02-20 16:00:00'),
(31, 'Samina', 'Ahmed', '12345-6000098-5', 2, '1964-12-04', 1, 1, 1, 2, 2, 97, 1, 2, 0, 8, NULL, NULL, NULL, 42, '2023-02-20 16:05:00'),
(31, 'Ashan', 'Ahmed', '12345-6000099-7', 1, '1993-06-22', 1, 1, 1, 1, 3, 97, 1, 4, 0, 1, 17, 11, 36000.00, 42, '2023-02-20 16:10:00'),

(32, 'Jalal', 'Khan', '12345-6000100-9', 1, '1962-08-10', 1, 1, 3, 2, 1, NULL, 1, 3, 0, 1, 11, 8, 42000.00, 42, '2023-02-20 16:15:00'),
(32, 'Uzma', 'Khan', '12345-6000101-0', 2, '1967-01-26', 1, 1, 3, 2, 2, 100, 1, 2, 0, 8, NULL, NULL, NULL, 42, '2023-02-20 16:20:00'),
(32, 'Shafiq', 'Khan', '12345-6000102-2', 1, '2000-11-03', 1, 1, 3, 1, 3, 100, 1, 3, 1, 6, NULL, NULL, 0.00, 42, '2023-02-20 16:25:00');

INSERT INTO Person_Disability (person_id, disability_type_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 1), (7, 2), (8, 3), (9, 4), (10, 5),
(11, 1), (12, 2), (13, 3), (14, 4), (15, 5), (16, 1), (17, 2), (18, 3), (19, 4), (20, 5),
(21, 1), (22, 2), (23, 3), (24, 4), (25, 5), (26, 1), (27, 2), (28, 3), (29, 4), (30, 5),
(31, 1), (32, 2), (33, 3), (34, 4), (35, 5), (36, 1), (37, 2), (38, 3), (39, 4), (40, 5),
(41, 1), (42, 2), (43, 3), (44, 4), (45, 5), (46, 1), (47, 2), (48, 3), (49, 4), (50, 5);

INSERT INTO Migration_History (person_id, previous_district_id, migration_reason, year_of_migration) VALUES
(1, 1, 'Employment', 2020), (2, 2, 'Marriage', 2019), (3, 3, 'Education', 2021), (4, 4, 'Family Move', 2018), (5, 5, 'Other', 2022),
(6, 6, 'Employment', 2017), (7, 7, 'Marriage', 2023), (8, 8, 'Education', 2020), (9, 9, 'Family Move', 2019), (10, 10, 'Other', 2021),
(11, 1, 'Employment', 2016), (12, 2, 'Marriage', 2022), (13, 3, 'Education', 2023), (14, 4, 'Family Move', 2020), (15, 5, 'Other', 2019),
(16, 6, 'Employment', 2018), (17, 7, 'Marriage', 2021), (18, 8, 'Education', 2022), (19, 9, 'Family Move', 2017), (20, 10, 'Other', 2023),
(21, 1, 'Employment', 2015), (22, 2, 'Marriage', 2020), (23, 3, 'Education', 2019), (24, 4, 'Family Move', 2022), (25, 5, 'Other', 2018),
(26, 6, 'Employment', 2021), (27, 7, 'Marriage', 2017), (28, 8, 'Education', 2023), (29, 9, 'Family Move', 2020), (30, 10, 'Other', 2019),
(31, 1, 'Employment', 2014), (32, 2, 'Marriage', 2023), (33, 3, 'Education', 2018), (34, 4, 'Family Move', 2021), (35, 5, 'Other', 2017),
(36, 6, 'Employment', 2022), (37, 7, 'Marriage', 2019), (38, 8, 'Education', 2020), (39, 9, 'Family Move', 2023), (40, 10, 'Other', 2021),
(41, 1, 'Employment', 2013), (42, 2, 'Marriage', 2021), (43, 3, 'Education', 2022), (44, 4, 'Family Move', 2019), (45, 5, 'Other', 2020),
(46, 6, 'Employment', 2020), (47, 7, 'Marriage', 2018), (48, 8, 'Education', 2021), (49, 9, 'Family Move', 2022), (50, 10, 'Other', 2017);

/* COMPLETE CITIZEN PROFILE REPORT*/


/*1. Person_Detail_View
Shows complete profile of every person including gender, education, job status and nationality.
Only persons who have all information filled are shown, no missing data allowed.*/


CREATE VIEW Person_Detail_View AS
SELECT
    p.person_id,
    p.first_name,
    p.last_name,
    bs.sex_name,
    el.level_name,
    es.status_name AS employment_status,
    ms.status_name AS marital_status,
    n.country_name,
    h.household_size
FROM Person p

INNER JOIN Biological_Sex bs
ON p.sex_id = bs.sex_id

INNER JOIN Education_Level el
ON p.education_level_id = el.education_level_id

INNER JOIN Employment_Status es
ON p.employment_status_id = es.employment_status_id

INNER JOIN Marital_Status ms
ON p.marital_status_id = ms.marital_status_id

INNER JOIN Nationality n
ON p.nationality_id = n.nationality_id

INNER JOIN Household h
ON p.household_id = h.household_id

ORDER BY p.first_name;
/* VIEW*/
SELECT* FROM PERSON_DETAIL_VIEW;




/* HIGHLY EDUCATED CITIZENS REPORT
Highly_Educated_Persons
Shows people who have Bachelors, Masters or PhD degree with their job and income.
Only highly educated and employed persons are displayed.
*/


CREATE VIEW Highly_Educated_Persons AS
SELECT
    p.first_name,
    p.last_name,
    el.level_name,
    es.status_name,
    o.occupation_name,
    i.industry_name,
    p.monthly_income
FROM Person p

INNER JOIN Education_Level el
ON p.education_level_id = el.education_level_id

INNER JOIN Employment_Status es
ON p.employment_status_id = es.employment_status_id

INNER JOIN Occupation o
ON p.occupation_id = o.occupation_id

INNER JOIN Industry i
ON p.industry_id = i.industry_id
WHERE el.level_name ='BACHELORS' OR EL.LEVEL_NAME='MASTERS' OR EL.LEVEL_NAME= 'PHD';
/* VIEW */
SELECT* FROM HIGHLY_EDUCATED_PERSONS;





/* MIGRATION / EDUCATION AND EMPLOYMENT RECORD ANALYSIS
Migration_Education_Employment_Record
Shows people who moved from one district to another with their education and job details.
Results are ordered by most recent migration year first.
*/

CREATE VIEW MIGRATION_EDUCATION_EPLOYMENT_RECORD AS
SELECT
    p.first_name,
    p.last_name,
    mh.migration_reason,
    mh.year_of_migration,
    d.district_name,
    el.level_name,
    es.status_name
FROM Migration_History mh

INNER JOIN Person p
ON mh.person_id = p.person_id

INNER JOIN District d
ON mh.previous_district_id = d.district_id

INNER JOIN Education_Level el
ON p.education_level_id = el.education_level_id

INNER JOIN Employment_Status es
ON p.employment_status_id = es.employment_status_id

ORDER BY mh.year_of_migration DESC;
SELECT* FROM MIGRATION_EDUCATION_EPLOYMENT_RECORD;



/* CENSUS STAFF WORKING REPORT
Staff_Working_Report
Shows every census staff member with their role, assigned block, union council and district.
Helps track which staff member is working in which area.
*/
CREATE VIEW STAFF_WORKING_REPORT AS
SELECT
    cs.first_name,
    cs.last_name,
    cs.staff_role,
    cb.census_block_code,
    uc.union_council_name,
    t.tehsil_name,
    d.district_name
FROM Census_Staff cs

INNER JOIN Census_Block cb
ON cs.assigned_census_block_id = cb.census_block_id

INNER JOIN Union_Council uc
ON cb.union_council_id = uc.union_council_id

INNER JOIN Tehsil t
ON uc.tehsil_id = t.tehsil_id

INNER JOIN District d
ON t.district_id = d.district_id

ORDER BY cs.staff_role;
/* VIEW */
SELECT* FROM STAFF_WORKING_REPORT;


/* TOP 3 CITIES HIGHIGHLY POPULATION
Top_Population_Cities
Shows top 3 districts in Pakistan with highest number of households.
Useful for identifying most populated cities in the country.
*/
CREATE VIEW TOP_POPULATION_CITIES AS
SELECT
    p.province_name,
    d.district_name,
    SUM(cb.estimated_household_count) AS Total_Population

FROM Province p

INNER JOIN Division dv
ON p.province_id = dv.province_id

INNER JOIN District d
ON dv.division_id = d.division_id

INNER JOIN Tehsil t
ON d.district_id = t.district_id

INNER JOIN Union_Council uc
ON t.tehsil_id = uc.tehsil_id

INNER JOIN Census_Block cb
ON uc.union_council_id = cb.union_council_id

GROUP BY
    p.province_name,
    d.district_name

ORDER BY
    Total_Population DESC

LIMIT 3;

SELECT* FROM TOP_POPULATION_CITIES;


/* ...........................LEFT JOIN.......................

Citizens_Record
Shows all persons with their education, job, occupation and nationality — even if some info is missing.
NULL appears where information is not available for a person.
*/

CREATE VIEW CITIZENS_RECORD AS
SELECT
    p.first_name,
    p.last_name,
    el.level_name,
    es.status_name AS employment_status,
    o.occupation_name,
    i.industry_name,
    n.country_name

FROM Person p

LEFT JOIN Education_Level el
ON p.education_level_id = el.education_level_id

LEFT JOIN Employment_Status es
ON p.employment_status_id = es.employment_status_id

LEFT JOIN Occupation o
ON p.occupation_id = o.occupation_id

LEFT JOIN Industry i
ON p.industry_id = i.industry_id

LEFT JOIN Mother_Tongue mt
ON p.mother_tongue_id = mt.mother_tongue_id

LEFT JOIN Nationality n
ON p.nationality_id = n.nationality_id

ORDER BY el.level_name;
SELECT* FROM CITIZENS_RECORD;



/* Highly Educated Individuals Missing Occupation or Industry Information
Educated_Unemployed
Shows educated people (Bachelor, Master, MPhil) who have no occupation or industry assigned.
Helps find highly educated people who are still unemployed or unregistered.
 */
CREATE VIEW  EDUACATED_UNEMPLOYED AS
SELECT
    p.first_name,
    p.last_name,
    el.level_name,
    o.occupation_name,
    i.industry_name

FROM Person p

LEFT JOIN Education_Level el
ON p.education_level_id = el.education_level_id

LEFT JOIN Occupation o
ON p.occupation_id = o.occupation_id

LEFT JOIN Industry i
ON p.industry_id = i.industry_id

WHERE el.level_name IN ('Bachelor','Master','MPhil')
AND (o.occupation_name IS NULL
     OR i.industry_name IS NULL);

/* HOUSEHOLD BASED ANALYSIS 
Household_Analysis
Shows all married persons with their household size information.
Useful for studying family structure of married citizens.
*/
CREATE VIEW HOUSEhOLD_ANALYSIS AS
SELECT
    p.first_name,
    p.last_name,
    ms.status_name,
    h.household_size

FROM Person p

LEFT JOIN Marital_Status ms
ON p.marital_status_id = ms.marital_status_id

LEFT JOIN Employment_Status es
ON p.employment_status_id = es.employment_status_id

LEFT JOIN Household h
ON p.household_id = h.household_id

WHERE ms.status_name = 'Married';
SELECT* FROM HOUSEHOLD_ANALYSIS;

/* Migration and Educated Unemployment Assessment Report
Migration_Educated_Unemployment
Shows educated people who migrated but are still unemployed.
Helps government understand brain drain and unemployment after migration.
 */
CREATE VIEW MIGRATIONEDUCATED_UNEMPLOYMENT AS
SELECT
    p.first_name,
    p.last_name,
    mh.migration_reason,
    el.level_name,
    es.status_name

FROM Person p

LEFT JOIN Migration_History mh
ON p.person_id = mh.person_id

LEFT JOIN Education_Level el
ON p.education_level_id = el.education_level_id

LEFT JOIN Employment_Status es
ON p.employment_status_id = es.employment_status_id

WHERE mh.person_id IS NOT NULL
AND el.level_name IN ('Bachelor','Master','MPhil')
AND es.status_name = 'Unemployed';

SELECT* FROM MIGRATIONEDUCATED_UNEMPLOYMENT;

/* ................RIGHT JOIN.................
Urban_Block_Staff_Assignment
Shows urban census blocks with more than 300 households and their assigned enumerators or supervisors.
Blocks without staff also appear — helps find uncovered areas.
*/
CREATE VIEW URBAN_BLOCK_STAFF_ASSIGNMENT AS
SELECT
    cs.first_name           AS staff_first_name,
    cs.last_name            AS staff_last_name,
    cs.staff_role,
    cs.contact_number,
    cb.census_block_code,
    cb.estimated_household_count,
    cb.area_sq_km,
    uc.union_council_name,
    t.tehsil_name,
    d.district_name

FROM Census_Staff cs

RIGHT JOIN Census_Block cb
    ON cs.assigned_census_block_id = cb.census_block_id

RIGHT JOIN Union_Council uc
    ON cb.union_council_id = uc.union_council_id

RIGHT JOIN Tehsil t
    ON uc.tehsil_id = t.tehsil_id

RIGHT JOIN District d
    ON t.district_id = d.district_id

WHERE cb.is_urban = TRUE
AND cb.estimated_household_count > 300
AND cs.staff_role IN ('Enumerator', 'Supervisor')

ORDER BY cb.estimated_household_count DESC;

-- View Query:
SELECT * FROM URBAN_BLOCK_STAFF_ASSIGNMENT;


/* Employed_Religion_Education_Profile
Shows highly educated and full-time employed persons with their religion and mother tongue.
Only persons earning more than 30,000 with Bachelors or higher degree are shown. */

CREATE VIEW EMPLOYED_RELIGION_EDUCATION_PROFILE AS
SELECT
    p.first_name,
    p.last_name,
    r.religion_name,
    mt.tongue_name          AS mother_tongue,
    el.level_name           AS education_level,
    es.status_name          AS employment_status,
    p.monthly_income,
    TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) AS age

FROM Religion r

RIGHT JOIN Person p
    ON r.religion_id = p.religion_id

RIGHT JOIN Household h
    ON p.household_id = h.household_id

RIGHT JOIN Mother_Tongue mt
    ON p.mother_tongue_id = mt.mother_tongue_id

RIGHT JOIN Education_Level el
    ON p.education_level_id = el.education_level_id

LEFT JOIN Employment_Status es
    ON p.employment_status_id = es.employment_status_id

WHERE el.level_name IN ('Bachelors', 'Masters', 'Doctorate')
AND es.status_name = 'Employed Full-Time'
AND p.monthly_income > 30000

ORDER BY p.monthly_income DESC;

-- View Query:
SELECT * FROM EMPLOYED_RELIGION_EDUCATION_PROFILE;

/* Disabled_Unemployed_Location_Report
Shows disabled and unemployed persons with their location from district to province level.
Only persons with no income are shown — useful for welfare targeting. */
CREATE VIEW DISABLEDUNEMPLOYED_LOCATION_REPORT AS
SELECT
    dt.disability_name,
    p.first_name,
    p.last_name,
    p.date_of_birth,
    bs.sex_name             AS gender,
    es.status_name          AS employment_status,
    el.level_name           AS education_level,
    p.monthly_income,
    d.district_name,
    pr.province_name

FROM Disability_Type dt

RIGHT JOIN Person_Disability pd
    ON dt.disability_type_id = pd.disability_type_id

RIGHT JOIN Person p
    ON pd.person_id = p.person_id

RIGHT JOIN Biological_Sex bs
    ON p.sex_id = bs.sex_id

RIGHT JOIN Employment_Status es
    ON p.employment_status_id = es.employment_status_id

RIGHT JOIN Education_Level el
    ON p.education_level_id = el.education_level_id

RIGHT JOIN Household h
    ON p.household_id = h.household_id

RIGHT JOIN Structure s
    ON h.structure_id = s.structure_id

RIGHT JOIN Census_Block cb
    ON s.census_block_id = cb.census_block_id

RIGHT JOIN Union_Council uc
    ON cb.union_council_id = uc.union_council_id

RIGHT JOIN Tehsil t
    ON uc.tehsil_id = t.tehsil_id

RIGHT JOIN District d
    ON t.district_id = d.district_id

RIGHT JOIN Division dv
    ON d.division_id = dv.division_id

RIGHT JOIN Province pr
    ON dv.province_id = pr.province_id

WHERE es.status_name IN (
    'Unemployed - Seeking Work',
    'Unemployed - Not Seeking Work',
    'Disabled - Unable to Work'
)
AND p.monthly_income IS NULL

ORDER BY dt.disability_name,
         pr.province_name;

-- View Query:
SELECT * FROM DISABLEDUNEMPLOYED_LOCATION_REPORT;

/*  Migrant_Employment_Housing_Report
Shows persons who migrated between 2015 and 2023 and are currently employed.
Also shows their housing condition, water source and lighting source. */
CREATE VIEW MIGRANT_EMPLOYMENT_HOUSING_REPORT AS
SELECT
    p.first_name,
    p.last_name,
    mh.migration_reason,
    mh.year_of_migration,
    d.district_name         AS migrated_from_district,
    el.level_name           AS education_level,
    es.status_name          AS employment_status,
    o.occupation_name,
    p.monthly_income,
    rst.status_name         AS residential_status,
    h.number_of_rooms,
    h.household_size,
    ws.source_name          AS water_source,
    ls.source_name          AS lighting_source

FROM District d

RIGHT JOIN Migration_History mh
    ON d.district_id = mh.previous_district_id

RIGHT JOIN Person p
    ON mh.person_id = p.person_id

RIGHT JOIN Education_Level el
    ON p.education_level_id = el.education_level_id

RIGHT JOIN Employment_Status es
    ON p.employment_status_id = es.employment_status_id

RIGHT JOIN Occupation o
    ON p.occupation_id = o.occupation_id

RIGHT JOIN Household h
    ON p.household_id = h.household_id

RIGHT JOIN Residential_Status_Type rst
    ON h.residential_status_type_id = rst.residential_status_type_id

RIGHT JOIN Structure s
    ON h.structure_id = s.structure_id

RIGHT JOIN Water_Source ws
    ON s.water_source_id = ws.water_source_id

RIGHT JOIN Lighting_Source ls
    ON s.lighting_source_id = ls.lighting_source_id

WHERE mh.year_of_migration BETWEEN 2015 AND 2023
AND es.status_name IN (
    'Employed Full-Time',
    'Employed Part-Time',
    'Self-Employed'
)
AND h.household_size >= 3

ORDER BY mh.year_of_migration DESC,
         p.monthly_income DESC;

-- View Query:
SELECT * FROM MIGRANT_EMPLOYMENT_HOUSING_REPORT;



/* ..................FULL OUTER JOIN..............

Full_Person_Disability_Report
Shows employed persons with Bachelors or Masters degree along with their disability status.
Both disabled and non-disabled employed persons appear in this report.

*/

CREATE VIEW FULL_PERSON_DISABILITY_REPORT AS

SELECT
    p.first_name,
    p.last_name,
    p.date_of_birth,
    bs.sex_name          AS gender,
    dt.disability_name,
    el.level_name        AS education_level,
    es.status_name       AS employment_status

FROM Person p

LEFT JOIN Person_Disability pd
    ON p.person_id = pd.person_id

LEFT JOIN Disability_Type dt
    ON pd.disability_type_id = dt.disability_type_id

LEFT JOIN Biological_Sex bs
    ON p.sex_id = bs.sex_id

LEFT JOIN Education_Level el
    ON p.education_level_id = el.education_level_id

LEFT JOIN Employment_Status es
    ON p.employment_status_id = es.employment_status_id

WHERE es.status_name = 'Employed Full-Time'
AND el.level_name IN ('Bachelors', 'Masters')

UNION

SELECT
    p.first_name,
    p.last_name,
    p.date_of_birth,
    bs.sex_name          AS gender,
    dt.disability_name,
    el.level_name        AS education_level,
    es.status_name       AS employment_status

FROM Person p

RIGHT JOIN Person_Disability pd
    ON p.person_id = pd.person_id

RIGHT JOIN Disability_Type dt
    ON pd.disability_type_id = dt.disability_type_id

RIGHT JOIN Biological_Sex bs
    ON p.sex_id = bs.sex_id

RIGHT JOIN Education_Level el
    ON p.education_level_id = el.education_level_id

RIGHT JOIN Employment_Status es
    ON p.employment_status_id = es.employment_status_id

WHERE es.status_name = 'Employed Full-Time'
AND el.level_name IN ('Bachelors', 'Masters')

ORDER BY disability_name, last_name;

-- View Query:
SELECT * FROM FULL_PERSON_DISABILITY_REPORT;



/* Full_Household_Structure_Report
Shows all households with their structure type, water source and residential ownership status.
Both owned and rented households with more than 2 members are included.   */
CREATE VIEW FULL_HOUSEHOLD_STRUCTURE_REPORT AS

SELECT
    h.household_id,
    h.household_size,
    h.number_of_rooms,
    rst.status_name      AS residential_status,
    s.structure_address_no,
    st.type_name         AS structure_type,
    ws.source_name       AS water_source

FROM Household h

LEFT JOIN Structure s
    ON h.structure_id = s.structure_id

LEFT JOIN Residential_Status_Type rst
    ON h.residential_status_type_id = rst.residential_status_type_id

LEFT JOIN Structure_Type st
    ON s.structure_type_id = st.structure_type_id

LEFT JOIN Water_Source ws
    ON s.water_source_id = ws.water_source_id

WHERE h.household_size > 2
AND rst.status_name IN ('Owned', 'Rented')

UNION

SELECT
    h.household_id,
    h.household_size,
    h.number_of_rooms,
    rst.status_name      AS residential_status,
    s.structure_address_no,
    st.type_name         AS structure_type,
    ws.source_name       AS water_source

FROM Household h

RIGHT JOIN Structure s
    ON h.structure_id = s.structure_id

RIGHT JOIN Residential_Status_Type rst
    ON h.residential_status_type_id = rst.residential_status_type_id

RIGHT JOIN Structure_Type st
    ON s.structure_type_id = st.structure_type_id

RIGHT JOIN Water_Source ws
    ON s.water_source_id = ws.water_source_id

WHERE h.household_size > 2
AND rst.status_name IN ('Owned', 'Rented')

ORDER BY household_size DESC;

-- View Query:
SELECT * FROM FULL_HOUSEHOLD_STRUCTURE_REPORT;



/*   Full_Block_Union_Council_Report
Shows all urban census blocks with more than 200 households linked to their union council and tehsil.
Blocks with or without full union council data both appear. */
CREATE VIEW FULL_BLOCK_UNION_COUNCIL_REPORT AS

SELECT
    cb.census_block_code,
    cb.estimated_household_count,
    cb.is_urban,
    cb.area_sq_km,
    uc.union_council_name,
    ucc.classification_name,
    t.tehsil_name

FROM Census_Block cb

LEFT JOIN Union_Council uc
    ON cb.union_council_id = uc.union_council_id

LEFT JOIN Union_Council_Classification ucc
    ON uc.union_council_classification_id = ucc.union_council_classification_id

LEFT JOIN Tehsil t
    ON uc.tehsil_id = t.tehsil_id

WHERE cb.estimated_household_count > 200
AND cb.is_urban = TRUE

UNION

SELECT
    cb.census_block_code,
    cb.estimated_household_count,
    cb.is_urban,
    cb.area_sq_km,
    uc.union_council_name,
    ucc.classification_name,
    t.tehsil_name

FROM Census_Block cb

RIGHT JOIN Union_Council uc
    ON cb.union_council_id = uc.union_council_id

RIGHT JOIN Union_Council_Classification ucc
    ON uc.union_council_classification_id = ucc.union_council_classification_id

RIGHT JOIN Tehsil t
    ON uc.tehsil_id = t.tehsil_id

WHERE cb.estimated_household_count > 200
AND cb.is_urban = TRUE

ORDER BY estimated_household_count DESC;

-- View Query:
SELECT * FROM FULL_BLOCK_UNION_COUNCIL_REPORT;

/* Full_Commercial_Province_Report
Shows all licensed commercial businesses with more than 5 employees from district to province level.
Both matched and unmatched commercial records appear to show complete business picture.
 */
CREATE VIEW FULL_COMMERCIAL_PROVINCE_REPORT AS

SELECT
    sc.business_name,
    sc.estimated_active_employees,
    sc.has_active_license,
    cst.commercial_type_name,
    s.structure_address_no,
    d.district_name,
    pr.province_name

FROM Structure_Commercial sc

LEFT JOIN Commercial_Sector_Type cst
    ON sc.commercial_type_id = cst.commercial_type_id

LEFT JOIN Structure s
    ON sc.structure_id = s.structure_id

LEFT JOIN Census_Block cb
    ON s.census_block_id = cb.census_block_id

LEFT JOIN Union_Council uc
    ON cb.union_council_id = uc.union_council_id

LEFT JOIN Tehsil t
    ON uc.tehsil_id = t.tehsil_id

LEFT JOIN District d
    ON t.district_id = d.district_id

LEFT JOIN Division dv
    ON d.division_id = dv.division_id

LEFT JOIN Province pr
    ON dv.province_id = pr.province_id

WHERE sc.has_active_license = TRUE
AND sc.estimated_active_employees > 5

UNION

SELECT
    sc.business_name,
    sc.estimated_active_employees,
    sc.has_active_license,
    cst.commercial_type_name,
    s.structure_address_no,
    d.district_name,
    pr.province_name

FROM Structure_Commercial sc

RIGHT JOIN Commercial_Sector_Type cst
    ON sc.commercial_type_id = cst.commercial_type_id

RIGHT JOIN Structure s
    ON sc.structure_id = s.structure_id

RIGHT JOIN Census_Block cb
    ON s.census_block_id = cb.census_block_id

RIGHT JOIN Union_Council uc
    ON cb.union_council_id = uc.union_council_id

RIGHT JOIN Tehsil t
    ON uc.tehsil_id = t.tehsil_id

RIGHT JOIN District d
    ON t.district_id = d.district_id

RIGHT JOIN Division dv
    ON d.division_id = dv.division_id

RIGHT JOIN Province pr
    ON dv.province_id = pr.province_id

WHERE sc.has_active_license = TRUE
AND sc.estimated_active_employees > 5

ORDER BY estimated_active_employees DESC;

-- View Query:
SELECT * FROM FULL_COMMERCIAL_PROVINCE_REPORT;



/* .....................NATURAL JOIN.....................




Natural_Person_Marital_Report
Shows all married persons with their date of birth and monthly income above 20,000.
Join happens automatically on matching column name marital_status_id.*/

CREATE VIEW NATURAL_PERSON_MARITAL_REPORT AS

SELECT
    p.first_name,
    p.last_name,
    p.date_of_birth,
    p.monthly_income,
    ms.status_name

FROM Marital_Status ms

NATURAL JOIN (
    SELECT
        marital_status_id,
        first_name,
        last_name,
        date_of_birth,
        monthly_income
    FROM Person
) p

WHERE ms.status_name = 'Married'
AND p.monthly_income > 20000

ORDER BY p.monthly_income DESC;

-- View Query:
SELECT * FROM NATURAL_PERSON_MARITAL_REPORT;

/*  Natural_Person_Employment_Report
Shows full-time employed or self-employed persons earning more than 30,000.
Join automatically matches on employment_status_id column between both tables. */
CREATE VIEW NATURAL_PERSON_EMPLOYMENT_REPORT AS

SELECT
    p.first_name,
    p.last_name,
    p.monthly_income,
    p.date_of_birth,
    es.status_name

FROM Employment_Status es

NATURAL JOIN (
    SELECT
        employment_status_id,
        first_name,
        last_name,
        monthly_income,
        date_of_birth
    FROM Person
) p

WHERE es.status_name IN (
    'Employed Full-Time',
    'Self-Employed'
)
AND p.monthly_income > 30000

ORDER BY p.monthly_income DESC;

-- View Query:
SELECT * FROM NATURAL_PERSON_EMPLOYMENT_REPORT;


/* Natural_Person_Education_Report
Shows persons with Bachelors, Masters or Doctorate degree earning more than 25,000.
Join automatically connects person to education level using education_level_id column. */
CREATE VIEW NATURAL_PERSON_EDUCATION_REPORT AS

SELECT
    p.first_name,
    p.last_name,
    p.monthly_income,
    p.date_of_birth,
    el.level_name

FROM Education_Level el

NATURAL JOIN (
    SELECT
        education_level_id,
        first_name,
        last_name,
        monthly_income,
        date_of_birth
    FROM Person
) p

WHERE el.level_name IN (
    'Bachelors',
    'Masters',
    'Doctorate'
)
AND p.monthly_income > 25000

ORDER BY el.level_name, p.monthly_income DESC;

-- View Query:
SELECT * FROM NATURAL_PERSON_EDUCATION_REPORT;





