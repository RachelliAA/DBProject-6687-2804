CREATE TABLE Employee_At_Station
(
  station_ID INT NOT NULL,
  employee_id INT NOT NULL,
  PRIMARY KEY (station_ID, employee_id),
  FOREIGN KEY (station_ID) REFERENCES Research_Stations(station_ID),
  FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

CREATE TABLE Attends
(
  traveler_id INT NOT NULL,
  program_ID INT NOT NULL,
  PRIMARY KEY (traveler_id, program_ID),
  FOREIGN KEY (traveler_id) REFERENCES Customers(traveler_id),
  FOREIGN KEY (program_ID) REFERENCES Education_Programs(program_ID)
);

alter table trails
add forest_id number;

ALTER TABLE trails
ADD CONSTRAINT fk_trails_forests
FOREIGN KEY (forest_id)
REFERENCES forests(forest_id);

update trails
set forest_id = floor(dbms_random.value(1,401));
