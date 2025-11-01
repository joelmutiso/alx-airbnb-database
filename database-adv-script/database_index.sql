/*
 * === Indexes for Foreign Keys (JOINs) ===
 * This is the most important performance boost for your queries.
 */

-- Index on Bookings table for linking to Users
CREATE INDEX idx_bookings_user_id ON Bookings(user_id);

-- Index on Bookings table for linking to Properties
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);

-- Index on Reviews table for linking to Properties
CREATE INDEX idx_reviews_property_id ON Reviews(property_id);

-- Index on Reviews table for linking to Users
CREATE INDEX idx_reviews_user_id ON Reviews(user_id);


/*
 * === Indexes for Common Searches (WHERE) ===
 * This speeds up finding specific records.
 */

-- Index on Users table for searching by username (logins)
CREATE UNIQUE INDEX idx_users_username ON Users(Username);

-- Index on Properties table for searching by location
CREATE INDEX idx_properties_location ON Properties(location);