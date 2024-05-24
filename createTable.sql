CREATE TABLE Forests
(
  forest_ID INT NOT NULL,
  forest_name VARCHAR(30) NOT NULL,
  location VARCHAR(30) NOT NULL,
  area FLOAT NOT NULL,
  PRIMARY KEY (forest_ID)
);

CREATE TABLE Research_Stations
(
  station_ID INT NOT NULL,
  station_name VARCHAR(70) NOT NULL,
  station_location VARCHAR(30) NOT NULL,
  research_subject VARCHAR(70),
  forest_ID INT NOT NULL,
  PRIMARY KEY (station_ID),
  FOREIGN KEY (forest_ID) REFERENCES Forests(forest_ID)
);

CREATE TABLE Forest_Fire_Prevention_Actions
(
  action_ID INT NOT NULL,
  action_name VARCHAR(70) NOT NULL,
  cost FLOAT NOT NULL,
  action_description VARCHAR(70),
  PRIMARY KEY (action_ID)
);

CREATE TABLE Education_Programs
(
  program_ID INT NOT NULL,
  program_name VARCHAR(70) NOT NULL,
  program_description VARCHAR(70),
  ages VARCHAR(30) NOT NULL,
  station_ID INT NOT NULL,
  PRIMARY KEY (program_ID),
  FOREIGN KEY (station_ID) REFERENCES Research_Stations(station_ID)
);

CREATE TABLE Tree_Planting_Projects
(
  planting_ID INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  forest_ID INT NOT NULL,
  PRIMARY KEY (planting_ID)
);

CREATE TABLE Trees
(
  tree_ID INT NOT NULL,
  type VARCHAR(30) NOT NULL,
  origin VARCHAR(30) NOT NULL,
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

CREATE TABLE Tree_Planting_Projects_donors
(
  donors VARCHAR(30) NOT NULL,
  planting_ID INT NOT NULL,
  PRIMARY KEY (donors, planting_ID),
  FOREIGN KEY (planting_ID) REFERENCES Tree_Planting_Projects(planting_ID)
);
