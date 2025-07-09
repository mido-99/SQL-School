WITH top_paid_skills AS(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Engineer'
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), top_demand_skills AS (
    SELECT
        skills_dim.skill_id,
        COUNT(*) AS jobs_requiring
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Engineer'
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
)

SELECT
    top_demand_skills.skill_id AS skill_id,
    skills,
    jobs_requiring,
    avg_salary
FROM
    top_demand_skills
INNER JOIN top_paid_skills ON top_demand_skills.skill_id = top_paid_skills.skill_id
ORDER BY
    jobs_requiring DESC,
    avg_salary DESC
LIMIT 25

-- All the upper query but concisely

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(*) AS jobs_requiring,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
/* If ordered by salary first, we notice appearance of rare & niche specific skills
So we use having to include only skills appearing in > 50 jobs
*/
HAVING
    COUNT(skills_job_dim.job_id) > 50
ORDER BY
    avg_salary DESC,
    jobs_requiring DESC
LIMIT 25
