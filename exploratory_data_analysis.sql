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

-- Most layoff by different metrics, percentage isn't useful without the total employees

SELECT company, SUM(total_laid_off) AS sum_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY company 
ORDER BY sum_laid_off DESC;

SELECT industry, SUM(total_laid_off) AS sum_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY sum_laid_off DESC;

SELECT country, SUM(total_laid_off) AS sum_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY sum_laid_off DESC;

SELECT YEAR(`date`) AS date_by_year, SUM(total_laid_off) AS sum_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY date_by_year
ORDER BY date_by_year DESC;

SELECT stage, SUM(total_laid_off) AS sum_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY sum_laid_off DESC;

-- layoff by month

SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY `month`;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) AS sum_laid_off
FROM world_layoffs.layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY `month`
)
SELECT `month`, sum_laid_off, 
SUM(sum_laid_off) OVER(ORDER BY `month`) AS rolling_total
FROM Rolling_Total;


-- Ranking companys by each year layoff

SELECT company, YEAR(`date`) AS date_by_year, SUM(total_laid_off) AS laid_by_year
FROM world_layoffs.layoffs_staging2
GROUP BY company, date_by_year
ORDER BY laid_by_year DESC;

WITH Company_Year (Company, Years, Total_Laid_Off) AS
(
SELECT company, YEAR(`date`) AS date_by_year, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY company, date_by_year
),
Company_Year_Ranks AS
(
SELECT *,
DENSE_RANK() OVER(PARTITION BY Years ORDER BY Total_Laid_Off DESC) AS ranking
FROM Company_Year
WHERE Years IS NOT NULL
)
SELECT *
FROM Company_Year_Ranks
WHERE ranking <= 5;

