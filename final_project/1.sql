-- Top 10 paying roles for remote Data Engineer jobs
with top_paying_roles AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        job_posted_date,
        job_location,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_location IN ('Anywhere', 'Egypt')
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_roles.*,
    skills
FROM
    top_paying_roles
INNER JOIN skills_job_dim AS skills_to_job ON skills_to_job.job_id = top_paying_roles.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_to_job.skill_id
ORDER BY
    salary_year_avg