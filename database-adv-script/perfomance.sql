/*
 * Initial "Inefficient" Query
 *
 * Inefficiency: SELECT * fetches every single column from all
 * four tables. This wastes I/O, memory, and network bandwidth.
 */

-- We add a complex WHERE clause (with AND) to simulate a
-- real-world use case for a fair performance test.
EXPLAIN ANALYZE
SELECT *
FROM Bookings AS B
JOIN Users AS U ON B.user_id = U.user_id
JOIN Properties AS P ON B.property_id = P.property_id
JOIN Payments AS Pay ON B.booking_id = Pay.booking_id
WHERE U.Username = 'Alice' AND P.location = 'Malibu';


/*
 * Refactored "Optimized" Query
 *
 * Optimization: Replaced SELECT * with a specific column list.
 * This dramatically reduces I/O, memory, and network load.
 * The query also relies on indexes for fast JOINs and WHERE.
 */

-- We use the same complex WHERE clause for a fair comparison.
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
WHERE U.Username = 'Alice' AND P.location = 'Malibu';