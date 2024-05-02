
----Assisgnment Task 1----

--Creating database

CREATE DATABASE TicketBookingSystem

--Initiating database

USE TicketBookingSystem

--Creating tables

CREATE TABLE Venue(
 venue_id INT PRIMARY KEY IDENTITY(1,1),
 venue_name VARCHAR(30),
 venue_address VARCHAR(80)
)

CREATE TABLE [Event](
 event_id INT PRIMARY KEY IDENTITY(1,1),
 event_name VARCHAR(30),
 event_date DATE,
 event_time TIME,
 venue_id INT,
 total_seats INT,
 available_seats INT,
 ticket_price DECIMAL(8, 1),
 event_type VARCHAR(10),
 booking_id INT,
 FOREIGN KEY (venue_id) REFERENCES Venue(venue_id)
)

CREATE TABLE Customer(
 customer_id INT PRIMARY KEY IDENTITY(1,1),
 customer_name VARCHAR(30),
 email VARCHAR(50),
 phone_number BIGINT,
 booking_id INT
)

CREATE TABLE Booking(
 booking_id INT PRIMARY KEY IDENTITY(1,1),
 customer_id INT,
 event_id INT,
 num_tickets INT,
 total_cost INT,
 booking_date DATE,
 FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
 FOREIGN KEY (event_id) REFERENCES [Event](event_id)
)

--Altering tables

ALTER TABLE [Event] ADD CONSTRAINT fk_booking_id 
FOREIGN KEY (booking_id) REFERENCES Booking(booking_id);

ALTER TABLE Customer ADD CONSTRAINT Customer_BookingId_FK
FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)


----TASKS 2----


--1. Write a SQL query to insert at least 10 sample records into each table.
  
INSERT INTO Venue VALUES('Old Trafford','Manchester'),
 ('Anfield','Liverpool'),
 ('Stamford Bridge','North_London'),
 ('Emirates Stadium','South_London'),
 ('Tottenham Hotspur Stadium','West_London'),
 ('Villa Park','Birmingham'),
 ('Goodison Park ','South_Liverpool'),
 ('St. James Park ','Newcastle'),
 ('Elland Road','Leeds'),
 ('Etihad','New_Manchester')
 SELECT * FROM Venue

INSERT INTO [Event] VALUES ('MU vs NC','2024-04-25','06:30:00',1,25000,100,15000.00,'Sports',Null),
 ('LIV vs TOT', '2024-08-1', '12:00:00', 2, 8000, 150, 20000.00, 'Sports', Null),
 ('Jurassic Park', '2024-05-03', '19:00:00', 3,300, 50, 250.00, 'Movie', Null),
 ('ARS vs WOL', '2024-05-01', '14:00:00', 4, 22000, 125, 25000.00, 'Sports', Null),
 ('Batman', '2024-05-05', '20:30:00', 5, 300, 8, 349.99, 'Movie', Null),
 ('Bollywood Concert', '2024-05-05', '20:30:00', 6, 3000, 155, 200.00, 'Concert',Null),
 ('EVE vs MC', '2024-04-10', '16:00:00', 7,34000, 50, 20000.00, 'Sports',Null),
 ('Barbie', '2024-05-07', '20:00:00', 8, 300, 15, 1500.55, 'Movie', Null),
 ('VH1 Concert', '2024-05-05', '17:30:00', 9, 4500, 160, 20000.99, 'Concert',Null),
 ('ARRahman Concert', '2024-02-03', '11:00:00', 10, 5000, 180, 10000.00, 'Concert', Null)
 SELECT * FROM [Event]

INSERT INTO Customer VALUES ('Mark Evans', 'mark.evans@example.com', 456267000, NULL),
 ('Sophia Clark', 'sophia.clark@example.com', 9654141265, NULL),
 ('Kevin Hall', 'kevin.hall@example.com', 1323437654, NULL),
 ('Nina Patel', 'nina.patel@example.com', 1234572413, NULL),
 ('Brian Lewis', 'brian.lewis@example.com', 6549881324, NULL),
 ('Grace Young', 'grace.young@example.com', 1324528465, NULL),
 ('Ethan Scott', 'ethan.scott@example.com', 9054357676, NULL),
 ('Chloe Adams', 'chloe.adams@example.com', 1054276565, NULL),
 ('Aaron Wright', 'aaron.wright@example.com', 1029633214, NULL),
 ('Mia Thompson', 'mia.thompson@example.com', 1076391235, NULL)
 SELECT* FROM Customer

INSERT INTO Booking VALUES (1,1,2,50000,'2024-04-08'),
 (2,2,1,20000,'2024-04-19'),
 (3,3,10,2500,'2024-02-01'),
 (4,4,2,50000,'2024-04-01'),
 (5,5,8,2800,'2024-05-01'),
 (6,6,150,30000,'2024-05-01'),
 (7,7,3,60000,'2024-04-03'),
 (8,8,1,1500.55,'2024-05-02'),
 (9,9,1,20000.99,'2024-03-01'),
 (10,10,2,20000,'2024-07-01')
 SELECT * FROM Booking
 
 ------                                           

--2. Write a SQL query to list all Events.
SELECT * FROM [Event]

--3. Write a SQL query to select events with available tickets.
SELECT * FROM [Event] WHERE available_seats>0

--4. Write a SQL query to select events name partial match with ‘cup’.
SELECT * FROM [Event] WHERE event_name LIKE '%cup%'

--5. Write a SQL query to select events with ticket price range is between 1000 to 2500.
SELECT * FROM [Event] WHERE ticket_price BETWEEN 1000 AND 2500

--6. Write a SQL query to retrieve events with dates falling within a specific range.
SELECT * FROM [Event] WHERE event_date BETWEEN '2024-02-03' AND'2024-03-05'

--7. Write a SQL query to retrieve events with available tickets that also have "Concert" in their name.
SELECT * FROM [Event] WHERE available_seats>0 AND event_type='Concert'

--8.Write a SQL query to retrieve users in batches of 5, starting from the 6th user.
SELECT * FROM [Event] ORDER BY event_id OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY
  
--9.Write a SQL query to retrieve bookings details contains booked no of ticket more than 4.
SELECT * FROM Booking WHERE num_tickets > 4

--10.Write a SQL query to retrieve customer information whose phone number end with ‘000’.
SELECT * FROM Customer WHERE phone_number LIKE ('%000')

--11.Write a SQL query to retrieve the events in order whose seat capacity more than 15000.
SELECT * FROM [Event] WHERE total_seats > 15000

--12.Write a SQL query to select events name not start with ‘x’, ‘y’, ‘z’
SELECT * FROM [Event] WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE 'z%'


----TASKS 3----

--1.Write a SQL query to List Events and Their Average Ticket Prices.
SELECT event_type, AVG(ticket_price) AS AveragePrice FROM [Event] GROUP BY event_type

--2.Write a SQL query to Calculate the Total Revenue Generated by Events.
SELECT SUM(total_cost) AS Total_Revenue 
 FROM Booking

--3.Write a SQL query to find the event with the highest ticket sales.
SELECT TOP 1 e.event_id, e.event_name, e.event_type, b.num_tickets
 FROM [EVENT] e JOIN Booking b 
 ON e.event_id = b.event_id 
 ORDER BY b.num_tickets DESC

--4.Write a SQL query to Calculate the Total Number of Tickets Sold for Each Event.
SELECT e.event_type, SUM(b.num_tickets) AS Total_Tickets_Sold
 FROM [Event] e JOIN Booking b 
 ON e.event_id = b.event_id 
 GROUP BY e.event_type

--5.Write a SQL query to Find Events with No Ticket Sales.
SELECT e.event_type, SUM(b.num_tickets) AS No_Ticket_Sold
 FROM [Event] e JOIN Booking b 
 ON e.event_id = b.event_id 
 WHERE b.num_tickets IS NULL
 GROUP BY e.event_type 

--6.Write a SQL query to Find the User Who Has Booked the Most Tickets.
SELECT TOP 1 c.customer_id, c.customer_name, SUM(b.num_tickets) AS Total_tickets_Bought
 FROM Customer c JOIN Booking b
 ON c.customer_id = b.customer_id
 GROUP BY c.customer_id, c.customer_name
 ORDER BY Total_tickets_Bought DESC

--7.Write a SQL query to List Events and the total number of tickets sold for each month.
SELECT e.event_id, e.event_name, e.event_type, SUM(b.num_tickets) AS Total_Tickets_Sold, MONTH(b.booking_date) AS [Month]
 FROM [Event] e JOIN Booking b 
 ON e.event_id = b.event_id
 GROUP BY e.event_id, e.event_name,e.event_type ,MONTH(b.booking_date) 
 ORDER BY [Month]

--8.Write a SQL query to calculate the average Ticket Price for Events in Each Venue.
SELECT v.venue_name, e.event_name ,AVG(e.ticket_price) as Avg_Price 
 FROM Venue v JOIN [Event] e
 ON v.venue_id = e.venue_id
 GROUP BY v.venue_name, e.event_name

--9.Write a SQL query to calculate the total Number of Tickets Sold for Each Event Type.
SELECT e.event_type, SUM(b.num_tickets) AS Total_Tickets_Sold 
 FROM [Event] e JOIN Booking b 
 ON e.event_id = b.event_id
 GROUP BY e.event_type

--10.Write a SQL query to calculate the total Revenue Generated by Events in Each Year.
SELECT e.event_type, SUM(b.total_cost ) AS Total_Revenue, YEAR(e.event_date) AS [Year]
 FROM Booking b JOIN [Event] e
 ON b.event_id = e.event_id
 GROUP BY e.event_type, YEAR(e.event_date)

--11.Write a SQL query to list users who have booked tickets for multiple events.
SELECT c.customer_id, c.customer_name 
 FROM Customer c JOIN Booking b 
 ON c.customer_id = b.customer_id
 GROUP BY c.customer_id, c.customer_name
 Having COUNT(b.booking_id) > 1

--12.Write a SQL query to calculate the Total Revenue Generated by Events for Each User.
SELECT c.customer_name, SUM(b.total_cost) AS Total_Revenue
 FROM Customer c JOIN Booking b
 ON c.customer_id = b.customer_id
 GROUP BY c.customer_name

--13.Write a SQL query to calculate the Average Ticket Price for Events in Each Category and Venue.
SELECT v.venue_name, e.event_type, AVG(e.ticket_price) AS Avg_Ticket_Price
 FROM Venue v JOIN [Event] e
 ON v.venue_id = e.venue_id
 GROUP BY v.venue_name,e.event_type

--14.Write a SQL query to list Users and the Total Number of Tickets They've Purchased in the Last 30 Days.
SELECT c.customer_name, SUM(b.num_tickets) AS Total_Ticket_purchase
 FROM Customer c JOIN Booking b
 ON c.customer_id = b.customer_id
 WHERE b.booking_date BETWEEN DATEADD(DAY, -30, GETDATE()) AND GETDATE()
 GROUP BY c.customer_name

SELECT * FROM Customer
SELECT * FROM [Event]
SELECT * FROM Booking 
SELECT * FROM Venue

----TASKS 4----


--1.Calculate the Average Ticket Price for Events in Each Venue Using a Subquery.
SELECT v.venue_name,
 (SELECT AVG(ticket_price)
 FROM [Event] e 
 WHERE e.venue_id = v.venue_id) AS Avg_Ticket_Price
FROM Venue v 

--2.Find Events with More Than 50% of Tickets Sold using subquery.
SELECT e.event_type, e.event_name,
 (SELECT SUM(b.num_tickets)
  FROM Booking b
  WHERE b.event_id = e.event_id) AS Tickets_Sold
 FROM Event e 
 WHERE (SELECT SUM(b.num_tickets)
  FROM Booking b
  WHERE b.event_id = e.event_id) > (available_seats*0.5)

--3.Calculate the Total Number of Tickets Sold for Each Event.
SELECT event_type, SUM(tickets_sold) AS Total_Tickets_Sold FROM( 
 SELECT e.event_type, e.event_id,
  (SELECT SUM(num_tickets) 
   FROM Booking b 
   WHERE b.event_id = e.event_id) AS tickets_sold
  FROM [Event] e) AS subquery_result 
 GROUP BY event_type

--4.Find Users Who Have Not Booked Any Tickets Using a NOT EXISTS Subquery.
SELECT c.customer_id, c.customer_name 
 FROM Customer c 
 WHERE NOT EXISTS 
  (SELECT b.num_tickets 
   FROM Booking b
   WHERE b.customer_id = c.customer_id)

--5.List Events with No Ticket Sales Using a NOT IN Subquery.
SELECT e.event_id, e.event_name
 FROM [Event] e
 WHERE e.event_id NOT IN 
 (SELECT b.event_id FROM Booking b)
	
--6.Calculate the Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause.
SELECT event_type, SUM(tickets_sold) AS Total_Tickets_Sold FROM( 
 SELECT e.event_type, e.event_id,
  (SELECT SUM(num_tickets) 
   FROM Booking b 
   WHERE b.event_id = e.event_id) AS tickets_sold
  FROM [Event] e) AS subquery_result
 GROUP BY event_type

--7.Find Events with Ticket Prices Higher Than the Average Ticket Price Using a Subquery in the WHERE Clause.
SELECT event_name, event_type
 FROM [Event]
 WHERE ticket_price > (SELECT AVG(ticket_price) FROM [Event])

--8.Calculate the Total Revenue Generated by Events for Each User Using a Correlated Subquery.
SELECT customer_name ,(
 SELECT SUM(total_cost) 
  FROM Booking b 
  WHERE b.customer_id = c.customer_id) AS Total_Revenue
 FROM Customer c 

--9.List Users Who Have Booked Tickets for Events in a Given Venue Using a Subquery in the WHERE Clause.
SELECT customer_name 
 FROM Customer 
 WHERE customer_id IN (
  SELECT b.customer_id 
  FROM Booking b 
  WHERE b.event_id IN(
   SELECT event_id FROM [EVENT] WHERE venue_id = (
    SELECT venue_id FROM Venue WHERE venue_name = 'Villa Park')))

--10.Calculate the Total Number of Tickets Sold for Each Event Category Using a Subquery with GROUP BY.
SELECT event_type, SUM(Tickets_sold) AS Total_Tickets_sold FROM(
 SELECT event_type, event_id,(
  SELECT SUM(num_tickets) FROM Booking b WHERE b.event_id = e.event_id) AS Tickets_sold 
  FROM [Event] e) AS subquery_result
 GROUP BY event_type

--11.Find Users Who Have Booked Tickets for Events in each Month Using a Subquery with DATE_FORMAT.
SELECT (SELECT c.customer_name 
 FROM CUSTOMER c 
 WHERE c.customer_id = b.customer_id) AS customer_name, 
 DATENAME(MONTH,b.booking_date) AS [Month]
 FROM Booking b
 WHERE DATENAME(MONTH,b.booking_date) IN 
  (SELECT DATENAME(MONTH,b.booking_date) AS [Month] 
  FROM Booking b)
 ORDER BY MONTH(b.booking_date)

--12.Calculate the Average Ticket Price for Events in Each Venue Using a Subquery
SELECT v.venue_name, (
 SELECT AVG(e.ticket_price)
 FROM [Event] e 
 WHERE e.venue_id = v.venue_id) AS Avg_Price
 FROM Venue v