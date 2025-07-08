# Sub Queries

**Sub Query** is used to create a temporary table to do operations on in same SQL session. This table doesn't exist really but we can make use of it in:

- Retrieving rows from another table that has specific value in this temp table like- Selecting companies that don't list a degree in their job postings requirements:

  ```sql
  SELECT
      company_id,
      name AS company_name
  FROM
      company_dim
  WHERE company_id IN (
      SELECT
          company_id
      FROM
          job_postings_fact
      WHERE
          job_no_degree_mention = TRUE
  )
  ORDER BY
      company_id
  ```

> Note for the above to work; Temp table should only return the column we're validating `IN` against.
>
> Means if you do the following inside parenthesis, that would raise `subquery has too many columns`.
>
> ```sql
>     SELECT
>         company_id
>     FROM
>         job_postings_fact
>     WHERE
>         job_no_degree_mention = TRUE
> ```

---

# CTEs - Common Table Expressions

Temporary result set; Similar to sub-query but defined in different syntax. Here we aim to see which company has the most job postings:

```sql
WITH company_total_jobs AS ( -- This CTE has aggregated number of jobs per each company
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
    )
SELECT -- Outer query to retrieve each company name based on id
    company_dim.name,
    company_total_jobs.total_jobs
FROM
    company_dim
LEFT JOIN company_total_jobs ON company_dim.company_id = company_total_jobs.company_id
-- left join to include all companies from company_dim, in case some didn't have any job postings
ORDER BY
    total_jobs DESC
```

**Advanced Example**

Find the top 5 skills required for remote jobs for Data Analyst position.

```sql
WITH skills_per_job AS (
    SELECT
        skill_id,
        COUNT(*) AS jobs_required
    FROM
        job_postings_fact AS jobs_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = jobs_fact.job_id
    WHERE
        jobs_fact.job_work_from_home = TRUE
        AND job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)
SELECT
    skills.skills AS skill,
    skills.type,
    skills_per_job.jobs_required
FROM
    skills_dim AS skills
INNER JOIN skills_per_job ON skills_per_job.skill_id = skills.skill_id
ORDER BY
    jobs_required DESC
LIMIT 5
```

