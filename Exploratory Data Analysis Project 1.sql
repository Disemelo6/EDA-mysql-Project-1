-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging2;

-- 1. Maximum employees laid off and percentage laid off in one go

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- 2. Finding companies that had 100% of their employees laid off

SELECT company,total_laid_off,percentage_laid_off
FROM layoffs_staging2
WHERE percentage_laid_off = 1
AND total_laid_off IS NOT NULL;

-- 3. Finding the total workforce, workforce not laid off and the percentage not laid off

SELECT *
FROM layoffs_staging2;

SELECT company,total_laid_off,percentage_laid_off
FROM layoffs_staging2
WHERE percentage_laid_off != 1
AND total_laid_off IS NOT NULL;

SELECT company,total_laid_off,percentage_laid_off
FROM layoffs_staging2
WHERE percentage_laid_off = 1
AND total_laid_off IS NOT NULL;

SELECT company, total_laid_off, percentage_laid_off, ROUND (total_laid_off * 1 / percentage_laid_off, 2) AS total_workforce
FROM layoffs_staging2
WHERE percentage_laid_off != 1
AND total_laid_off IS NOT NULL
ORDER BY total_laid_off DESC;

WITH workforce_total AS 
(
SELECT company, total_laid_off, percentage_laid_off, ROUND (total_laid_off * 1 / percentage_laid_off, 2) AS total_workforce
FROM layoffs_staging2
WHERE percentage_laid_off != 1
AND total_laid_off IS NOT NULL
ORDER BY total_laid_off DESC
),
laid_off_percentage AS 
( SELECT company, total_laid_off,Percentage_laid_off,total_workforce, total_workforce - total_laid_off AS total_not_laid_off
FROM workforce_total
)

SELECT company,total_laid_off,percentage_laid_off,total_workforce,total_not_laid_off,ROUND (total_not_laid_off * 1.0 / total_workforce, 2) AS percentage_not_laid_off
FROM laid_off_percentage;