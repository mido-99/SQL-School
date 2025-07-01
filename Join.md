# Join

Is mostly used to query data from multiple tables based on a joint type.

---

## Left

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