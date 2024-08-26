-- Step 1: Create the bookings Table
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    hotel VARCHAR(100),
    is_canceled INTEGER,
    lead_time INTEGER,
    arrival_date_year INTEGER,
    arrival_date_month VARCHAR(20),
    arrival_date_week_number INTEGER,
    arrival_date_day_of_month INTEGER,
    stays_in_weekend_nights INTEGER,
    stays_in_week_nights INTEGER,
    adults INTEGER,
    children INTEGER,
    babies INTEGER,
    meal VARCHAR(20),
    country VARCHAR(50),
    market_segment VARCHAR(50),
    distribution_channel VARCHAR(50),
    is_repeated_guest INTEGER,
    previous_cancellations INTEGER,
    previous_bookings_not_canceled INTEGER,
    reserved_room_type VARCHAR(5),
    assigned_room_type VARCHAR(5),
    booking_changes INTEGER,
    deposit_type VARCHAR(20),
    agent VARCHAR(10),
    company VARCHAR(10),
    days_in_waiting_list INTEGER,
    customer_type VARCHAR(20),
    adr DECIMAL(10, 2),
    required_car_parking_spaces INTEGER,
    total_of_special_requests INTEGER,
    reservation_status VARCHAR(20),
    reservation_status_date DATE
);


-- Step 2: Import Data from CSV
\copy bookings(hotel, is_canceled, lead_time, arrival_date_year, arrival_date_month, arrival_date_week_number, arrival_date_day_of_month, stays_in_weekend_nights, stays_in_week_nights, adults, children, babies, meal, country, market_segment, distribution_channel, is_repeated_guest, previous_cancellations, previous_bookings_not_canceled, reserved_room_type, assigned_room_type, booking_changes, deposit_type, agent, company, days_in_waiting_list, customer_type, adr, required_car_parking_spaces, total_of_special_requests, reservation_status, reservation_status_date) 
FROM 'C:/path/to/your/hotel_bookings.csv' DELIMITER ',' CSV HEADER NULL 'NA';


-- Step 3: Basic Data Exploration Queries
-- Check the Row Count to ensure all data was imported:
SELECT COUNT(*) FROM bookings;

-- View the First 10 Records:
SELECT * FROM bookings LIMIT 10;

-- Group Bookings by Hotel:
SELECT hotel, COUNT(*) AS total_bookings
FROM bookings
GROUP BY hotel
ORDER BY total_bookings DESC;


-- Step 4: Advanced Analytical Queries
-- Cancellation Analysis by Booking Channel:
SELECT distribution_channel, 
       COUNT(*) AS total_bookings, 
       SUM(is_canceled) AS cancellations, 
       (SUM(is_canceled) * 100.0 / COUNT(*)) AS cancellation_rate
FROM bookings
GROUP BY distribution_channel
ORDER BY cancellation_rate DESC;

-- Revenue Analysis by Lead Time:
SELECT lead_time, 
       AVG(adr) AS avg_revenue, 
       AVG(booking_changes) AS avg_changes
FROM bookings
WHERE is_canceled = 0
GROUP BY lead_time
ORDER BY lead_time;

-- Customer Segmentation by Market Segment and Revenue:
SELECT market_segment, 
       COUNT(*) AS total_bookings, 
       AVG(adr) AS avg_revenue
FROM bookings
WHERE is_canceled = 0
GROUP BY market_segment
ORDER BY avg_revenue DESC;

-- Identify Peak Booking Periods:
SELECT arrival_date_month, 
       COUNT(*) AS total_bookings
FROM bookings
WHERE is_canceled = 0
GROUP BY arrival_date_month
ORDER BY total_bookings DESC;

-- Analyze Booking Changes:
SELECT booking_changes, 
       COUNT(*) AS total_bookings
FROM bookings
GROUP BY booking_changes
ORDER BY total_bookings DESC;


