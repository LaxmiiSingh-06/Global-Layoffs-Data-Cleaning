-- Data Cleaning

SELECT *
FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or blank values
-- 3. Remove any column

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_staging;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,
industry,total_laid_off,percentage_laid_off, 'date', stage, country, funds_raised_millions ) AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(

PARTITION BY  company,location,
industry,total_laid_off,percentage_laid_off, 'date', stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM layoffs_staging
WHERE company='casper';

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY  company,location,
industry,total_laid_off,percentage_laid_off, 'date', stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE   
FROM duplicate_cte
WHERE row_num > 1;


-- CREATING NEW TABLE FOR DATA CLEANING
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

 INSERT INTO layoffs_staging2
 SELECT *,
ROW_NUMBER() OVER(
PARTITION BY  company,location,
industry,total_laid_off,percentage_laid_off, 'date', stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging;

SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;


-- DISPLAYING THE TABLES
SELECT *
FROM layoffs_staging2;

-- Standardize the Data
-- REMOVING ANY WHITE SPACE
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company=TRIM(company);

SELECT DISTINCT(industry)
FROM layoffs_staging2
ORDER BY 1;


-- UPDATING THE SAME INDUSTRY WITH DIFFERENT BUT SIMILAR NAMES
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'crypto%';

UPDATE layoffs_staging2
SET industry='Crypto'
WHERE industry LIKE 'crypto%';

SELECT DISTINCT location
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States%'
ORDER BY 1;

-- LOOKING FOR '.' FROM COUNTRY COLUMN
SELECT DISTINCT country,TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1; 


-- REMOVING '.' FROM COUNTRY COLUMN
UPDATE layoffs_staging2
SET country= TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


-- FORMAT OF DATE
SELECT `date`,
STR_TO_DATE(`date`,'%m/%d/%Y')
FROM layoffs_staging2;

-- UPDATE DATE FROM TEXT TYPE
UPDATE layoffs_staging2
SET date=STR_TO_DATE(`date`,'%m/%d/%Y');


-- CHANGING THE DATE FROM TEXT FORMAT
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- HANDLING NULL VALUES FOR INDUSTRY FIELD
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


UPDATE layoffs_staging2
SET industry = NULL
WHERE industry ='';


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry ='';

SELECT *
FROM layoffs_staging2
WHERE company='Airbnb';

-- UPDATING THE BLANKS OR NULL WITH PRE-EXISTING VALUES OF THE SAME 
SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company=t2.company
    AND t1.location=t2.location
WHERE (t1.industry IS NULL OR t1.industry='')
AND t2.industry IS NOT NULL;

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company=t2.company
    AND t1.location=t2.location
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company=t2.company
SET t1.industry=t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;


-- IF ANY MISTAKES MADE WHILE PERFORMING CHANGES IN INDUSTRY COLUMN
-- UPDATE layoffs_staging2 t2
-- JOIN layoffs t1
--   ON t2.company = t1.company
--   AND t2.location = t1.location
--   AND t2.total_laid_off = t1.total_laid_off
--   AND t2.percentage_laid_off = t1.percentage_laid_off
-- SET t2.industry = t1.industry;


-- HANDLING NULL VALUES OF LAID OFF
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- REMOVING THR ROW NUMBERR COLUMN AS IT HAS NO USE NOW
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


-- RENAMING THE TABLE
RENAME TABLE layoffs_staging2 TO layoffs_cleaned;





  
