-- Exploratory Data Analysis

select *
from layoffs_staging2;

update layoffs_staging2
set total_laid_off = null 
where total_laid_off = '';

update layoffs_staging2
set percentage_laid_off = null 
where percentage_laid_off = '';

select *
from layoffs_staging2
where percentage_laid_off = 100
order by funds_raised desc;

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select min(`date`),max(`date`)
from layoffs_staging2;

select Year(`date`), sum(total_laid_off)
from layoffs_staging2
group by Year(`date`)
order by 1 desc;

select substring(`date`,1,7)  as `Month`, sum(total_laid_off)
from layoffs_staging2
group by `month`
order by 1 asc;

-- Rolling Total
with rolling_total as
(
select substring(`date`,1,7)  as `Month`, sum(total_laid_off) as total_off
from layoffs_staging2
group by `month`
order by 1 asc
)
select `month`, total_off,
sum(total_off) over(order by `month`) 
from rolling_total;

-- Rank
With Company_Year (Company, Years, Total_Laid_Off) as
(
Select company, 
		year(`date`), 
        sum(total_laid_off)
        from layoffs_staging2
group by company, year(`date`)
order by company asc
), Company_Year_Rank as
(
Select *,
	dense_rank() over(partition by Years order by Total_Laid_Off desc) as dense_rank_company
from Company_Year
)
Select * 
from Company_Year_Rank
where dense_rank_company <= 5;