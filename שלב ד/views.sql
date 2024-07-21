--view our side:
CREATE VIEW forests_view AS
SELECT
    forests.forest_ID,
    area,
    trail_id,
    trail_name,
    trails.location as t_location,
    forests.location as f_location,
    open_closed
FROM
    trails left join forests on forests.forest_id = trails.forest_id

select * from forests_view;

--query1:
SELECT 
DISTINCT forest_id,
    f_location,
    area,
    'https://www.google.com/maps/place/' || 
         REPLACE(f_location, ', ', ',') AS google_earth_link
FROM forests_view
WHERE forest_id = &<name="forest number"
          list="select forest_id from forests"
          restricted = "yes">
          
--query2:         
SELECT v.trail_name, 'hiking' AS trail_type, open_closed
FROM hiking_trails ht
JOIN forests_view v ON ht.trail_id = v.trail_id
WHERE v.forest_id = 78
UNION
SELECT v.trail_name, 'biking' AS trail_type, open_closed
FROM biking_trails bt
JOIN forests_view v ON bt.trail_id = v.trail_id
WHERE v.forest_id = 78;
  


--view their side:
CREATE VIEW Customer_Activities AS
SELECT b.traveler_id, 'biking' AS activity_type, traveler_name
FROM Bikers_On_Trail b left join customers c on c.traveler_id = b.traveler_id
UNION ALL
SELECT h.traveler_id, 'hiking' AS activity_type, traveler_name
FROM Hikers_On_Trail h left join customers c on c.traveler_id = h.traveler_id
UNION ALL
SELECT a.traveler_id, 'educational' AS activity_type, traveler_name
FROM Attends a left join customers c on c.traveler_id = a.traveler_id;

select * from Customer_Activities order by traveler_name;


--query1:
SELECT 
    c.traveler_id, 
    c.traveler_name, 
    SUM(p.amount) AS total_spent
FROM 
    Customers c
JOIN (Customers_Payment cp LEFT JOIN payment p ON cp.payment_id = p.payment_id )
     ON c.traveler_id = cp.traveler_id
GROUP BY 
    c.traveler_id, c.traveler_name
HAVING 
    SUM(p.amount) > 180;
    
--query2:   
SELECT 
    SUM(biking_customers) AS biking_customers,
    SUM(hiking_customers) AS hiking_customers,
    SUM(educational_customers) AS educational_customers,
    SUM(biking_customers + hiking_customers + educational_customers) AS total_customers
FROM (
    SELECT COUNT(*) AS biking_customers, 0 AS hiking_customers, 0 AS educational_customers FROM Bikers_On_Trail
    UNION ALL
    SELECT 0 AS biking_customers, COUNT(*) AS hiking_customers, 0 AS educational_customers FROM Hikers_On_Trail
    UNION ALL
    SELECT 0 AS biking_customers, 0 AS hiking_customers, COUNT(*) AS educational_customers 
    FROM Attends a LEFT JOIN customers c ON c.traveler_id = a.traveler_id
);