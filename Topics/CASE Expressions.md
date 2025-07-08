CASE Expressions allow you to select, run aggregation functions on rows of your data based on columns values within.

**For example:**

If we want to list jobs with `Anywhere`in `job_location` as `Remote`, with `New York` As local, & else as `More Jobs`. We only want to include those with `title_short` of `Data Analyst`:

```sql
SELECT 
    COUNT (job_id) AS jobs_number,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York' THEN 'Local'
        ELSE 'More Jobs'
    END AS job_locations
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    job_locations
```

**Example 2**

List based on salaries:

```sql
SELECT 
    COUNT (job_id) AS jobs_number,
    CASE
        WHEN salary_year_avg < 20000 THEN 'Low Hell'
        WHEN salary_year_avg BETWEEN 20000 AND 40000 THEN 'Low End'
        WHEN salary_year_avg BETWEEN 40000 AND 60000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 60000 AND 80000 THEN 'Average'
        WHEN salary_year_avg BETWEEN 80000 AND 100000 THEN 'High'
        WHEN salary_year_avg BETWEEN 100000 AND 120000 THEN 'High End'
        WHEN salary_year_avg > 120000 THEN 'High Hell'
    END AS salary_categories
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    salary_categories
ORDER BY
    jobs_number
```

