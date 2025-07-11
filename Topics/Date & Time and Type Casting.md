# Data Type Casting

To view - retrieve - data in a specific format - like viewing string date as real data - we do the following:

```sql
SELECT column::data_type
FROM table_name;
```

That way it will be retrieved - for example a data with time row selected `::DATE` will show only date & omit time part.

Other data types like `INTEGER`, `REAL`, `BOOLEAN`, ...

- ***To Cast dates that don't have a time zone when added to db, we use the following:***

```sql
SELECT job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'
FROM job_postings_fact
LIMIT 10;O
```

So we first use at real date time zone - UTC in this example - then cast to target time zone.

# More Date & Time

## EXTRACT()

Extract date items from a date:

```sql
SELECT
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST',
    EXTRACT(MONTH FROM job_posted_date) AS month,
    EXTRACT(DAY FROM job_posted_date) AS day,
    EXTRACT(YEAR FROM job_posted_date) AS year
FROM job_postings_fact
LIMIT 10;
```

---

## Create New Table based on Data Extraction

We can create tables based on values from specific rows on our table:

```sql	
CREATE TABLE january_jobs AS
    SELECT * 
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;
-- ...
```

