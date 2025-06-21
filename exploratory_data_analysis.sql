-- Exploring the data wihput any particular objetive in mind

SELECT *
FROM world_layoffs.layoffs_staging2;

-- Max amount and percentage of people laid of in a day
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM world_layoffs.layoffs_staging2;

-- Companies who laid off 100% of their workers

SELECT * 
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;


-- Date range

SELECT MIN(`date`), MAX(`date`)
FROM world_layoffs.layoffs_staging2;

-- Companies and industries with the most layoff

SELECT company, SUM(total_laid_off) AS sum_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY company 
ORDER BY sum_laid_off DESC;

SELECT industry, SUM(total_laid_off) AS sum_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY sum_laid_off DESC;