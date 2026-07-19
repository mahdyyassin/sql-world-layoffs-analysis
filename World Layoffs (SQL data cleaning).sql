#Data cleaning

select * from layoffs;
# 1- remove duplicates
# 2- standardize data
# 3- deal with null values
# 4- delete unnecessary rows and columns
#--------------------------------------------------------------
# creating a staging table to have the main table as a backup
create table layoffs_staging
like layoffs;
insert layoffs_staging
select * from layoffs;
# 1- remove duplicates:

#identifying duplicates using a cte:
with duplicates_cte as 
(
select *,
row_number() over(
partition by company, location, industry, total_laid_off,
percentage_laid_off, date, stage, country, funds_raised_millions)
as row_num
from layoffs_staging
)
select * from duplicates_cte where row_num > 1;
#Creating a second staging table that contains the column of row numbers in order to be able to delete duplicates from it.
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
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
select * from layoffs_staging2;
insert layoffs_staging2
select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions) as row_num
from layoffs_staging;
delete from layoffs_staging2 where row_num > 1;
#check if "casper" company, one of the duplicates, still duplicated or not
select * from layoffs_staging2 where company = "casper";

# 2- standardize data

select * from layoffs_staging2;
#removing white space at the beginning and end of a company names
update layoffs_staging2
set company = trim(company);
select distinct industry from layoffs_staging2 order by 1;
#combining all crypto indusrties into one:
update layoffs_staging2
set industry = "crypto" where industry like "crypto%";
select distinct country from layoffs_staging2 order by 1;
#Combine "United states" and "United states." into one country:
update layoffs_staging2
set country = "United States" where country like "United States%";
#Changing the date column from text to date:
#Change to date format:
update layoffs_staging2
set `date` = str_to_date(`date`,'%m/%d/%Y');
select `date` from layoffs_staging2;
#Change data type:
alter table layoffs_staging2
modify column `date` date;

# 3- null values

select * from layoffs_staging2 where industry is null or industry = "";
#standardize the null values:
update layoffs_staging2
set industry = null where industry = "";
#populate if possipble:
update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company and t1.location = t2.location
set t1.industry = t2.industry where t1.industry is null and t2.industry is not null;

# 4- delete unnecessary rows and columns
#identifying unhelpful rows
select * from layoffs_staging2 where (total_laid_off is null or total_laid_off = '') and (percentage_laid_off is null or percentage_laid_off = '');
#delete them because we are interested in layoffs
delete from layoffs_staging2 where (total_laid_off is null or total_laid_off = '') and (percentage_laid_off is null or percentage_laid_off = '');
#delete unhelpful columns
alter table layoffs_staging2
drop column row_num;

#perfectly cleaned data:
select * from layoffs_staging2;