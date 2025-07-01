**Aggregation work by applying an operation on the entire column, not rows**

## SUM()

- Sum all values in a given column

  SELECT SUM(salary) AS total_salary FROM salaries



---

## COUNT()

- Count of rows in given column

- Useful in conjunction with DISTINCT keyword:

  SELECT COUNT(DISTINCT job_title) AS job_type_total FROM job_postings_fact 

---

## AVG() - MIN() - MAX()

- Same like SUM()

  SELECT  AVG(salary_year_avg) as salary_avg

  FROM job_postings_fact

  WHERE job_title_short = 'Data Analyst'

---

## GROUP BY

- Group rows based on distinct values from given column

```sql
SELECT
	job_title_short as jobs,
	AVG(salary_year_avg) as salary_avg,
	MIN(salary_year_avg) as salary_min,
	MAX(salary_year_avg) as salary_max
FROM
	job_postings_fact
GROUP BY
	jobs
ORDER BY
	salary_avg DESC
```

---

## HAVING()

Filter rows based on aggregated result. Aggregation doesn't take place before WHERE is executed, which may raise an error if misused rather than HAVING. To get it better, here's order of execution in SQL:

> 1. **`FROM` clause**: Determines the source table(s) for the data. If there are joins, they are performed here.
> 2. **`WHERE` clause**: Filters individual rows based on specified conditions. At this point, no aggregation has occurred, so you can only refer to columns directly from the tables.
> 3. **`GROUP BY` clause**: If present, this clause groups the rows that passed the `WHERE` filter into summary groups based on the specified column(s).
> 4. **Aggregate Functions (in `SELECT` or `HAVING`)**: These functions (like `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`) are calculated *for each group* created by `GROUP BY`, or for the entire dataset if no `GROUP BY` is present.
> 5. **`HAVING` clause**: Filters the *groups* based on conditions applied to the aggregated values. This is why you can use `job_count` here, because it has already been calculated for each group.
> 6. **`SELECT` clause**: Specifies which columns (including the results of aggregate functions) will be returned in the final output. Aliases (like `job_count`) are also assigned here.
> 7. **`DISTINCT` (if specified)**: Removes duplicate rows from the result set.
> 8. **`ORDER BY` clause**: Sorts the final result set based on specified columns or expressions.
> 9. **`LIMIT`/`OFFSET` (or `TOP` in some SQL dialects)**: Restricts the number of rows returned.

Ex: ✔

```sql
SELECT
	job_title_short as jobs,
    COUNT(job_title_short) AS job_count,
	AVG(salary_year_avg) as salary_avg,
	MIN(salary_year_avg) as salary_min,
	MAX(salary_year_avg) as salary_max
FROM
	job_postings_fact
GROUP BY
	jobs
HAVING
	job_count > 1000
ORDER BY
	salary_avg DESC
```

Ex: ❌

```sql
SELECT
-- ...
GROUP BY
	jobs
WHERE
	job_count > 1000
ORDER BY
-- ...
```

