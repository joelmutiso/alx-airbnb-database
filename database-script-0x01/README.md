# Database Schema (DDL)

This directory contains the `schema.sql` file.

This script is responsible for Data Definition (DDL). It creates the entire database structure for the ALX Airbnb project, including all tables, constraints (Primary Keys, Foreign Keys, Checks), and indexes.

## How to Run

1.  Ensure you have PostgreSQL running.
2.  Create a new database (e.g., `alx_airbnb`).
3.  Execute the script against your new database.

**Command:**

```bash
psql -U <your_username> -d <your_database_name> -f schema.sql