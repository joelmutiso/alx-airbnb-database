# Index Performance Analysis

This document explains the performance impact of adding indexes to the Airbnb database, as measured by the `EXPLAIN` command.

## Step 1: Analyze the Query *Before* the Index

First, we ask the database to explain its plan for finding all bookings for a single user (e.g., `user_id = 1`) **before** we add any indexes.

**Command:**
```sql
EXPLAIN SELECT * FROM Bookings WHERE user_id = 1;
```

**"Before" Plan Analysis:**
The output would show a line that says:
`"Seq Scan on Bookings"` (or `Full Table Scan`)

* **Meaning:** This is the "dumb" plan. The database must read **every single row** in the `Bookings` table (a 'Sequential Scan') and check them one by one.
* **Performance:** This is very slow on a large table.



## Step 2: Create the Index

Next, we run the command to create the index on our high-usage `user_id` column.

**Command:**
```sql
CREATE INDEX idx_bookings_user_id ON Bookings(user_id);
```

## Step 3: Analyze the Query *After* the Index

We run the *exact same* `EXPLAIN` command again, but this time the database will use our new index.

**Command:**
```sql
EXPLAIN SELECT * FROM Bookings WHERE user_id = 1;
```

**"After" Plan Analysis:**
The output would now show something like:
`"Index Scan using idx_bookings_user_id on Bookings"` (or `Index Seek`)

* **Meaning:** This is the "smart" plan. The database uses the `idx_bookings_user_id` "table of contents" to **jump directly** to the rows it needs.
* **Performance:** This is extremely fast, even on a table with billions of rows.