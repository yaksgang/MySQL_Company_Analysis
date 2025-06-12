-- Data Cleaning

Select *
from layoffs;

-- 1 Remove Duplicates
-- 2 Standerdize the data
-- 3 Null and blank values
-- 4 Remove any columns that are uncessary

create table layoffs_staging
like layoffs;

insert layoffs_staging
select *
from layoffs;

-- Duplicate Removal
select *,
row_number() over (
partition by company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;

With duplicate_cte as
(
	select *,
	row_number() over (
	partition by company, location, `source`, stage, funds_raised, country, date_added, industry, total_laid_off, percentage_laid_off, `date`) as row_num
	from layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

-- Always verify using a few examples that values are actually duplicates
select *
from layoffs_staging
where company = '23andMe';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `total_laid_off` text,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `source` text,
  `stage` text,
  `funds_raised` text,
  `country` text,
  `date_added` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from layoffs_staging2
where row_num > 1;

insert into layoffs_staging2
	select *,
	row_number() over (
	partition by company, location, `source`, stage, funds_raised, country, date_added, industry, total_laid_off, percentage_laid_off, `date`) as row_num
	from layoffs_staging;

delete 
from layoffs_staging2
where row_num > 1;

select *
from layoffs_staging2;

-- Standerdize the data

Select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

-- Standerdize name difference in spelling
/* select distinct industry
from layoffs_staging2;

Select *
from layoff_stagings2
where industry like 'Crypto%';

Update layoffs_stagings2
set industry = 'Crypto'
where industry like 'Crypto%'; 

select distinct country, trim(trailing '.' from country))
from layoffs_staging2
where country like 'United-States%'
order by 1

update layoffs_staging2
set country = trim(trailing '.' from country))
where country like 'United States%';*/

select distinct location
from layoffs_staging2
where location like '%eldorf%';

update layoffs_staging2
set location = 'Dusseldorf,Non-U.S.'
where location like '%eldorf%';

-- Change data type from text to date series
Select `date`,
str_to_date(`date`, '%m/%d/%Y') as updated_date
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date;

-- Null and Blank Values 
update layoffs_staging2
set industry = 'Software Development'
where company = 'Appsmith';

select company, industry
from layoffs_staging2
order by 1;

select distinct industry
from layoffs_staging2;

-- Data set different from example
/* 
update layoffs_staging2
set industry = null
where industry = '';

Select *
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
    and t1.location = t2.location
where  t1.industry = '';

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null 
*/

select *
from layoffs_staging2
where total_laid_off = '' 
and percentage_laid_off = '';

-- Optional

Delete
from layoffs_staging2
where total_laid_off = '' 
and percentage_laid_off = '';

alter table layoffs_staging2
drop column row_num;

select *
from layoffs_staging2;

