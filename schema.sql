-- Schema for Bus Ticket Reservation System using JDBC
-- Create the database
CREATE DATABASE IF NOT EXISTS bus_ticket_jdbc;
USE bus_ticket_jdbc;

-- Table structure for table `users`
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- Increased length for potential hashing
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    role ENUM('ADMIN', 'CUSTOMER') NOT NULL DEFAULT 'CUSTOMER'
);

-- Table structure for table `bus`
CREATE TABLE IF NOT EXISTS bus (
    bus_id INT PRIMARY KEY AUTO_INCREMENT,
    bus_number VARCHAR(50) UNIQUE NOT NULL,
    bus_name VARCHAR(100) NOT NULL,
    source VARCHAR(100) NOT NULL,
    destination VARCHAR(100) NOT NULL,
    travel_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    fare DECIMAL(10, 2) NOT NULL
);

-- Table structure for table `bookings`
CREATE TABLE IF NOT EXISTS bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    bus_id INT NOT NULL,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    journey_date DATE NOT NULL,
    num_of_seats INT NOT NULL,
    total_fare DECIMAL(10, 2) NOT NULL,
    status ENUM('BOOKED', 'CANCELLED') DEFAULT 'BOOKED',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (bus_id) REFERENCES bus(bus_id) ON DELETE CASCADE
);

-- Insert sample admin user (Password is likely 'admin123' in plain text based on your code)
INSERT INTO users (username, password, first_name, last_name, role)
VALUES ('admin', 'admin123', 'System', 'Administrator', 'ADMIN');

-- Insert sample buses
INSERT INTO bus (bus_number, bus_name, source, destination, travel_date, departure_time, arrival_time, total_seats, available_seats, fare)
VALUES
('BH1001', 'Sharma Travels', 'Nagpur', 'Pune', CURDATE() + INTERVAL 1 DAY, '08:00:00', '16:00:00', 40, 40, 850.00),
('BH1002', 'Neeta Tours', 'Nagpur', 'Mumbai', CURDATE() + INTERVAL 1 DAY, '22:00:00', '07:00:00', 35, 35, 1200.00),
('BH1003', 'Orange City Travels', 'Pune', 'Nagpur', CURDATE() + INTERVAL 2 DAY, '09:30:00', '17:30:00', 40, 40, 850.00);

-- Sample select query to verify data
SELECT 'Database and tables created successfully!' AS Status;
SELECT * FROM users;
SELECT bus_id, bus_number, bus_name, source, destination FROM bus;
