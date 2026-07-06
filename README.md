# Emission Factors SQL Practice

A compact MySQL 8 project demonstrating relational schema design and common join patterns using a synthetic emission-factor dataset.

## Skills demonstrated

- Primary and foreign keys
- `INNER JOIN`, `LEFT JOIN`, `USING`, and `NATURAL JOIN`
- Self joins for comparing related factor records
- Multiple-table joins and compound filters
- Cross joins for data-completeness auditing
- `UNION` and `UNION ALL`
- Calculated columns and unit cross-checks

## Project structure

```text
sql/
├── 01_schema.sql
├── 02_synthetic_data.sql
└── 03_join_exercises.sql
```

## Run locally

Run the files in order using MySQL Workbench or the MySQL command line:

```bash
mysql -u root -p < sql/01_schema.sql
mysql -u root -p < sql/02_synthetic_data.sql
mysql -u root -p < sql/03_join_exercises.sql
```

Each exercise is a separate statement. In MySQL Workbench, place the cursor inside one statement and execute it to inspect that result independently.

## Data note

This repository uses a small synthetic dataset created solely for SQL practice. Values are illustrative and must not be used for greenhouse-gas accounting, regulatory reporting, or technical analysis.

## Author

Dr. Khawar Naeem  
Qatar Transportation and Traffic Safety Center (QTTSC), Qatar University

## References

MySQL 8 Reference Manual: https://dev.mysql.com/doc/refman/8.0/en/

US EPA GHG Emission Factors Hub, provided only as domain background and not as the source of the synthetic values: https://www.epa.gov/climateleadership/ghg-emission-factors-hub

