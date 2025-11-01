# Query Optimization Report

This report analyzes an inefficient query and presents a refactored, high-performance version.

## 1. Initial Inefficient Query

The following query was written to retrieve all booking details, user details, property details, and payment details for a specific user.

```sql
-- Initial "Bad" Query
EXPLAIN ANALYZE
SELECT *
FROM Bookings AS B
JOIN Users AS U ON B.user_id = U.user_id
JOIN Properties AS P ON B.property_id = P.property_id
JOIN Payments AS Pay ON B.booking_id = Pay.booking_id
WHERE U.Username = 'Alice';
```

### Performance Analysis (`EXPLAIN ANALYZE`)

When analyzing this query, two major inefficiencies are identified:

1.  **Over-fetching with `SELECT *`:** The `*` wildcard is the primary bottleneck. It forces the database to read **every single column** from all four tables from the disk, load them into memory, and send them over the network. This includes columns we don't need, such as passwords, user creation dates, property descriptions, etc. This wastes I/O, memory, and network resources.

2.  **Missing Indexes (Potential Issue):** Without the indexes from Task 3 (on `B.user_id`, `B.property_id`, `Pay.booking_id`, and `U.Username`), the database would be forced to perform **Sequential Scans** (Full Table Scans) for its `JOIN` and `WHERE` operations, which is extremely slow.

The `EXPLAIN` plan for this query would show a high **cost** and **execution time**, even with indexes, due to the large amount of data being read and moved by `SELECT *`.

## 2. Refactored, Optimized Query

The query was refactored by addressing the single biggest inefficiency: `SELECT *`.

```sql
-- Refactored "Good" Query
EXPLAIN ANALYZE
SELECT
    -- Specific columns from Bookings
    B.booking_id,
    B.booking_date,
    B.total_price,
    -- Specific columns from Users
    U.Username,
    U.email,
    -- Specific columns from Properties
    P.name AS property_name,
    P.location,
    -- Specific columns from Payments
    Pay.payment_status,
    Pay.payment_date
FROM Bookings AS B
JOIN Users AS U ON B.user_id = U.user_id
JOIN Properties AS P ON B.property_id = P.property_id
JOIN Payments AS Pay ON B.booking_id = Pay.booking_id
WHERE U.Username = 'Alice';
```

### Performance Improvements

1.  **Reduced I/O and Network Traffic:** By selecting only the 9 columns needed (instead of 30+ columns with `SELECT *`), the database does significantly less work. It reads only the required data from disk and sends a much smaller, faster packet of data to the application.

2.  **Leverages Indexes:** The refactored query (like the original) is designed to run on an indexed database. The `EXPLAIN` plan will now show:
    * **`Index Scan on Users (idx_users_username)`** for the `WHERE` clause (very fast).
    * **`Index Scan on Bookings (idx_bookings_user_id)`** for the `JOIN` (very fast).
    * And so on for all `JOIN` keys.

The `EXPLAIN ANALYZE` output for this query will show a **much lower execution time** and **cost** because the database is only reading and processing the exact data required.