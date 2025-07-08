# UNION & UNION ALL

- **UNION**

  Used basically as opposed to `JOIN`, Now we union (combine) 2 or more tables to get 1 single big table of data

- UNION ALL

  Is exactly the same but doesn't drop duplicated like just `UNION` does. 

  ```sql
  SELECT *
  FROM january_jobs
  UNION ALL
  SELECT *
  FROM february_jobs
  UNION ALL
  SELECT *
  FROM march_jobs
  ```

  **Example**

Get "Data Analyst" job postings of the first quarter of 2023 with yearly avg salary of 70k $ or more

```sql
SELECT
    salary_year_avg,
    job_location,
    job_via,
    job_posted_date::DATE
FROM (
SELECT *
FROM january_jobs
UNION ALL
SELECT *
FROM february_jobs
UNION ALL
SELECT *
FROM march_jobs
) AS q1_2023_jobs
WHERE
    q1_2023_jobs.salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC
```

