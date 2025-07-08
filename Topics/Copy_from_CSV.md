#### To load data from CSV into your db, do the folloiwng:

- Normal command is like:

  ```sql
  COPY company_dim
  FROM 'C:\Users\Mido Hany\VS code Projects\SQL\advanced\csv_files\company_dim.csv'
  WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
  ```

  but this can fail due to 

  ```ba
  could not open file "C:\Users\Mido Hany\VS code Projects\SQL\advanced\csv_files\company_dim.csv" for reading: Permission denied
  ```

  So instead, we'd do the same  but in sql shelll.

- Follow steps in `C:\Users\Mido Hany\VS code Projects\SQL\advanced\sql_load\3_modify_tables.sql`.

- Final command would be like:

  ```sh
  \copy company_dim FROM '[Insert File Path]/company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
  ```

> ⚠NOTE: You have to execute the commands in the same order as some tables contains reference keys for other tables' columns. So any change in order would corrupt the whole operation.