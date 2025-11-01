-- Non-Correlated Subquery

SELECT
    name,
    location
FROM
    Properties
WHERE
    property_id IN (
        -- This is the "inner question" (the subquery)
        SELECT
            property_id
        FROM
            Reviews
        GROUP BY
            property_id
        HAVING
            AVG(rating) > 4.0
    );

-- Correlated Subquery

SELECT
    Username,
    user_id
FROM
    Users AS U
WHERE
    (
        -- This "correlated" subquery runs for EACH user
        SELECT
            COUNT(*)
        FROM
            Bookings AS B
        WHERE
            B.user_id = U.user_id -- The "correlation" link
    ) > 3;