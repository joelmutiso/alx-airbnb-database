-- Aggregation (COUNT and GROUP BY)

SELECT
    U.Username,
    COUNT(B.booking_id) AS total_bookings
FROM
    Users AS U
LEFT JOIN -- Use LEFT JOIN to include users with 0 bookings
    Bookings AS B ON U.user_id = B.user_id
GROUP BY
    U.user_id, U.Username -- Group by both ID and Name
ORDER BY
    total_bookings DESC; -- Optional: See most active users first

-- Window Function (RANK)

/* Layer 1: The CTE to count bookings per property */
WITH PropertyBookingCounts AS (
    SELECT
        P.name AS property_name,
        COUNT(B.booking_id) AS total_bookings
    FROM
        Properties AS P
    LEFT JOIN -- Use LEFT JOIN to include properties with 0 bookings
        Bookings AS B ON P.property_id = B.property_id
    GROUP BY
        P.property_id, P.name
)

/* Layer 2: The Window Function to rank the counts */
SELECT
    property_name,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS property_rank
FROM
    PropertyBookingCounts
ORDER BY
    property_rank ASC; -- Optional: Show rank #1 at the top