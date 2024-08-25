-- Check the Row Count: Run a query to count the number of rows in the bookings table to ensure all data was imported:
SELECT COUNT(*) FROM bookings;

-- View Sample Data: To inspect some of the imported data, run:
SELECT * FROM bookings LIMIT 10;

-- Filter bookings by Resort Hotel
SELECT * FROM bookings WHERE hotel = 'Resort Hotel';

-- Aggregate Data: Calculate the total number of bookings per month:
SELECT arrival_date_month, COUNT(*) AS total_bookings
FROM bookings
GROUP BY arrival_date_month;

-- Analyze Cancellations: Find out the cancellation rate
SELECT is_canceled, COUNT(*) AS count, (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bookings)) AS percentage
FROM bookings
GROUP BY is_canceled;

-- Revenue Analysis: Calculate the total revenue (assuming adr is the average daily rate)
SELECT SUM(adr * (stays_in_week_nights + stays_in_weekend_nights)) AS total_revenue
FROM bookings
WHERE is_canceled = 0;

