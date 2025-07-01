# Q & A

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

---

