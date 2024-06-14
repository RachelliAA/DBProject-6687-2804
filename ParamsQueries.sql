--parameter select--
--1--
SELECT *
FROM forests
WHERE area BETWEEN &<name="from"
          list=" 5, 10,15,20,25,30,35"
          restricted = "yes">
AND &<name="until"
          list=" 5, 10,15,20,25,30,35"
          restricted = "yes">
ORDER BY area;

--2--
select * from tree_planting_projects
where EXTRACT(YEAR FROM start_date)  = &<name="year"
 list="select distinct EXTRACT(YEAR FROM start_date)as year from tree_planting_projects order by year"
 type = string
  hint = "planting projects that start in a certain month and year"
 restricted = "yes"> 
AND  EXTRACT(MONTH FROM start_date)  = &<name="month"
 list="01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12"
 type = string
 hint = "planting projects that start in a certain month and year"
 restricted = "yes">
order by forest_id

--3--
select * from education_programs
where station_id in (
      SELECT station_id 
      from research_stations 
      where station_location = 
      &<name="city"
      list="select distinct station_location from research_stations order by station_location"
      type = string
      hint = "All education programs in chosen city"
      restricted = "yes">
      );

--4--
select trees.type, trees.forest_id, forest_name
from trees left join forests on forests.forest_id = trees.forest_id 
where origin = &<name="origin"
 list="select distinct origin from trees order by origin"
 restricted = "yes"
 type = string>
order by forest_id;




