---

## 3. Seed the Database with Sample Data

This task requires the SQL file to insert sample data, plus a `README.md` file explaining how to use it.

### File: `database-script-0x02/seed.sql`

```sql
-- Seed script to populate the ALX Airbnb database with sample data.
-- This script assumes 'schema.sql' has already been run.

-- Wrap in a transaction so all inserts succeed or fail together.
BEGIN;

-- --- Sample Users ---
-- Passwords here are placeholders, e.g., 'password123' hashed.
-- In a real app, you would hash these securely. Using plain text for simplicity.
INSERT INTO Users (email, password_hash, first_name, last_name, phone_number)
VALUES
('host1@example.com', 'hash_host1', 'John', 'Doe', '111-222-3333'),
('guest1@example.com', 'hash_guest1', 'Jane', 'Smith', '444-555-6666'),
('guest2@example.com', 'hash_guest2', 'Mike', 'Johnson', '777-888-9999');

-- --- Sample Properties ---
-- Insert properties, using the user_id of 'host1@example.com' (which is 1)
INSERT INTO Properties (host_id, title, description, address, city, country, property_type, price_per_night, max_guests, bedrooms, bathrooms)
VALUES
(1, 'Cozy Downtown Apartment', 'A beautiful and cozy apartment right in the heart of the city.', '123 Main St', 'New York', 'USA', 'Apartment', 150.00, 2, 1, 1),
(1, 'Spacious Beach House', 'A large house with a private beach, perfect for families.', '456 Ocean Ave', 'Miami', 'USA', 'House', 400.00, 8, 4, 3),
(1, 'Rustic Cabin in the Woods', 'Escape the city and enjoy nature in this rustic cabin.', '789 Forest Rd', 'Asheville', 'USA', 'Cabin', 100.00, 4, 2, 1);

-- --- Sample Bookings ---
-- guest1 (ID 2) books property 1
INSERT INTO Bookings (guest_id, property_id, check_in_date, check_out_date, total_price, status)
VALUES
(2, 1, '2025-11-10', '2025-11-15', 750.00, 'Confirmed');

-- guest2 (ID 3) books property 2
INSERT INTO Bookings (guest_id, property_id, check_in_date, check_out_date, total_price, status)
VALUES
(3, 2, '2025-12-01', '2025-12-07', 2400.00, 'Confirmed');

-- guest1 (ID 2) books property 3 but it's pending
INSERT INTO Bookings (guest_id, property_id, check_in_date, check_out_date, total_price, status)
VALUES
(2, 3, '2026-01-05', '2026-01-10', 500.00, 'Pending');

-- --- Sample Reviews ---
-- Add a review for the first booking (ID 1)
INSERT INTO Reviews (booking_id, guest_id, property_id, rating, comment)
VALUES
(1, 2, 1, 5, 'Absolutely loved this place! It was clean, centrally located, and the host was very communicative. Highly recommend!');

-- Add a review for the second booking (ID 2)
INSERT INTO Reviews (booking_id, guest_id, property_id, rating, comment)
VALUES
(2, 3, 2, 4, 'Great house with lots of space. The beach access was amazing. Only downside was the spotty WiFi.');

-- Commit the transaction
COMMIT;