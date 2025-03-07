SELECT * 
FROM Project3.dbo.cleanedupdata_output


--How many states were represented in the race--

Select count(Distinct State) as distinct_count
from Project3.dbo.cleanedupdata_output

--What was the average time of Men vs Women--

select Gender, AVG(Total_minutes) as avg_time
from Project3.dbo.cleanedupdata_output
group by gender

--What were the ypungest and oldest ages in the race--

select Gender, Min(age) as youngest, Max(age) as oldest
from Project3.dbo.cleanedupdata_output
group by gender

--what was the average time for each age group--

with age_buckets as (
select total_minutes,
	case when age < 30 then 'age_20-29'
		 when age < 40 then 'age_30-39'
		 when age < 50 then 'age_40-49'
		 when age < 60 then 'age_50-59'
	else 'age_60+' end as age_group
From Project3.dbo.cleanedupdata_output
)

Select age_group, avg(total_minutes) avg_race_time
from age_buckets
group by age_group


--Top 3 males and females--

with gender_rank as (
select rank() over (partition by Gender order by total_minutes asc) as gender_rank,
fullname,
gender,
total_minutes
from Project3.dbo.cleanedupdata_output
)

Select *
from gender_rank
where gender_rank < 4
order by total_minutes