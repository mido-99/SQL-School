# Join

Is mostly used to query data from multiple tables based on a joint type.

---

## LEFT

Query all data from left table & those that match from right table, based on specified column (joining column)

```sql
SELECT
	job_postings_fact.job_id,
    job_postings_fact.job_title_short title,
    companies.name AS comp_name
FROM
	job_postings_fact
LEFT JOIN company_dim AS companies
	ON job_postings_fact.company_id = companies.company_id
```

## RIGHT

Opposite to left :)

## INNER

Query rows that are shared between tables

Ex:

```sql
SELECT
	job_postings_fact.job_id,
    job_postings_fact.job_title_short,
    job_skills.skill_id,
    skills.skills
FROM
	job_postings_fact
INNER JOIN skills_job_dim AS job_skills ON job_postings_fact.job_id = job_skills.job_id
INNER JOIN skills_dim AS skills ON job_skills.skill_id = skills.skill_id
```

