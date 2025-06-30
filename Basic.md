# General

Order of keywords

- SELECT
- FROM
- WHERE
- ORDER BY
- HAVING
- ORDER BY [ASC / DESC / ...]
- LIMIT



---

## SELECT

#### SELECT * FROM table_name

Select all data from a table

#### SELECT table_name.column_name FROM table_name

Options: 

- Keyword AS to rename tables or columns - We can use or omit it with the same behavior: 

  SELECT 

  ​	col_ name [AS /  ] col_renamed 

  FROM 

  ​	tb_name tb_renamed

  

#### SELECT DISTINCT ...

Select only specific values for a columns

---

## WHERE

Used for filtering

#### SELECT ... FROM ...

#### WHERE [NOT]

#### 	column_name [operator] value

### Operators:

- =, <> (**Not Equal**)

- <, <=, >, >=

- % Exactly like py modulus

- AND, OR

- BETWEEN: 

  <100 AND >50 is equal to BETWENN 50 AND 100

- IN

  Like that of python in list[]: job_location IN ('Anywhere', 'Boston, MA')

---

## ORDER BY

Order by column name

Options:

- ASC (default)
- DESC

---

## LIMIT 

- LIMIT [int]: Limits number of rows to query

---

## Comments

#### --

Anything after -- is a single line comment

#### /* Multi

#### Line 

#### Comment */



