# Q & A

>Write a query to find companies (include company name) that have posted jobs offering health insurance, where these postings were made in the second quarter of 2023. Use date extraction to filter by quarter. 

```sql
SELECT
    job_postings_fact.job_title,
    companies.name name
FROM
    job_postings_fact
LEFT JOIN company_dim AS companies ON
    job_postings_fact.company_id = companies.company_id
WHERE
    job_postings_fact.job_title ILIKE '%health insurance%' -- ILIKE Case-insensitive and specific
    AND EXTRACT(QUARTER FROM job_postings_fact.job_posted_date) = 2 -- Filters for Q2
    AND EXTRACT(YEAR FROM job_postings_fact.job_posted_date) = 2023
/*	-- alternatively we can:
    job_postings_fact.job_title ILIKE '%Health Insurance%' AND
    job_postings_fact.job_posted_date BETWEEN '2023-04-01' AND '2023-07-01'
    -- sql implicitly sets timestamp like 2023-07-01 00:00:00 that's why 2023-06-30 won't work
*/
```



---

> Write a query to count the number of job postings for each month in 2023, adjusting the timezone to be in 'America/New_York' time zone before extracting (hint) the month.  Assume the job_posted_date is stored in UTC. Group by and order by the month.  

```sql
SELECT
    COUNT(job_id),
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month
FROM
    job_postings_fact
WHERE -- Note we also filter based on timezoned date - otherwise we may skip borderline jobs 
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY
    month
ORDER BY
    month
```



---

> Write a query to find the average salary both yearly ( sa lary_yea r_avg )and hourly ( ) for job postings that were posted after June I, 2023. Group the results by job schedule type.

```sql
SELECT
    job_schedule_type,
    AVG(salary_year_avg)::INTEGER as avg_yearly,
    AVG(salary_hour_avg)::INT as avg_hourly
FROM
    job_postings_fact
WHERE
    job_posted_date >= '2023-06-01'
GROUP BY
    job_schedule_type
ORDER BY
    avg_hourly DESC NULLS LAST;
```

---

## ![image-20250701221445688](C:\Users\Mido Hany\AppData\Roaming\Typora\typora-user-images\image-20250701221445688.png)

## A:

```sql
SELECT
	skills.skills AS skill,
    COUNT(job_skills.job_id) AS number_of_jobs,
    AVG(job_postings.salary_year_avg) AS avg_yr_salary
FROM
	skills_dim AS skills
LEFT JOIN skills_job_dim AS job_skills ON skills.skill_id = job_skills.skill_id
LEFT JOIN job_postings_fact AS job_postings ON job_skills.job_id = job_postings.job_id
GROUP BY
	skills.skills
ORDER BY
	avg_yr_salary DESC
```
