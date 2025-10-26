# Database Seeding (DML)

This directory contains the `seed.sql` file.

This script is responsible for Data Manipulation (DML). It populates the database tables with sample, realistic data for `Users`, `Properties`, `Bookings`, and `Reviews`. This is essential for testing and development.

## Prerequisites

You **must** run the `schema.sql` script from the `database-script-0x01` directory *before* running this seed script.

## How to Run

1.  Ensure you have a database with the correct schema already created.
2.  Execute the seed script against that database.

**Command:**

```bash
psql -U <your_username> -d <your_database_name> -f seed.sql