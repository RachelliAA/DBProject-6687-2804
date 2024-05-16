CREATE TABLE Forests
(
  forest_ID INT NOT NULL,
  forest_name INT NOT NULL,
  location INT NOT NULL,
  area INT NOT NULL,
  PRIMARY KEY (forest_ID)
);

CREATE TABLE Research_Stations
(
  station_ID INT NOT NULL,
  station_name INT NOT NULL,
  station_location INT NOT NULL,
  research_subject INT,
  forest_ID INT NOT NULL,
  PRIMARY KEY (station_ID),
  FOREIGN KEY (forest_ID) REFERENCES Forests(forest_ID)
);

CREATE TABLE Forest_Fire_Prevention_Actions
(
  action_ID INT NOT NULL,
  action_name INT NOT NULL,
  cost INT NOT NULL,
  action_description INT,
  PRIMARY KEY (action_ID)
);

CREATE TABLE Environmental_Education_Programs
(
  program_ID INT NOT NULL,
  program_name INT NOT NULL,
  program_description INT,
  research_station_ID INT,
  station_ID INT NOT NULL,
  PRIMARY KEY (program_ID),
  FOREIGN KEY (station_ID) REFERENCES Research_Stations(station_ID)
);

CREATE TABLE Tree_Planting_Projects
(
  planting_ID INT NOT NULL,
  start_date INT NOT NULL,
  end_date INT NOT NULL,
  forest_ID INT NOT NULL,
  donors INT,
  PRIMARY KEY (planting_ID)
);

CREATE TABLE Trees
(
  tree_ID INT NOT NULL,
  type INT NOT NULL,
  origin INT NOT NULL,
  forest_ID INT NOT NULL,
  PRIMARY KEY (tree_ID, forest_ID),
  FOREIGN KEY (forest_ID) REFERENCES Forests(forest_ID)
);

CREATE TABLE HasA
(
  forest_ID INT NOT NULL,
  action_ID INT NOT NULL,
  PRIMARY KEY (forest_ID, action_ID),
  FOREIGN KEY (forest_ID) REFERENCES Forests(forest_ID),
  FOREIGN KEY (action_ID) REFERENCES Forest_Fire_Prevention_Actions(action_ID)
);

CREATE TABLE IsFor
(
  planting_ID INT NOT NULL,
  forest_ID INT NOT NULL,
  PRIMARY KEY (planting_ID, forest_ID),
  FOREIGN KEY (planting_ID) REFERENCES Tree_Planting_Projects(planting_ID),
  FOREIGN KEY (forest_ID) REFERENCES Forests(forest_ID)
);

CREATE TABLE Environmental_Education_Programs_ages
(
  ages INT NOT NULL,
  program_ID INT NOT NULL,
  PRIMARY KEY (ages, program_ID),
  FOREIGN KEY (program_ID) REFERENCES Environmental_Education_Programs(program_ID)
);