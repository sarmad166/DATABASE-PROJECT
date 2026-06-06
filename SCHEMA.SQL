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