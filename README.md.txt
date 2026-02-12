# 🧹 Global Layoffs Data Cleaning Pipeline (MySQL + Excel)

## 📌 Project Overview

Designed and implemented a structured data cleaning pipeline for a global layoffs dataset using **MySQL Workbench** and **Microsoft Excel**.

The project transforms raw, inconsistent data into a clean, structured, and analysis-ready dataset using multi-stage staging tables and systematic SQL transformations.

---

## 🛠 Tech Stack

- MySQL Workbench  
- SQL  
- Microsoft Excel  

---

## 📂 Data Cleaning Architecture

A multi-layer staging approach was used to ensure safe and organized data manipulation:

Raw Table → layoffs  
↓  
Staging Layer 1 → layoffs_staging  
↓  
Staging Layer 2 → layoffs_staging2  
↓  
Final Cleaned Table → layoffs_cleaned  

This architecture ensured:

- Preservation of raw data  
- Controlled transformations  
- Structured cleaning workflow  
- Reduced risk of data corruption  

---

## 🔹 Key Data Cleaning Operations

### 1️⃣ Duplicate Removal

- Used `ROW_NUMBER()` with `PARTITION BY`
- Identified duplicate records
- Removed duplicates using CTE-based deletion logic

**Concepts Used:**

- Window Functions  
- CTE (`WITH`)  
- `DELETE`

---

### 2️⃣ Data Standardization

- Trimmed whitespace from company names  
- Standardized inconsistent industry labels  
- Cleaned country name formatting  
- Removed trailing punctuation  

**Functions Used:**

- `TRIM()`  
- `LIKE`  
- `UPDATE`  
- `TRIM(TRAILING ...)`

---

### 3️⃣ Date Transformation

- Converted date column from TEXT to DATE format  
- Used `STR_TO_DATE()`  
- Modified datatype using `ALTER TABLE`

---

### 4️⃣ NULL & Missing Value Handling

- Converted blank fields to NULL  
- Used self-join logic to populate missing industry values  
- Removed records where both `total_laid_off` and `percentage_laid_off` were NULL  

**Concepts Used:**

- `IS NULL`  
- `JOIN`  
- `UPDATE`  
- `DELETE`

---

### 5️⃣ Final Optimization

- Dropped temporary `row_num` column  
- Renamed final table to `layoffs_cleaned`  
- Exported cleaned dataset to Excel for validation and refinement  

---

## 📊 Final Output

- Cleaned MySQL Table: `layoffs_cleaned`  
- Excel File: `layoffs_cleaned.xlsx`  

The dataset is fully standardized and ready for:

- Exploratory Data Analysis  
- Dashboard Creation  
- Business Insights Generation  
- Predictive Modeling  

---

## 💡 SQL Skills Demonstrated

- Window Functions  
- Data Deduplication Techniques  
- Multi-stage Staging Strategy  
- Self Joins  
- Data Type Conversion  
- Data Standardization  
- Structured Data Cleaning Workflow  

---

## 🎯 Project Highlights

- Implemented production-style staging architecture  
- Applied advanced SQL window functions  
- Ensured data integrity throughout transformations  
- Integrated SQL and Excel for final validation  

---

## 📈 Why This Project Matters

Raw business data is often inconsistent and unreliable.  
This project demonstrates the ability to transform messy real-world datasets into structured, analysis-ready data using systematic SQL workflows.

---

## 👩‍💻 Author

**Laxmi Singh**  
Aspiring Data Analyst
LinkedIn: www.linkedin.com/in/laxmi-singh-2929b0329 
