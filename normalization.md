# Database Normalization (3NF)

This document explains the process of normalizing the ALX Airbnb database to ensure it meets the Third Normal Form (3NF).

The primary goal of normalization is to reduce data redundancy and improve data integrity.

## 1. First Normal Form (1NF)
**Rule:** All column values must be atomic, and there should be no repeating groups.

* **Action:** The initial design adheres to 1NF. Each table has a primary key (`user_id`, `property_id`, etc.), and all columns store a single value. For example, a `Property` does not store a list of amenities in a single text column. To store a list (e.g., 'WiFi', 'Pool'), we would create separate `Amenity` and `PropertyAmenity` (join) tables.

## 2. Second Normal Form (2NF)
**Rule:** The database must be in 1NF, and all non-key attributes must be fully dependent on the *entire* primary key.

* **Action:** This rule primarily applies to tables with composite primary keys. In our schema, most tables have a single column primary key (e.g., `booking_id`), so they automatically satisfy 2NF.
* If we had a join table like `PropertyAmenity (property_id, amenity_id)`, any extra columns (like `is_active`) would depend on *both* keys, thus satisfying 2NF.

## 3. Third Normal Form (3NF)
**Rule:** The database must be in 2NF, and there must be no transitive dependencies (where a non-key attribute depends on another non-key attribute).

* **Potential Violation Example:** Imagine in our first draft, the `Properties` table looked like this:
    * `Properties (property_id, host_id, host_email, title, ...)`

* **Problem:** The `host_email` does not depend on the primary key `property_id`. Instead, `host_email` depends on `host_id`, which in turn depends on `property_id`. This is a **transitive dependency** (`property_id` -> `host_id` -> `host_email`). This causes data redundancy (the host's email would be repeated for every property they own) and update anomalies (if a host's email changes, it must be updated in all their property rows).

* **Resolution:** We move all attributes that depend *only* on the host (like `host_email`, `host_name`) into the `Users` table, where they belong.
    * `Users (user_id, email, first_name, ...)`
    * `Properties (property_id, host_id, title, ...)`
    * The `Properties` table only contains the `host_id` (foreign key). To find the host's email, we `JOIN` the `Users` table on `Users.user_id = Properties.host_id`.

**Conclusion:** The final schema presented in `database-script-0x01/schema.sql` adheres to 3NF. All attributes in each table are directly dependent on the table's primary key, the whole key, and nothing but the key.