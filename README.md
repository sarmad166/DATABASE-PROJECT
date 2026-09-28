# Pakistan Census Database

A relational database project designed to collect, organize, manage, and analyze demographic, household, geographic, and census workforce data for Pakistan.

## 📌 Project Information

- **Project:** Pakistan Census Database
- **Course:** Introduction to Database
- **Type:** Semester Final Project
- **Session:** Spring 2026

### 👥 Group Members

| Member | Student ID |
|---|---|
| Azma | L1F24BSCS0674 |
| Sarmad | L1F24BSCS0716 |
| Sharjeel | L1F24BSCS0506 |
| Zakia | L1F24BSCS0587 |

---

## 📖 Project Overview

The **Pakistan Census Database** is a centralized relational database system for managing national census information.

The system is designed to organize data across multiple geographic levels, from provinces and divisions down to districts, tehsils, union councils, and census blocks. It also manages structures, households, citizens, demographic information, utilities, migration history, disabilities, and census field staff.

The database is intended to support reliable data retrieval and analysis for population reporting, literacy analysis, employment statistics, regional development, and resource planning.

---

## 🎯 Objectives

The main objectives of this project are:

1. Securely store and efficiently retrieve data across all geographic levels.
2. Maintain citizen information including CNIC, family relationships, education, employment, and income.
3. Generate population, literacy, and regional development statistics.
4. Perform complex SQL queries for demographic and employment analysis.
5. Maintain normalization and referential integrity to reduce redundancy and prevent inconsistent data.

---

## 🔍 Main Features

### 🌍 Geographic Management

The database maintains a hierarchical geographic structure:

```text
Province
   ↓
Division
   ↓
District
   ↓
Tehsil
   ↓
Union Council
   ↓
Census Block
```

### 🏠 Property & Household Management

The system stores:

- Structures and addresses
- GPS coordinates
- Structure types
- Water sources
- Lighting sources
- Cooking fuel
- Washroom status
- Kitchen status
- Residential units
- Household categories
- Residential status
- Number of rooms
- Household size

### 👤 Citizen Management

Citizen records include:

- Name
- CNIC
- Biological sex
- Date of birth
- Nationality
- Religion
- Mother tongue
- Marital status
- Family relationship
- Household head relationship
- Literacy status
- Education
- Employment
- Occupation
- Industry
- Monthly income

### 👷 Census Staff Management

The system manages census field staff and their organizational hierarchy using self-referencing relationships.

Staff information includes:

- Name
- Role
- Contact number
- Email
- Assigned census block
- Supervisor
- Employment date

### 🚚 Migration & Disability Tracking

The database also supports:

- Citizen migration history
- Previous districts
- Migration reasons
- Migration years
- Multiple disability records through a junction table

---

## 🗃️ Database Entities

The database contains lookup, geographic, operational, demographic, and relationship entities.

### Lookup / Reference Tables

- `Water_Source`
- `Lighting_Source`
- `Cooking_Fuel_Source`
- `Washroom_Status`
- `Kitchen_Status`
- `Biological_Sex`
- `Religion`
- `Mother_Tongue`
- `Education_Level`
- `Employment_Status`
- `Marital_Status`
- `Disability_Type`
- `Occupation`
- `Industry`
- `Relationship_Type`
- `Nationality`
- `Household_Category`
- `Residential_Status_Type`
- `Union_Council_Classification`
- `Structure_Type`
- `Commercial_Sector_Type`

### Geographic Tables

- `Province`
- `Division`
- `District`
- `Tehsil`
- `Union_Council`
- `Census_Block`

### Census & Operational Tables

- `Census_Cycle`
- `Census_Staff`
- `Structure`
- `Structure_Residential`
- `Structure_Commercial`
- `Structure_Institution`
- `Household`

### Citizen Tables

- `Person`
- `Person_Disability`
- `Migration_History`

---

## 🔗 Major Relationships

### Geographic Hierarchy

```text
Province 1 ─── M Division
Division 1 ─── M District
District 1 ─── M Tehsil
Tehsil 1 ─── M Union_Council
Union_Council 1 ─── M Census_Block
```

### Census Operations

```text
Census_Block 1 ─── M Structure
Structure 1 ─── M Household
Household 1 ─── M Person
```

### Structure Extensions

```text
Structure 1 ─── 1 Structure_Residential
Structure 1 ─── 1 Structure_Commercial
Structure 1 ─── 1 Structure_Institution
```

### Recursive Relationships

The project uses self-referencing relationships for:

- `Census_Staff.supervisor_id → Census_Staff.staff_id`
- `Person.head_person_id → Person.person_id`

These relationships allow the database to represent staff management hierarchies and household head relationships.

### Many-to-Many Relationships

`Person` and `Disability_Type` are connected through:

```text
Person
   ↕
Person_Disability
   ↕
Disability_Type
```

Migration history connects citizens with previous districts through `Migration_History`.

---

## 🧱 Relational Database Design

The database follows a normalized relational structure with foreign-key relationships between related tables.

The design targets **Third Normal Form (3NF)** to reduce redundant data and keep attributes dependent on their appropriate primary keys.

Lookup tables are used for repeated categories such as education, employment, water source, religion, and other demographic attributes instead of repeatedly storing the same descriptive text.

---

## 🔐 Referential Integrity

Foreign keys are used throughout the database to maintain valid relationships between tables.

Examples include:

```text
Division.province_id
District.division_id
Tehsil.district_id
Union_Council.tehsil_id
Census_Block.union_council_id
Structure.census_block_id
Household.structure_id
Person.household_id
```

This helps prevent orphaned records and keeps the geographic and operational hierarchy connected.

---

## 🔄 Cascading Operations

### ON DELETE CASCADE

`Migration_History` depends on the existence of a corresponding `Person`.

When a person's record is deleted, their related migration history can automatically be removed.

```text
Person
  ↓
Migration_History
```

### ON DELETE SET NULL

The `Census_Staff.supervisor_id` relationship uses `ON DELETE SET NULL`.

If a supervisor is removed, subordinate staff records remain in the database while their supervisor reference becomes `NULL`.

```text
Supervisor
    ↓
Field Enumerator
```

This preserves staff records while allowing the management relationship to be reassigned.

---

## 🧮 SQL Query Work

The project demonstrates different SQL query concepts, including:

### Joins

- `INNER JOIN`
- `LEFT JOIN`
- `RIGHT JOIN`
- `NATURAL JOIN`
- `SELF JOIN`

Examples of analysis include:

- Districts with the highest number of households
- Highly educated citizens with employment and income information
- Citizens with education, occupation, and nationality information
- Urban census blocks with high household counts
- Census staff management hierarchy
- Household head and family-member relationships

### Nested & Correlated Queries

The project includes queries for:

- Citizens living in households with more than four members
- Citizens earning more than at least one male
- Citizens earning more than all females
- Citizens with no migration history
- Citizens with migration records
- Citizens whose income falls below specified comparison groups

### Aggregate Queries

The database supports calculations such as:

- Total citizen population
- Total monthly income
- Average monthly income
- Minimum income
- Maximum income
- Population distribution by biological sex
- Population and average income by religion

### Set Operations

The project demonstrates:

- `UNION`
- `UNION ALL`
- `INTERSECT`
- `EXCEPT`

These queries are used to compare names between citizens and census staff.

### Views

The project includes logical views for presenting complex relational data in a simpler form, including:

- Citizen profiles
- Housing and living conditions
- Geographic population summaries

---

## ⚡ Optimization & Scalability

The project considers large-scale census data containing potentially millions of records.

Key strategies include:

### Normalization

Repeated information is separated into lookup tables to reduce duplication.

### Compact Data Types

Small categorical identifiers can use compact data types such as `TINYINT` where appropriate.

### Relational Views

Complex multi-table queries can be encapsulated in views to simplify repeated analysis.

### Referential Integrity

Foreign keys and cascading rules help maintain consistency as the database grows.

---

## ⚠️ Challenges Addressed

### 1. Handling Large Data

A national census can involve millions of households and citizens. The project addresses this through normalization, lookup tables, and storage optimization.

### 2. Maintaining Referential Integrity

The database contains a deep hierarchy:

```text
Province
 → Division
 → District
 → Tehsil
 → Union Council
 → Census Block
 → Structure
 → Household
 → Person
```

Foreign keys and cascading rules help maintain valid relationships throughout this hierarchy.

### 3. Complex Queries

The database requires multi-table joins, nested queries, aggregate operations, recursive relationships, and views.

The project addresses this by organizing the relational schema and using predefined views for repeated analytical operations.

---

## 📂 Project Scope

### Included

- Geographic hierarchy
- Census workforce management
- Structure and housing information
- Household information
- Citizen demographic records
- Migration history
- Disability records
- Relational constraints
- SQL analysis queries
- Database optimization concepts

### Not Included

- Web or mobile frontend applications
- Public-facing dashboards
- Real-time GPS tracking
- Biometric fingerprint or facial verification

---

## 🛠️ Technologies / Concepts

This project focuses on relational database concepts such as:

- SQL
- Relational Database Design
- ERD
- Relational Schema
- Primary Keys
- Foreign Keys
- Composite Keys
- Cardinality
- Participation Constraints
- Database Normalization
- Third Normal Form (3NF)
- Joins
- Nested Queries
- Correlated Queries
- Aggregate Functions
- Set Operations
- Views
- Cascading Operations
- Referential Integrity

---

## 📑 Project Documentation

The complete project documentation covers:

- Project title and overview
- Objectives and scope
- Entities and attributes
- Relationships and cardinalities
- ERD
- Relational schema
- SQL queries
- Query analysis
- Views
- Cascading operations
- Challenges and optimization strategies

---

## 🎥 Demonstration & Viva

The project also includes preparation for:

- Project execution demonstration
- Explanation of assigned roles
- SQL query demonstration
- Query output explanation
- Database concept viva preparation

---

## 📦 Final Submission

The final submission is intended to contain:

```text
├── SQL Code Files
├── Documentation
├── ERD
├── Relational Schema
├── Query Outputs
├── Screenshots
└── Screen Recording
```

---

## 📌 Conclusion

The **Pakistan Census Database** provides a structured relational model for managing geographic, household, demographic, infrastructure, migration, and census workforce information.

The project demonstrates how database normalization, relational constraints, SQL queries, views, recursive relationships, and cascading operations can be combined to build a scalable and logically connected census database system.

