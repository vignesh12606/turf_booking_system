-- Drop tables if they exist to start fresh
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS turfs;
DROP TABLE IF EXISTS users;

-- Users table to store user information, including administrators
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    is_admin BOOLEAN NOT NULL DEFAULT 0, -- 0 for User, 1 for Admin
    loyalty_points INTEGER NOT NULL DEFAULT 0
);

-- Turfs table to store details of each turf
CREATE TABLE turfs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    location TEXT NOT NULL,
    description TEXT,
    price_per_hour REAL NOT NULL,
    image_url TEXT DEFAULT 'https://placehold.co/600x400/2d3748/ffffff?text=Turf+Image'
);

-- Bookings table to track all bookings made by users
CREATE TABLE bookings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    turf_id INTEGER NOT NULL,
    booking_time DATETIME NOT NULL,
    status TEXT NOT NULL DEFAULT 'Confirmed', -- e.g., 'Confirmed', 'Cancelled'
    amount_paid REAL NOT NULL,
    points_redeemed INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (turf_id) REFERENCES turfs (id)
);

-- Insert a default admin user for initial setup
-- Password is 'admin'
INSERT INTO users (username, email, password_hash, is_admin) VALUES
('admin', 'admin@turf.com', 'scrypt:32768:8:1$va0oe3GPcgV3Dr1l$f5eca15f7123ecb7031c70e05e0bbc2c067db1a60354f9749c5c19b608740d38244c2c6ae4878f6d8492f976f8edbeeace002cec5ee079a4d12ef87a7b485091', 1);

-- Insert some sample turfs for demonstration
INSERT INTO turfs (name, location, description, price_per_hour) VALUES
('Green Pitch Arena', 'City Center, Downtown', 'State-of-the-art 5-a-side football turf with premium artificial grass.', 1200.00),
('Skyline Sports', 'North Suburbs, Rooftop Complex', 'Rooftop turf offering a stunning city view. Perfect for evening matches.', 1500.00),
('Community Kickers', 'Westside Park', 'A friendly, well-maintained turf ideal for community games and practice sessions.', 1000.00),
('VIT Chennai', 'Vandalur - Kilampakkam Road', 'Large 5 Cricket Turf and 5 Football Turf', 2000.00);

