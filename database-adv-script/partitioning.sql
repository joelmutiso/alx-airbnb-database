/*
 * This script creates a new, partitioned Bookings table.
 * Partitioning is ideal for very large tables (VLDBs)
 * where queries often filter by a specific range, like dates.
 *
 * In a real-world scenario with an *existing* large table,
 * you would create this new table, migrate the data,
 * and then replace the old table.
 */

-- 1. Create the "parent" partitioned table.
-- This table doesn't store data itself; it acts as a
-- "router" to send data to the correct child partition.
CREATE TABLE Bookings_Partitioned (
    booking_id SERIAL,
    user_id INT,
    property_id INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2),
    -- The partition key (start_date) must be part of the primary key.
    PRIMARY KEY (booking_id, start_date)
)
PARTITION BY RANGE (start_date);

-- 2. Create the "child" partitions for specific date ranges.
-- The database will automatically scan only the relevant
-- partitions based on a query's WHERE clause.

CREATE TABLE bookings_y2024 PARTITION OF Bookings_Partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_y2025 PARTITION OF Bookings_Partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- A default partition is good practice to catch any
-- dates that don't fit in the defined ranges.
CREATE TABLE bookings_default PARTITION OF Bookings_Partitioned
    DEFAULT;


-- 3. Create an index on the partition key.
-- This is crucial for helping the planner find the
-- right partition and for speeding up queries.
CREATE INDEX idx_bookings_partitioned_start_date ON Bookings_Partitioned(start_date);


/*
 * ===================================================
 * Test Query
 * ===================================================
 *
 * When you run EXPLAIN ANALYZE on this query,
 * the "After" plan will show that it *only* scans
 * the 'bookings_y2024' partition and ignores all others.
 * This is called "Partition Pruning."
 */

EXPLAIN ANALYZE
SELECT *
FROM Bookings_Partitioned
WHERE start_date >= '2024-03-01' AND start_date < '2024-04-01';