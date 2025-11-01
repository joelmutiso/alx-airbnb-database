-- INNER JOIN
SELECT
    U.Username,
    B.booking_date,
    B.total_price
FROM
    Bookings AS B
INNER JOIN
    Users AS U ON B.user_id = U.user_id;

-- LEFT JOIN
SELECT
    P.name AS property_name,
    P.location,
    R.rating,
    R.comment
FROM
    Properties AS P
LEFT JOIN
    Reviews AS R ON P.property_id = R.property_id;

--FULL OUTER JOIN
SELECT
    U.Username,
    B.booking_date
FROM
    Users AS U
FULL OUTER JOIN
    Bookings AS B ON U.user_id = B.user_id;