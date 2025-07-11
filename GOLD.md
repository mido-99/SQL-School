> *Whenever you want a separate count per category (like a skill name), you must GROUP BY that category.*

---

## 🔑 Rule of thumb

**LEFT JOIN**:

- includes **all** rows from the left
- repeats each left row for every matching right row
- fills NULLs if there is no match

So if a skill appears in 10,000 job postings, you will get 10,000 rows for that skill after the JOIN.

---

## GROUP BY Rule

**Any column or expression in your `SELECT` list that is \*not\* part of an aggregate function (like `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`) must explicitly appear in your `GROUP BY` clause.**