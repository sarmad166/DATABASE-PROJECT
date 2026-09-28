Introduction to Database
Semester Final Project
Pakistan Census Database
Session: Spring 2026
Group Members
Azma
L1F24BSCS0674 
Sarmad
L1F24BSCS0716
Sharjeel
L1F24BSCS0506
Zakia
L1F24BSCS0587
1
1. Project Title
Pakistan Census Database
2. Project Overview
The Pakistan Census Database is a centralized system built to collect and 
manage national demographic, household, and geographic data. 
 Geographic Tracking: Organizes data down a strict chain from 
Provinces and Districts to local Census Blocks.
 Property & Housing Utilities: Tracks the quality of physical structures 
and access to water, power, and fuel. 
 Population Registries: Stores citizen profiles, including CNICs, family 
structures, literacy, and income. 
 Field Operations: Manages the census workforce by linking local 
enumerators to their regional supervisors. 
Ultimately, this system provides fast, reliable data slicing to help the 
government make accurate decisions regarding resource allocation and 
national planning. 
3. Objectives
Objective 1: Securely store and quickly find data across all geographic levels, 
from whole provinces down to local census blocks.
Objective 2: Track citizen details accurately, including CNICs, family 
structures, income, literacy, and housing conditions. 
Objective 3: Support generating clear population reports, literacy rate 
summaries, and regional development statistics for government planning.
Objective 4: Perform complex SQL queries to filter and analyze deep 
demographic trends and employment rates across different regions. 
Objective 5: Ensure database normalization and strict integrity constraints so 
that data remains clean, connected, and free of duplicates.
2
4. Scope
What is Included:
➢ Geographic & Personnel Infrastructure: Tracking administrative 
boundaries from provinces down to local census blocks, along with the 
operational field staff hierarchies. 
➢ Property & Household Metrics: Managing details of physical structures, 
domestic utility profiles, and family household groupings. 
➢ Citizen Demographics: Storing individual citizen records, including 
identity verification numbers (CNICs), family relations, educational 
status, and income levels. 
➢ Backend Database Optimization: Developing index structures, 
relational constraints, and core SQL queries for backend data analysis. 
What is Not Included:
➢ Front-End Applications: The project does not include building web or 
mobile applications for data entry or public dashboards.
➢ Live GPS Tracking: It maps static coordinates for structures but does 
not support real-time GPS tracking of field staff. 
➢ Biometric Verification System: The database processes text-based 
CNIC records but does not handle direct fingerprint or facial biometric 
verification processing.
3
5. Entities and Attributes
Entity Attributes
Water_Source water_source_id, source_name
Lighting_Source lighting_source_id, source_name
Cooking_Fuel_Source fuel_source_id, fuel_source_name
Washroom_Status washroom_status_id, status_name
Kitchen_Status kitchen_status_id, status_name
Biological_Sex sex_id, sex_name
Religion religion_id, religion_name
Mother_Tongue mother_tongue_id, tongue_name
Education_Level education_level_id, level_name
Employment_Status employment_status_id, status_name
Marital_Status marital_status_id, status_name
Disability_Type disability_type_id, disability_name
Occupation occupation_id, occupation_name
Industry industry_id, industry_name
Relationship_Type relationship_type_id, relationship_name
Entity Attributes
Census_Cycle census_id, census_year, census_title, 
start_date, end_date
Census_Staff staff_id, first_name, last_name, staff_role, 
contact_number, email, 
assigned_census_block_id, supervisor_id, 
employment_date
4
Entity Attributes
Nationality nationality_id, country_name, 
citizenship_status
Province province_id, province_name
Division division_id, division_name, 
province_id
District district_id, district_name, division_id
Tehsil tehsil_id, tehsil_name, district_id
Union_Council union_council_id, 
union_council_name, 
union_council_classification_id, 
tehsil_id
Census_Block census_block_id, census_block_code, 
estimated_household_count, 
is_urban, area_sq_km, 
union_council_id
Union_Council_Classification union_council_classification_id, 
classification_name, description
Entity Attributes
Person person_id, household_id, first_name, last_name, 
cnic_number, sex_id, date_of_birth, nationality_id, 
religion_id, mother_tongue_id, marital_status_id, 
relationship_type_id, head_person_id, is_literate, 
education_level_id, currently_attending_school, 
employment_status_id, occupation_id, industry_id, 
monthly_income, data_entry_operator_id, 
created_date
Person_Disability person_disability_id, person_id, disability_type_id
Migration_History migration_id, person_id, previous_district_id, 
migration_reason, year_of_migration
5
Entity
Structure_Type
Structure
Structure_Residential
Structure_Commercial
Structure_Institution
Attributes
structure_type_id, type_name, description
structure_id, structure_address_no, 
gps_latitude, gps_longitude, created_date, 
census_block_id, structure_type_id, 
water_source_id, lighting_source_id, 
fuel_source_id, washroom_status_id, 
kitchen_status_id
structure_id, total_residential_units
structure_id, commercial_type_id, 
business_name, 
estimated_active_employees, 
has_industrial_power_connection, 
has_active_license
structure_id, institution_type, 
organization_name, population_count, 
is_government
Commercial_Sector_Type commercial_type_id, 
commercial_type_name, description
Household
household_id, structure_id, census_id, 
household_sub_token, 
household_category_id, 
residential_status_type_id, owner_sex_id, 
number_of_rooms, household_size, 
data_entry_operator_id, created_date
Household_Category
household_category_id, category_name, 
description
Residential_Status_Type residential_status_type_id, status_name, 
description
6
6. Relationships
1. Geographic Hierarchy Chain
   Province to Division:
➢ Cardinality: 1:M (One Province can have Many Divisions).
➢ Participation: Total on Division side (A division cannot exist without 
being mapped to a province).
➢ Foreign Key: Division.province_id references Province.province_id.
   Division to District: 
➢ Cardinality: 1:M (One Division contains Many Districts).
➢ Participation: Total on District side (A district must belong to an 
administrative division).
➢ Foreign Key: District.division_id references Division.division_id.
   District to Tehsil: 
➢ Cardinality: 1:M (One District oversees Many Tehsils).
➢ Participation: Total on Tehsil side.
➢ Foreign Key: Tehsil.district_id references District.district_id.
   Tehsil to Union Council:
➢ Cardinality: 1:M (One Tehsil contains Many Union Councils).
➢ Participation: Total on Union Council side.
➢ Foreign Key: Union_Council.tehsil_id references Tehsil.tehsil_id.
7
  Union Council to Census Block: 
➢ Cardinality: 1:M (One Union Council contains Many localized Census 
Blocks).
➢ Participation: Total on Census Block side.
➢ Foreign Key: Census_Block.union_council_id references 
Union_Council.union_council_id.
2. Building Extension Layers 
   Structure to Structure_Residential: 
➢ Cardinality: 1:1 
➢ Participation: Partial on Structure side, Total on Residential side (The 
profile cannot exist without its base parent building asset).
➢ Foreign Key: Structure_Residential.structure_id references 
Structure.structure_id.
   Structure to Structure_Commercial:
➢ Cardinality: 1:1
➢ Participation: Partial on Structure side, Total on Commercial side.
➢ Foreign Key: Structure_Commercial.structure_id references 
Structure.structure_id.
   Structure to Structure_Institution: 
➢ Cardinality: 1:1.
➢ Participation: Partial on Structure side, Total on Institution side.
➢ Foreign Key: Structure_Institution.structure_id references 
Structure.structure_id.
8
3. Core Operational Census Operations
   Census_Block to Structure Location: 
➢ Cardinality: 1:M (One Census Block encompasses Many physical 
building structures).
➢ Participation: Total on Structure side (Every building must be 
cataloged inside an active census block boundary).
➢ Foreign Key: Structure.census_block_id references 
Census_Block.census_block_id.
   Structure Location to Household Unit: 
➢ Cardinality: 1:M (A physical building structure can host Multiple 
separate living households).
➢ Participation: Total on Household side (Every household must be 
linked to a physical address/structure asset).
➢ Foreign Key: Household.structure_id references Structure.structure_id.
   Household Unit to Person Profile: 
➢ Cardinality: 1:M (One Household unit contains Many citizens 
living/eating together).
➢ Participation: Total on Person side (An individual citizen must be 
accounted for within an registered household cohort).
➢ Foreign Key: Person.household_id references Household.household_id.
9
4. Recursive Self-Referencing Links
   Census_Staff to Census_Staff (Management Hierarchy): 
➢ Cardinality: 1:M (One Supervisor manages Many field staff 
members/enumerators).
➢ Participation: Total on enumerators side (Enumerators have 
supervisors).
➢ Foreign Key: Census_Staff.supervisor_id references 
Census_Staff.staff_id.
   Person to Person (Household Head Mapping): 
➢ Cardinality: 1:M (One household head is referenced by Many living 
family members in the house).
➢ Participation: Partial on both sides (A chosen household head points to 
null or themselves, while family members point to the head).
➢ Foreign Key: Person.head_person_id references Person.person_id.
5. Junction Tables 
   Person to Disability_Type via Person_Disability:
➢ Cardinality: M:N (One person can have multiple concurrent functional 
health challenges; one disability type applies to many citizens).
➢ Participation: Total on the junction table (Person_Disability), Partial on 
the individual tables (A citizen might have zero disabilities listed).
➢ Foreign Keys: Person_Disability.person_id references Person.person_id. 
Person_Disability.disability_type_id references 
Disability_Type.disability_type_id.
10
   Person to District via Migration_History:
➢ Cardinality: M:N (A citizen can move through multiple locations over 
time; a single district acts as a historical home for many citizens).
➢ Participation: Total on the history tracker (Migration_History), Partial 
on individual tables.
➢ Foreign Keys: Migration_History.person_id references Person.person_id. 
Migration_History.previous_district_id references District.district_id.
11
7. ERD (Entity Relationship Diagram)
12
8. Relational Schema*
• Water_Source (water_source_id, source_name)
• Lighting_Source (lighting_source_id, source_name)
• Cooking_Fuel_Source (fuel_source_id, fuel_source_name)
• Washroom_Status (washroom_status_id, status_name)
• Kitchen_Status (kitchen_status_id, status_name)
• Household_Category (household_category_id, category_name, 
description)
• Residential_Status_Type (residential_status_type_id, status_name, 
description)
• Biological_Sex (sex_id, sex_name)
• Religion (religion_id, religion_name)
• Mother_Tongue (mother_tongue_id, tongue_name)
• Education_Level (education_level_id, level_name)
• Employment_Status (employment_status_id, status_name)
• Marital_Status (marital_status_id, status_name)
• Disability_Type (disability_type_id, disability_name)
• Occupation (occupation_id, occupation_name)
• Industry (industry_id, industry_name)
• Relationship_Type (relationship_type_id, relationship_name)
• Nationality (nationality_id, country_name, citizenship_status)
• Union_Council_Classification (union_council_classification_id, 
classification_name, description)
13
• Census_Cycle (census_id, census_year, census_title, start_date, 
end_date)
• Structure_Type (structure_type_id, type_name, description)
• Commercial_Sector_Type (commercial_type_id, 
commercial_type_name, description)
• Province (province_id, province_name)
• Division (division_id, division_name, province_id references 
Province.province_id)
• District (district_id, district_name, division_id references 
Division.division_id)
• Tehsil (tehsil_id, tehsil_name, district_id references District.district_id)
• Union_Council (union_council_id, union_council_name, 
union_council_classification_id references 
Union_Council_Classification.union_council_classification_id, tehsil_id 
references Tehsil.tehsil_id)
• Census_Block (census_block_id, census_block_code, 
estimated_household_count, is_urban, area_sq_km, union_council_id 
references Union_Council.union_council_id)
• Census_Staff (staff_id, first_name, last_name, staff_role, 
contact_number, email, assigned_census_block_id references 
Census_Block.census_block_id, supervisor_id references 
Census_Staff.staff_id, employment_date)
• Structure (structure_id, structure_address_no, gps_latitude, 
gps_longitude, created_date, census_block_id references 
Census_Block.census_block_id, structure_type_id references 
Structure_Type.structure_type_id, water_source_id references 
Water_Source.water_source_id, lighting_source_id references 
Lighting_Source.lighting_source_id, fuel_source_id references 
Cooking_Fuel_Source.fuel_source_id, washroom_status_id references 
Washroom_Status.washroom_status_id, kitchen_status_id references 
Kitchen_Status.kitchen_status_id)
• Structure_Institution (structure_id references Structure.structure_id, 
institution_type, organization_name, population_count, is_government)
14
• Structure_Commercial (structure_id references Structure.structure_id, 
commercial_type_id references 
Commercial_Sector_Type.commercial_type_id, business_name, 
estimated_active_employees, has_industrial_power_connection, 
has_active_license)
• Structure_Residential (structure_id references Structure.structure_id, 
total_residential_units)
• Household (household_id, structure_id references Structure.structure_id, 
census_id references Census_Cycle.census_id, household_sub_token, 
household_category_id references 
Household_Category.household_category_id, residential_status_type_id 
references Residential_Status_Type.residential_status_type_id, 
owner_sex_id references Biological_Sex.sex_id, number_of_rooms, 
household_size, data_entry_operator_id references Census_Staff.staff_id, 
created_date)
• Person (person_id, household_id references Household.household_id, 
first_name, last_name, cnic_number, sex_id references 
Biological_Sex.sex_id, date_of_birth, nationality_id references 
Nationality.nationality_id, religion_id references Religion.religion_id, 
mother_tongue_id references Mother_Tongue.mother_tongue_id, 
marital_status_id references Marital_Status.marital_status_id, 
relationship_type_id references Relationship_Type.relationship_type_id, 
head_person_id references Person.person_id, is_literate, 
education_level_id references Education_Level.education_level_id, 
currently_attending_school, employment_status_id references 
Employment_Status.employment_status_id, occupation_id references 
Occupation.occupation_id, industry_id references Industry.industry_id, 
monthly_income, data_entry_operator_id references Census_Staff.staff_id, 
created_date)
• Person_Disability (person_disability_id, person_id references 
Person.person_id, disability_type_id references 
Disability_Type.disability_type_id)
• Migration_History (migration_id, person_id references Person.person_id, 
previous_district_id references District.district_id, migration_reason, 
year_of_migration)
15
*HOW TO READ
➢ Fields styled in bold represent the Primary Key (PK) of the 
table.
➢ Fields styled in italics represent a Foreign Key (FK) along with 
its explicit relational table direction map.
➢ Fields styled in bold italics represent a composite setup acting 
concurrently as both the table's Primary Key and its parent 
class Foreign Key identifier (1:1 structural extension).
16
9. SQL Queries and Data Retrieval
A. Joins
INNER JOIN
Shows top 5 districts in Pakistan with highest number of households.
Shows people who have Bachelors, Masters or PhD degree with their job and 
income.
17
LEFT JOIN
Shows all persons with their education, job, occupation and nationality — even 
if some info is missing.
Shows all married persons with their household size information.
18
RIGHT JOIN
Shows urban census blocks with more than 300 households and their assigned 
staff.
Shows educated and full-time employed persons with their religion and mother 
tongue profile.
19
NATURAL JOIN
Shows married individuals with an income above 20,000, joined implicitly on 
marital_status_id.
Shows individuals with premium employment statuses earning over 30,000, 
joined implicitly on employment_status_id.
20
SELF JOIN
Maps out the internal management hierarchy of the census field staff team.
Maps out biological family dynamics by identifying the official household head 
for each member.
21
B. Nested and Correlated Queries
Retrieves names of citizens who live in crowded families with more than 4 
members.
Finds citizens earning more than at least one individual of biological sex male.
22
Finds citizens earning more than all females
Lists all citizens who have never migrated or shifted their residential district.
23
Finds citizens earning less than or equal to the absolute lowest salary among 
males.
Finds citizens earning less than or equal to at least one individual of among 
males.
24
Identifies citizens who have an active internal migration or relocation history 
record.
25
Identifies stable citizens who have zero documented history of changing 
districts.
26
C. Aggregate Queries
Calculates the total headcount of recorded citizens in the census system 
database.
Computes the gross combined monthly income of the entire surveyed 
population.
Evaluates the national baseline average monthly income across all citizens.
27
Pinpoints the absolute lowest recorded individual monthly income entry.
Pinpoints the absolute highest recorded individual monthly income entry.
Groups and counts total population distribution cleanly across distinct 
biological sexes.
28
Filters demographic categories to show only biological sexes with more than 40 
individuals.
Breaks down population counts and average monthly income metrics 
categorized by religion.
29
Combines distinct first names from both citizens and field staff, removing 
duplicate values.
30
Combines all first names from citizens and field staff, preserving every 
duplicate entry.
31
Finds common names shared by both active citizens and field census staff.
32
Lists first names unique to citizens that do not exist among census staff.
33
D. Views
Shows a complete profile of each citizen, including their full name, age, 
education, job, and income in plain words instead of codes.
Shows the living conditions of each home, tracking things like room counts, 
clean water access, electricity, and whether it is in a city or a village.
34
Groups Pakistan's geographic areas together to show the total number of 
census blocks and households in every region at a glance.
35
10. Cascading Operations
• ON DELETE CASCADE
In our census architecture, the Migration_History table acts as a tracking log 
for changing districts. It is completely dependent on a person's profile existing 
in the Person table. If a citizen is legally removed from the census database 
(due to data entry errors or fraud cancellation), keeping their old migration 
history is meaningless and leaves orphaned logs.
By applying ON DELETE CASCADE, removing a record from the Person table 
automatically triggers a chain reaction that deletes all corresponding relocation 
entries from Migration_History.
• ON DELETE SET NULL
Our census operations utilize a supervisor network in the Census_Staff table. 
Field enumerators are monitored via a recursive self-referencing foreign key 
column called supervisor_id. If a supervisor resigns, retires, or is removed from 
the staff workforce database, we absolutely do not want to lose or delete the 
subordinate field enumerators they managed.
By using ON DELETE SET NULL, when a supervisor's record is removed, the 
field enumerators they were managing remain perfectly intact in the database; 
their supervisor_id simply switches to NULL (meaning they are temporarily 
unassigned until a new manager takes over).
36
11. Challenges and Risks
1. Handling Large Data Efficiently
 The Challenge: A national census involves capturing records for tens 
of millions of citizens and millions of households. Standard un
normalized or flat-file database architectures experience catastrophic 
performance degradation and massive disk space bloating when handling 
data at this scale.
 Our Strategy (Normalization & Storage Optimization):
➢ Elimination of Redundant Text: Instead of storing repetitive 
textual data (e.g., storing the string "Tap Water" or "Employed Full
Time" millions of times across individual household and person 
rows), these attributes were extracted into micro-lookup tables 
(Water_Source, Employment_Status, etc.).
➢ Strategic Use of Compact Data Types: By linking parent tracking 
records via TINYINT (1 byte per row, supporting up to 255 distinct 
lookup categories) instead of INT (4 bytes) or VARCHAR text 
strings, our schema dramatically compresses the overall database 
footprint. When scaled to 200 million citizen records, saving 3 
bytes per column across dozens of columns prevents gigabytes of 
unnecessary data footprint, ensuring data blocks fit efficiently into 
system cache memory during intense analytical processing.
➢ Achieving 3rd Normal Form (3NF): The database schema was 
systematically advanced to 3NF. Every non-prime attribute 
depends purely, directly, and non-transitively on the primary key 
anchor of its respective table, ensuring computational efficiency 
and keeping data storage structurally lean.
37
2. Ensuring Referential Integrity 
 The Challenge: In a highly relational database with deep 
organizational hierarchies (e.g., Province --> Division --> District --> 
Tehsil --> Union_Council --> Census_Block --> Structure --> Household --> Person), deleting or updating a higher-level record risks creating 
orphaned child data blocks and breaking internal consistency.
 Our Strategy:
➢ Implemented structural relational rules via declarative foreign 
keys.
➢ Applied ON DELETE CASCADE on strict target operational 
tracking tables (such as wiping out a citizen's internal logs in 
Migration_History automatically if their baseline Person profile is 
deleted).
➢ Applied ON DELETE SET NULL on organizational management 
linkages (such as self-referencing workforce hierarchies in 
Census_Staff), ensuring field enumerator operational performance 
data is preserved if a supervisor's account is removed.
3. Handling Complex Queries and Optimization
 The Challenge: As the volume of deep relational tables grows into 
millions of data points, executing multi-table statements utilizing 
numerous INNER JOIN, LEFT JOIN, or nested aggregate operations can 
lead to slow performance due to intensive nested loop evaluations or 
extensive full table scans.
 Our Strategy:
➢ Relational Views: Wrapped multi-tier joins inside predefined 
logical relational SQL views (Most_Populated_Cities, 
Highly_Educated_Persons, Citizen_Record). This abstracts 
structural execution complexities and helps the database engine 
optimize compilation paths.
38
18. Documentation (10 Marks)
Include a PDF or Word document containing:
• Project Title
• Group Members and Roles
• ERD and Relational Mapping
• SQL Queries with Outputs
• Screenshots
• Explanation of Logic
• Challenges Faced
• Conclusion
19. Video Demonstration & Viva (10 Marks)
Each student must:
• Record a short video showing the project execution
• Explain their assigned role and logic
• Demonstrate SQL queries and outputs
• Prepare for viva questions related to database concepts and implementation
20. Final Submission Must Include
• .sql code files
• Documentation (PDF or Word)
• Screen recording of execution
• ERD and Relational Schema
• Query outputs and screenshots
39
