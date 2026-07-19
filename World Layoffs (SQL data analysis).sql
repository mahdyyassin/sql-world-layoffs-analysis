#Exploring data
select * from layoffs_staging2;

#Total payoffs per company
select company, sum(total_laid_off) sum_l 
from layoffs_staging2
group by company
order by sum_l desc
;

#Total payoffs per industry
select industry, sum(total_laid_off) sum_l 
from layoffs_staging2
group by industry
order by sum_l desc
;

#Total payoffs per country
select country, sum(total_laid_off) sum_l 
from layoffs_staging2
group by country
order by sum_l desc
;

#Total payoffs per year
select year(`date`) yearr, sum(total_laid_off) sum_l 
from layoffs_staging2
group by yearr
order by sum_l desc
;

#Data range
select min(`date`), max(`date`)
from layoffs_staging2;

#Payoffs Rolling total by month
with rolling_Total as
(
select substring(`date`,1,7) m, sum(total_laid_off) sum_1 
from layoffs_staging2
where substring(`date`,1,7) is not null
group by m
order by 1
)
select m, sum_1, sum(sum_1) over(order by m) rolling_total
from rolling_Total
;

#Top 5 companies according to total payoffs for each year
with company_year(company, yearr, sum1) as
(
select company, year(`date`) yearr, sum(total_laid_off) sum_l 
from layoffs_staging2
group by company, yearr
order by sum_l desc
), rankk as
(
select *, dense_rank() over(partition by yearr order by sum1 desc) ranking
from company_year
where yearr is not null
)
select *
from rankk
where ranking < 6
;