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