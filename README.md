# 🚀 ALX Airbnb Database Module

Welcome to the ALX Airbnb Database project! This repository contains the complete database module, from conceptual design to a fully populated, runnable SQL database. This file serves as the central documentation for the entire project.

## 🗺️ 1. DataScape & ER Diagram

The Entity-Relationship (ER) Diagram provides a high-level, visual blueprint of our database. It defines the "what" (our data entities) and the "how" (their relationships).

![ALX Airbnb ER Diagram](ERD/airbnb_erd.png)

<details>
<summary><strong>View Entities & Attributes</strong> (Click to expand)</summary>

### 👤 User
* `user_id` (Primary Key): Unique identifier for the user.
* `email`: User's email (Unique, Not Null).
* `password_hash`: Hashed password (Not Null).
* `first_name`: User's first name.
* `last_name`: User's last name.
* `phone_number`: User's contact number.
* `created_at`: Timestamp of account creation.

### 🏠 Property
* `property_id` (Primary Key): Unique identifier for the property.
* `host_id` (Foreign Key -> User): The user who owns/lists the property.
* `title`: Title of the listing.
* `description`: Detailed description (TEXT).
* `address`: Physical address.
* `city`: City.
* `country`: Country.
* `property_type`: e.g., 'Apartment', 'House', 'Guest House'.
* `price_per_night`: Cost per night (DECIMAL).
* `max_guests`: Maximum number of guests (INTEGER).
* `bedrooms`: Number of bedrooms.
* `bathrooms`: Number of bathrooms.
* `created_at`: Timestamp of listing creation.

### 🗓️ Booking
* `booking_id` (Primary Key): Unique identifier for the booking.
* `guest_id` (Foreign Key -> User): The user who made the booking.
* `property_id` (Foreign Key -> Property): The property being booked.
* `check_in_date`: Start date of the booking (DATE).
* `check_out_date`: End date of the booking (DATE).
* `total_price`: The total calculated price for the stay (DECIMAL).
* `status`: e.g., 'Pending', 'Confirmed', 'Cancelled' (ENUM type).
* `booked_at`: Timestamp of when the booking was made.

### ⭐ Review
* `review_id` (Primary Key): Unique identifier for the review.
* `booking_id` (Foreign Key -> Booking): The booking this review is for (Unique).
* `guest_id` (Foreign Key -> User): The user who wrote the review.
* `property_id
