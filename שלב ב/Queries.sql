--select--
--1--
SELECT hasa.forest_id, 
    forests.forest_name, 
    hasa.action_id, 
    prevention_actions.action_name, 
    prevention_actions.cost
FROM hasa 
LEFT JOIN forests ON hasa.forest_id = forests.forest_id 
LEFT JOIN prevention_actions ON hasa.action_id = prevention_actions.action_id
WHERE prevention_actions.action_id = (
      SELECT action_id
      FROM prevention_actions
      WHERE cost = (  SELECT MIN(cost)
                                  FROM prevention_actions
                                  WHERE ACTION_DURATION = 'strong protection for a long time')
    );
    
--2--
SELECT donors, EXTRACT(YEAR FROM end_date) as PROJECT_YEAR
FROM tree_planting_projects
LEFT JOIN tree_planting_projects_donors 
ON tree_planting_projects.planting_id = tree_planting_projects_donors.planting_id
WHERE donors IS NOT NULL
AND tree_planting_projects.planting_id IN (
    SELECT planting_id
    FROM tree_planting_projects
    WHERE EXTRACT(YEAR FROM end_date) > 2022
);

--3--
SELECT f.forest_name, rs.station_name, rs.research_subject
FROM forests f
JOIN (
    SELECT forest_id, station_name, research_subject
    FROM research_stations
    WHERE research_subject LIKE 'Tree%'
) rs ON f.forest_id = rs.forest_id
ORDER BY rs.research_subject;

--4--
WITH station_counts AS (
    SELECT station_location AS city, COUNT(*) AS station_count
    FROM research_stations
    GROUP BY station_location
),
/* creates a temporary result set that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement*/
forest_counts AS (
    SELECT forest_name AS city, COUNT(*) AS forest_count
    FROM forests
    GROUP BY forest_name
),
combined_counts AS (
    SELECT station_counts.city,
        station_counts.station_count + 
        NVL(forest_counts.forest_count, 0)/*this function replaces null with 0 for the count*/ 
        AS total_count
    FROM station_counts
    LEFT JOIN forest_counts ON station_counts.city = forest_counts.city
)
SELECT city, total_count
FROM (
    SELECT city, total_count, 
           DENSE_RANK() OVER (ORDER BY total_count DESC) AS drnk
    FROM combined_counts
)
WHERE drnk <= 3;/*gives cities with same count the same rank, then dispalys the cities in top 3*/

--delete--
--5--
DELETE FROM trees
WHERE tree_id > 5 AND tree_id < 25 AND forest_id in 
      (select forest_id from forests where forest_id<5 and forest_name = 
              &<name="name"
              list="select forest_name from forests where forest_id <6 order by forest_id"
              type = string
              restricted = "yes">);
              
--6--
DELETE FROM education_programs 
WHERE 
ages = 'schools' and station_id IN (
      SELECT station_id 
      from research_stations 
      where forest_id = 45
      );

--update--
--7--
UPDATE forests
SET area = area+5
WHERE forest_id IN (
    SELECT forest_id
    FROM tree_planting_projects
    WHERE EXTRACT(YEAR FROM end_date) = 2024 
    and EXTRACT(MONTH FROM end_date) = 05 
    and EXTRACT(DAY FROM end_date) > 19
);

--8--
UPDATE tree_planting_projects
SET start_date = ADD_MONTHS(start_date, 1), end_date = ADD_MONTHS(end_date, 1)
WHERE start_date BETWEEN TO_DATE('07/10/2023', 'DD/MM/YYYY') 
                     AND TO_DATE('01/11/2023', 'DD/MM/YYYY');
