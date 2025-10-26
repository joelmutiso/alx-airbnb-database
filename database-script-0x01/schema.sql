-- Drops all tables if they exist to ensure a clean slate.
-- CASCADE drops any dependent objects (like views or foreign key constraints).
DROP TABLE IF EXISTS Reviews CASCADE;
DROP TABLE IF EXISTS Bookings CASCADE;
DROP TABLE IF EXISTS Properties CASCADE;
DROP TABLE IF EXISTS Users CASCADE;

-- Create an ENUM type for booking status for data consistency.
DROP TYPE IF EXISTS booking_status;
CREATE TYPE booking_status AS ENUM ('Pending', 'Confirmed', 'Cancelled');

-- Table: Users
-- Stores information about all users (both hosts and guests).
CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(50) UNIQUE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);

-- Table: Properties
-- Stores all property listings.
CREATE TABLE Properties (
    property_id SERIAL PRIMARY KEY,
    host_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    property_type VARCHAR(50),
    price_per_night DECIMAL(10, 2) NOT NULL CHECK (price_per_night > 0),
    max_guests INT NOT NULL CHECK (max_guests > 0),
    bedrooms INT DEFAULT 1 CHECK (bedrooms >= 0),
    bathrooms INT DEFAULT 1 CHECK (bathrooms >= 0),
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraint linking to the host (User)
    CONSTRAINT fk_host
        FOREIGN KEY(host_id) 
        REFERENCES Users(user_id)
        ON DELETE CASCADE -- If a user is deleted, their properties are also deleted.
);

-- Table: Bookings
-- Stores information about reservations made by users.
CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    guest_id INT NOT NULL,
    property_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status DEFAULT 'Pending' NOT NULL,
    booked_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key for the guest (User)
    CONSTRAINT fk_guest
        FOREIGN KEY(guest_id) 
        REFERENCES Users(user_id)
        ON DELETE CASCADE, -- If a guest user is deleted, their bookings are deleted.
    
    -- Foreign key for the property
    CONSTRAINT fk_property
        FOREIGN KEY(property_id) 
        REFERENCES Properties(property_id)
        ON DELETE CASCADE, -- If a property is deleted, its bookings are deleted.
        
    -- Check constraint to ensure logical dates
    CONSTRAINT check_dates CHECK (check_out_date > check_in_date)
);

-- Table: Reviews
-- Stores reviews submitted by guests for properties after a stay.
CREATE TABLE Reviews (
    review_id SERIAL PRIMARY KEY,
    booking_id INT UNIQUE NOT NULL, -- Ensures one review per booking
    guest_id INT NOT NULL,
    property_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign keys
    CONSTRAINT fk_booking
        FOREIGN KEY(booking_id)
        REFERENCES Bookings(booking_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_guest
        FOREIGN KEY(guest_id)
        REFERENCES Users(user_id)
        ON DELETE SET NULL, -- If guest account is deleted, keep the review anonymously
    CONSTRAINT fk_property
        FOREIGN KEY(property_id)
        REFERENCES Properties(property_id)
        ON DELETE CASCADE -- If property is deleted, delete its reviews
);

-- --- INDEXES ---
-- Create indexes on foreign keys and common search columns for performance.

-- On Users table
CREATE INDEX idx_users_email ON Users(email);

-- On Properties table
CREATE INDEX idx_properties_host_id ON Properties(host_id);
CREATE INDEX idx_properties_city_country ON Properties(city, country);
CREATE INDEX idx_properties_price ON Properties(price_per_night);

-- On Bookings table
CREATE INDEX idx_bookings_guest_id ON Bookings(guest_id);
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);

-- On Reviews table
CREATE INDEX idx_reviews_guest_id ON Reviews(guest_id);
CREATE INDEX idx_reviews_property_id ON Reviews(property_id);