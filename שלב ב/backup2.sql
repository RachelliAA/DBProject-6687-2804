prompt PL/SQL Developer import file
prompt Created on Friday, 14 June 2024 by shani
set feedback off
set define off
prompt Creating RESEARCH_STATIONS...
create table RESEARCH_STATIONS
(
  station_id       INTEGER not null,
  station_name     VARCHAR2(70) not null,
  station_location VARCHAR2(30) not null,
  research_subject VARCHAR2(70) default 'Nature' not null,
  forest_id        INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table RESEARCH_STATIONS
  add primary key (STATION_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating EDUCATION_PROGRAMS...
create table EDUCATION_PROGRAMS
(
  program_id          INTEGER not null,
  program_name        VARCHAR2(70) not null,
  program_description VARCHAR2(70),
  ages                VARCHAR2(30) default 'all' not null,
  station_id          INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EDUCATION_PROGRAMS
  add primary key (PROGRAM_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table EDUCATION_PROGRAMS
  add foreign key (STATION_ID)
  references RESEARCH_STATIONS (STATION_ID);

prompt Creating FORESTS...
create table FORESTS
(
  forest_id   INTEGER not null,
  forest_name VARCHAR2(30) not null,
  location    VARCHAR2(30) not null,
  area        FLOAT not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table FORESTS
  add primary key (FOREST_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating HASA...
create table HASA
(
  forest_id INTEGER not null,
  action_id INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HASA
  add primary key (FOREST_ID, ACTION_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HASA
  add foreign key (FOREST_ID)
  references FORESTS (FOREST_ID);

prompt Creating TREE_PLANTING_PROJECTS...
create table TREE_PLANTING_PROJECTS
(
  planting_id INTEGER not null,
  start_date  DATE not null,
  end_date    DATE not null,
  forest_id   INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TREE_PLANTING_PROJECTS
  add primary key (PLANTING_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );

prompt Creating ISFOR...
create table ISFOR
(
  planting_id INTEGER not null,
  forest_id   INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ISFOR
  add primary key (PLANTING_ID, FOREST_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table ISFOR
  add foreign key (PLANTING_ID)
  references TREE_PLANTING_PROJECTS (PLANTING_ID);
alter table ISFOR
  add foreign key (FOREST_ID)
  references FORESTS (FOREST_ID);

prompt Creating PREVENTION_ACTIONS...
create table PREVENTION_ACTIONS
(
  action_id       INTEGER not null,
  action_name     VARCHAR2(70) not null,
  cost            FLOAT not null,
  action_duration VARCHAR2(70) not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PREVENTION_ACTIONS
  add primary key (ACTION_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table PREVENTION_ACTIONS
  add constraint CHK_DURATION
  check (action_duration in ('strong protection for a long time', 'medium protection for a while', 'low protection for a short time'));

prompt Creating TREES...
create table TREES
(
  tree_id   INTEGER not null,
  type      VARCHAR2(30) not null,
  origin    VARCHAR2(30) not null,
  forest_id INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TREES
  add primary key (TREE_ID, FOREST_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TREES
  add foreign key (FOREST_ID)
  references FORESTS (FOREST_ID);

prompt Creating TREE_PLANTING_PROJECTS_DONORS...
create table TREE_PLANTING_PROJECTS_DONORS
(
  donors      VARCHAR2(30) not null,
  planting_id INTEGER not null
)
tablespace SYSTEM
  pctfree 10
  pctused 40
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TREE_PLANTING_PROJECTS_DONORS
  add primary key (DONORS, PLANTING_ID)
  using index 
  tablespace SYSTEM
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TREE_PLANTING_PROJECTS_DONORS
  add foreign key (PLANTING_ID)
  references TREE_PLANTING_PROJECTS (PLANTING_ID);

prompt Disabling triggers for RESEARCH_STATIONS...
alter table RESEARCH_STATIONS disable all triggers;
prompt Disabling triggers for EDUCATION_PROGRAMS...
alter table EDUCATION_PROGRAMS disable all triggers;
prompt Disabling triggers for FORESTS...
alter table FORESTS disable all triggers;
prompt Disabling triggers for HASA...
alter table HASA disable all triggers;
prompt Disabling triggers for TREE_PLANTING_PROJECTS...
alter table TREE_PLANTING_PROJECTS disable all triggers;
prompt Disabling triggers for ISFOR...
alter table ISFOR disable all triggers;
prompt Disabling triggers for PREVENTION_ACTIONS...
alter table PREVENTION_ACTIONS disable all triggers;
prompt Disabling triggers for TREES...
alter table TREES disable all triggers;
prompt Disabling triggers for TREE_PLANTING_PROJECTS_DONORS...
alter table TREE_PLANTING_PROJECTS_DONORS disable all triggers;
prompt Disabling foreign key constraints for EDUCATION_PROGRAMS...
alter table EDUCATION_PROGRAMS disable constraint SYS_C007409;
prompt Disabling foreign key constraints for HASA...
alter table HASA disable constraint SYS_C007437;
prompt Disabling foreign key constraints for ISFOR...
alter table ISFOR disable constraint SYS_C007421;
alter table ISFOR disable constraint SYS_C007438;
prompt Disabling foreign key constraints for TREES...
alter table TREES disable constraint SYS_C007439;
prompt Disabling foreign key constraints for TREE_PLANTING_PROJECTS_DONORS...
alter table TREE_PLANTING_PROJECTS_DONORS disable constraint SYS_C007430;
prompt Loading RESEARCH_STATIONS...
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (1, 'Forest Ecology Station', 'Seattle', 'Forest Ecology', 135);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (2, 'Tree Growth Research Center', 'Boston', 'Tree Growth', 28);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (3, 'Conservation Biology Lab', 'San Francisco', 'Conservation Biology', 64);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (4, 'Forest Genetics Institute', 'Portland', 'Forest Genetics', 150);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (5, 'Arboreal Studies Center', 'Denver', 'Arboreal Studies', 192);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (6, 'Tree Physiology Lab', 'Chicago', 'Tree Physiology', 89);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (7, 'Woodland Research Facility', 'Austin', 'Woodland Ecology', 77);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (8, 'Forest Pathology Lab', 'Miami', 'Forest Pathology', 105);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (9, 'Urban Forestry Research Center', 'New York', 'Urban Forestry', 53);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (10, 'Boreal Forest Research Institute', 'Anchorage', 'Boreal Forests', 181);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (11, 'Temperate Forest Studies Station', 'Philadelphia', 'Temperate Forests', 34);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (12, 'Tree Biomechanics Lab', 'Los Angeles', 'Tree Biomechanics', 71);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (13, 'Forest Biodiversity Center', 'Houston', 'Forest Biodiversity', 199);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (14, 'Tropical Forest Research Institute', 'Honolulu', 'Tropical Forests', 138);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (15, 'Forest Hydrology Lab', 'Atlanta', 'Forest Hydrology', 45);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (16, 'Tree Disease Control Center', 'New Orleans', 'Tree Disease Control', 112);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (17, 'Silviculture Research Station', 'Richmond', 'Silviculture', 29);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (18, 'Agroforestry Research Lab', 'Sacramento', 'Agroforestry', 87);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (19, 'Forest Fire Management Center', 'Phoenix', 'Forest Fire Management', 158);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (20, 'Tree Ecology Research Facility', 'Las Vegas', 'Tree Ecology', 49);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (21, 'Forest Resources Institute', 'San Diego', 'Forest Resources', 123);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (22, 'Wildlife and Forests Lab', 'Dallas', 'Wildlife and Forests', 193);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (23, 'Forest Soil Science Center', 'San Jose', 'Forest Soil Science', 17);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (24, 'Tree Health Monitoring Lab', 'Tampa', 'Tree Health Monitoring', 61);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (25, 'Forestry and Climate Change Center', 'Orlando', 'Forestry and Climate Change', 95);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (26, 'Forest Products Research Facility', 'Minneapolis', 'Forest Products', 102);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (27, 'Conifer Research Station', 'Detroit', 'Conifer Studies', 44);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (28, 'Forest Restoration Lab', 'Columbus', 'Forest Restoration', 169);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (29, 'Tree Genetics and Breeding Center', 'Indianapolis', 'Tree Breeding', 57);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (30, 'Forest Canopy Research Institute', 'Charlotte', 'Forest Canopy', 142);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (31, 'Ecological Forestry Lab', 'Milwaukee', 'Ecological Forestry', 119);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (32, 'Forest Carbon Sequestration Center', 'San Antonio', 'Carbon Sequestration', 131);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (33, 'Tree and Shrub Research Facility', 'El Paso', 'Shrub Ecology', 58);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (34, 'Forest Insect Lab', 'Kansas City', 'Forest Entomology', 93);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (35, 'Woodland Habitat Research Station', 'Fort Worth', 'Woodland Habitats', 170);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (36, 'Forest Climate Adaptation Center', 'Oklahoma City', 'Climate Adaptation', 106);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (37, 'Forest Dynamics Lab', 'Memphis', 'Forest Dynamics', 65);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (38, 'Urban Tree Research Institute', 'Jacksonville', 'Urban Trees', 148);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (39, 'Tree Anatomy and Physiology Lab', 'Baltimore', 'Tree Anatomy', 16);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (40, 'Forest Conservation Strategies Center', 'Nashville', 'Conservation Strategies', 83);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (41, 'Tree Species Diversity Lab', 'San Bernardino', 'Species Diversity', 197);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (42, 'Forest Restoration and Reclamation Lab', 'Albuquerque', 'Forest Reclamation', 38);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (43, 'Forest Ecosystem Services Research Facility', 'Louisville', 'Ecosystem Services', 187);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (44, 'Forest Nutrient Cycling Lab', 'Tucson', 'Nutrient Cycling', 13);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (45, 'Forest Microbiology Research Station', 'Omaha', 'Forest Microbiology', 114);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (46, 'Forest Disturbance Lab', 'Newark', 'Forest Disturbances', 76);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (47, 'Tree Population Genetics Center', 'Toledo', 'Population Genetics', 54);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (48, 'Forest Ecosystem Health Lab', 'Buffalo', 'Ecosystem Health', 96);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (49, 'Forest Productivity Research Station', 'St. Louis', 'Forest Productivity', 41);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (50, 'Forest Biotechnology Center', 'Orlando', 'Forest Biotechnology', 137);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (51, 'Woodland Management Lab', 'Riverside', 'Woodland Management', 23);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (52, 'Forest Policy and Economics Research Facility', 'Lexington', 'Forest Policy', 190);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (53, 'Forest Plantations Research Lab', 'Stockton', 'Forest Plantations', 48);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (54, 'Forest and Watershed Management Institute', 'Cincinnati', 'Watershed Management', 77);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (55, 'Tree Root Biology Lab', 'Corpus Christi', 'Root Biology', 25);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (56, 'Forest Wildlife Habitat Center', 'Newark', 'Wildlife Habitat', 111);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (57, 'Urban Woodland Research Facility', 'Fremont', 'Urban Woodlands', 40);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (58, 'Forest Health and Protection Lab', 'Henderson', 'Forest Protection', 147);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (59, 'Woodland Carbon Research Station', 'Laredo', 'Woodland Carbon', 10);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (60, 'Forest Ecosystem Monitoring Lab', 'Madison', 'Ecosystem Monitoring', 3);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (61, 'Urban and Community Forestry Research Institute', 'Scottsdale', 'Community Forestry', 180);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (62, 'Forest and Fire Ecology Lab', 'Baton Rouge', 'Fire Ecology', 50);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (63, 'Forest Monitoring and Assessment Center', 'Durham', 'Forest Assessment', 85);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (64, 'Tree and Forest Genetics Lab', 'Garland', 'Genetics', 194);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (65, 'Forest Health and Restoration Center', 'Glendale', 'Health and Restoration', 21);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (66, 'Forest Water Management Lab', 'Hialeah', 'Water Management', 84);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (67, 'Forest Pathogen Research Institute', 'Chesapeake', 'Pathogen Research', 127);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (68, 'Forest Herbivory Research Station', 'Irving', 'Herbivory', 56);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (69, 'Forest Biomass Research Lab', 'Greensboro', 'Forest Biomass', 134);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (70, 'Forest and Tree Canopy Center', 'North Las Vegas', 'Tree Canopy', 193);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (71, 'Urban Tree Health Research Facility', 'Chula Vista', 'Urban Tree Health', 6);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (72, 'Forest and Range Management Center', 'Reno', 'Range Management', 26);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (73, 'Forest and Woodland Fire Lab', 'Chandler', 'Woodland Fire', 77);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (74, 'Forest Water Resources Research Station', 'Lubbock', 'Water Resources', 42);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (75, 'Forest and Grassland Ecology Lab', 'Spokane', 'Grassland Ecology', 131);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (76, 'Urban Forest Sustainability Center', 'Irvine', 'Urban Sustainability', 105);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (77, 'Forest and Tree Physiology Lab', 'Modesto', 'Tree Physiology', 32);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (78, 'Forest Soil and Tree Nutrition Lab', 'Huntington Beach', 'Tree Nutrition', 171);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (79, 'Forest Productivity and Growth Research Station', 'Glendale', 'Forest Growth', 76);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (80, 'Tree and Forest Ecology Research Institute', 'Akron', 'Forest Ecology', 129);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (81, 'Forest Disturbance and Recovery Lab', 'Tallahassee', 'Disturbance and Recovery', 145);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (82, 'Tree Carbon Dynamics Research Facility', 'Amarillo', 'Carbon Dynamics', 19);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (83, 'Forest Genetics and Biotechnology Lab', 'Huntsville', 'Forest Biotechnology', 119);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (84, 'Forest Fire Behavior Research Institute', 'Montgomery', 'Fire Behavior', 4);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (85, 'Tree and Forest Entomology Lab', 'Grand Prairie', 'Forest Entomology', 178);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (86, 'Forest Hydrology and Watershed Lab', 'Overland Park', 'Watershed Studies', 99);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (87, 'Forest Pathology and Entomology Research Facility', 'Tacoma', 'Pathology and Entomology', 111);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (88, 'Urban Forest and Green Spaces Research Center', 'Knoxville', 'Green Spaces', 182);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (89, 'Forest Soil Microbiology Lab', 'Shreveport', 'Soil Microbiology', 91);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (90, 'Forest Products and Timber Research Institute', 'Augusta', 'Timber Research', 11);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (91, 'Tree and Forest Disease Resistance Lab', 'Mobile', 'Disease Resistance', 120);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (92, 'Forest Soil and Water Research Station', 'Little Rock', 'Soil and Water', 78);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (93, 'Forest Restoration and Ecology Center', 'Moreno Valley', 'Forest Restoration', 160);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (94, 'Forest Carbon and Nutrient Cycling Lab', 'Glendale', 'Carbon and Nutrient Cycling', 8);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (95, 'Urban Forest Research Station', 'Yonkers', 'Urban Forestry', 20);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (96, 'Tree and Forest Hydrology Research Facility', 'Wichita', 'Hydrology', 121);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (97, 'Forest Soil and Nutrient Research Lab', 'Birmingham', 'Nutrient Research', 97);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (98, 'Tree and Forest Carbon Sequestration Center', 'Augusta', 'Carbon Sequestration', 5);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (99, 'Forest and Wildlife Management Research Station', 'Sioux Falls', 'Wildlife Management', 62);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (100, 'Urban Forest and Tree Health Research Institute', 'Boise', 'Tree Health', 141);
commit;
prompt 100 records committed...
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (101, 'Tree and Forest Genetics Research Center', 'Santa Ana', 'Genetics Research', 48);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (102, 'Forest and Woodland Restoration Lab', 'Oxnard', 'Restoration', 86);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (103, 'Forest Ecosystem Dynamics Research Facility', 'Bakersfield', 'Ecosystem Dynamics', 124);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (104, 'Forest Fire and Tree Health Lab', 'Olympia', 'Fire and Tree Health', 15);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (105, 'Urban Tree and Forest Research Station', 'Renton', 'Urban Forestry', 77);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (106, 'Forest Water Quality Research Lab', 'Fort Lauderdale', 'Water Quality', 183);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (107, 'Tree and Forest Pathology Research Institute', 'Tempe', 'Pathology', 94);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (108, 'Forest Ecology and Conservation Center', 'Sioux Falls', 'Ecology and Conservation', 70);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (109, 'Forest Carbon and Energy Dynamics Research Lab', 'Lancaster', 'Energy Dynamics', 55);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (110, 'Urban Tree and Forest Research Facility', 'Peoria', 'Urban Research', 18);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (111, 'Forest Health and Tree Protection Lab', 'Sterling Heights', 'Health and Protection', 75);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (112, 'Tree and Forest Pathogen Research Center', 'McKinney', 'Pathogen Research', 138);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (113, 'Urban Forest and Tree Health Lab', 'Chesapeake', 'Urban Tree Health', 194);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (114, 'Forest and Tree Ecosystem Services Research Station', 'Worcester', 'Ecosystem Services', 2);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (115, 'Forest and Tree Hydrology Research Institute', 'Frisco', 'Hydrology', 115);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (116, 'Urban Forestry and Ecosystem Research Center', 'Brownsville', 'Urban Ecosystems', 96);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (117, 'Forest Products and Timber Utilization Research Lab', 'Newport News', 'Timber Utilization', 110);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (118, 'Forest Fire and Climate Research Institute', 'Newport News', 'Fire and Climate', 24);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (119, 'Forest and Tree Genomics Lab', 'High Point', 'Genomics', 137);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (120, 'Urban Forest Monitoring Research Facility', 'Billings', 'Urban Monitoring', 79);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (121, 'Forest Ecosystem Resilience Lab', 'West Covina', 'Ecosystem Resilience', 117);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (122, 'Tree and Forest Genetics Center', 'Hampton', 'Genetics', 95);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (123, 'Forest and Woodland Fire Research Facility', 'Vancouver', 'Fire Research', 153);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (124, 'Forest Health Monitoring and Management Lab', 'Columbia', 'Health Monitoring', 63);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (125, 'Tree and Forest Ecosystem Health Center', 'Lowell', 'Ecosystem Health', 84);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (126, 'Urban Tree and Forest Canopy Research Institute', 'Eugene', 'Canopy Research', 143);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (127, 'Forest Water Resources and Hydrology Lab', 'Pembroke Pines', 'Water Resources', 192);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (128, 'Forest Soil and Plant Nutrition Research Station', 'Salem', 'Soil and Nutrition', 45);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (129, 'Forest Biodiversity and Conservation Lab', 'Cape Coral', 'Biodiversity', 162);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (130, 'Urban Forestry and Tree Growth Research Facility', 'Springfield', 'Tree Growth', 99);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (131, 'Forest Pathology and Tree Disease Research Center', 'Pasadena', 'Tree Disease', 115);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (132, 'Forest Ecosystem Management Research Lab', 'Denton', 'Ecosystem Management', 33);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (133, 'Urban Tree and Woodland Research Institute', 'Victorville', 'Woodland Research', 191);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (134, 'Forest and Climate Change Adaptation Lab', 'Beaumont', 'Climate Change', 74);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (135, 'Tree and Forest Soil Health Research Center', 'Vallejo', 'Soil Health', 146);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (136, 'Forest Water Use Efficiency Lab', 'Inglewood', 'Water Use Efficiency', 19);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (137, 'Forest Ecology and Soil Science Research Station', 'Independence', 'Soil Science', 40);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (138, 'Urban Forest and Tree Growth Monitoring Lab', 'Ann Arbor', 'Tree Growth', 170);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (139, 'Forest and Woodland Health Research Institute', 'El Monte', 'Woodland Health', 122);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (140, 'Forest Dynamics and Tree Physiology Lab', 'Simi Valley', 'Dynamics and Physiology', 77);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (141, 'Forest Soil Fertility Research Lab', 'Carrollton', 'Soil Fertility', 1);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (142, 'Tree and Forest Hydrology and Soil Lab', 'Coral Springs', 'Hydrology and Soil', 81);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (143, 'Forest Insect and Disease Monitoring Research Facility', 'Odessa', 'Insect and Disease', 173);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (144, 'Forest Genetics and Tree Breeding Lab', 'Antioch', 'Tree Breeding', 25);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (145, 'Urban Tree and Forest Conservation Research Center', 'Green Bay', 'Conservation', 138);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (146, 'Forest Ecology and Tree Biomechanics Lab', 'Everett', 'Tree Biomechanics', 69);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (147, 'Forest Fire and Management Research Station', 'West Jordan', 'Fire Management', 147);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (148, 'Tree and Forest Biodiversity Research Facility', 'Richmond', 'Forest Biodiversity', 13);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (149, 'Urban Tree Health Monitoring Lab', 'Clearwater', 'Tree Health Monitoring', 33);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (150, 'Forest Ecosystem Restoration and Fire Lab', 'Manchester', 'Ecosystem Restoration', 37);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (151, 'Forest and Soil Hydrology Research Institute', 'Westminster', 'Soil Hydrology', 82);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (152, 'Forest Fire and Ecology Research Lab', 'Murfreesboro', 'Fire Ecology', 27);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (153, 'Tree and Forest Genetics and Breeding Center', 'Miramar', 'Genetics and Breeding', 166);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (154, 'Forest Water and Soil Quality Research Station', 'College Station', 'Water and Soil Quality', 58);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (155, 'Urban Forestry and Green Infrastructure Lab', 'Costa Mesa', 'Green Infrastructure', 67);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (156, 'Forest Ecosystem and Tree Health Research Center', 'Sparks', 'Ecosystem and Health', 131);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (157, 'Forest Pathology and Tree Health Monitoring Lab', 'Miami Gardens', 'Tree Health Monitoring', 159);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (158, 'Urban Tree and Forest Ecology Research Facility', 'Blaine', 'Urban Ecology', 66);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (159, 'Forest and Tree Canopy Monitoring Research Institute', 'Concord', 'Canopy Monitoring', 174);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (160, 'Forest and Soil Nutrient Dynamics Lab', 'Bellevue', 'Nutrient Dynamics', 102);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (161, 'Urban Forest and Ecosystem Health Research Station', 'South Bend', 'Ecosystem Health', 51);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (162, 'Forest and Tree Genetics Research Facility', 'Tracy', 'Genetics Research', 76);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (163, 'Urban Forest and Tree Canopy Lab', 'West Valley City', 'Tree Canopy', 8);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (164, 'Forest Soil and Water Research Institute', 'Broken Arrow', 'Soil and Water', 145);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (165, 'Tree and Forest Ecosystem Dynamics Research Lab', 'Clovis', 'Ecosystem Dynamics', 190);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (166, 'Forest and Tree Health Monitoring Center', 'Pueblo', 'Tree Health', 5);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (167, 'Urban Forestry and Ecosystem Services Research Institute', 'San Buenaventura', 'Ecosystem Services', 184);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (168, 'Forest Genetics and Genomics Research Lab', 'North Charleston', 'Genomics', 99);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (169, 'Forest and Tree Ecosystem Management Center', 'San Mateo', 'Ecosystem Management', 47);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (170, 'Forest Pathology and Disease Research Station', 'Fargo', 'Disease Research', 14);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (171, 'Urban Forest Monitoring and Assessment Lab', 'Norwalk', 'Urban Monitoring', 132);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (172, 'Tree and Forest Hydrology Research Facility', 'Fort Smith', 'Hydrology', 70);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (173, 'Forest and Woodland Carbon Research Institute', 'El Cajon', 'Carbon Research', 146);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (174, 'Forest and Tree Soil Quality Lab', 'Burbank', 'Soil Quality', 17);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (175, 'Urban Forest and Green Spaces Monitoring Center', 'Daly City', 'Green Spaces', 183);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (176, 'Forest and Tree Health Research Lab', 'Richardson', 'Tree Health', 61);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (177, 'Forest Water Use Research Station', 'Pompano Beach', 'Water Use', 152);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (178, 'Urban Forestry and Ecosystem Monitoring Lab', 'Round Rock', 'Ecosystem Monitoring', 9);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (179, 'Forest and Tree Biodiversity Research Lab', 'North Richland Hills', 'Biodiversity', 101);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (180, 'Forest Health and Restoration Research Institute', 'Annandale', 'Restoration', 188);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (181, 'Tree and Forest Genetics Research Station', 'Las Cruces', 'Genetics Research', 95);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (182, 'Forest Fire and Ecosystem Dynamics Lab', 'Largo', 'Ecosystem Dynamics', 72);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (183, 'Forest and Tree Soil Health Research Institute', 'Warwick', 'Soil Health', 185);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (184, 'Urban Forest and Tree Growth Research Lab', 'Cambridge', 'Tree Growth', 144);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (185, 'Forest and Tree Canopy Dynamics Research Station', 'Mission Viejo', 'Canopy Dynamics', 116);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (186, 'Urban Forestry and Ecosystem Health Lab', 'New Bedford', 'Ecosystem Health', 103);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (187, 'Forest Pathology and Tree Disease Lab', 'Vacaville', 'Tree Disease', 78);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (188, 'Forest Genetics and Biotechnology Research Institute', 'San Angelo', 'Biotechnology', 31);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (189, 'Urban Forest and Tree Species Diversity Research Center', 'Bend', 'Species Diversity', 50);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (190, 'Forest and Tree Genetics and Breeding Research Facility', 'Longview', 'Tree Breeding', 115);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (191, 'Forest Health and Ecosystem Restoration Lab', 'Meridian', 'Ecosystem Restoration', 188);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (192, 'Tree and Forest Water Resources Research Center', 'Champaign', 'Water Resources', 100);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (193, 'Forest and Tree Health Monitoring Lab', 'Stamford', 'Health Monitoring', 57);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (194, 'Urban Forestry and Tree Pathology Research Station', 'Fishers', 'Pathology Research', 135);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (195, 'Forest Ecosystem and Soil Health Research Facility', 'Roseville', 'Soil Health', 28);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (196, 'Forest Pathology and Tree Disease Control Lab', 'Davie', 'Tree Disease Control', 42);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (197, 'Urban Forest and Tree Health Research Institute', 'Orem', 'Tree Health', 98);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (198, 'Forest and Tree Canopy Research Lab', 'Lehi', 'Canopy Research', 167);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (199, 'Forest Ecosystem Monitoring and Assessment Lab', 'Kirkland', 'Ecosystem Monitoring', 126);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (200, 'Forest Ecology Station', 'Seattle', 'Forest Ecology', 282);
commit;
prompt 200 records committed...
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (201, 'Tree Growth Research Center', 'Boston', 'Tree Growth', 256);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (202, 'Conservation Biology Lab', 'San Francisco', 'Conservation Biology', 278);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (203, 'Forest Genetics Institute', 'Portland', 'Forest Genetics', 307);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (204, 'Arboreal Studies Center', 'Denver', 'Arboreal Studies', 217);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (205, 'Tree Physiology Lab', 'Chicago', 'Tree Physiology', 357);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (206, 'Woodland Research Facility', 'Austin', 'Woodland Ecology', 239);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (207, 'Forest Pathology Lab', 'Miami', 'Forest Pathology', 311);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (208, 'Urban Forestry Research Center', 'New York', 'Urban Forestry', 304);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (209, 'Boreal Forest Research Institute', 'Anchorage', 'Boreal Forests', 311);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (210, 'Temperate Forest Studies Station', 'Philadelphia', 'Temperate Forests', 226);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (211, 'Tree Biomechanics Lab', 'Los Angeles', 'Tree Biomechanics', 391);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (212, 'Forest Biodiversity Center', 'Houston', 'Forest Biodiversity', 218);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (213, 'Tropical Forest Research Institute', 'Honolulu', 'Tropical Forests', 396);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (214, 'Forest Hydrology Lab', 'Atlanta', 'Forest Hydrology', 268);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (215, 'Tree Disease Control Center', 'New Orleans', 'Tree Disease Control', 308);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (216, 'Silviculture Research Station', 'Richmond', 'Silviculture', 293);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (217, 'Agroforestry Research Lab', 'Sacramento', 'Agroforestry', 369);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (218, 'Forest Fire Management Center', 'Phoenix', 'Forest Fire Management', 278);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (219, 'Tree Ecology Research Facility', 'Las Vegas', 'Tree Ecology', 360);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (220, 'Forest Resources Institute', 'San Diego', 'Forest Resources', 288);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (221, 'Wildlife and Forests Lab', 'Dallas', 'Wildlife and Forests', 272);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (222, 'Forest Soil Science Center', 'San Jose', 'Forest Soil Science', 399);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (223, 'Tree Health Monitoring Lab', 'Tampa', 'Tree Health Monitoring', 239);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (224, 'Forestry and Climate Change Center', 'Orlando', 'Forestry and Climate Change', 316);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (225, 'Forest Products Research Facility', 'Minneapolis', 'Forest Products', 399);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (226, 'Conifer Research Station', 'Detroit', 'Conifer Studies', 367);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (227, 'Forest Restoration Lab', 'Columbus', 'Forest Restoration', 213);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (228, 'Tree Genetics and Breeding Center', 'Indianapolis', 'Tree Breeding', 332);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (229, 'Forest Canopy Research Institute', 'Charlotte', 'Forest Canopy', 284);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (230, 'Ecological Forestry Lab', 'Milwaukee', 'Ecological Forestry', 279);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (231, 'Forest Carbon Sequestration Center', 'San Antonio', 'Carbon Sequestration', 283);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (232, 'Tree and Shrub Research Facility', 'El Paso', 'Shrub Ecology', 303);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (233, 'Forest Insect Lab', 'Kansas City', 'Forest Entomology', 220);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (234, 'Woodland Habitat Research Station', 'Fort Worth', 'Woodland Habitats', 292);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (235, 'Forest Climate Adaptation Center', 'Oklahoma City', 'Climate Adaptation', 260);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (236, 'Forest Dynamics Lab', 'Memphis', 'Forest Dynamics', 383);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (237, 'Urban Tree Research Institute', 'Jacksonville', 'Urban Trees', 286);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (238, 'Tree Anatomy and Physiology Lab', 'Baltimore', 'Tree Anatomy', 336);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (239, 'Forest Conservation Strategies Center', 'Nashville', 'Conservation Strategies', 367);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (240, 'Tree Species Diversity Lab', 'San Bernardino', 'Species Diversity', 389);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (241, 'Forest Restoration and Reclamation Lab', 'Albuquerque', 'Forest Reclamation', 306);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (242, 'Forest Ecosystem Services Research Facility', 'Louisville', 'Ecosystem Services', 382);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (243, 'Forest Nutrient Cycling Lab', 'Tucson', 'Nutrient Cycling', 355);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (244, 'Forest Microbiology Research Station', 'Omaha', 'Forest Microbiology', 304);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (245, 'Forest Disturbance Lab', 'Newark', 'Forest Disturbances', 302);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (246, 'Tree Population Genetics Center', 'Toledo', 'Population Genetics', 393);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (247, 'Forest Ecosystem Health Lab', 'Buffalo', 'Ecosystem Health', 261);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (248, 'Forest Productivity Research Station', 'St. Louis', 'Forest Productivity', 246);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (249, 'Forest Biotechnology Center', 'Orlando', 'Forest Biotechnology', 360);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (250, 'Woodland Management Lab', 'Riverside', 'Woodland Management', 270);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (251, 'Forest Policy and Economics Research Facility', 'Lexington', 'Forest Policy', 241);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (252, 'Forest Plantations Research Lab', 'Stockton', 'Forest Plantations', 265);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (253, 'Forest and Watershed Management Institute', 'Cincinnati', 'Watershed Management', 299);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (254, 'Tree Root Biology Lab', 'Corpus Christi', 'Root Biology', 247);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (255, 'Forest Wildlife Habitat Center', 'Newark', 'Wildlife Habitat', 372);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (256, 'Urban Woodland Research Facility', 'Fremont', 'Urban Woodlands', 352);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (257, 'Forest Health and Protection Lab', 'Henderson', 'Forest Protection', 362);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (258, 'Woodland Carbon Research Station', 'Laredo', 'Woodland Carbon', 367);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (259, 'Forest Ecosystem Monitoring Lab', 'Madison', 'Ecosystem Monitoring', 362);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (260, 'Urban and Community Forestry Research Institute', 'Scottsdale', 'Community Forestry', 379);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (261, 'Forest and Fire Ecology Lab', 'Baton Rouge', 'Fire Ecology', 257);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (262, 'Forest Monitoring and Assessment Center', 'Durham', 'Forest Assessment', 230);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (263, 'Tree and Forest Genetics Lab', 'Garland', 'Genetics', 303);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (264, 'Forest Health and Restoration Center', 'Glendale', 'Health and Restoration', 318);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (265, 'Forest Water Management Lab', 'Hialeah', 'Water Management', 210);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (266, 'Forest Pathogen Research Institute', 'Chesapeake', 'Pathogen Research', 293);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (267, 'Forest Herbivory Research Station', 'Irving', 'Herbivory', 300);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (268, 'Forest Biomass Research Lab', 'Greensboro', 'Forest Biomass', 238);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (269, 'Forest and Tree Canopy Center', 'North Las Vegas', 'Tree Canopy', 216);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (270, 'Urban Tree Health Research Facility', 'Chula Vista', 'Urban Tree Health', 391);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (271, 'Forest and Range Management Center', 'Reno', 'Range Management', 280);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (272, 'Forest and Woodland Fire Lab', 'Chandler', 'Woodland Fire', 222);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (273, 'Forest Water Resources Research Station', 'Lubbock', 'Water Resources', 394);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (274, 'Forest and Grassland Ecology Lab', 'Spokane', 'Grassland Ecology', 214);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (275, 'Urban Forest Sustainability Center', 'Irvine', 'Urban Sustainability', 337);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (276, 'Forest and Tree Physiology Lab', 'Modesto', 'Tree Physiology', 379);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (277, 'Forest Soil and Tree Nutrition Lab', 'Huntington Beach', 'Tree Nutrition', 267);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (278, 'Forest Productivity and Growth Research Station', 'Glendale', 'Forest Growth', 233);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (279, 'Tree and Forest Ecology Research Institute', 'Akron', 'Forest Ecology', 302);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (280, 'Forest Disturbance and Recovery Lab', 'Tallahassee', 'Disturbance and Recovery', 238);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (281, 'Tree Carbon Dynamics Research Facility', 'Amarillo', 'Carbon Dynamics', 285);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (282, 'Forest Genetics and Biotechnology Lab', 'Huntsville', 'Forest Biotechnology', 356);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (283, 'Forest Fire Behavior Research Institute', 'Montgomery', 'Fire Behavior', 336);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (284, 'Tree and Forest Entomology Lab', 'Grand Prairie', 'Forest Entomology', 241);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (285, 'Forest Hydrology and Watershed Lab', 'Overland Park', 'Watershed Studies', 386);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (286, 'Forest Pathology and Entomology Research Facility', 'Tacoma', 'Pathology and Entomology', 319);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (287, 'Urban Forest and Green Spaces Research Center', 'Knoxville', 'Green Spaces', 229);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (288, 'Forest Soil Microbiology Lab', 'Shreveport', 'Soil Microbiology', 354);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (289, 'Forest Products and Timber Research Institute', 'Augusta', 'Timber Research', 304);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (290, 'Tree and Forest Disease Resistance Lab', 'Mobile', 'Disease Resistance', 293);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (291, 'Forest Soil and Water Research Station', 'Little Rock', 'Soil and Water', 372);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (292, 'Forest Restoration and Ecology Center', 'Moreno Valley', 'Forest Restoration', 216);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (293, 'Forest Carbon and Nutrient Cycling Lab', 'Glendale', 'Carbon and Nutrient Cycling', 390);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (294, 'Urban Forest Research Station', 'Yonkers', 'Urban Forestry', 393);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (295, 'Tree and Forest Hydrology Research Facility', 'Wichita', 'Hydrology', 380);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (296, 'Forest Soil and Nutrient Research Lab', 'Birmingham', 'Nutrient Research', 235);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (297, 'Tree and Forest Carbon Sequestration Center', 'Augusta', 'Carbon Sequestration', 274);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (298, 'Forest and Wildlife Management Research Station', 'Sioux Falls', 'Wildlife Management', 210);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (299, 'Urban Forest and Tree Health Research Institute', 'Boise', 'Tree Health', 395);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (300, 'Tree and Forest Genetics Research Center', 'Santa Ana', 'Genetics Research', 301);
commit;
prompt 300 records committed...
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (301, 'Forest and Woodland Restoration Lab', 'Oxnard', 'Restoration', 293);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (302, 'Forest Ecosystem Dynamics Research Facility', 'Bakersfield', 'Ecosystem Dynamics', 257);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (303, 'Forest Fire and Tree Health Lab', 'Olympia', 'Fire and Tree Health', 276);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (304, 'Urban Tree and Forest Research Station', 'Renton', 'Urban Forestry', 292);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (305, 'Forest Water Quality Research Lab', 'Fort Lauderdale', 'Water Quality', 204);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (306, 'Tree and Forest Pathology Research Institute', 'Tempe', 'Pathology', 288);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (307, 'Forest Ecology and Conservation Center', 'Sioux Falls', 'Ecology and Conservation', 240);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (308, 'Forest Carbon and Energy Dynamics Research Lab', 'Lancaster', 'Energy Dynamics', 275);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (309, 'Urban Tree and Forest Research Facility', 'Peoria', 'Urban Research', 367);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (310, 'Forest Health and Tree Protection Lab', 'Sterling Heights', 'Health and Protection', 277);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (311, 'Tree and Forest Pathogen Research Center', 'McKinney', 'Pathogen Research', 258);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (312, 'Urban Forest and Tree Health Lab', 'Chesapeake', 'Urban Tree Health', 302);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (313, 'Forest and Tree Ecosystem Services Research Station', 'Worcester', 'Ecosystem Services', 382);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (314, 'Forest and Tree Hydrology Research Institute', 'Frisco', 'Hydrology', 301);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (315, 'Urban Forestry and Ecosystem Research Center', 'Brownsville', 'Urban Ecosystems', 354);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (316, 'Forest Products and Timber Utilization Research Lab', 'Newport', 'Timber Utilization', 241);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (317, 'Forest and Tree Hydrology Research Station', 'Boulder', 'Hydrology', 265);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (318, 'Urban Forestry Research Institute', 'Midland', 'Urban Forestry', 380);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (319, 'Forest Ecology and Management Lab', 'Charleston', 'Ecosystem Management', 330);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (320, 'Tree and Forest Genetics Research Facility', 'Columbia', 'Genetics Research', 233);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (321, 'Forest Soil Science Research Station', 'Santa Maria', 'Soil Science', 301);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (322, 'Urban Tree and Forest Research Center', 'Springfield', 'Urban Forestry', 358);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (323, 'Forest Climate Change Adaptation Lab', 'Brownsville', 'Climate Change', 278);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (324, 'Tree and Forest Canopy Research Institute', 'Jacksonville', 'Canopy Research', 328);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (325, 'Forest Hydrology and Soil Research Center', 'Sioux City', 'Soil Hydrology', 219);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (326, 'Urban Forest and Tree Health Research Lab', 'Santa Clarita', 'Tree Health', 320);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (327, 'Forest Pathology and Tree Disease Control Institute', 'McKinney', 'Tree Disease', 298);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (328, 'Forest Ecosystem Services Research Lab', 'Fargo', 'Ecosystem Services', 258);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (329, 'Urban Tree and Forest Research Facility', 'Carrollton', 'Urban Forestry', 366);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (330, 'Tree Physiology and Genetics Research Center', 'Waco', 'Tree Physiology', 262);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (331, 'Forest Soil Fertility Lab', 'Carlsbad', 'Soil Fertility', 357);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (332, 'Urban Forestry and Tree Growth Research Lab', 'Westminster', 'Tree Growth', 247);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (333, 'Forest Biodiversity and Conservation Institute', 'Boulder', 'Biodiversity', 309);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (334, 'Forest Fire and Ecology Research Center', 'Waterbury', 'Fire and Ecology', 369);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (335, 'Tree and Forest Health Research Facility', 'West Jordan', 'Forest Health', 276);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (336, 'Urban Tree and Forest Hydrology Research Lab', 'Beaumont', 'Hydrology', 281);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (337, 'Forest Dynamics Research Station', 'Roseville', 'Forest Dynamics', 235);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (338, 'Urban Forestry and Tree Research Institute', 'Miami', 'Urban Forestry', 343);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (339, 'Forest and Woodland Fire Research Lab', 'South Bend', 'Woodland Fire', 337);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (340, 'Tree and Forest Carbon Research Center', 'Tyler', 'Carbon Research', 372);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (341, 'Forest Ecosystem Monitoring Lab', 'West Covina', 'Ecosystem Monitoring', 289);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (342, 'Forest and Tree Health Monitoring Station', 'Billings', 'Health Monitoring', 282);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (343, 'Forest Pathology Research Center', 'Richmond', 'Pathology', 210);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (344, 'Urban Forestry and Ecosystem Health Lab', 'Lowell', 'Ecosystem Health', 290);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (345, 'Forest and Tree Canopy Research Facility', 'Eugene', 'Canopy Research', 398);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (346, 'Forest and Tree Hydrology Research Station', 'Pembroke Pines', 'Hydrology', 353);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (347, 'Forest Soil and Plant Nutrition Lab', 'Salem', 'Soil Nutrition', 345);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (348, 'Forest Biodiversity Research Center', 'Cape Coral', 'Biodiversity', 367);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (349, 'Urban Tree and Forest Growth Research Institute', 'Springfield', 'Tree Growth', 301);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (350, 'Forest Pathology and Tree Disease Lab', 'Pasadena', 'Tree Disease', 269);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (351, 'Forest Ecosystem Management Lab', 'Denton', 'Ecosystem Management', 355);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (352, 'Urban Tree and Woodland Research Center', 'Victorville', 'Woodland Research', 391);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (353, 'Forest and Climate Change Adaptation Research Station', 'Beaumont', 'Climate Change', 260);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (354, 'Tree and Forest Soil Health Lab', 'Vallejo', 'Soil Health', 327);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (355, 'Forest Water Use Efficiency Research Center', 'Inglewood', 'Water Use Efficiency', 382);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (356, 'Forest Ecology and Soil Science Lab', 'Independence', 'Soil Science', 300);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (357, 'Urban Forest and Tree Growth Monitoring Lab', 'Ann Arbor', 'Tree Growth', 289);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (358, 'Forest and Woodland Health Research Institute', 'El Monte', 'Woodland Health', 366);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (359, 'Forest Dynamics and Tree Physiology Research Center', 'Simi Valley', 'Dynamics and Physiology', 283);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (360, 'Forest Soil Fertility Research Lab', 'Carrollton', 'Soil Fertility', 387);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (361, 'Tree and Forest Hydrology and Soil Lab', 'Coral Springs', 'Hydrology and Soil', 258);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (362, 'Forest Insect and Disease Monitoring Research Station', 'Odessa', 'Insect and Disease', 308);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (363, 'Forest Genetics and Tree Breeding Lab', 'Antioch', 'Tree Breeding', 331);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (364, 'Urban Tree and Forest Conservation Research Center', 'Green Bay', 'Conservation', 285);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (365, 'Forest Ecology and Tree Biomechanics Lab', 'Everett', 'Tree Biomechanics', 313);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (366, 'Forest Fire and Management Research Lab', 'West Jordan', 'Fire Management', 248);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (367, 'Tree and Forest Biodiversity Research Facility', 'Richmond', 'Forest Biodiversity', 339);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (368, 'Urban Tree Health Monitoring Lab', 'Clearwater', 'Tree Health Monitoring', 392);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (369, 'Forest Ecosystem Restoration and Fire Lab', 'Manchester', 'Ecosystem Restoration', 388);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (370, 'Forest and Soil Hydrology Research Center', 'Westminster', 'Soil Hydrology', 354);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (371, 'Forest Fire and Ecology Research Station', 'Murfreesboro', 'Fire Ecology', 236);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (372, 'Tree and Forest Genetics and Breeding Center', 'Miramar', 'Genetics and Breeding', 293);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (373, 'Forest Water and Soil Quality Research Lab', 'College Station', 'Water and Soil Quality', 321);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (374, 'Urban Forestry and Green Infrastructure Lab', 'Costa Mesa', 'Green Infrastructure', 367);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (375, 'Forest Ecosystem and Tree Health Research Center', 'Sparks', 'Ecosystem and Health', 303);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (376, 'Forest Pathology and Tree Health Monitoring Lab', 'Miami Gardens', 'Tree Health Monitoring', 218);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (377, 'Urban Tree and Forest Ecology Research Institute', 'Blaine', 'Urban Ecology', 380);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (378, 'Forest and Tree Canopy Monitoring Research Center', 'Concord', 'Canopy Monitoring', 354);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (379, 'Forest and Soil Nutrient Dynamics Lab', 'Bellevue', 'Nutrient Dynamics', 234);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (380, 'Urban Forest and Ecosystem Health Research Station', 'South Bend', 'Ecosystem Health', 336);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (381, 'Forest and Tree Genetics Research Lab', 'Tracy', 'Genetics Research', 389);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (382, 'Urban Forest and Tree Canopy Lab', 'West Valley City', 'Tree Canopy', 339);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (383, 'Forest Soil and Water Research Institute', 'Broken Arrow', 'Soil and Water', 275);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (384, 'Tree and Forest Ecosystem Dynamics Research Lab', 'Clovis', 'Ecosystem Dynamics', 331);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (385, 'Forest and Tree Health Monitoring Center', 'Pueblo', 'Tree Health', 252);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (386, 'Urban Forestry and Ecosystem Services Research Institute', 'San Buenaventura', 'Ecosystem Services', 308);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (387, 'Forest Genetics and Genomics Research Lab', 'North Charleston', 'Genomics', 398);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (388, 'Forest and Tree Ecosystem Management Center', 'San Mateo', 'Ecosystem Management', 358);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (389, 'Forest Pathology and Disease Research Station', 'Fargo', 'Disease Research', 338);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (390, 'Urban Forest Monitoring and Assessment Lab', 'Norwalk', 'Urban Monitoring', 330);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (391, 'Tree and Forest Hydrology Research Facility', 'Fort Smith', 'Hydrology', 239);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (392, 'Forest and Woodland Carbon Research Institute', 'El Cajon', 'Carbon Research', 344);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (393, 'Forest and Tree Soil Quality Lab', 'Burbank', 'Soil Quality', 372);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (394, 'Urban Forest and Green Spaces Monitoring Center', 'Daly City', 'Green Spaces', 284);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (395, 'Forest and Tree Health Research Lab', 'Richardson', 'Tree Health', 390);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (396, 'Forest Water Use Research Station', 'Pompano Beach', 'Water Use', 232);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (397, 'Urban Forestry and Ecosystem Monitoring Lab', 'Round Rock', 'Ecosystem Monitoring', 256);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (398, 'Forest and Tree Biodiversity Research Lab', 'North Richland Hills', 'Biodiversity', 221);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (399, 'Forest Health and Restoration Research Institute', 'Annandale', 'Restoration', 330);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (400, 'Tree and Forest Genetics Research Station', 'Las Cruces', 'Genetics Research', 373);
commit;
prompt 400 records committed...
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (401, 'Tree and Forest Genetics and Breeding Center', 'New Orleans', 'Genetics and Breeding', 408);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (402, 'Urban Forest and Tree Canopy Lab', 'Phoenix', 'Tree Canopy', 405);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (403, 'Forest Soil and Water Research Institute', 'Kansas City', 'Soil and Water', 402);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (404, 'Forest Health and Protection Lab', 'Henderson', 'Nature', 147);
insert into RESEARCH_STATIONS (station_id, station_name, station_location, research_subject, forest_id)
values (405, 'Woodland Carbon Research Station', 'Laredo', 'null', 10);
commit;
prompt 405 records loaded
prompt Loading EDUCATION_PROGRAMS...
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (1, 'Sustainable Seeds Program', null, 'all', 284);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (2, 'Green Horizons Academy', null, 'all', 220);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (3, 'Green Horizons Academy', 'environmental science', 'all', 214);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (4, 'EcoLeaders Learning Hub', 'Biodiversity Surveys', 'toddlers', 187);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (5, 'Sustainability Quest Academy', 'Leaf Pressing', 'all', 16);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (6, 'Green Pathways Program', 'hike', 'tweens', 372);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (7, 'Nature''s Classroom Network', 'meaningful', 'toddlers', 129);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (8, 'Blue Planet Learning Center', 'history of the forest', 'family', 135);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (9, 'Sustainable Scholars Network', 'environmental science', 'tweens', 235);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (10, 'Green Pathways Program', 'wildlife observation', 'toddlers', 130);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (11, 'Sustainable Future Scholars', null, 'groups', 180);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (12, 'Wildlife Warriors Program', 'Leaf Pressing', 'teens', 357);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (13, 'EcoSavvy School Project', 'environmental science', 'schools', 266);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (14, 'EarthWise Education Initiative', 'environmental science', 'seniors', 385);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (15, 'Planet Pioneers Academy', 'guided', 'all', 184);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (16, 'Earth Guardians Academy', 'guided', 'all', 264);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (17, 'Earth Guardians Academy', 'local', 'schools', 335);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (18, 'Sustainable Seeds Program', 'Tree Identification', 'schools', 373);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (19, 'Planet Protectors Initiative', 'Forest Photography', 'all', 51);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (20, 'EcoSavvy School Project', null, 'couples', 321);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (21, 'Sustainable Scholars Network', null, 'tweens', 318);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (22, 'EcoLeaders Learning Hub', 'Soil Testing', 'all', 51);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (23, 'Green Trails Education Initiative', null, 'groups', 310);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (24, 'Green Guardians Program', 'Biodiversity Surveys', 'all', 355);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (25, 'Sustainable Seeds Program', 'meaningful', 'all', 64);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (26, 'Earth Guardians Academy', 'Insect Study', 'adults', 208);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (27, 'Eco Innovators Institute', 'Forest Photography', 'all', 272);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (28, 'Sustainability Starters Program', 'Mapping', 'schools', 198);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (29, 'EcoLeaders Learning Hub', 'wildlife observation', 'couples', 231);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (30, 'Eco Future Foundation', null, 'toddlers', 90);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (31, 'EcoVision Learning Center', 'Forest Photography', 'all', 54);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (32, 'Earth Ambassadors Program', 'adventurous', 'adults', 340);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (33, 'Eco Innovators Institute', 'Mapping', 'kids', 131);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (34, 'Sustainability Quest Academy', 'climate changes', 'teens', 351);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (35, 'Green Planet Academy', 'wildlife observation', 'seniors', 160);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (36, 'Sustainable Seeds Program', 'Insect Study', 'family', 160);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (37, 'Green Earth Explorers', 'Tree Identification', 'toddlers', 153);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (38, 'Blue Planet Learning Center', null, 'all', 164);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (39, 'Eco Innovators Institute', 'Insect Study', 'couples', 13);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (40, 'Green Trails Education Initiative', 'habitat restoration', 'kids', 281);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (41, 'EcoLeaders Learning Hub', 'wildlife observation', 'tweens', 185);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (42, 'Green Earth Explorers', 'adventurous', 'all', 352);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (43, 'Eco Pioneers Program', null, 'seniors', 296);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (44, 'Eco Explorers Club', 'guided', 'adults', 389);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (45, 'EcoSavvy School Project', 'animal habitat', 'all', 190);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (46, 'Sustainable Seeds Program', 'history of the forest', 'adults', 383);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (47, 'Eco Explorers Club', 'Insect Study', 'all', 162);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (48, 'EcoSavvy School Project', 'Survival Skills', 'all', 298);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (49, 'EcoSavvy School Project', 'local', 'adults', 172);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (50, 'EarthWise Education Initiative', 'Mapping', 'schools', 34);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (51, 'Sustainable Seeds Program', 'habitat restoration', 'all', 74);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (52, 'Eco Horizon Project', 'animal habitat', 'tweens', 182);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (53, 'EcoVision Learning Center', 'local', 'couples', 213);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (54, 'Blue Planet Learning Center', 'climate changes', 'tweens', 7);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (55, 'Sustainability Quest Academy', 'Biodiversity Surveys', 'all', 161);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (56, 'Planet Protectors Initiative', 'adventurous', 'groups', 20);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (57, 'Planet Protectors Initiative', 'climate changes', 'adults', 173);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (58, 'Green Generation Labs', 'Mapping', 'toddlers', 156);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (59, 'Green Guardians Program', 'ecosystems', 'schools', 281);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (60, 'Eco Horizon Project', 'habitat restoration', 'all', 359);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (61, 'Green Planet Academy', 'ecosystems', 'toddlers', 86);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (62, 'Earth Guardians Academy', 'Insect Study', 'toddlers', 366);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (63, 'Planet Protectors Initiative', 'Soil Testing', 'couples', 395);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (64, 'Sustainability Starters Program', 'wildlife observation', 'all', 277);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (65, 'EcoSavvy School Project', 'Survival Skills', 'kids', 122);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (66, 'Eco Future Foundation', 'history of the forest', 'groups', 246);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (67, 'Nature''s Wisdom School', 'local', 'tweens', 271);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (68, 'Nature''s Wisdom School', 'Insect Study', 'groups', 391);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (69, 'EcoLeaders Learning Hub', 'wildlife observation', 'schools', 160);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (70, 'Earth Guardians Academy', 'Soil Testing', 'all', 375);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (71, 'EcoVision Learning Center', 'Leaf Pressing', 'groups', 20);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (72, 'Green Planet Academy', 'wildlife observation', 'toddlers', 253);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (73, 'Sustainability Starters Program', 'hike', 'seniors', 287);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (74, 'Eco Horizon Project', null, 'teens', 178);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (75, 'Earth Guardians Academy', null, 'schools', 225);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (76, 'Nature''s Wisdom School', 'local', 'all', 273);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (77, 'Sustainability Starters Program', 'Leaf Pressing', 'all', 215);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (78, 'EcoLeaders Learning Hub', 'Survival Skills', 'seniors', 331);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (79, 'Green Guardians Program', 'Leaf Pressing', 'all', 192);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (80, 'Green Horizons Academy', 'ecosystems', 'tweens', 126);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (81, 'Planet Protectors Initiative', 'Night Hikes', 'tweens', 139);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (82, 'Planet Protectors Initiative', 'animal habitat', 'all', 6);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (83, 'Green Planet Academy', null, 'family', 277);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (84, 'Eco Innovators Institute', 'hike', 'seniors', 44);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (85, 'Wildlife Warriors Program', 'wildlife observation', 'teens', 65);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (86, 'Sustainable Seeds Program', 'local', 'all', 301);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (87, 'Sustainability Quest Academy', 'Survival Skills', 'all', 130);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (88, 'Planet Protectors Initiative', 'animal habitat', 'all', 37);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (89, 'Sustainable Scholars Network', 'ecosystems', 'seniors', 37);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (90, 'Green Earth Explorers', 'climate changes', 'adults', 314);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (91, 'Sustainable Seeds Program', null, 'all', 393);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (92, 'Eco Horizon Project', 'Tree Identification', 'family', 40);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (93, 'Sustainability Quest Academy', 'habitat restoration', 'all', 129);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (94, 'Eco Innovators Institute', 'Leaf Pressing', 'family', 372);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (95, 'EcoLeaders Learning Hub', 'Survival Skills', 'all', 310);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (96, 'Earth Guardians Academy', 'Insect Study', 'tweens', 171);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (97, 'Earth Guardians Academy', 'ecosystems', 'all', 66);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (98, 'Climate Champions Academy', 'history of the forest', 'schools', 228);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (99, 'EarthWise Education Initiative', 'Night Hikes', 'kids', 260);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (100, 'Eco Explorers Club', 'history of the forest', 'all', 173);
commit;
prompt 100 records committed...
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (101, 'Green Generation Labs', 'animal habitat', 'tweens', 302);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (102, 'Green Earth Explorers', 'Mapping', 'all', 12);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (103, 'Green Pathways Program', 'Mapping', 'kids', 27);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (104, 'Eco Pioneers Program', 'ecosystems', 'groups', 39);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (105, 'Eco Pioneers Program', 'Leaf Pressing', 'toddlers', 372);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (106, 'Blue Planet Learning Center', 'Night Hikes', 'teens', 232);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (107, 'Sustainable Future Scholars', 'environmental science', 'seniors', 273);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (108, 'Sustainable Future Scholars', 'local', 'family', 181);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (109, 'Sustainability Starters Program', 'ecosystems', 'family', 7);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (110, 'Nature''s Classroom Network', 'hike', 'all', 94);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (111, 'Nature''s Classroom Network', 'adventurous', 'couples', 355);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (112, 'Sustainability Quest Academy', null, 'kids', 248);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (113, 'Planet Pioneers Academy', 'habitat restoration', 'couples', 334);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (114, 'EcoLeaders Learning Hub', 'climate changes', 'family', 287);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (115, 'Green Guardians Program', 'local', 'teens', 64);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (116, 'Sustainability Quest Academy', 'environmental science', 'seniors', 309);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (117, 'EcoLeaders Learning Hub', 'environmental science', 'couples', 10);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (118, 'Green Earth Explorers', 'Forest Photography', 'toddlers', 340);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (119, 'EcoVision Learning Center', 'habitat restoration', 'kids', 244);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (120, 'Nature''s Wisdom School', null, 'toddlers', 6);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (121, 'Sustainable Seeds Program', 'Tree Identification', 'seniors', 7);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (122, 'Eco Explorers Club', 'history of the forest', 'kids', 249);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (123, 'Earth Guardians Academy', 'adventurous', 'family', 147);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (124, 'Sustainable Future Scholars', 'local', 'kids', 231);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (125, 'Green Trails Education Initiative', 'animal habitat', 'groups', 398);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (126, 'Wildlife Warriors Program', 'environmental science', 'couples', 108);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (127, 'Sustainable Seeds Program', 'ecosystems', 'all', 69);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (128, 'Green Earth Explorers', 'Night Hikes', 'teens', 278);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (129, 'Earth Guardians Academy', 'guided', 'seniors', 161);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (130, 'EarthWise Education Initiative', 'environmental science', 'toddlers', 392);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (131, 'Green Trails Education Initiative', 'ecosystems', 'groups', 159);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (132, 'Eco Explorers Club', 'Leaf Pressing', 'kids', 207);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (133, 'Green Planet Academy', null, 'teens', 297);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (134, 'Wildlife Warriors Program', null, 'seniors', 39);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (135, 'Green Pathways Program', 'environmental science', 'adults', 396);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (136, 'Green Generation Labs', 'Mapping', 'schools', 354);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (137, 'Nature''s Classroom Network', 'environmental science', 'teens', 251);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (138, 'Nature''s Classroom Network', 'climate changes', 'adults', 162);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (139, 'EcoSavvy School Project', null, 'all', 277);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (140, 'Sustainable Scholars Network', 'local', 'schools', 140);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (141, 'Green Trails Education Initiative', null, 'teens', 243);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (142, 'Sustainable Scholars Network', 'climate changes', 'adults', 299);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (143, 'Nature''s Wisdom School', 'local', 'groups', 296);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (144, 'Eco Horizon Project', 'animal habitat', 'adults', 368);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (145, 'Green Planet Academy', 'wildlife observation', 'couples', 168);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (146, 'EcoVision Learning Center', 'Night Hikes', 'toddlers', 63);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (147, 'EcoSavvy School Project', 'wildlife observation', 'teens', 214);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (148, 'Green Trails Education Initiative', 'Night Hikes', 'family', 100);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (149, 'EcoLeaders Learning Hub', 'Mapping', 'schools', 9);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (150, 'EcoVision Learning Center', 'Biodiversity Surveys', 'schools', 81);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (151, 'Green Earth Explorers', 'Survival Skills', 'all', 275);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (152, 'EcoVision Learning Center', null, 'seniors', 72);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (153, 'EcoSavvy School Project', 'Biodiversity Surveys', 'all', 128);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (154, 'EcoLeaders Learning Hub', 'ecosystems', 'seniors', 309);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (155, 'Eco Pioneers Program', 'Insect Study', 'all', 71);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (156, 'Sustainable Seeds Program', 'climate changes', 'couples', 10);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (157, 'EcoSavvy School Project', 'animal habitat', 'groups', 234);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (158, 'Eco Pioneers Program', 'guided', 'all', 370);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (159, 'Blue Planet Learning Center', 'hands-on', 'couples', 43);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (160, 'Green Horizons Academy', 'guided', 'adults', 310);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (161, 'Earth Guardians Academy', 'history of the forest', 'all', 208);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (162, 'EcoSavvy School Project', 'hands-on', 'all', 72);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (163, 'Planet Protectors Initiative', 'Soil Testing', 'couples', 119);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (164, 'Sustainability Starters Program', 'guided', 'all', 227);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (165, 'Green Generation Labs', 'environmental science', 'schools', 227);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (166, 'EarthWise Education Initiative', 'climate changes', 'all', 206);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (167, 'Blue Planet Learning Center', 'climate changes', 'kids', 26);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (168, 'EarthWise Education Initiative', 'climate changes', 'toddlers', 264);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (169, 'Eco Explorers Club', 'Soil Testing', 'all', 176);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (170, 'Earth Guardians Academy', null, 'kids', 33);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (171, 'Green Guardians Program', 'Survival Skills', 'seniors', 235);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (172, 'Green Horizons Academy', null, 'kids', 77);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (173, 'Green Planet Academy', 'guided', 'all', 247);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (174, 'Nature''s Wisdom School', 'hike', 'all', 213);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (175, 'EcoVision Learning Center', 'Survival Skills', 'kids', 259);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (176, 'Nature''s Classroom Network', 'hike', 'toddlers', 161);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (177, 'Climate Champions Academy', 'hike', 'schools', 327);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (178, 'Wildlife Warriors Program', null, 'all', 96);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (179, 'Green Guardians Program', 'Biodiversity Surveys', 'all', 341);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (180, 'Sustainability Quest Academy', 'climate changes', 'seniors', 341);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (181, 'Eco Innovators Institute', 'Survival Skills', 'family', 318);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (182, 'Sustainable Scholars Network', 'history of the forest', 'family', 285);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (183, 'Green Planet Academy', 'local', 'couples', 344);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (184, 'Nature''s Wisdom School', 'Insect Study', 'all', 7);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (185, 'Nature''s Wisdom School', 'hike', 'groups', 196);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (186, 'Eco Innovators Institute', 'meaningful', 'schools', 200);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (187, 'Nature''s Classroom Network', 'climate changes', 'teens', 4);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (188, 'Green Trails Education Initiative', 'Insect Study', 'groups', 45);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (189, 'Eco Horizon Project', 'wildlife observation', 'all', 218);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (190, 'Nature''s Wisdom School', 'animal habitat', 'kids', 381);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (191, 'EarthWise Education Initiative', 'Biodiversity Surveys', 'toddlers', 361);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (192, 'Sustainability Quest Academy', 'history of the forest', 'kids', 263);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (193, 'Green Generation Labs', 'local', 'schools', 176);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (194, 'Eco Explorers Club', null, 'schools', 57);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (195, 'Green Earth Explorers', 'environmental science', 'toddlers', 164);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (196, 'Green Earth Explorers', 'Soil Testing', 'seniors', 280);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (197, 'Green Horizons Academy', 'local', 'toddlers', 217);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (198, 'Green Guardians Program', 'hike', 'teens', 249);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (199, 'Nature''s Classroom Network', 'climate changes', 'toddlers', 216);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (200, 'Eco Horizon Project', 'Survival Skills', 'all', 353);
commit;
prompt 200 records committed...
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (201, 'EcoLeaders Learning Hub', 'local', 'tweens', 221);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (202, 'Sustainable Future Scholars', 'Leaf Pressing', 'seniors', 315);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (203, 'Green Horizons Academy', 'history of the forest', 'all', 387);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (204, 'Eco Future Foundation', 'guided', 'seniors', 358);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (205, 'Green Trails Education Initiative', 'history of the forest', 'seniors', 296);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (206, 'Sustainable Future Scholars', 'Tree Identification', 'schools', 124);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (207, 'Green Guardians Program', 'hike', 'kids', 166);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (208, 'Climate Champions Academy', 'Biodiversity Surveys', 'kids', 366);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (209, 'Green Pathways Program', null, 'teens', 28);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (210, 'EarthWise Education Initiative', 'Insect Study', 'family', 344);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (211, 'Eco Horizon Project', 'Biodiversity Surveys', 'toddlers', 194);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (212, 'Green Generation Labs', 'Night Hikes', 'all', 310);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (213, 'Green Pathways Program', 'local', 'teens', 254);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (214, 'EcoVision Learning Center', 'Insect Study', 'adults', 49);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (215, 'Sustainability Starters Program', 'Tree Identification', 'all', 15);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (216, 'Sustainability Starters Program', 'environmental science', 'all', 6);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (217, 'Planet Pioneers Academy', 'hike', 'adults', 58);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (218, 'Wildlife Warriors Program', 'adventurous', 'all', 331);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (219, 'Nature''s Classroom Network', 'Leaf Pressing', 'kids', 152);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (220, 'Sustainable Scholars Network', 'Insect Study', 'seniors', 224);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (221, 'Sustainable Seeds Program', 'local', 'kids', 379);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (222, 'Green Pathways Program', 'ecosystems', 'all', 391);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (223, 'Green Horizons Academy', 'local', 'toddlers', 365);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (224, 'Sustainability Starters Program', null, 'all', 374);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (225, 'Nature''s Wisdom School', 'Survival Skills', 'teens', 153);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (226, 'EcoLeaders Learning Hub', 'guided', 'couples', 387);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (227, 'EcoVision Learning Center', 'Biodiversity Surveys', 'all', 153);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (228, 'Green Earth Explorers', 'adventurous', 'all', 377);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (229, 'Eco Innovators Institute', 'habitat restoration', 'toddlers', 334);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (230, 'Green Pathways Program', 'hands-on', 'teens', 16);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (231, 'Sustainability Starters Program', null, 'all', 180);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (232, 'Eco Pioneers Program', 'Insect Study', 'adults', 377);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (233, 'Blue Planet Learning Center', 'history of the forest', 'family', 44);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (234, 'Climate Champions Academy', 'meaningful', 'family', 277);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (235, 'Wildlife Warriors Program', 'Leaf Pressing', 'teens', 356);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (236, 'EcoSavvy School Project', 'Biodiversity Surveys', 'all', 300);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (237, 'Eco Innovators Institute', 'local', 'couples', 291);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (238, 'Green Planet Academy', 'Soil Testing', 'teens', 30);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (239, 'Green Generation Labs', 'Leaf Pressing', 'tweens', 387);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (240, 'Nature''s Wisdom School', 'hands-on', 'all', 3);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (242, 'EcoSavvy School Project', 'Biodiversity Surveys', 'teens', 160);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (243, 'Sustainable Seeds Program', 'Survival Skills', 'all', 103);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (244, 'EcoSavvy School Project', 'animal habitat', 'family', 261);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (245, 'Green Earth Explorers', 'Tree Identification', 'all', 337);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (246, 'EcoLeaders Learning Hub', 'hike', 'adults', 24);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (247, 'Sustainable Scholars Network', 'climate changes', 'all', 35);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (248, 'Earth Guardians Academy', 'environmental science', 'schools', 103);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (249, 'Sustainability Quest Academy', 'Night Hikes', 'adults', 363);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (250, 'EcoSavvy School Project', 'local', 'teens', 154);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (251, 'Eco Horizon Project', 'history of the forest', 'teens', 302);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (252, 'Green Generation Labs', 'Night Hikes', 'adults', 32);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (253, 'Wildlife Warriors Program', 'meaningful', 'seniors', 384);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (254, 'Green Trails Education Initiative', 'Tree Identification', 'family', 310);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (255, 'EarthWise Education Initiative', 'guided', 'toddlers', 34);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (256, 'Eco Innovators Institute', 'ecosystems', 'groups', 303);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (257, 'Eco Pioneers Program', 'Insect Study', 'teens', 255);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (258, 'Earth Guardians Academy', 'hike', 'groups', 113);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (259, 'Sustainable Scholars Network', 'Survival Skills', 'all', 64);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (260, 'EcoLeaders Learning Hub', 'Mapping', 'all', 395);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (261, 'Eco Future Foundation', 'Night Hikes', 'kids', 175);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (262, 'Green Pathways Program', null, 'all', 199);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (263, 'Climate Champions Academy', 'environmental science', 'family', 227);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (264, 'EcoVision Learning Center', 'Insect Study', 'all', 67);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (265, 'Wildlife Warriors Program', 'animal habitat', 'couples', 243);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (266, 'EarthWise Education Initiative', 'local', 'all', 17);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (267, 'Eco Pioneers Program', 'history of the forest', 'seniors', 304);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (268, 'EcoSavvy School Project', 'Mapping', 'couples', 218);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (269, 'Nature''s Classroom Network', 'Insect Study', 'toddlers', 31);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (271, 'Wildlife Warriors Program', 'Survival Skills', 'seniors', 97);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (272, 'Eco Innovators Institute', 'local', 'groups', 5);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (273, 'Planet Pioneers Academy', 'wildlife observation', 'groups', 166);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (274, 'Green Generation Labs', 'Mapping', 'kids', 63);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (275, 'EcoSavvy School Project', 'meaningful', 'kids', 42);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (276, 'Climate Champions Academy', 'Forest Photography', 'all', 122);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (277, 'Sustainable Scholars Network', 'Leaf Pressing', 'teens', 185);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (278, 'Green Guardians Program', 'wildlife observation', 'tweens', 200);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (279, 'Blue Planet Learning Center', 'Mapping', 'all', 86);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (280, 'Green Trails Education Initiative', 'wildlife observation', 'groups', 15);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (281, 'Green Planet Academy', 'meaningful', 'toddlers', 312);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (282, 'EcoSavvy School Project', 'meaningful', 'all', 174);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (283, 'Eco Horizon Project', 'history of the forest', 'kids', 152);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (284, 'Climate Champions Academy', 'adventurous', 'teens', 372);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (285, 'Sustainable Future Scholars', 'wildlife observation', 'all', 243);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (286, 'Wildlife Warriors Program', 'Tree Identification', 'seniors', 273);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (287, 'Nature''s Classroom Network', null, 'toddlers', 75);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (288, 'Eco Explorers Club', 'habitat restoration', 'all', 233);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (289, 'Blue Planet Learning Center', 'Tree Identification', 'family', 188);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (290, 'Nature''s Wisdom School', 'guided', 'seniors', 287);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (291, 'Climate Champions Academy', 'Tree Identification', 'seniors', 298);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (292, 'Green Planet Academy', 'guided', 'groups', 348);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (293, 'Sustainable Scholars Network', null, 'family', 209);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (294, 'Green Horizons Academy', 'Biodiversity Surveys', 'seniors', 214);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (295, 'Sustainability Quest Academy', null, 'all', 54);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (296, 'Eco Innovators Institute', 'Night Hikes', 'couples', 188);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (297, 'Planet Protectors Initiative', 'climate changes', 'family', 331);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (298, 'Green Trails Education Initiative', 'adventurous', 'all', 231);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (299, 'Green Planet Academy', 'environmental science', 'adults', 199);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (300, 'Eco Pioneers Program', 'Forest Photography', 'teens', 380);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (301, 'Sustainability Quest Academy', 'Night Hikes', 'all', 154);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (303, 'Earth Guardians Academy', 'hike', 'teens', 371);
commit;
prompt 300 records committed...
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (304, 'Sustainability Starters Program', 'ecosystems', 'kids', 382);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (305, 'Climate Champions Academy', 'hands-on', 'all', 141);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (306, 'Earth Guardians Academy', 'wildlife observation', 'groups', 292);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (307, 'Green Earth Explorers', 'ecosystems', 'toddlers', 140);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (308, 'Eco Innovators Institute', null, 'couples', 123);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (309, 'Sustainable Future Scholars', null, 'couples', 71);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (310, 'EcoVision Learning Center', 'meaningful', 'groups', 103);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (311, 'Eco Explorers Club', 'hands-on', 'kids', 283);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (312, 'Sustainable Seeds Program', 'Night Hikes', 'couples', 213);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (313, 'Climate Champions Academy', 'environmental science', 'couples', 73);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (314, 'Planet Protectors Initiative', 'history of the forest', 'teens', 113);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (315, 'Sustainable Scholars Network', 'adventurous', 'all', 75);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (316, 'Sustainable Future Scholars', null, 'adults', 252);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (317, 'EcoSavvy School Project', 'history of the forest', 'kids', 185);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (318, 'Green Trails Education Initiative', 'Leaf Pressing', 'all', 374);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (319, 'Sustainable Seeds Program', 'Leaf Pressing', 'seniors', 135);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (320, 'Green Trails Education Initiative', 'Survival Skills', 'adults', 354);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (321, 'Sustainable Scholars Network', 'ecosystems', 'all', 195);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (322, 'Earth Ambassadors Program', 'Leaf Pressing', 'groups', 61);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (323, 'Sustainability Starters Program', 'hike', 'adults', 168);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (324, 'Green Trails Education Initiative', 'Leaf Pressing', 'family', 10);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (325, 'Eco Innovators Institute', 'habitat restoration', 'tweens', 262);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (326, 'Earth Guardians Academy', 'hike', 'schools', 355);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (327, 'EcoVision Learning Center', 'Tree Identification', 'all', 75);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (328, 'Planet Pioneers Academy', 'history of the forest', 'schools', 237);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (329, 'Planet Pioneers Academy', 'ecosystems', 'kids', 6);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (330, 'Sustainable Scholars Network', 'hike', 'all', 97);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (331, 'Wildlife Warriors Program', 'animal habitat', 'family', 309);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (332, 'EcoLeaders Learning Hub', 'climate changes', 'schools', 220);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (333, 'Sustainable Future Scholars', 'Leaf Pressing', 'all', 305);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (334, 'Blue Planet Learning Center', 'Forest Photography', 'teens', 279);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (335, 'Eco Future Foundation', 'Soil Testing', 'couples', 50);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (336, 'Green Earth Explorers', null, 'all', 271);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (337, 'Planet Protectors Initiative', 'climate changes', 'kids', 18);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (338, 'Green Guardians Program', 'climate changes', 'teens', 232);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (339, 'Green Generation Labs', 'hands-on', 'groups', 238);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (340, 'Sustainable Seeds Program', 'animal habitat', 'seniors', 268);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (341, 'EcoLeaders Learning Hub', null, 'couples', 339);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (342, 'Blue Planet Learning Center', null, 'all', 202);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (343, 'Wildlife Warriors Program', 'guided', 'couples', 162);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (344, 'Wildlife Warriors Program', 'Biodiversity Surveys', 'adults', 157);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (345, 'Sustainable Seeds Program', 'habitat restoration', 'kids', 32);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (346, 'Sustainable Seeds Program', 'Survival Skills', 'all', 234);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (347, 'Planet Protectors Initiative', 'Mapping', 'groups', 177);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (348, 'Eco Horizon Project', 'animal habitat', 'all', 191);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (349, 'Eco Innovators Institute', 'meaningful', 'family', 14);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (350, 'Sustainability Quest Academy', 'hands-on', 'all', 85);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (351, 'Sustainable Seeds Program', 'Night Hikes', 'family', 273);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (352, 'Nature''s Classroom Network', 'Survival Skills', 'adults', 343);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (353, 'Wildlife Warriors Program', 'Biodiversity Surveys', 'seniors', 332);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (354, 'Sustainable Scholars Network', 'Biodiversity Surveys', 'couples', 352);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (355, 'Green Earth Explorers', null, 'schools', 184);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (356, 'Nature''s Wisdom School', null, 'toddlers', 278);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (357, 'Eco Pioneers Program', 'meaningful', 'all', 360);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (358, 'Sustainable Scholars Network', 'meaningful', 'adults', 115);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (359, 'Sustainable Seeds Program', 'hands-on', 'toddlers', 305);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (360, 'Eco Future Foundation', 'Leaf Pressing', 'all', 239);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (361, 'Planet Pioneers Academy', 'habitat restoration', 'toddlers', 60);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (362, 'Eco Horizon Project', 'Forest Photography', 'all', 164);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (363, 'EcoLeaders Learning Hub', 'wildlife observation', 'adults', 263);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (364, 'Green Trails Education Initiative', 'Biodiversity Surveys', 'groups', 250);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (365, 'Planet Protectors Initiative', 'adventurous', 'schools', 167);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (366, 'Blue Planet Learning Center', 'local', 'teens', 11);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (367, 'Earth Guardians Academy', 'Leaf Pressing', 'family', 165);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (368, 'Nature''s Wisdom School', 'adventurous', 'all', 7);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (369, 'EarthWise Education Initiative', 'Night Hikes', 'all', 207);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (370, 'Eco Explorers Club', 'Insect Study', 'seniors', 242);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (371, 'Eco Horizon Project', 'hands-on', 'teens', 15);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (372, 'Blue Planet Learning Center', 'Biodiversity Surveys', 'family', 247);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (373, 'Blue Planet Learning Center', 'Mapping', 'couples', 212);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (374, 'Green Pathways Program', 'Night Hikes', 'all', 14);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (375, 'Sustainable Seeds Program', 'local', 'all', 346);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (376, 'Green Earth Explorers', 'Forest Photography', 'toddlers', 308);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (377, 'Green Pathways Program', null, 'all', 321);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (378, 'EcoVision Learning Center', 'Forest Photography', 'kids', 292);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (379, 'Eco Explorers Club', 'wildlife observation', 'all', 140);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (380, 'Sustainability Starters Program', 'hike', 'couples', 144);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (381, 'Sustainable Seeds Program', 'Soil Testing', 'groups', 112);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (382, 'Nature''s Classroom Network', 'Biodiversity Surveys', 'all', 41);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (383, 'Sustainability Quest Academy', null, 'toddlers', 274);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (384, 'Nature''s Wisdom School', 'Survival Skills', 'kids', 236);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (385, 'Climate Champions Academy', 'Mapping', 'kids', 184);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (386, 'Eco Pioneers Program', 'Insect Study', 'all', 44);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (387, 'Planet Pioneers Academy', 'Mapping', 'teens', 129);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (388, 'Earth Guardians Academy', 'Insect Study', 'family', 15);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (389, 'Green Horizons Academy', 'environmental science', 'couples', 289);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (390, 'Green Horizons Academy', 'Forest Photography', 'all', 29);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (391, 'Green Pathways Program', 'Leaf Pressing', 'all', 139);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (392, 'EcoLeaders Learning Hub', 'Soil Testing', 'toddlers', 15);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (393, 'Green Earth Explorers', 'environmental science', 'kids', 243);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (394, 'EcoVision Learning Center', 'Soil Testing', 'groups', 225);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (395, 'Sustainable Future Scholars', 'Leaf Pressing', 'family', 110);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (396, 'Sustainable Future Scholars', 'animal habitat', 'adults', 228);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (397, 'Sustainable Scholars Network', 'Leaf Pressing', 'seniors', 244);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (398, 'EarthWise Education Initiative', 'climate changes', 'all', 267);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (399, 'Blue Planet Learning Center', 'ecosystems', 'all', 12);
insert into EDUCATION_PROGRAMS (program_id, program_name, program_description, ages, station_id)
values (400, 'Earth Guardians Academy', 'adventurous', 'all', 338);
commit;
prompt 397 records loaded
prompt Loading FORESTS...
insert into FORESTS (forest_id, forest_name, location, area)
values (1, 'Heiligenhaus', '48.2851, 86.0435', 27.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (2, 'Coppell', '23.0428, 69.7629', 18.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (3, 'Kaunas', '43.4479, 35.0608', 16.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (4, 'Toyama', '22.5009, 90.6627', 13.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (5, 'Waldbronn', '77.4385, 86.1420', 30.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (6, 'Lengdorf', '28.7169, 29.2946', 13);
insert into FORESTS (forest_id, forest_name, location, area)
values (7, 'Lublin', '68.6345, 52.8107', 30.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (8, 'Fort McMurray', '03.0293, 01.4243', 23.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (9, 'Battle Creek', '85.9614, 45.4358', 24.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (10, 'Glendale', '74.2525, 69.8780', 23.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (11, 'Lancaster', '58.9635, 41.0436', 15.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (12, 'Birmingham', '00.0666, 09.7398', 17.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (13, 'Beaverton', '30.3850, 83.8892', 12.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (14, 'Casselberry', '21.1257, 51.5425', 25.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (15, 'Paraju', '47.5317, 98.4193', 19.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (16, 'Bham', '44.2943, 46.1077', 24.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (17, 'Salisbury', '87.3587, 00.3026', 15.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (18, 'Hartford', '87.4188, 44.8601', 26.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (19, 'Peachtree City', '40.3763, 92.9707', 18.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (20, 'Toulouse', '67.2978, 32.8240', 15.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (21, 'Duisburg', '38.2222, 02.5455', 12.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (22, 'Hackensack', '23.3749, 64.7620', 14.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (23, 'Stanford', '22.6999, 55.3305', 23.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (24, 'Batavia', '79.9624, 80.0146', 10.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (25, 'Sheffield', '22.5462, 53.5249', 28.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (26, 'Antwerpen', '54.8023, 82.7128', 20.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (27, 'Chirignago', '49.8860, 21.6353', 26.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (28, 'Archbold', '65.1040, 93.5426', 23.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (29, 'Encinitas', '53.2684, 31.4899', 10.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (30, 'Grapevine', '32.8790, 92.6779', 24.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (31, 'Montreal', '18.1494, 77.6287', 14.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (32, 'Changwon-si', '84.2606, 60.5002', 27.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (33, 'Whittier', '33.4568, 34.9961', 12.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (34, 'Alessandria', '34.8610, 31.1547', 13.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (35, 'Essen', '26.6928, 29.2926', 11.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (36, 'Hannover', '08.7595, 40.3313', 30.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (37, 'Bloemfontein', '05.2067, 61.7626', 30.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (38, 'Nynäshamn', '65.5431, 89.3592', 23.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (39, 'Santa Clarita', '50.4686, 01.4545', 15.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (40, 'Vancouver', '56.8240, 91.6644', 19.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (41, 'Elche', '18.7138, 33.6618', 14);
insert into FORESTS (forest_id, forest_name, location, area)
values (42, 'Exeter', '89.1264, 86.2338', 22.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (43, 'Bremen', '49.4126, 12.6970', 23.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (44, 'Lexington', '87.7588, 17.7160', 9.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (45, 'Silverdale', '78.6820, 14.6121', 21.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (46, 'Rua eteno', '91.3655, 67.2246', 21.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (47, 'Charleston', '31.6928, 83.5098', 21.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (48, 'San Dimas', '64.0460, 26.3242', 30.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (49, 'Essen', '52.3605, 00.3483', 27.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (50, 'Northbrook', '39.3208, 30.6821', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (51, 'Lisbon', '62.0191, 10.1560', 19.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (52, 'Gattico', '16.5935, 07.8703', 29);
insert into FORESTS (forest_id, forest_name, location, area)
values (53, 'Brentwood', '52.8261, 94.2968', 13.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (54, 'Manchester', '68.2637, 14.6676', 18.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (55, 'Oppenheim', '99.9854, 84.8335', 17);
insert into FORESTS (forest_id, forest_name, location, area)
values (56, 'Bruneck', '24.5998, 99.0952', 29.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (57, 'Warszawa', '58.7633, 76.1032', 13.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (58, 'Bingham Farms', '74.6291, 44.0048', 22.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (59, 'Brampton', '18.8075, 36.7868', 9.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (60, 'Chemnitz', '39.4874, 48.4107', 22.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (61, 'Hjallerup', '55.8233, 43.1952', 16);
insert into FORESTS (forest_id, forest_name, location, area)
values (62, 'Kozani', '39.5292, 62.0027', 13.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (63, 'Oyten', '70.9561, 99.1431', 22.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (64, 'Santa rita sapucaí', '44.5257, 65.9657', 9);
insert into FORESTS (forest_id, forest_name, location, area)
values (65, 'Tustin', '11.3729, 35.2821', 18.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (66, 'Overland park', '20.2590, 19.5150', 14.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (67, 'Flower mound', '61.3741, 27.3345', 10.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (68, 'Bracknell', '88.6912, 55.5260', 14.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (69, 'Curitiba', '87.3804, 04.2452', 12.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (70, 'Santiago', '79.8660, 50.8753', 19.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (71, 'Neuchâtel', '74.8699, 52.1655', 11.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (72, 'Mountain View', '92.8031, 34.2688', 10.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (73, 'Waldorf', '62.1274, 98.7181', 16.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (74, 'Chapel hill', '25.5877, 96.4233', 16.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (75, 'Köln', '76.6986, 43.7685', 13.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (76, 'Ricardson', '52.0052, 83.7266', 17.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (77, 'Vanderbijlpark', '44.0202, 35.2716', 10.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (78, 'Kansas City', '45.0726, 66.1768', 22.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (79, 'Huntington Beach', '88.8679, 55.0663', 12.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (80, 'Lancaster', '26.5066, 10.6888', 19.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (81, 'Newton-le-willows', '19.2866, 51.9300', 11.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (82, 'Kozani', '25.6693, 99.5938', 10.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (83, 'Oldwick', '85.7223, 54.4873', 22.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (84, 'Pordenone', '30.4467, 69.1644', 12.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (85, 'Pulheim-brauweiler', '50.8304, 53.6847', 13.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (86, 'Richmond', '09.0518, 92.8620', 11.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (87, 'Wien', '25.2815, 08.6950', 22.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (88, 'Naestved', '04.5453, 06.9675', 11);
insert into FORESTS (forest_id, forest_name, location, area)
values (89, 'Tilst', '05.4611, 20.8462', 26);
insert into FORESTS (forest_id, forest_name, location, area)
values (90, 'Ferraz  vasconcelos', '95.8355, 20.1128', 10.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (91, 'Stoneham', '55.8691, 46.9453', 28.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (92, 'Espoo', '43.0673, 52.5385', 24.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (93, 'Dartmouth', '77.8672, 44.2782', 26.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (94, 'Park Ridge', '03.6963, 44.4787', 25.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (95, 'Bham', '03.0310, 19.2042', 16.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (96, 'Bolton', '63.5051, 98.1238', 16.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (97, 'Waite Park', '95.5567, 13.8135', 10.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (98, 'Reading', '53.4549, 20.7814', 20.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (99, 'Thame', '41.8124, 16.3441', 30.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (100, 'Cannock', '39.9725, 67.6587', 12.9);
commit;
prompt 100 records committed...
insert into FORESTS (forest_id, forest_name, location, area)
values (101, 'Golden', '92.5149, 15.7350', 21.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (102, 'Swarthmore', '73.3665, 14.3607', 11.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (103, 'The Woodlands', '80.4533, 83.5592', 9.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (104, 'Menlo Park', '28.5559, 65.0073', 22.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (105, 'Bellevue', '95.1789, 98.7129', 24.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (106, 'Edinburgh', '83.2960, 44.8069', 16.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (107, 'Bend', '50.3615, 31.5626', 12.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (108, 'Odense', '54.6208, 43.4485', 25);
insert into FORESTS (forest_id, forest_name, location, area)
values (109, 'Leawood', '30.7635, 20.7234', 22.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (110, 'Rockville', '58.3510, 14.0705', 14.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (111, 'Wien', '99.2679, 63.5435', 18.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (112, 'Bad Camberg', '20.5091, 24.0201', 15.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (113, 'Istanbul', '39.8235, 19.5993', 14);
insert into FORESTS (forest_id, forest_name, location, area)
values (114, 'Oberwangen', '36.3598, 24.3719', 23.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (115, 'Arlington', '10.8839, 92.7427', 19.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (116, 'Thame', '08.6247, 38.6937', 12.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (117, 'Rockford', '60.3372, 28.8224', 20.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (118, 'North Point', '60.1844, 17.3278', 29.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (119, 'Niles', '88.6749, 02.3843', 12.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (120, 'Chambersburg', '48.0410, 08.0450', 22.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (121, 'Rosemead', '03.9676, 27.1787', 12.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (122, 'West Point', '38.0365, 87.6354', 27.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (123, 'San Jose', '78.5207, 36.9203', 10.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (124, 'South Jordan', '10.2762, 83.4951', 29.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (125, 'Carlin', '50.2116, 46.0876', 23.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (126, 'Hiroshima', '98.6225, 39.4924', 25.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (127, 'Birmingham', '41.0293, 87.2835', 27.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (128, 'Lake Oswego', '47.5587, 63.6857', 9.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (129, 'Immenstaad', '42.1603, 54.1052', 29.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (130, 'Wageningen', '07.8044, 92.3967', 21.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (131, 'Olympia', '43.9467, 88.6538', 26.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (132, 'N. ft. Myers', '79.7921, 12.5422', 24.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (133, 'Matsue', '14.0790, 15.2438', 13.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (134, 'Montreal', '53.4171, 41.0472', 31.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (135, 'Prague', '96.0767, 21.7017', 25.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (136, 'Lyngby', '88.9037, 85.8308', 21.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (137, 'Mclean', '01.1649, 97.9334', 12);
insert into FORESTS (forest_id, forest_name, location, area)
values (138, 'Alleroed', '05.0477, 11.1595', 21.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (139, 'Fort gordon', '69.5859, 21.8563', 17.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (140, 'Alessandria', '23.8119, 93.1645', 13.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (141, 'Ashland', '18.0551, 90.1710', 23.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (142, 'Erpe-Mere', '20.4788, 57.3403', 28.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (143, 'Tilburg', '02.1465, 54.1355', 24.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (144, 'Changwon-si', '38.1232, 98.5472', 9);
insert into FORESTS (forest_id, forest_name, location, area)
values (145, 'Claymont', '38.9188, 09.7052', 21.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (146, 'Petach-Tikva', '17.0029, 64.6499', 11.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (147, 'Coslada', '27.6997, 20.3188', 28.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (148, 'Greenville', '78.9544, 06.4677', 28.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (149, 'Glenshaw', '78.7495, 28.8138', 26);
insert into FORESTS (forest_id, forest_name, location, area)
values (150, 'Hercules', '38.9359, 82.0279', 30.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (151, 'Huntington', '70.3898, 54.7334', 22.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (152, 'Tualatin', '77.4382, 98.8946', 27.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (153, 'Suberg', '62.1844, 78.5473', 9.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (154, 'Hyderabad', '36.5564, 79.5478', 11.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (155, 'Hillerød', '41.5498, 17.1346', 17.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (156, 'Oshawa', '68.5027, 10.7455', 26.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (157, 'Oldenburg', '28.1838, 86.4677', 25.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (158, 'Dartmouth', '85.5368, 11.5832', 16.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (159, 'Santana do parnaíba', '00.6261, 16.7668', 28.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (160, 'Rozenburg', '68.9421, 33.1107', 29);
insert into FORESTS (forest_id, forest_name, location, area)
values (161, 'Sugar Land', '99.0846, 33.6101', 16.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (162, 'Houston', '29.9048, 41.5519', 21.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (163, 'Framingaham', '52.0327, 46.5543', 19.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (164, 'Hartford', '56.9603, 74.8246', 21);
insert into FORESTS (forest_id, forest_name, location, area)
values (165, 'Denver', '94.4854, 22.6514', 14.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (166, 'Marietta', '69.4562, 70.0965', 13);
insert into FORESTS (forest_id, forest_name, location, area)
values (167, 'Meppel', '75.7185, 38.6211', 15.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (168, 'Lublin', '72.3962, 04.2594', 15.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (169, 'Seattle', '47.3351, 21.1320', 11.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (170, 'Lexington', '92.5736, 74.4844', 29.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (171, 'São paulo', '04.5245, 32.5114', 26.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (172, 'Cromwell', '58.0190, 07.3413', 22.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (173, 'Kochi', '80.8057, 39.9076', 24.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (174, 'Manaus', '79.0686, 17.0047', 24.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (175, 'Burlington', '46.7420, 35.8196', 15);
insert into FORESTS (forest_id, forest_name, location, area)
values (176, 'Laredo', '35.6807, 35.8888', 22.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (177, 'West Lafayette', '98.9397, 64.9623', 9.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (178, 'Buffalo', '63.9852, 75.7933', 16.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (179, 'St Jean de Soudain', '38.2296, 95.1634', 9.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (180, 'Edenbridge', '14.4700, 80.3049', 28.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (181, 'Redwood Shores', '81.5605, 97.2180', 11.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (182, 'Fort Lewis', '41.3592, 84.8478', 18.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (183, 'North Point', '97.6825, 34.5191', 24);
insert into FORESTS (forest_id, forest_name, location, area)
values (184, 'Summerside', '66.5920, 10.1246', 10.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (185, 'Mt. Laurel', '28.9407, 16.5617', 24.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (186, 'Manaus', '44.6673, 56.3229', 20.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (187, 'Verwood', '15.7869, 77.5487', 22.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (188, 'Adelaide', '02.1790, 66.5084', 15.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (189, 'Luzern', '51.2898, 85.5600', 11.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (190, 'Herzlia', '58.1726, 88.0150', 14.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (191, 'Albuquerque', '19.3961, 61.0194', 15);
insert into FORESTS (forest_id, forest_name, location, area)
values (192, 'Hartford', '10.6081, 38.5245', 29.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (193, 'Portsmouth', '25.0054, 01.7197', 18.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (194, 'Joinville', '45.9960, 09.9479', 10.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (195, 'Waterloo', '49.9547, 48.3499', 11.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (196, 'Los Angeles', '18.4057, 53.2533', 26.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (197, 'Karlsruhe', '89.7053, 28.4544', 30.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (198, 'Copenhagen', '30.5700, 28.8881', 25.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (199, 'Radovljica', '17.5038, 88.6795', 16.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (200, 'Treviso', '82.5756, 29.5979', 9.9);
commit;
prompt 200 records committed...
insert into FORESTS (forest_id, forest_name, location, area)
values (201, 'Solikamsk', '71.0352, 99.8286', 28.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (202, 'Gattico', '52.8496, 36.7714', 26.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (203, 'Conshohocken', '38.3258, 76.6372', 22.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (204, 'Paal Beringen', '72.8808, 99.4641', 24.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (205, 'Washington', '75.3973, 33.8845', 26.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (206, 'Scottsdale', '98.5121, 09.3628', 19.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (207, 'Hyderabad', '51.2285, 78.6256', 29);
insert into FORESTS (forest_id, forest_name, location, area)
values (208, 'Gdansk', '75.9160, 95.3704', 9.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (209, 'Livermore', '87.4875, 73.8247', 26.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (210, 'Debary', '48.0854, 03.9058', 14.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (211, 'Slough', '15.1676, 62.7159', 11.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (212, 'Rueil-Malmaison', '45.4157, 61.9541', 18.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (213, 'Horsens', '09.8635, 28.3840', 22.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (214, 'Springfield', '84.1556, 88.5123', 13.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (215, 'Newnan', '89.0977, 25.2361', 14.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (216, 'Soest', '66.6813, 15.8369', 19.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (217, 'Aachen', '90.1483, 31.8079', 15.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (218, 'N. ft. Myers', '18.0011, 24.0252', 24.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (219, 'Uetikon am See', '05.9424, 48.5334', 19.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (220, 'Hjallerup', '19.4131, 36.3673', 17.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (221, 'Harahan', '01.6439, 12.1567', 9.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (222, 'Key Biscayne', '17.4342, 57.8704', 27.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (223, 'Sapporo', '59.8095, 64.4447', 20);
insert into FORESTS (forest_id, forest_name, location, area)
values (224, 'Reading', '15.1074, 12.7212', 20.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (225, 'New orleans', '71.0925, 26.8545', 13.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (226, 'Spring City', '40.7601, 27.2633', 23.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (227, 'Ft. Leavenworth', '23.4898, 64.0342', 29.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (228, 'Kanazawa', '68.1745, 65.4054', 25.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (229, 'Visselhövede', '20.2770, 33.8918', 20.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (230, 'Hong Kong', '85.9835, 62.9947', 24.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (231, 'Suwon', '61.4569, 07.9863', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (232, 'Indianapolis', '64.0978, 76.8558', 12.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (233, 'Walnut Creek', '85.6737, 30.7136', 15.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (234, 'Carlsbad', '29.4456, 62.3102', 27.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (235, 'Ponta grossa', '16.7413, 35.5066', 17.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (236, 'Horsham', '08.3858, 70.4150', 12.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (237, 'West Monroe', '58.4656, 93.4206', 22.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (238, 'Grapevine', '07.8883, 29.7258', 18.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (239, 'Pulheim-brauweiler', '39.5978, 93.8143', 28.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (240, 'Wuerzburg', '45.8155, 39.7706', 25.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (241, 'Duisburg', '47.7620, 27.6470', 21.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (242, 'Ellicott City', '33.1256, 09.2731', 18.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (243, 'Herndon', '90.5188, 68.5868', 20.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (244, 'Pompeia', '01.2020, 05.7558', 21);
insert into FORESTS (forest_id, forest_name, location, area)
values (245, 'Immenstaad', '57.0488, 63.7690', 12.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (246, 'Luedenscheid', '72.2671, 97.3076', 24.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (247, 'Saint Ouen', '76.5687, 21.9568', 27.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (248, 'Essex', '15.1631, 84.1077', 14.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (249, 'Macclesfield', '53.3121, 62.1771', 17.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (250, 'Fukuoka', '85.9433, 70.2029', 18.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (251, 'Wehrheim', '65.5871, 67.1239', 15.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (252, 'Gliwice', '09.6169, 81.1697', 13.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (253, 'Bologna', '46.7312, 72.1917', 18.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (254, 'Huntsville', '39.3658, 31.0561', 19);
insert into FORESTS (forest_id, forest_name, location, area)
values (255, 'Suwon-city', '06.7949, 11.1095', 30.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (256, 'Portsmouth', '06.3162, 25.5137', 26.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (257, 'Manchester', '10.7182, 03.9811', 13.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (258, 'durham', '25.4969, 27.7366', 17);
insert into FORESTS (forest_id, forest_name, location, area)
values (259, 'Milwaukee', '04.6471, 59.0605', 26.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (260, 'Gävle', '77.6729, 40.4021', 18.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (261, 'Warrington', '41.8245, 15.9927', 16);
insert into FORESTS (forest_id, forest_name, location, area)
values (262, 'Bielefeld', '12.9925, 62.1679', 22.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (263, 'Canal Winchester', '71.6925, 84.5568', 28.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (264, 'Glenshaw', '95.2456, 25.8383', 15.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (265, 'Middletown', '58.8272, 35.1165', 24.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (266, 'Nashua', '20.3747, 41.6770', 14.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (267, 'Fairborn', '14.0529, 04.6258', 20.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (268, 'Mito', '50.8304, 91.7670', 10.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (269, 'Kagoshima', '14.5347, 96.7511', 19.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (270, 'Bartlett', '72.3786, 91.8083', 16.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (271, 'Kista', '28.2142, 29.5978', 15.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (272, 'Dorval', '24.7582, 65.7702', 20.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (273, 'Cuenca', '13.7738, 88.9491', 24.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (274, 'Karlsruhe', '38.7927, 13.6779', 14.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (275, 'Hiroshima', '91.7623, 65.8071', 15.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (276, 'Redwood Shores', '67.7133, 10.0044', 12.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (277, 'Beaverton', '97.0744, 45.2854', 13.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (278, 'Luzern', '60.6643, 16.5627', 30.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (279, 'Double Oak', '37.6072, 29.6311', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (280, 'Aurora', '39.3188, 10.8870', 25.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (281, 'Pusan', '58.5741, 71.9894', 28);
insert into FORESTS (forest_id, forest_name, location, area)
values (282, 'Coburg', '59.2563, 09.0653', 21.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (283, 'Exeter', '52.1829, 24.2748', 18.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (284, 'Leinfelden-Echterdin', '54.5687, 67.1423', 9.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (285, 'Juno Beach', '33.5023, 95.3014', 29.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (286, 'Raleigh', '82.1400, 77.0673', 18.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (287, 'Herdecke', '82.5078, 87.0497', 9.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (288, 'Newbury', '61.1035, 22.4852', 26.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (289, 'Paço de Arcos', '36.3971, 41.4880', 12.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (290, 'Maebashi', '73.1766, 57.8984', 12.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (291, 'El Segundo', '34.2641, 71.6991', 30.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (292, 'Philadelphia', '76.2063, 65.8414', 15.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (293, 'Conshohocken', '73.2171, 38.3798', 29.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (294, 'Dardilly', '29.9408, 09.5827', 11.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (295, 'Trumbull', '78.4316, 66.8458', 20.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (296, 'Huntington Beach', '53.1787, 68.7832', 17.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (297, 'Halfway house', '18.6073, 95.6469', 17.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (298, 'Graz', '66.4437, 63.1390', 27);
insert into FORESTS (forest_id, forest_name, location, area)
values (299, 'Pulheim-brauweiler', '34.6682, 24.7664', 32);
insert into FORESTS (forest_id, forest_name, location, area)
values (300, 'Springfield', '24.2735, 54.8642', 30.8);
commit;
prompt 300 records committed...
insert into FORESTS (forest_id, forest_name, location, area)
values (301, 'Toronto', '68.7352, 06.5149', 16.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (302, 'Malmö', '31.2968, 42.5749', 17.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (303, 'Olivette', '73.6383, 08.3124', 22.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (304, 'Cedar Rapids', '25.4168, 94.3047', 9);
insert into FORESTS (forest_id, forest_name, location, area)
values (305, 'Tottori', '10.9081, 51.1675', 10.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (306, 'Saint Paul', '83.0126, 33.8748', 13.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (307, 'Springfield', '52.9898, 35.8500', 21);
insert into FORESTS (forest_id, forest_name, location, area)
values (308, 'Mainz-kastel', '49.5834, 21.7816', 24.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (309, 'Soest', '97.7416, 96.8634', 13.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (310, 'Billerica', '02.1021, 74.6852', 26.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (311, 'Swarthmore', '14.1808, 87.7564', 28.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (312, 'Alcobendas', '31.7145, 64.5015', 12.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (313, 'Kyoto', '33.3617, 69.4148', 14.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (314, 'Fort Saskatchewan', '61.9054, 69.6634', 20.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (315, 'Toledo', '71.2662, 63.0523', 24.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (316, 'Louisville', '94.7532, 03.8560', 17.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (317, 'Irving', '27.6558, 52.2853', 13.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (318, 'Somerset', '62.3398, 32.8507', 24.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (319, 'Fairbanks', '59.1702, 14.7006', 9.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (320, 'Greenville', '55.7722, 43.8519', 19.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (321, 'Geneve', '03.3246, 67.6287', 15.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (322, 'Gifu', '34.6120, 42.2989', 16.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (323, 'Bend', '66.6885, 88.7952', 22.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (324, 'Grand Rapids', '72.5690, 29.7814', 30.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (325, 'Friedrichshafe', '18.0380, 34.4905', 11.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (326, 'Goteborg', '07.3024, 22.8917', 14.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (327, 'Chambersburg', '29.1634, 97.8013', 19.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (328, 'Munich', '56.3236, 14.7026', 15.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (329, 'Northampton', '98.8632, 58.8964', 9.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (330, 'Budapest', '51.5508, 18.4471', 13.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (331, 'San Antonio', '05.9672, 49.8932', 9.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (332, 'Rome', '36.8411, 88.4890', 27.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (333, 'Ithaca', '38.9267, 99.4762', 22.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (334, 'Houma', '36.5376, 93.3549', 15.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (335, 'Colombes', '98.3273, 21.9214', 24.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (336, 'Canal Winchester', '63.5880, 29.9146', 23.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (337, 'Berkeley', '00.3667, 01.7026', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (338, 'Reading', '19.7622, 62.3697', 17);
insert into FORESTS (forest_id, forest_name, location, area)
values (339, 'Edison', '35.4048, 53.3989', 19.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (340, 'Uetikon am See', '22.9378, 03.0598', 10.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (341, 'Essex', '42.6915, 62.2991', 29);
insert into FORESTS (forest_id, forest_name, location, area)
values (342, 'Irkutsk', '33.3843, 17.7888', 23.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (343, 'Sidney', '62.2249, 04.9448', 22.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (344, 'Knoxville', '03.0832, 39.7609', 10.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (345, 'Pomona', '76.8630, 16.5236', 11.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (346, 'Bham', '86.7573, 23.5278', 26.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (347, 'Ramat Gan', '92.2812, 35.6863', 27.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (348, 'Springfield', '08.4087, 88.9867', 21.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (349, 'Horsham', '73.6907, 99.0916', 22);
insert into FORESTS (forest_id, forest_name, location, area)
values (350, 'Manchester', '86.9691, 47.8429', 26.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (351, 'Stocksbridge', '65.7138, 98.4841', 26.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (352, 'Duluth', '06.2660, 49.2919', 9.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (353, 'Kista', '94.5793, 47.8698', 30.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (354, 'Mount Olive', '71.3956, 69.6916', 29.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (355, 'Altamonte Springs', '94.3433, 87.5808', 25);
insert into FORESTS (forest_id, forest_name, location, area)
values (356, 'Shelton', '63.2024, 84.9515', 11.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (357, 'Tours', '19.6900, 41.3972', 16.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (358, 'Budapest', '40.0755, 99.7754', 23.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (359, 'Essex', '14.7682, 88.0671', 27.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (360, 'Yamagata', '05.8019, 24.1865', 30.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (361, 'Slmea', '29.2820, 80.6991', 28.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (362, 'Fambach', '15.2608, 65.9737', 11);
insert into FORESTS (forest_id, forest_name, location, area)
values (363, 'Whitehouse Station', '89.1829, 51.7428', 30.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (364, 'Gummersbach', '00.4536, 33.0469', 24.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (365, 'Amsterdam', '71.4358, 36.6658', 12.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (366, 'Pitstone', '22.2482, 92.0787', 9.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (367, 'Warley', '99.5656, 44.8655', 29.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (368, 'Sapporo', '76.1783, 24.4019', 27.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (369, 'Fambach', '80.2147, 64.7843', 18.3);
insert into FORESTS (forest_id, forest_name, location, area)
values (370, 'Coppell', '12.9061, 05.9916', 18.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (371, 'Singapore', '86.7033, 88.8681', 14.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (372, 'Pensacola', '41.1195, 88.7023', 22.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (373, 'Melrose', '16.6266, 62.0315', 10.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (374, 'Ulm', '59.0357, 24.9472', 11);
insert into FORESTS (forest_id, forest_name, location, area)
values (375, 'Essex', '21.6782, 14.7656', 30.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (376, 'Washington', '89.7226, 44.2570', 27.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (377, 'Bretzfeld-Waldbach', '79.2699, 90.2468', 16.4);
insert into FORESTS (forest_id, forest_name, location, area)
values (378, 'Butner', '80.3002, 68.9840', 19.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (379, 'Jacksonville', '16.6996, 68.6468', 11.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (380, 'Avon', '16.4503, 91.2323', 27);
insert into FORESTS (forest_id, forest_name, location, area)
values (381, 'Daejeon', '40.7321, 58.2891', 21);
insert into FORESTS (forest_id, forest_name, location, area)
values (382, 'Bedfordshire', '11.4438, 93.1645', 15.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (383, 'Michendorf', '45.5562, 70.0844', 16.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (384, 'Kloten', '15.0502, 83.8661', 20);
insert into FORESTS (forest_id, forest_name, location, area)
values (385, 'Duluth', '51.9794, 35.2709', 10.8);
insert into FORESTS (forest_id, forest_name, location, area)
values (386, 'Fambach', '26.9851, 69.2521', 27.6);
insert into FORESTS (forest_id, forest_name, location, area)
values (387, 'Forest Park', '71.9972, 54.3451', 19.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (388, 'Webster Groves', '69.0076, 01.3067', 23);
insert into FORESTS (forest_id, forest_name, location, area)
values (389, 'Fort Lee', '17.6076, 29.2763', 12.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (390, 'Kobe', '87.3787, 15.6457', 13.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (391, 'Cambridge', '14.8201, 32.2403', 24.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (392, 'Protvino', '32.7449, 50.3773', 23.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (393, 'Philadelphia', '92.6778, 54.8609', 10.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (394, 'Sao roque', '36.5484, 41.7220', 24.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (395, 'Durham', '14.4710, 95.1997', 19.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (396, 'Shelton', '77.0687, 48.3696', 16.1);
insert into FORESTS (forest_id, forest_name, location, area)
values (397, 'El Dorado Hills', '52.5326, 67.0426', 30.5);
insert into FORESTS (forest_id, forest_name, location, area)
values (398, 'Salisbury', '70.1085, 62.2302', 13.7);
insert into FORESTS (forest_id, forest_name, location, area)
values (399, 'Padova', '81.3266, 73.4855', 29.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (400, 'Melrose park', '30.2658, 32.3993', 29.3);
commit;
prompt 400 records committed...
insert into FORESTS (forest_id, forest_name, location, area)
values (401, 'Kansas City', '82.7643, 55.8970', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (402, 'Kansas City', '81.2341, 50.5683', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (403, 'Kansas City', '78.9711, 51.1267', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (404, 'Phoenix', '79.5481, 54.3906', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (405, 'Phoenix', '56.8445, 54.2306', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (406, 'Phoenix', '59.5481, 53.8979', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (407, 'New Orleans', '23.9874, 98.7342', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (408, 'New Orleans', '25.8454, 89.2676', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (409, 'New Orleans', '22.7671, 97.2987', 14.2);
insert into FORESTS (forest_id, forest_name, location, area)
values (410, 'Kansas City', '82.7643, 55.8970', 14);
insert into FORESTS (forest_id, forest_name, location, area)
values (411, 'Phoenix', '56.8445, 52.2306', 5.9);
insert into FORESTS (forest_id, forest_name, location, area)
values (412, 'New Orleans', '25.8454, 89.2676', 7.4);
commit;
prompt 412 records loaded
prompt Loading HASA...
insert into HASA (forest_id, action_id)
values (1, 168);
insert into HASA (forest_id, action_id)
values (1, 248);
insert into HASA (forest_id, action_id)
values (1, 282);
insert into HASA (forest_id, action_id)
values (2, 12);
insert into HASA (forest_id, action_id)
values (2, 92);
insert into HASA (forest_id, action_id)
values (2, 264);
insert into HASA (forest_id, action_id)
values (2, 375);
insert into HASA (forest_id, action_id)
values (2, 378);
insert into HASA (forest_id, action_id)
values (3, 8);
insert into HASA (forest_id, action_id)
values (3, 96);
insert into HASA (forest_id, action_id)
values (3, 116);
insert into HASA (forest_id, action_id)
values (4, 174);
insert into HASA (forest_id, action_id)
values (4, 323);
insert into HASA (forest_id, action_id)
values (4, 343);
insert into HASA (forest_id, action_id)
values (5, 1);
insert into HASA (forest_id, action_id)
values (5, 49);
insert into HASA (forest_id, action_id)
values (5, 139);
insert into HASA (forest_id, action_id)
values (5, 145);
insert into HASA (forest_id, action_id)
values (5, 225);
insert into HASA (forest_id, action_id)
values (5, 253);
insert into HASA (forest_id, action_id)
values (5, 275);
insert into HASA (forest_id, action_id)
values (5, 353);
insert into HASA (forest_id, action_id)
values (5, 375);
insert into HASA (forest_id, action_id)
values (6, 69);
insert into HASA (forest_id, action_id)
values (6, 88);
insert into HASA (forest_id, action_id)
values (6, 143);
insert into HASA (forest_id, action_id)
values (6, 196);
insert into HASA (forest_id, action_id)
values (6, 221);
insert into HASA (forest_id, action_id)
values (7, 1);
insert into HASA (forest_id, action_id)
values (7, 152);
insert into HASA (forest_id, action_id)
values (7, 284);
insert into HASA (forest_id, action_id)
values (7, 351);
insert into HASA (forest_id, action_id)
values (8, 74);
insert into HASA (forest_id, action_id)
values (8, 182);
insert into HASA (forest_id, action_id)
values (8, 306);
insert into HASA (forest_id, action_id)
values (9, 48);
insert into HASA (forest_id, action_id)
values (10, 21);
insert into HASA (forest_id, action_id)
values (10, 209);
insert into HASA (forest_id, action_id)
values (10, 282);
insert into HASA (forest_id, action_id)
values (10, 341);
insert into HASA (forest_id, action_id)
values (10, 384);
insert into HASA (forest_id, action_id)
values (11, 62);
insert into HASA (forest_id, action_id)
values (11, 72);
insert into HASA (forest_id, action_id)
values (12, 80);
insert into HASA (forest_id, action_id)
values (12, 82);
insert into HASA (forest_id, action_id)
values (12, 122);
insert into HASA (forest_id, action_id)
values (12, 163);
insert into HASA (forest_id, action_id)
values (12, 381);
insert into HASA (forest_id, action_id)
values (13, 95);
insert into HASA (forest_id, action_id)
values (13, 192);
insert into HASA (forest_id, action_id)
values (14, 3);
insert into HASA (forest_id, action_id)
values (14, 105);
insert into HASA (forest_id, action_id)
values (14, 281);
insert into HASA (forest_id, action_id)
values (14, 349);
insert into HASA (forest_id, action_id)
values (14, 389);
insert into HASA (forest_id, action_id)
values (14, 392);
insert into HASA (forest_id, action_id)
values (15, 83);
insert into HASA (forest_id, action_id)
values (15, 98);
insert into HASA (forest_id, action_id)
values (15, 284);
insert into HASA (forest_id, action_id)
values (15, 353);
insert into HASA (forest_id, action_id)
values (15, 394);
insert into HASA (forest_id, action_id)
values (16, 241);
insert into HASA (forest_id, action_id)
values (16, 302);
insert into HASA (forest_id, action_id)
values (16, 339);
insert into HASA (forest_id, action_id)
values (16, 373);
insert into HASA (forest_id, action_id)
values (16, 375);
insert into HASA (forest_id, action_id)
values (17, 1);
insert into HASA (forest_id, action_id)
values (17, 99);
insert into HASA (forest_id, action_id)
values (17, 128);
insert into HASA (forest_id, action_id)
values (18, 138);
insert into HASA (forest_id, action_id)
values (19, 154);
insert into HASA (forest_id, action_id)
values (19, 332);
insert into HASA (forest_id, action_id)
values (20, 32);
insert into HASA (forest_id, action_id)
values (20, 141);
insert into HASA (forest_id, action_id)
values (20, 162);
insert into HASA (forest_id, action_id)
values (21, 44);
insert into HASA (forest_id, action_id)
values (21, 177);
insert into HASA (forest_id, action_id)
values (21, 225);
insert into HASA (forest_id, action_id)
values (21, 276);
insert into HASA (forest_id, action_id)
values (21, 283);
insert into HASA (forest_id, action_id)
values (22, 10);
insert into HASA (forest_id, action_id)
values (22, 63);
insert into HASA (forest_id, action_id)
values (22, 66);
insert into HASA (forest_id, action_id)
values (22, 67);
insert into HASA (forest_id, action_id)
values (22, 269);
insert into HASA (forest_id, action_id)
values (22, 297);
insert into HASA (forest_id, action_id)
values (23, 134);
insert into HASA (forest_id, action_id)
values (23, 193);
insert into HASA (forest_id, action_id)
values (23, 373);
insert into HASA (forest_id, action_id)
values (24, 101);
insert into HASA (forest_id, action_id)
values (24, 129);
insert into HASA (forest_id, action_id)
values (24, 154);
insert into HASA (forest_id, action_id)
values (24, 165);
insert into HASA (forest_id, action_id)
values (24, 215);
insert into HASA (forest_id, action_id)
values (24, 276);
insert into HASA (forest_id, action_id)
values (24, 295);
insert into HASA (forest_id, action_id)
values (24, 348);
insert into HASA (forest_id, action_id)
values (25, 38);
insert into HASA (forest_id, action_id)
values (25, 42);
insert into HASA (forest_id, action_id)
values (25, 162);
commit;
prompt 100 records committed...
insert into HASA (forest_id, action_id)
values (25, 254);
insert into HASA (forest_id, action_id)
values (25, 259);
insert into HASA (forest_id, action_id)
values (25, 383);
insert into HASA (forest_id, action_id)
values (26, 61);
insert into HASA (forest_id, action_id)
values (26, 182);
insert into HASA (forest_id, action_id)
values (26, 255);
insert into HASA (forest_id, action_id)
values (26, 315);
insert into HASA (forest_id, action_id)
values (27, 17);
insert into HASA (forest_id, action_id)
values (27, 20);
insert into HASA (forest_id, action_id)
values (27, 57);
insert into HASA (forest_id, action_id)
values (27, 86);
insert into HASA (forest_id, action_id)
values (27, 166);
insert into HASA (forest_id, action_id)
values (27, 185);
insert into HASA (forest_id, action_id)
values (27, 191);
insert into HASA (forest_id, action_id)
values (27, 390);
insert into HASA (forest_id, action_id)
values (28, 79);
insert into HASA (forest_id, action_id)
values (28, 185);
insert into HASA (forest_id, action_id)
values (28, 281);
insert into HASA (forest_id, action_id)
values (29, 56);
insert into HASA (forest_id, action_id)
values (29, 84);
insert into HASA (forest_id, action_id)
values (29, 185);
insert into HASA (forest_id, action_id)
values (29, 234);
insert into HASA (forest_id, action_id)
values (29, 374);
insert into HASA (forest_id, action_id)
values (30, 114);
insert into HASA (forest_id, action_id)
values (30, 124);
insert into HASA (forest_id, action_id)
values (30, 169);
insert into HASA (forest_id, action_id)
values (30, 220);
insert into HASA (forest_id, action_id)
values (31, 16);
insert into HASA (forest_id, action_id)
values (31, 35);
insert into HASA (forest_id, action_id)
values (31, 58);
insert into HASA (forest_id, action_id)
values (31, 62);
insert into HASA (forest_id, action_id)
values (31, 107);
insert into HASA (forest_id, action_id)
values (31, 117);
insert into HASA (forest_id, action_id)
values (31, 298);
insert into HASA (forest_id, action_id)
values (32, 142);
insert into HASA (forest_id, action_id)
values (32, 152);
insert into HASA (forest_id, action_id)
values (32, 303);
insert into HASA (forest_id, action_id)
values (32, 307);
insert into HASA (forest_id, action_id)
values (32, 379);
insert into HASA (forest_id, action_id)
values (33, 75);
insert into HASA (forest_id, action_id)
values (33, 181);
insert into HASA (forest_id, action_id)
values (33, 280);
insert into HASA (forest_id, action_id)
values (33, 281);
insert into HASA (forest_id, action_id)
values (33, 289);
insert into HASA (forest_id, action_id)
values (34, 261);
insert into HASA (forest_id, action_id)
values (34, 289);
insert into HASA (forest_id, action_id)
values (34, 290);
insert into HASA (forest_id, action_id)
values (34, 292);
insert into HASA (forest_id, action_id)
values (34, 353);
insert into HASA (forest_id, action_id)
values (35, 8);
insert into HASA (forest_id, action_id)
values (35, 391);
insert into HASA (forest_id, action_id)
values (36, 136);
insert into HASA (forest_id, action_id)
values (36, 216);
insert into HASA (forest_id, action_id)
values (36, 248);
insert into HASA (forest_id, action_id)
values (36, 266);
insert into HASA (forest_id, action_id)
values (37, 109);
insert into HASA (forest_id, action_id)
values (37, 131);
insert into HASA (forest_id, action_id)
values (37, 157);
insert into HASA (forest_id, action_id)
values (37, 243);
insert into HASA (forest_id, action_id)
values (37, 307);
insert into HASA (forest_id, action_id)
values (37, 341);
insert into HASA (forest_id, action_id)
values (37, 364);
insert into HASA (forest_id, action_id)
values (37, 372);
insert into HASA (forest_id, action_id)
values (38, 56);
insert into HASA (forest_id, action_id)
values (38, 114);
insert into HASA (forest_id, action_id)
values (38, 173);
insert into HASA (forest_id, action_id)
values (38, 228);
insert into HASA (forest_id, action_id)
values (38, 393);
insert into HASA (forest_id, action_id)
values (39, 16);
insert into HASA (forest_id, action_id)
values (39, 40);
insert into HASA (forest_id, action_id)
values (39, 72);
insert into HASA (forest_id, action_id)
values (39, 154);
insert into HASA (forest_id, action_id)
values (39, 183);
insert into HASA (forest_id, action_id)
values (39, 205);
insert into HASA (forest_id, action_id)
values (39, 229);
insert into HASA (forest_id, action_id)
values (39, 268);
insert into HASA (forest_id, action_id)
values (39, 365);
insert into HASA (forest_id, action_id)
values (39, 369);
insert into HASA (forest_id, action_id)
values (39, 399);
insert into HASA (forest_id, action_id)
values (40, 4);
insert into HASA (forest_id, action_id)
values (40, 15);
insert into HASA (forest_id, action_id)
values (40, 53);
insert into HASA (forest_id, action_id)
values (40, 148);
insert into HASA (forest_id, action_id)
values (40, 161);
insert into HASA (forest_id, action_id)
values (41, 142);
insert into HASA (forest_id, action_id)
values (41, 201);
insert into HASA (forest_id, action_id)
values (41, 237);
insert into HASA (forest_id, action_id)
values (42, 18);
insert into HASA (forest_id, action_id)
values (42, 139);
insert into HASA (forest_id, action_id)
values (42, 227);
insert into HASA (forest_id, action_id)
values (42, 366);
insert into HASA (forest_id, action_id)
values (43, 12);
insert into HASA (forest_id, action_id)
values (43, 185);
insert into HASA (forest_id, action_id)
values (43, 196);
insert into HASA (forest_id, action_id)
values (44, 298);
insert into HASA (forest_id, action_id)
values (45, 4);
insert into HASA (forest_id, action_id)
values (45, 140);
insert into HASA (forest_id, action_id)
values (45, 168);
insert into HASA (forest_id, action_id)
values (46, 72);
insert into HASA (forest_id, action_id)
values (46, 75);
commit;
prompt 200 records committed...
insert into HASA (forest_id, action_id)
values (46, 236);
insert into HASA (forest_id, action_id)
values (47, 36);
insert into HASA (forest_id, action_id)
values (47, 96);
insert into HASA (forest_id, action_id)
values (47, 243);
insert into HASA (forest_id, action_id)
values (47, 330);
insert into HASA (forest_id, action_id)
values (47, 399);
insert into HASA (forest_id, action_id)
values (48, 63);
insert into HASA (forest_id, action_id)
values (48, 172);
insert into HASA (forest_id, action_id)
values (48, 244);
insert into HASA (forest_id, action_id)
values (48, 327);
insert into HASA (forest_id, action_id)
values (48, 341);
insert into HASA (forest_id, action_id)
values (48, 369);
insert into HASA (forest_id, action_id)
values (48, 373);
insert into HASA (forest_id, action_id)
values (49, 313);
insert into HASA (forest_id, action_id)
values (50, 36);
insert into HASA (forest_id, action_id)
values (50, 130);
insert into HASA (forest_id, action_id)
values (50, 262);
insert into HASA (forest_id, action_id)
values (51, 126);
insert into HASA (forest_id, action_id)
values (51, 201);
insert into HASA (forest_id, action_id)
values (52, 124);
insert into HASA (forest_id, action_id)
values (52, 128);
insert into HASA (forest_id, action_id)
values (53, 152);
insert into HASA (forest_id, action_id)
values (53, 247);
insert into HASA (forest_id, action_id)
values (53, 392);
insert into HASA (forest_id, action_id)
values (54, 25);
insert into HASA (forest_id, action_id)
values (54, 266);
insert into HASA (forest_id, action_id)
values (55, 6);
insert into HASA (forest_id, action_id)
values (56, 6);
insert into HASA (forest_id, action_id)
values (56, 109);
insert into HASA (forest_id, action_id)
values (56, 156);
insert into HASA (forest_id, action_id)
values (56, 292);
insert into HASA (forest_id, action_id)
values (57, 103);
insert into HASA (forest_id, action_id)
values (57, 187);
insert into HASA (forest_id, action_id)
values (57, 218);
insert into HASA (forest_id, action_id)
values (57, 249);
insert into HASA (forest_id, action_id)
values (57, 305);
insert into HASA (forest_id, action_id)
values (58, 129);
insert into HASA (forest_id, action_id)
values (58, 156);
insert into HASA (forest_id, action_id)
values (58, 354);
insert into HASA (forest_id, action_id)
values (58, 391);
insert into HASA (forest_id, action_id)
values (59, 14);
insert into HASA (forest_id, action_id)
values (59, 74);
insert into HASA (forest_id, action_id)
values (59, 384);
insert into HASA (forest_id, action_id)
values (211, 167);
insert into HASA (forest_id, action_id)
values (211, 220);
insert into HASA (forest_id, action_id)
values (211, 289);
insert into HASA (forest_id, action_id)
values (211, 293);
insert into HASA (forest_id, action_id)
values (211, 346);
insert into HASA (forest_id, action_id)
values (211, 380);
insert into HASA (forest_id, action_id)
values (212, 134);
insert into HASA (forest_id, action_id)
values (212, 251);
insert into HASA (forest_id, action_id)
values (212, 278);
insert into HASA (forest_id, action_id)
values (213, 100);
insert into HASA (forest_id, action_id)
values (213, 165);
insert into HASA (forest_id, action_id)
values (213, 184);
insert into HASA (forest_id, action_id)
values (213, 236);
insert into HASA (forest_id, action_id)
values (214, 18);
insert into HASA (forest_id, action_id)
values (214, 184);
insert into HASA (forest_id, action_id)
values (214, 260);
insert into HASA (forest_id, action_id)
values (214, 291);
insert into HASA (forest_id, action_id)
values (214, 335);
insert into HASA (forest_id, action_id)
values (215, 55);
insert into HASA (forest_id, action_id)
values (215, 91);
insert into HASA (forest_id, action_id)
values (215, 132);
insert into HASA (forest_id, action_id)
values (215, 149);
insert into HASA (forest_id, action_id)
values (215, 226);
insert into HASA (forest_id, action_id)
values (215, 277);
insert into HASA (forest_id, action_id)
values (215, 280);
insert into HASA (forest_id, action_id)
values (215, 393);
insert into HASA (forest_id, action_id)
values (216, 211);
insert into HASA (forest_id, action_id)
values (216, 228);
insert into HASA (forest_id, action_id)
values (216, 245);
insert into HASA (forest_id, action_id)
values (216, 327);
insert into HASA (forest_id, action_id)
values (216, 353);
insert into HASA (forest_id, action_id)
values (217, 242);
insert into HASA (forest_id, action_id)
values (217, 287);
insert into HASA (forest_id, action_id)
values (218, 10);
insert into HASA (forest_id, action_id)
values (218, 117);
insert into HASA (forest_id, action_id)
values (218, 171);
insert into HASA (forest_id, action_id)
values (218, 244);
insert into HASA (forest_id, action_id)
values (218, 343);
insert into HASA (forest_id, action_id)
values (218, 380);
insert into HASA (forest_id, action_id)
values (218, 386);
insert into HASA (forest_id, action_id)
values (219, 258);
insert into HASA (forest_id, action_id)
values (220, 13);
insert into HASA (forest_id, action_id)
values (220, 384);
insert into HASA (forest_id, action_id)
values (221, 55);
insert into HASA (forest_id, action_id)
values (221, 59);
insert into HASA (forest_id, action_id)
values (221, 147);
insert into HASA (forest_id, action_id)
values (221, 178);
insert into HASA (forest_id, action_id)
values (221, 397);
insert into HASA (forest_id, action_id)
values (222, 149);
insert into HASA (forest_id, action_id)
values (222, 304);
insert into HASA (forest_id, action_id)
values (222, 316);
insert into HASA (forest_id, action_id)
values (223, 76);
insert into HASA (forest_id, action_id)
values (224, 108);
insert into HASA (forest_id, action_id)
values (224, 146);
insert into HASA (forest_id, action_id)
values (224, 265);
insert into HASA (forest_id, action_id)
values (225, 69);
insert into HASA (forest_id, action_id)
values (226, 20);
commit;
prompt 300 records committed...
insert into HASA (forest_id, action_id)
values (226, 24);
insert into HASA (forest_id, action_id)
values (226, 140);
insert into HASA (forest_id, action_id)
values (226, 267);
insert into HASA (forest_id, action_id)
values (227, 13);
insert into HASA (forest_id, action_id)
values (227, 100);
insert into HASA (forest_id, action_id)
values (227, 178);
insert into HASA (forest_id, action_id)
values (228, 116);
insert into HASA (forest_id, action_id)
values (228, 181);
insert into HASA (forest_id, action_id)
values (228, 208);
insert into HASA (forest_id, action_id)
values (228, 335);
insert into HASA (forest_id, action_id)
values (229, 37);
insert into HASA (forest_id, action_id)
values (229, 47);
insert into HASA (forest_id, action_id)
values (229, 60);
insert into HASA (forest_id, action_id)
values (229, 85);
insert into HASA (forest_id, action_id)
values (229, 165);
insert into HASA (forest_id, action_id)
values (229, 340);
insert into HASA (forest_id, action_id)
values (230, 74);
insert into HASA (forest_id, action_id)
values (230, 106);
insert into HASA (forest_id, action_id)
values (230, 345);
insert into HASA (forest_id, action_id)
values (231, 302);
insert into HASA (forest_id, action_id)
values (231, 370);
insert into HASA (forest_id, action_id)
values (232, 39);
insert into HASA (forest_id, action_id)
values (232, 86);
insert into HASA (forest_id, action_id)
values (232, 139);
insert into HASA (forest_id, action_id)
values (233, 39);
insert into HASA (forest_id, action_id)
values (233, 77);
insert into HASA (forest_id, action_id)
values (233, 132);
insert into HASA (forest_id, action_id)
values (233, 369);
insert into HASA (forest_id, action_id)
values (234, 300);
insert into HASA (forest_id, action_id)
values (235, 255);
insert into HASA (forest_id, action_id)
values (235, 271);
insert into HASA (forest_id, action_id)
values (236, 87);
insert into HASA (forest_id, action_id)
values (236, 291);
insert into HASA (forest_id, action_id)
values (237, 89);
insert into HASA (forest_id, action_id)
values (237, 103);
insert into HASA (forest_id, action_id)
values (237, 154);
insert into HASA (forest_id, action_id)
values (238, 26);
insert into HASA (forest_id, action_id)
values (238, 58);
insert into HASA (forest_id, action_id)
values (238, 59);
insert into HASA (forest_id, action_id)
values (238, 108);
insert into HASA (forest_id, action_id)
values (238, 133);
insert into HASA (forest_id, action_id)
values (238, 164);
insert into HASA (forest_id, action_id)
values (238, 234);
insert into HASA (forest_id, action_id)
values (238, 244);
insert into HASA (forest_id, action_id)
values (238, 246);
insert into HASA (forest_id, action_id)
values (239, 295);
insert into HASA (forest_id, action_id)
values (240, 350);
insert into HASA (forest_id, action_id)
values (240, 369);
insert into HASA (forest_id, action_id)
values (241, 80);
insert into HASA (forest_id, action_id)
values (241, 144);
insert into HASA (forest_id, action_id)
values (241, 160);
insert into HASA (forest_id, action_id)
values (241, 164);
insert into HASA (forest_id, action_id)
values (241, 287);
insert into HASA (forest_id, action_id)
values (241, 400);
insert into HASA (forest_id, action_id)
values (242, 131);
insert into HASA (forest_id, action_id)
values (242, 175);
insert into HASA (forest_id, action_id)
values (242, 250);
insert into HASA (forest_id, action_id)
values (242, 300);
insert into HASA (forest_id, action_id)
values (242, 369);
insert into HASA (forest_id, action_id)
values (243, 66);
insert into HASA (forest_id, action_id)
values (243, 113);
insert into HASA (forest_id, action_id)
values (243, 189);
insert into HASA (forest_id, action_id)
values (243, 196);
insert into HASA (forest_id, action_id)
values (243, 202);
insert into HASA (forest_id, action_id)
values (244, 75);
insert into HASA (forest_id, action_id)
values (245, 174);
insert into HASA (forest_id, action_id)
values (245, 188);
insert into HASA (forest_id, action_id)
values (245, 316);
insert into HASA (forest_id, action_id)
values (246, 20);
insert into HASA (forest_id, action_id)
values (246, 79);
insert into HASA (forest_id, action_id)
values (247, 125);
insert into HASA (forest_id, action_id)
values (247, 216);
insert into HASA (forest_id, action_id)
values (247, 314);
insert into HASA (forest_id, action_id)
values (247, 340);
insert into HASA (forest_id, action_id)
values (248, 95);
insert into HASA (forest_id, action_id)
values (248, 150);
insert into HASA (forest_id, action_id)
values (248, 157);
insert into HASA (forest_id, action_id)
values (248, 161);
insert into HASA (forest_id, action_id)
values (248, 202);
insert into HASA (forest_id, action_id)
values (248, 209);
insert into HASA (forest_id, action_id)
values (248, 238);
insert into HASA (forest_id, action_id)
values (248, 302);
insert into HASA (forest_id, action_id)
values (249, 7);
insert into HASA (forest_id, action_id)
values (249, 117);
insert into HASA (forest_id, action_id)
values (249, 170);
insert into HASA (forest_id, action_id)
values (249, 219);
insert into HASA (forest_id, action_id)
values (249, 252);
insert into HASA (forest_id, action_id)
values (249, 314);
insert into HASA (forest_id, action_id)
values (249, 377);
insert into HASA (forest_id, action_id)
values (250, 30);
insert into HASA (forest_id, action_id)
values (250, 89);
insert into HASA (forest_id, action_id)
values (250, 138);
insert into HASA (forest_id, action_id)
values (250, 155);
insert into HASA (forest_id, action_id)
values (251, 141);
insert into HASA (forest_id, action_id)
values (251, 149);
insert into HASA (forest_id, action_id)
values (251, 261);
insert into HASA (forest_id, action_id)
values (251, 280);
insert into HASA (forest_id, action_id)
values (251, 337);
insert into HASA (forest_id, action_id)
values (252, 199);
insert into HASA (forest_id, action_id)
values (252, 273);
commit;
prompt 400 records committed...
insert into HASA (forest_id, action_id)
values (252, 396);
insert into HASA (forest_id, action_id)
values (253, 215);
insert into HASA (forest_id, action_id)
values (254, 41);
insert into HASA (forest_id, action_id)
values (254, 141);
insert into HASA (forest_id, action_id)
values (254, 200);
insert into HASA (forest_id, action_id)
values (254, 230);
insert into HASA (forest_id, action_id)
values (254, 264);
insert into HASA (forest_id, action_id)
values (255, 50);
insert into HASA (forest_id, action_id)
values (255, 109);
insert into HASA (forest_id, action_id)
values (255, 309);
insert into HASA (forest_id, action_id)
values (255, 354);
insert into HASA (forest_id, action_id)
values (256, 36);
insert into HASA (forest_id, action_id)
values (256, 95);
insert into HASA (forest_id, action_id)
values (256, 133);
insert into HASA (forest_id, action_id)
values (256, 190);
insert into HASA (forest_id, action_id)
values (256, 290);
insert into HASA (forest_id, action_id)
values (257, 94);
insert into HASA (forest_id, action_id)
values (257, 121);
insert into HASA (forest_id, action_id)
values (257, 330);
insert into HASA (forest_id, action_id)
values (257, 373);
insert into HASA (forest_id, action_id)
values (258, 41);
insert into HASA (forest_id, action_id)
values (258, 211);
insert into HASA (forest_id, action_id)
values (258, 234);
insert into HASA (forest_id, action_id)
values (259, 140);
insert into HASA (forest_id, action_id)
values (259, 180);
insert into HASA (forest_id, action_id)
values (259, 299);
insert into HASA (forest_id, action_id)
values (259, 349);
insert into HASA (forest_id, action_id)
values (259, 390);
insert into HASA (forest_id, action_id)
values (260, 45);
insert into HASA (forest_id, action_id)
values (260, 322);
insert into HASA (forest_id, action_id)
values (261, 251);
insert into HASA (forest_id, action_id)
values (261, 369);
insert into HASA (forest_id, action_id)
values (262, 104);
insert into HASA (forest_id, action_id)
values (262, 154);
insert into HASA (forest_id, action_id)
values (262, 226);
insert into HASA (forest_id, action_id)
values (262, 282);
insert into HASA (forest_id, action_id)
values (262, 342);
insert into HASA (forest_id, action_id)
values (263, 139);
insert into HASA (forest_id, action_id)
values (263, 319);
insert into HASA (forest_id, action_id)
values (263, 334);
insert into HASA (forest_id, action_id)
values (264, 125);
insert into HASA (forest_id, action_id)
values (264, 129);
insert into HASA (forest_id, action_id)
values (264, 226);
insert into HASA (forest_id, action_id)
values (264, 338);
insert into HASA (forest_id, action_id)
values (265, 224);
insert into HASA (forest_id, action_id)
values (265, 337);
insert into HASA (forest_id, action_id)
values (266, 204);
insert into HASA (forest_id, action_id)
values (266, 236);
insert into HASA (forest_id, action_id)
values (266, 270);
insert into HASA (forest_id, action_id)
values (266, 301);
insert into HASA (forest_id, action_id)
values (266, 335);
insert into HASA (forest_id, action_id)
values (267, 38);
insert into HASA (forest_id, action_id)
values (267, 68);
insert into HASA (forest_id, action_id)
values (267, 80);
insert into HASA (forest_id, action_id)
values (267, 136);
insert into HASA (forest_id, action_id)
values (267, 147);
insert into HASA (forest_id, action_id)
values (267, 177);
insert into HASA (forest_id, action_id)
values (267, 228);
insert into HASA (forest_id, action_id)
values (267, 229);
insert into HASA (forest_id, action_id)
values (267, 311);
insert into HASA (forest_id, action_id)
values (268, 41);
insert into HASA (forest_id, action_id)
values (268, 79);
insert into HASA (forest_id, action_id)
values (268, 239);
insert into HASA (forest_id, action_id)
values (268, 242);
insert into HASA (forest_id, action_id)
values (268, 257);
insert into HASA (forest_id, action_id)
values (268, 277);
insert into HASA (forest_id, action_id)
values (269, 122);
insert into HASA (forest_id, action_id)
values (269, 211);
insert into HASA (forest_id, action_id)
values (269, 234);
insert into HASA (forest_id, action_id)
values (270, 17);
insert into HASA (forest_id, action_id)
values (270, 63);
insert into HASA (forest_id, action_id)
values (270, 127);
insert into HASA (forest_id, action_id)
values (270, 164);
insert into HASA (forest_id, action_id)
values (270, 282);
insert into HASA (forest_id, action_id)
values (270, 322);
insert into HASA (forest_id, action_id)
values (271, 61);
insert into HASA (forest_id, action_id)
values (271, 85);
insert into HASA (forest_id, action_id)
values (271, 127);
insert into HASA (forest_id, action_id)
values (271, 156);
insert into HASA (forest_id, action_id)
values (271, 182);
insert into HASA (forest_id, action_id)
values (271, 193);
insert into HASA (forest_id, action_id)
values (271, 210);
insert into HASA (forest_id, action_id)
values (271, 373);
insert into HASA (forest_id, action_id)
values (272, 125);
insert into HASA (forest_id, action_id)
values (272, 296);
insert into HASA (forest_id, action_id)
values (273, 16);
insert into HASA (forest_id, action_id)
values (273, 85);
insert into HASA (forest_id, action_id)
values (273, 244);
insert into HASA (forest_id, action_id)
values (273, 252);
insert into HASA (forest_id, action_id)
values (273, 315);
insert into HASA (forest_id, action_id)
values (274, 6);
insert into HASA (forest_id, action_id)
values (274, 293);
insert into HASA (forest_id, action_id)
values (274, 321);
insert into HASA (forest_id, action_id)
values (275, 4);
insert into HASA (forest_id, action_id)
values (275, 86);
insert into HASA (forest_id, action_id)
values (275, 157);
insert into HASA (forest_id, action_id)
values (275, 255);
insert into HASA (forest_id, action_id)
values (275, 271);
insert into HASA (forest_id, action_id)
values (276, 51);
insert into HASA (forest_id, action_id)
values (276, 70);
commit;
prompt 500 records committed...
insert into HASA (forest_id, action_id)
values (276, 97);
insert into HASA (forest_id, action_id)
values (276, 105);
insert into HASA (forest_id, action_id)
values (276, 142);
insert into HASA (forest_id, action_id)
values (276, 160);
insert into HASA (forest_id, action_id)
values (276, 239);
insert into HASA (forest_id, action_id)
values (276, 369);
insert into HASA (forest_id, action_id)
values (277, 78);
insert into HASA (forest_id, action_id)
values (277, 93);
insert into HASA (forest_id, action_id)
values (277, 119);
insert into HASA (forest_id, action_id)
values (277, 250);
insert into HASA (forest_id, action_id)
values (278, 126);
insert into HASA (forest_id, action_id)
values (278, 314);
insert into HASA (forest_id, action_id)
values (278, 330);
insert into HASA (forest_id, action_id)
values (278, 383);
insert into HASA (forest_id, action_id)
values (279, 18);
insert into HASA (forest_id, action_id)
values (279, 82);
insert into HASA (forest_id, action_id)
values (280, 7);
insert into HASA (forest_id, action_id)
values (280, 44);
insert into HASA (forest_id, action_id)
values (280, 110);
insert into HASA (forest_id, action_id)
values (280, 203);
insert into HASA (forest_id, action_id)
values (280, 249);
insert into HASA (forest_id, action_id)
values (280, 255);
insert into HASA (forest_id, action_id)
values (280, 395);
insert into HASA (forest_id, action_id)
values (281, 250);
insert into HASA (forest_id, action_id)
values (281, 266);
insert into HASA (forest_id, action_id)
values (281, 303);
insert into HASA (forest_id, action_id)
values (281, 314);
insert into HASA (forest_id, action_id)
values (282, 55);
insert into HASA (forest_id, action_id)
values (282, 90);
insert into HASA (forest_id, action_id)
values (282, 168);
insert into HASA (forest_id, action_id)
values (282, 178);
insert into HASA (forest_id, action_id)
values (282, 223);
insert into HASA (forest_id, action_id)
values (283, 39);
insert into HASA (forest_id, action_id)
values (283, 82);
insert into HASA (forest_id, action_id)
values (283, 170);
insert into HASA (forest_id, action_id)
values (283, 192);
insert into HASA (forest_id, action_id)
values (283, 260);
insert into HASA (forest_id, action_id)
values (284, 133);
insert into HASA (forest_id, action_id)
values (284, 146);
insert into HASA (forest_id, action_id)
values (284, 184);
insert into HASA (forest_id, action_id)
values (284, 202);
insert into HASA (forest_id, action_id)
values (284, 249);
insert into HASA (forest_id, action_id)
values (284, 311);
insert into HASA (forest_id, action_id)
values (285, 64);
insert into HASA (forest_id, action_id)
values (285, 139);
insert into HASA (forest_id, action_id)
values (285, 180);
insert into HASA (forest_id, action_id)
values (286, 60);
insert into HASA (forest_id, action_id)
values (286, 228);
insert into HASA (forest_id, action_id)
values (286, 366);
insert into HASA (forest_id, action_id)
values (287, 60);
insert into HASA (forest_id, action_id)
values (287, 94);
insert into HASA (forest_id, action_id)
values (287, 130);
insert into HASA (forest_id, action_id)
values (287, 143);
insert into HASA (forest_id, action_id)
values (287, 248);
insert into HASA (forest_id, action_id)
values (287, 339);
insert into HASA (forest_id, action_id)
values (287, 366);
insert into HASA (forest_id, action_id)
values (288, 82);
insert into HASA (forest_id, action_id)
values (288, 310);
insert into HASA (forest_id, action_id)
values (288, 328);
insert into HASA (forest_id, action_id)
values (288, 395);
insert into HASA (forest_id, action_id)
values (289, 75);
insert into HASA (forest_id, action_id)
values (289, 111);
insert into HASA (forest_id, action_id)
values (289, 135);
insert into HASA (forest_id, action_id)
values (290, 3);
insert into HASA (forest_id, action_id)
values (290, 82);
insert into HASA (forest_id, action_id)
values (290, 343);
insert into HASA (forest_id, action_id)
values (290, 392);
insert into HASA (forest_id, action_id)
values (291, 209);
insert into HASA (forest_id, action_id)
values (291, 338);
insert into HASA (forest_id, action_id)
values (291, 355);
insert into HASA (forest_id, action_id)
values (292, 5);
insert into HASA (forest_id, action_id)
values (292, 13);
insert into HASA (forest_id, action_id)
values (292, 26);
insert into HASA (forest_id, action_id)
values (292, 32);
insert into HASA (forest_id, action_id)
values (292, 65);
insert into HASA (forest_id, action_id)
values (292, 145);
insert into HASA (forest_id, action_id)
values (292, 200);
insert into HASA (forest_id, action_id)
values (292, 254);
insert into HASA (forest_id, action_id)
values (292, 363);
insert into HASA (forest_id, action_id)
values (293, 21);
insert into HASA (forest_id, action_id)
values (293, 138);
insert into HASA (forest_id, action_id)
values (293, 146);
insert into HASA (forest_id, action_id)
values (293, 305);
insert into HASA (forest_id, action_id)
values (293, 358);
insert into HASA (forest_id, action_id)
values (294, 50);
insert into HASA (forest_id, action_id)
values (294, 63);
insert into HASA (forest_id, action_id)
values (294, 354);
insert into HASA (forest_id, action_id)
values (294, 363);
insert into HASA (forest_id, action_id)
values (295, 27);
insert into HASA (forest_id, action_id)
values (295, 263);
insert into HASA (forest_id, action_id)
values (296, 9);
insert into HASA (forest_id, action_id)
values (296, 190);
insert into HASA (forest_id, action_id)
values (296, 348);
insert into HASA (forest_id, action_id)
values (296, 386);
insert into HASA (forest_id, action_id)
values (297, 99);
insert into HASA (forest_id, action_id)
values (297, 223);
insert into HASA (forest_id, action_id)
values (297, 272);
insert into HASA (forest_id, action_id)
values (297, 329);
insert into HASA (forest_id, action_id)
values (297, 342);
insert into HASA (forest_id, action_id)
values (298, 77);
commit;
prompt 600 records committed...
insert into HASA (forest_id, action_id)
values (298, 177);
insert into HASA (forest_id, action_id)
values (298, 231);
insert into HASA (forest_id, action_id)
values (298, 344);
insert into HASA (forest_id, action_id)
values (299, 272);
insert into HASA (forest_id, action_id)
values (299, 386);
insert into HASA (forest_id, action_id)
values (300, 168);
insert into HASA (forest_id, action_id)
values (300, 198);
insert into HASA (forest_id, action_id)
values (301, 6);
insert into HASA (forest_id, action_id)
values (301, 112);
insert into HASA (forest_id, action_id)
values (301, 283);
insert into HASA (forest_id, action_id)
values (301, 312);
insert into HASA (forest_id, action_id)
values (302, 196);
insert into HASA (forest_id, action_id)
values (302, 252);
insert into HASA (forest_id, action_id)
values (303, 213);
insert into HASA (forest_id, action_id)
values (303, 306);
insert into HASA (forest_id, action_id)
values (303, 308);
insert into HASA (forest_id, action_id)
values (304, 46);
insert into HASA (forest_id, action_id)
values (304, 162);
insert into HASA (forest_id, action_id)
values (305, 182);
insert into HASA (forest_id, action_id)
values (305, 212);
insert into HASA (forest_id, action_id)
values (305, 214);
insert into HASA (forest_id, action_id)
values (306, 75);
insert into HASA (forest_id, action_id)
values (306, 215);
insert into HASA (forest_id, action_id)
values (306, 247);
insert into HASA (forest_id, action_id)
values (306, 352);
insert into HASA (forest_id, action_id)
values (307, 100);
insert into HASA (forest_id, action_id)
values (307, 241);
insert into HASA (forest_id, action_id)
values (308, 114);
insert into HASA (forest_id, action_id)
values (308, 313);
insert into HASA (forest_id, action_id)
values (308, 337);
insert into HASA (forest_id, action_id)
values (309, 89);
insert into HASA (forest_id, action_id)
values (309, 311);
insert into HASA (forest_id, action_id)
values (309, 360);
insert into HASA (forest_id, action_id)
values (310, 369);
insert into HASA (forest_id, action_id)
values (311, 10);
insert into HASA (forest_id, action_id)
values (311, 174);
insert into HASA (forest_id, action_id)
values (311, 273);
insert into HASA (forest_id, action_id)
values (312, 115);
insert into HASA (forest_id, action_id)
values (312, 234);
insert into HASA (forest_id, action_id)
values (313, 59);
insert into HASA (forest_id, action_id)
values (313, 121);
insert into HASA (forest_id, action_id)
values (313, 159);
insert into HASA (forest_id, action_id)
values (314, 84);
insert into HASA (forest_id, action_id)
values (314, 190);
insert into HASA (forest_id, action_id)
values (314, 204);
insert into HASA (forest_id, action_id)
values (314, 258);
insert into HASA (forest_id, action_id)
values (314, 342);
insert into HASA (forest_id, action_id)
values (314, 392);
insert into HASA (forest_id, action_id)
values (315, 3);
insert into HASA (forest_id, action_id)
values (315, 116);
insert into HASA (forest_id, action_id)
values (315, 178);
insert into HASA (forest_id, action_id)
values (315, 232);
insert into HASA (forest_id, action_id)
values (315, 251);
insert into HASA (forest_id, action_id)
values (315, 272);
insert into HASA (forest_id, action_id)
values (315, 284);
insert into HASA (forest_id, action_id)
values (315, 289);
insert into HASA (forest_id, action_id)
values (315, 370);
insert into HASA (forest_id, action_id)
values (316, 124);
insert into HASA (forest_id, action_id)
values (316, 133);
insert into HASA (forest_id, action_id)
values (317, 169);
insert into HASA (forest_id, action_id)
values (317, 227);
insert into HASA (forest_id, action_id)
values (317, 294);
insert into HASA (forest_id, action_id)
values (318, 220);
insert into HASA (forest_id, action_id)
values (318, 253);
insert into HASA (forest_id, action_id)
values (318, 268);
insert into HASA (forest_id, action_id)
values (318, 377);
insert into HASA (forest_id, action_id)
values (319, 7);
insert into HASA (forest_id, action_id)
values (319, 73);
insert into HASA (forest_id, action_id)
values (319, 76);
insert into HASA (forest_id, action_id)
values (319, 124);
insert into HASA (forest_id, action_id)
values (319, 273);
insert into HASA (forest_id, action_id)
values (319, 276);
insert into HASA (forest_id, action_id)
values (319, 376);
insert into HASA (forest_id, action_id)
values (319, 384);
insert into HASA (forest_id, action_id)
values (320, 25);
insert into HASA (forest_id, action_id)
values (320, 75);
insert into HASA (forest_id, action_id)
values (320, 133);
insert into HASA (forest_id, action_id)
values (320, 219);
insert into HASA (forest_id, action_id)
values (320, 255);
insert into HASA (forest_id, action_id)
values (321, 13);
insert into HASA (forest_id, action_id)
values (321, 389);
insert into HASA (forest_id, action_id)
values (322, 94);
insert into HASA (forest_id, action_id)
values (322, 227);
insert into HASA (forest_id, action_id)
values (323, 81);
insert into HASA (forest_id, action_id)
values (324, 109);
insert into HASA (forest_id, action_id)
values (324, 212);
insert into HASA (forest_id, action_id)
values (324, 283);
insert into HASA (forest_id, action_id)
values (325, 51);
insert into HASA (forest_id, action_id)
values (325, 65);
insert into HASA (forest_id, action_id)
values (325, 70);
insert into HASA (forest_id, action_id)
values (325, 253);
insert into HASA (forest_id, action_id)
values (325, 337);
insert into HASA (forest_id, action_id)
values (325, 385);
insert into HASA (forest_id, action_id)
values (326, 94);
insert into HASA (forest_id, action_id)
values (326, 200);
insert into HASA (forest_id, action_id)
values (326, 277);
insert into HASA (forest_id, action_id)
values (327, 102);
insert into HASA (forest_id, action_id)
values (327, 274);
insert into HASA (forest_id, action_id)
values (328, 289);
insert into HASA (forest_id, action_id)
values (329, 50);
commit;
prompt 700 records committed...
insert into HASA (forest_id, action_id)
values (329, 140);
insert into HASA (forest_id, action_id)
values (329, 165);
insert into HASA (forest_id, action_id)
values (329, 206);
insert into HASA (forest_id, action_id)
values (329, 262);
insert into HASA (forest_id, action_id)
values (329, 344);
insert into HASA (forest_id, action_id)
values (330, 1);
insert into HASA (forest_id, action_id)
values (330, 43);
insert into HASA (forest_id, action_id)
values (330, 149);
insert into HASA (forest_id, action_id)
values (330, 352);
insert into HASA (forest_id, action_id)
values (330, 368);
insert into HASA (forest_id, action_id)
values (330, 379);
insert into HASA (forest_id, action_id)
values (331, 105);
insert into HASA (forest_id, action_id)
values (331, 210);
insert into HASA (forest_id, action_id)
values (331, 238);
insert into HASA (forest_id, action_id)
values (331, 301);
insert into HASA (forest_id, action_id)
values (332, 64);
insert into HASA (forest_id, action_id)
values (332, 81);
insert into HASA (forest_id, action_id)
values (332, 98);
insert into HASA (forest_id, action_id)
values (332, 128);
insert into HASA (forest_id, action_id)
values (332, 180);
insert into HASA (forest_id, action_id)
values (332, 297);
insert into HASA (forest_id, action_id)
values (332, 303);
insert into HASA (forest_id, action_id)
values (332, 378);
insert into HASA (forest_id, action_id)
values (333, 9);
insert into HASA (forest_id, action_id)
values (333, 101);
insert into HASA (forest_id, action_id)
values (333, 164);
insert into HASA (forest_id, action_id)
values (333, 351);
insert into HASA (forest_id, action_id)
values (333, 380);
insert into HASA (forest_id, action_id)
values (334, 34);
insert into HASA (forest_id, action_id)
values (334, 118);
insert into HASA (forest_id, action_id)
values (335, 261);
insert into HASA (forest_id, action_id)
values (335, 278);
insert into HASA (forest_id, action_id)
values (335, 394);
insert into HASA (forest_id, action_id)
values (336, 16);
insert into HASA (forest_id, action_id)
values (336, 74);
insert into HASA (forest_id, action_id)
values (336, 128);
insert into HASA (forest_id, action_id)
values (336, 204);
insert into HASA (forest_id, action_id)
values (336, 298);
insert into HASA (forest_id, action_id)
values (336, 329);
insert into HASA (forest_id, action_id)
values (337, 187);
insert into HASA (forest_id, action_id)
values (337, 218);
insert into HASA (forest_id, action_id)
values (337, 306);
insert into HASA (forest_id, action_id)
values (337, 317);
insert into HASA (forest_id, action_id)
values (338, 49);
insert into HASA (forest_id, action_id)
values (338, 157);
insert into HASA (forest_id, action_id)
values (338, 201);
insert into HASA (forest_id, action_id)
values (338, 267);
insert into HASA (forest_id, action_id)
values (339, 108);
insert into HASA (forest_id, action_id)
values (339, 298);
insert into HASA (forest_id, action_id)
values (339, 348);
insert into HASA (forest_id, action_id)
values (339, 375);
insert into HASA (forest_id, action_id)
values (340, 80);
insert into HASA (forest_id, action_id)
values (340, 156);
insert into HASA (forest_id, action_id)
values (340, 179);
insert into HASA (forest_id, action_id)
values (340, 255);
insert into HASA (forest_id, action_id)
values (340, 278);
insert into HASA (forest_id, action_id)
values (340, 383);
insert into HASA (forest_id, action_id)
values (341, 41);
insert into HASA (forest_id, action_id)
values (341, 54);
insert into HASA (forest_id, action_id)
values (341, 56);
insert into HASA (forest_id, action_id)
values (341, 179);
insert into HASA (forest_id, action_id)
values (342, 54);
insert into HASA (forest_id, action_id)
values (342, 231);
insert into HASA (forest_id, action_id)
values (342, 259);
insert into HASA (forest_id, action_id)
values (343, 181);
insert into HASA (forest_id, action_id)
values (343, 328);
insert into HASA (forest_id, action_id)
values (344, 33);
insert into HASA (forest_id, action_id)
values (344, 42);
insert into HASA (forest_id, action_id)
values (345, 125);
insert into HASA (forest_id, action_id)
values (345, 135);
insert into HASA (forest_id, action_id)
values (345, 146);
insert into HASA (forest_id, action_id)
values (345, 372);
insert into HASA (forest_id, action_id)
values (345, 399);
insert into HASA (forest_id, action_id)
values (346, 21);
insert into HASA (forest_id, action_id)
values (346, 195);
insert into HASA (forest_id, action_id)
values (346, 198);
insert into HASA (forest_id, action_id)
values (346, 238);
insert into HASA (forest_id, action_id)
values (347, 18);
insert into HASA (forest_id, action_id)
values (347, 43);
insert into HASA (forest_id, action_id)
values (347, 45);
insert into HASA (forest_id, action_id)
values (347, 87);
insert into HASA (forest_id, action_id)
values (347, 127);
insert into HASA (forest_id, action_id)
values (347, 156);
insert into HASA (forest_id, action_id)
values (347, 323);
insert into HASA (forest_id, action_id)
values (348, 60);
insert into HASA (forest_id, action_id)
values (348, 73);
insert into HASA (forest_id, action_id)
values (348, 93);
insert into HASA (forest_id, action_id)
values (348, 101);
insert into HASA (forest_id, action_id)
values (348, 236);
insert into HASA (forest_id, action_id)
values (348, 275);
insert into HASA (forest_id, action_id)
values (348, 284);
insert into HASA (forest_id, action_id)
values (348, 374);
insert into HASA (forest_id, action_id)
values (349, 90);
insert into HASA (forest_id, action_id)
values (349, 180);
insert into HASA (forest_id, action_id)
values (349, 216);
insert into HASA (forest_id, action_id)
values (350, 95);
insert into HASA (forest_id, action_id)
values (350, 110);
insert into HASA (forest_id, action_id)
values (350, 130);
insert into HASA (forest_id, action_id)
values (350, 133);
insert into HASA (forest_id, action_id)
values (350, 208);
commit;
prompt 800 records committed...
insert into HASA (forest_id, action_id)
values (350, 211);
insert into HASA (forest_id, action_id)
values (350, 287);
insert into HASA (forest_id, action_id)
values (351, 7);
insert into HASA (forest_id, action_id)
values (351, 362);
insert into HASA (forest_id, action_id)
values (352, 81);
insert into HASA (forest_id, action_id)
values (352, 107);
insert into HASA (forest_id, action_id)
values (352, 153);
insert into HASA (forest_id, action_id)
values (352, 196);
insert into HASA (forest_id, action_id)
values (352, 263);
insert into HASA (forest_id, action_id)
values (352, 376);
insert into HASA (forest_id, action_id)
values (353, 1);
insert into HASA (forest_id, action_id)
values (353, 15);
insert into HASA (forest_id, action_id)
values (353, 351);
insert into HASA (forest_id, action_id)
values (354, 152);
insert into HASA (forest_id, action_id)
values (354, 157);
insert into HASA (forest_id, action_id)
values (355, 57);
insert into HASA (forest_id, action_id)
values (355, 251);
insert into HASA (forest_id, action_id)
values (356, 2);
insert into HASA (forest_id, action_id)
values (356, 59);
insert into HASA (forest_id, action_id)
values (356, 167);
insert into HASA (forest_id, action_id)
values (356, 356);
insert into HASA (forest_id, action_id)
values (356, 388);
insert into HASA (forest_id, action_id)
values (357, 9);
insert into HASA (forest_id, action_id)
values (357, 57);
insert into HASA (forest_id, action_id)
values (357, 79);
insert into HASA (forest_id, action_id)
values (357, 215);
insert into HASA (forest_id, action_id)
values (357, 245);
insert into HASA (forest_id, action_id)
values (357, 311);
insert into HASA (forest_id, action_id)
values (358, 151);
insert into HASA (forest_id, action_id)
values (358, 155);
insert into HASA (forest_id, action_id)
values (358, 207);
insert into HASA (forest_id, action_id)
values (358, 271);
insert into HASA (forest_id, action_id)
values (358, 358);
insert into HASA (forest_id, action_id)
values (359, 97);
insert into HASA (forest_id, action_id)
values (360, 20);
insert into HASA (forest_id, action_id)
values (360, 44);
insert into HASA (forest_id, action_id)
values (360, 47);
insert into HASA (forest_id, action_id)
values (360, 249);
insert into HASA (forest_id, action_id)
values (360, 267);
insert into HASA (forest_id, action_id)
values (361, 25);
insert into HASA (forest_id, action_id)
values (361, 286);
insert into HASA (forest_id, action_id)
values (361, 318);
insert into HASA (forest_id, action_id)
values (361, 366);
insert into HASA (forest_id, action_id)
values (362, 79);
insert into HASA (forest_id, action_id)
values (362, 94);
insert into HASA (forest_id, action_id)
values (362, 258);
insert into HASA (forest_id, action_id)
values (362, 379);
insert into HASA (forest_id, action_id)
values (364, 21);
insert into HASA (forest_id, action_id)
values (364, 94);
insert into HASA (forest_id, action_id)
values (364, 214);
insert into HASA (forest_id, action_id)
values (364, 302);
insert into HASA (forest_id, action_id)
values (364, 329);
insert into HASA (forest_id, action_id)
values (365, 125);
insert into HASA (forest_id, action_id)
values (365, 157);
insert into HASA (forest_id, action_id)
values (365, 174);
insert into HASA (forest_id, action_id)
values (365, 233);
insert into HASA (forest_id, action_id)
values (365, 327);
insert into HASA (forest_id, action_id)
values (366, 25);
insert into HASA (forest_id, action_id)
values (366, 52);
insert into HASA (forest_id, action_id)
values (366, 130);
insert into HASA (forest_id, action_id)
values (366, 331);
insert into HASA (forest_id, action_id)
values (367, 271);
insert into HASA (forest_id, action_id)
values (367, 372);
insert into HASA (forest_id, action_id)
values (368, 92);
insert into HASA (forest_id, action_id)
values (368, 153);
insert into HASA (forest_id, action_id)
values (368, 278);
insert into HASA (forest_id, action_id)
values (368, 297);
insert into HASA (forest_id, action_id)
values (368, 351);
insert into HASA (forest_id, action_id)
values (368, 373);
insert into HASA (forest_id, action_id)
values (369, 241);
insert into HASA (forest_id, action_id)
values (369, 348);
insert into HASA (forest_id, action_id)
values (369, 359);
insert into HASA (forest_id, action_id)
values (370, 21);
insert into HASA (forest_id, action_id)
values (370, 30);
insert into HASA (forest_id, action_id)
values (370, 128);
insert into HASA (forest_id, action_id)
values (370, 316);
insert into HASA (forest_id, action_id)
values (370, 319);
insert into HASA (forest_id, action_id)
values (370, 328);
insert into HASA (forest_id, action_id)
values (370, 368);
insert into HASA (forest_id, action_id)
values (371, 127);
insert into HASA (forest_id, action_id)
values (371, 147);
insert into HASA (forest_id, action_id)
values (371, 194);
insert into HASA (forest_id, action_id)
values (371, 305);
insert into HASA (forest_id, action_id)
values (371, 393);
insert into HASA (forest_id, action_id)
values (372, 5);
insert into HASA (forest_id, action_id)
values (372, 156);
insert into HASA (forest_id, action_id)
values (372, 315);
insert into HASA (forest_id, action_id)
values (372, 316);
insert into HASA (forest_id, action_id)
values (373, 30);
insert into HASA (forest_id, action_id)
values (373, 31);
insert into HASA (forest_id, action_id)
values (373, 217);
insert into HASA (forest_id, action_id)
values (373, 225);
insert into HASA (forest_id, action_id)
values (373, 276);
insert into HASA (forest_id, action_id)
values (374, 33);
insert into HASA (forest_id, action_id)
values (374, 85);
insert into HASA (forest_id, action_id)
values (374, 86);
insert into HASA (forest_id, action_id)
values (375, 76);
insert into HASA (forest_id, action_id)
values (375, 99);
insert into HASA (forest_id, action_id)
values (375, 100);
insert into HASA (forest_id, action_id)
values (375, 248);
commit;
prompt 900 records committed...
insert into HASA (forest_id, action_id)
values (376, 228);
insert into HASA (forest_id, action_id)
values (376, 354);
insert into HASA (forest_id, action_id)
values (377, 169);
insert into HASA (forest_id, action_id)
values (377, 298);
insert into HASA (forest_id, action_id)
values (378, 251);
insert into HASA (forest_id, action_id)
values (379, 112);
insert into HASA (forest_id, action_id)
values (379, 224);
insert into HASA (forest_id, action_id)
values (379, 378);
insert into HASA (forest_id, action_id)
values (379, 381);
insert into HASA (forest_id, action_id)
values (380, 142);
insert into HASA (forest_id, action_id)
values (380, 184);
insert into HASA (forest_id, action_id)
values (380, 270);
insert into HASA (forest_id, action_id)
values (381, 172);
insert into HASA (forest_id, action_id)
values (381, 378);
insert into HASA (forest_id, action_id)
values (381, 389);
insert into HASA (forest_id, action_id)
values (382, 12);
insert into HASA (forest_id, action_id)
values (382, 292);
insert into HASA (forest_id, action_id)
values (383, 8);
insert into HASA (forest_id, action_id)
values (383, 133);
insert into HASA (forest_id, action_id)
values (383, 184);
insert into HASA (forest_id, action_id)
values (383, 208);
insert into HASA (forest_id, action_id)
values (383, 390);
insert into HASA (forest_id, action_id)
values (384, 15);
insert into HASA (forest_id, action_id)
values (385, 165);
insert into HASA (forest_id, action_id)
values (385, 194);
insert into HASA (forest_id, action_id)
values (385, 257);
insert into HASA (forest_id, action_id)
values (385, 397);
insert into HASA (forest_id, action_id)
values (386, 72);
insert into HASA (forest_id, action_id)
values (386, 305);
insert into HASA (forest_id, action_id)
values (387, 5);
insert into HASA (forest_id, action_id)
values (388, 30);
insert into HASA (forest_id, action_id)
values (389, 364);
insert into HASA (forest_id, action_id)
values (390, 120);
insert into HASA (forest_id, action_id)
values (390, 248);
insert into HASA (forest_id, action_id)
values (390, 298);
insert into HASA (forest_id, action_id)
values (391, 268);
insert into HASA (forest_id, action_id)
values (392, 307);
insert into HASA (forest_id, action_id)
values (392, 322);
insert into HASA (forest_id, action_id)
values (393, 106);
insert into HASA (forest_id, action_id)
values (393, 122);
insert into HASA (forest_id, action_id)
values (393, 149);
insert into HASA (forest_id, action_id)
values (393, 383);
insert into HASA (forest_id, action_id)
values (394, 27);
insert into HASA (forest_id, action_id)
values (394, 34);
insert into HASA (forest_id, action_id)
values (394, 327);
insert into HASA (forest_id, action_id)
values (394, 374);
insert into HASA (forest_id, action_id)
values (395, 42);
insert into HASA (forest_id, action_id)
values (395, 53);
insert into HASA (forest_id, action_id)
values (396, 135);
insert into HASA (forest_id, action_id)
values (396, 239);
insert into HASA (forest_id, action_id)
values (397, 27);
insert into HASA (forest_id, action_id)
values (397, 63);
insert into HASA (forest_id, action_id)
values (397, 161);
insert into HASA (forest_id, action_id)
values (397, 359);
insert into HASA (forest_id, action_id)
values (397, 377);
insert into HASA (forest_id, action_id)
values (397, 394);
insert into HASA (forest_id, action_id)
values (398, 84);
insert into HASA (forest_id, action_id)
values (398, 139);
insert into HASA (forest_id, action_id)
values (398, 148);
insert into HASA (forest_id, action_id)
values (399, 92);
insert into HASA (forest_id, action_id)
values (399, 131);
insert into HASA (forest_id, action_id)
values (399, 340);
insert into HASA (forest_id, action_id)
values (400, 69);
insert into HASA (forest_id, action_id)
values (400, 79);
insert into HASA (forest_id, action_id)
values (400, 343);
insert into HASA (forest_id, action_id)
values (60, 23);
insert into HASA (forest_id, action_id)
values (60, 150);
insert into HASA (forest_id, action_id)
values (60, 166);
insert into HASA (forest_id, action_id)
values (60, 286);
insert into HASA (forest_id, action_id)
values (60, 298);
insert into HASA (forest_id, action_id)
values (61, 30);
insert into HASA (forest_id, action_id)
values (61, 84);
insert into HASA (forest_id, action_id)
values (61, 136);
insert into HASA (forest_id, action_id)
values (61, 234);
insert into HASA (forest_id, action_id)
values (61, 270);
insert into HASA (forest_id, action_id)
values (61, 327);
insert into HASA (forest_id, action_id)
values (61, 378);
insert into HASA (forest_id, action_id)
values (62, 100);
insert into HASA (forest_id, action_id)
values (62, 260);
insert into HASA (forest_id, action_id)
values (62, 306);
insert into HASA (forest_id, action_id)
values (62, 372);
insert into HASA (forest_id, action_id)
values (62, 387);
insert into HASA (forest_id, action_id)
values (63, 32);
insert into HASA (forest_id, action_id)
values (63, 80);
insert into HASA (forest_id, action_id)
values (63, 107);
insert into HASA (forest_id, action_id)
values (63, 183);
insert into HASA (forest_id, action_id)
values (63, 194);
insert into HASA (forest_id, action_id)
values (63, 368);
insert into HASA (forest_id, action_id)
values (64, 18);
insert into HASA (forest_id, action_id)
values (64, 44);
insert into HASA (forest_id, action_id)
values (64, 102);
insert into HASA (forest_id, action_id)
values (64, 108);
insert into HASA (forest_id, action_id)
values (64, 140);
insert into HASA (forest_id, action_id)
values (64, 191);
insert into HASA (forest_id, action_id)
values (64, 293);
insert into HASA (forest_id, action_id)
values (64, 329);
insert into HASA (forest_id, action_id)
values (65, 174);
insert into HASA (forest_id, action_id)
values (65, 215);
insert into HASA (forest_id, action_id)
values (65, 301);
insert into HASA (forest_id, action_id)
values (65, 309);
commit;
prompt 1000 records committed...
insert into HASA (forest_id, action_id)
values (65, 347);
insert into HASA (forest_id, action_id)
values (66, 4);
insert into HASA (forest_id, action_id)
values (66, 102);
insert into HASA (forest_id, action_id)
values (66, 117);
insert into HASA (forest_id, action_id)
values (66, 274);
insert into HASA (forest_id, action_id)
values (66, 307);
insert into HASA (forest_id, action_id)
values (67, 6);
insert into HASA (forest_id, action_id)
values (67, 140);
insert into HASA (forest_id, action_id)
values (67, 214);
insert into HASA (forest_id, action_id)
values (67, 277);
insert into HASA (forest_id, action_id)
values (67, 295);
insert into HASA (forest_id, action_id)
values (68, 190);
insert into HASA (forest_id, action_id)
values (68, 305);
insert into HASA (forest_id, action_id)
values (68, 312);
insert into HASA (forest_id, action_id)
values (68, 327);
insert into HASA (forest_id, action_id)
values (68, 363);
insert into HASA (forest_id, action_id)
values (68, 384);
insert into HASA (forest_id, action_id)
values (69, 188);
insert into HASA (forest_id, action_id)
values (69, 380);
insert into HASA (forest_id, action_id)
values (70, 190);
insert into HASA (forest_id, action_id)
values (71, 5);
insert into HASA (forest_id, action_id)
values (71, 28);
insert into HASA (forest_id, action_id)
values (71, 191);
insert into HASA (forest_id, action_id)
values (71, 217);
insert into HASA (forest_id, action_id)
values (71, 222);
insert into HASA (forest_id, action_id)
values (71, 255);
insert into HASA (forest_id, action_id)
values (71, 363);
insert into HASA (forest_id, action_id)
values (72, 21);
insert into HASA (forest_id, action_id)
values (72, 86);
insert into HASA (forest_id, action_id)
values (72, 236);
insert into HASA (forest_id, action_id)
values (72, 283);
insert into HASA (forest_id, action_id)
values (72, 317);
insert into HASA (forest_id, action_id)
values (73, 102);
insert into HASA (forest_id, action_id)
values (73, 124);
insert into HASA (forest_id, action_id)
values (73, 222);
insert into HASA (forest_id, action_id)
values (73, 240);
insert into HASA (forest_id, action_id)
values (73, 250);
insert into HASA (forest_id, action_id)
values (73, 274);
insert into HASA (forest_id, action_id)
values (74, 126);
insert into HASA (forest_id, action_id)
values (74, 184);
insert into HASA (forest_id, action_id)
values (74, 204);
insert into HASA (forest_id, action_id)
values (74, 228);
insert into HASA (forest_id, action_id)
values (75, 1);
insert into HASA (forest_id, action_id)
values (75, 22);
insert into HASA (forest_id, action_id)
values (75, 207);
insert into HASA (forest_id, action_id)
values (75, 261);
insert into HASA (forest_id, action_id)
values (76, 60);
insert into HASA (forest_id, action_id)
values (76, 117);
insert into HASA (forest_id, action_id)
values (76, 142);
insert into HASA (forest_id, action_id)
values (76, 169);
insert into HASA (forest_id, action_id)
values (76, 331);
insert into HASA (forest_id, action_id)
values (76, 389);
insert into HASA (forest_id, action_id)
values (76, 400);
insert into HASA (forest_id, action_id)
values (77, 66);
insert into HASA (forest_id, action_id)
values (77, 180);
insert into HASA (forest_id, action_id)
values (78, 96);
insert into HASA (forest_id, action_id)
values (78, 108);
insert into HASA (forest_id, action_id)
values (78, 212);
insert into HASA (forest_id, action_id)
values (78, 282);
insert into HASA (forest_id, action_id)
values (78, 383);
insert into HASA (forest_id, action_id)
values (79, 164);
insert into HASA (forest_id, action_id)
values (79, 190);
insert into HASA (forest_id, action_id)
values (79, 279);
insert into HASA (forest_id, action_id)
values (80, 6);
insert into HASA (forest_id, action_id)
values (80, 72);
insert into HASA (forest_id, action_id)
values (80, 274);
insert into HASA (forest_id, action_id)
values (80, 316);
insert into HASA (forest_id, action_id)
values (81, 395);
insert into HASA (forest_id, action_id)
values (82, 198);
insert into HASA (forest_id, action_id)
values (82, 234);
insert into HASA (forest_id, action_id)
values (83, 103);
insert into HASA (forest_id, action_id)
values (83, 111);
insert into HASA (forest_id, action_id)
values (83, 221);
insert into HASA (forest_id, action_id)
values (83, 244);
insert into HASA (forest_id, action_id)
values (83, 393);
insert into HASA (forest_id, action_id)
values (84, 137);
insert into HASA (forest_id, action_id)
values (84, 233);
insert into HASA (forest_id, action_id)
values (84, 268);
insert into HASA (forest_id, action_id)
values (84, 277);
insert into HASA (forest_id, action_id)
values (85, 17);
insert into HASA (forest_id, action_id)
values (85, 228);
insert into HASA (forest_id, action_id)
values (85, 297);
insert into HASA (forest_id, action_id)
values (85, 341);
insert into HASA (forest_id, action_id)
values (86, 119);
insert into HASA (forest_id, action_id)
values (86, 133);
insert into HASA (forest_id, action_id)
values (86, 148);
insert into HASA (forest_id, action_id)
values (86, 160);
insert into HASA (forest_id, action_id)
values (86, 371);
insert into HASA (forest_id, action_id)
values (86, 373);
insert into HASA (forest_id, action_id)
values (87, 226);
insert into HASA (forest_id, action_id)
values (87, 322);
insert into HASA (forest_id, action_id)
values (87, 355);
insert into HASA (forest_id, action_id)
values (88, 53);
insert into HASA (forest_id, action_id)
values (88, 189);
insert into HASA (forest_id, action_id)
values (88, 289);
insert into HASA (forest_id, action_id)
values (88, 390);
insert into HASA (forest_id, action_id)
values (89, 20);
insert into HASA (forest_id, action_id)
values (89, 76);
insert into HASA (forest_id, action_id)
values (89, 157);
insert into HASA (forest_id, action_id)
values (89, 240);
commit;
prompt 1100 records committed...
insert into HASA (forest_id, action_id)
values (89, 321);
insert into HASA (forest_id, action_id)
values (90, 12);
insert into HASA (forest_id, action_id)
values (90, 37);
insert into HASA (forest_id, action_id)
values (90, 80);
insert into HASA (forest_id, action_id)
values (90, 125);
insert into HASA (forest_id, action_id)
values (90, 240);
insert into HASA (forest_id, action_id)
values (90, 276);
insert into HASA (forest_id, action_id)
values (91, 23);
insert into HASA (forest_id, action_id)
values (91, 174);
insert into HASA (forest_id, action_id)
values (91, 190);
insert into HASA (forest_id, action_id)
values (91, 218);
insert into HASA (forest_id, action_id)
values (91, 275);
insert into HASA (forest_id, action_id)
values (91, 393);
insert into HASA (forest_id, action_id)
values (91, 395);
insert into HASA (forest_id, action_id)
values (92, 2);
insert into HASA (forest_id, action_id)
values (92, 23);
insert into HASA (forest_id, action_id)
values (92, 40);
insert into HASA (forest_id, action_id)
values (92, 191);
insert into HASA (forest_id, action_id)
values (93, 2);
insert into HASA (forest_id, action_id)
values (93, 82);
insert into HASA (forest_id, action_id)
values (93, 174);
insert into HASA (forest_id, action_id)
values (93, 185);
insert into HASA (forest_id, action_id)
values (93, 280);
insert into HASA (forest_id, action_id)
values (93, 340);
insert into HASA (forest_id, action_id)
values (93, 370);
insert into HASA (forest_id, action_id)
values (94, 42);
insert into HASA (forest_id, action_id)
values (94, 145);
insert into HASA (forest_id, action_id)
values (94, 169);
insert into HASA (forest_id, action_id)
values (94, 185);
insert into HASA (forest_id, action_id)
values (94, 277);
insert into HASA (forest_id, action_id)
values (94, 299);
insert into HASA (forest_id, action_id)
values (95, 149);
insert into HASA (forest_id, action_id)
values (95, 240);
insert into HASA (forest_id, action_id)
values (95, 380);
insert into HASA (forest_id, action_id)
values (96, 105);
insert into HASA (forest_id, action_id)
values (96, 131);
insert into HASA (forest_id, action_id)
values (96, 138);
insert into HASA (forest_id, action_id)
values (96, 277);
insert into HASA (forest_id, action_id)
values (96, 380);
insert into HASA (forest_id, action_id)
values (97, 70);
insert into HASA (forest_id, action_id)
values (97, 119);
insert into HASA (forest_id, action_id)
values (97, 303);
insert into HASA (forest_id, action_id)
values (98, 242);
insert into HASA (forest_id, action_id)
values (98, 342);
insert into HASA (forest_id, action_id)
values (99, 141);
insert into HASA (forest_id, action_id)
values (99, 162);
insert into HASA (forest_id, action_id)
values (99, 219);
insert into HASA (forest_id, action_id)
values (99, 269);
insert into HASA (forest_id, action_id)
values (100, 60);
insert into HASA (forest_id, action_id)
values (100, 273);
insert into HASA (forest_id, action_id)
values (100, 285);
insert into HASA (forest_id, action_id)
values (100, 299);
insert into HASA (forest_id, action_id)
values (101, 107);
insert into HASA (forest_id, action_id)
values (101, 192);
insert into HASA (forest_id, action_id)
values (101, 345);
insert into HASA (forest_id, action_id)
values (101, 386);
insert into HASA (forest_id, action_id)
values (102, 50);
insert into HASA (forest_id, action_id)
values (102, 79);
insert into HASA (forest_id, action_id)
values (102, 112);
insert into HASA (forest_id, action_id)
values (102, 290);
insert into HASA (forest_id, action_id)
values (102, 398);
insert into HASA (forest_id, action_id)
values (102, 400);
insert into HASA (forest_id, action_id)
values (103, 261);
insert into HASA (forest_id, action_id)
values (103, 307);
insert into HASA (forest_id, action_id)
values (103, 369);
insert into HASA (forest_id, action_id)
values (104, 155);
insert into HASA (forest_id, action_id)
values (104, 173);
insert into HASA (forest_id, action_id)
values (104, 254);
insert into HASA (forest_id, action_id)
values (105, 48);
insert into HASA (forest_id, action_id)
values (105, 91);
insert into HASA (forest_id, action_id)
values (105, 161);
insert into HASA (forest_id, action_id)
values (105, 211);
insert into HASA (forest_id, action_id)
values (105, 241);
insert into HASA (forest_id, action_id)
values (105, 283);
insert into HASA (forest_id, action_id)
values (105, 293);
insert into HASA (forest_id, action_id)
values (105, 324);
insert into HASA (forest_id, action_id)
values (106, 21);
insert into HASA (forest_id, action_id)
values (106, 233);
insert into HASA (forest_id, action_id)
values (106, 249);
insert into HASA (forest_id, action_id)
values (106, 342);
insert into HASA (forest_id, action_id)
values (107, 379);
insert into HASA (forest_id, action_id)
values (108, 64);
insert into HASA (forest_id, action_id)
values (108, 98);
insert into HASA (forest_id, action_id)
values (108, 142);
insert into HASA (forest_id, action_id)
values (108, 222);
insert into HASA (forest_id, action_id)
values (109, 258);
insert into HASA (forest_id, action_id)
values (109, 381);
insert into HASA (forest_id, action_id)
values (110, 109);
insert into HASA (forest_id, action_id)
values (110, 241);
insert into HASA (forest_id, action_id)
values (110, 289);
insert into HASA (forest_id, action_id)
values (110, 358);
insert into HASA (forest_id, action_id)
values (110, 397);
insert into HASA (forest_id, action_id)
values (111, 47);
insert into HASA (forest_id, action_id)
values (111, 177);
insert into HASA (forest_id, action_id)
values (111, 283);
insert into HASA (forest_id, action_id)
values (111, 339);
insert into HASA (forest_id, action_id)
values (112, 41);
insert into HASA (forest_id, action_id)
values (112, 87);
insert into HASA (forest_id, action_id)
values (112, 300);
insert into HASA (forest_id, action_id)
values (113, 35);
commit;
prompt 1200 records committed...
insert into HASA (forest_id, action_id)
values (113, 261);
insert into HASA (forest_id, action_id)
values (114, 23);
insert into HASA (forest_id, action_id)
values (114, 121);
insert into HASA (forest_id, action_id)
values (114, 148);
insert into HASA (forest_id, action_id)
values (114, 259);
insert into HASA (forest_id, action_id)
values (114, 304);
insert into HASA (forest_id, action_id)
values (114, 319);
insert into HASA (forest_id, action_id)
values (115, 18);
insert into HASA (forest_id, action_id)
values (115, 120);
insert into HASA (forest_id, action_id)
values (115, 146);
insert into HASA (forest_id, action_id)
values (115, 170);
insert into HASA (forest_id, action_id)
values (116, 34);
insert into HASA (forest_id, action_id)
values (116, 37);
insert into HASA (forest_id, action_id)
values (116, 214);
insert into HASA (forest_id, action_id)
values (116, 324);
insert into HASA (forest_id, action_id)
values (116, 385);
insert into HASA (forest_id, action_id)
values (116, 389);
insert into HASA (forest_id, action_id)
values (117, 183);
insert into HASA (forest_id, action_id)
values (117, 254);
insert into HASA (forest_id, action_id)
values (117, 298);
insert into HASA (forest_id, action_id)
values (118, 150);
insert into HASA (forest_id, action_id)
values (118, 326);
insert into HASA (forest_id, action_id)
values (118, 335);
insert into HASA (forest_id, action_id)
values (118, 338);
insert into HASA (forest_id, action_id)
values (119, 14);
insert into HASA (forest_id, action_id)
values (119, 200);
insert into HASA (forest_id, action_id)
values (119, 332);
insert into HASA (forest_id, action_id)
values (120, 250);
insert into HASA (forest_id, action_id)
values (120, 337);
insert into HASA (forest_id, action_id)
values (120, 343);
insert into HASA (forest_id, action_id)
values (120, 376);
insert into HASA (forest_id, action_id)
values (121, 49);
insert into HASA (forest_id, action_id)
values (121, 139);
insert into HASA (forest_id, action_id)
values (121, 162);
insert into HASA (forest_id, action_id)
values (121, 332);
insert into HASA (forest_id, action_id)
values (122, 313);
insert into HASA (forest_id, action_id)
values (122, 332);
insert into HASA (forest_id, action_id)
values (122, 382);
insert into HASA (forest_id, action_id)
values (123, 9);
insert into HASA (forest_id, action_id)
values (123, 136);
insert into HASA (forest_id, action_id)
values (123, 281);
insert into HASA (forest_id, action_id)
values (123, 288);
insert into HASA (forest_id, action_id)
values (123, 347);
insert into HASA (forest_id, action_id)
values (123, 348);
insert into HASA (forest_id, action_id)
values (123, 371);
insert into HASA (forest_id, action_id)
values (124, 183);
insert into HASA (forest_id, action_id)
values (124, 225);
insert into HASA (forest_id, action_id)
values (124, 285);
insert into HASA (forest_id, action_id)
values (124, 350);
insert into HASA (forest_id, action_id)
values (125, 63);
insert into HASA (forest_id, action_id)
values (125, 166);
insert into HASA (forest_id, action_id)
values (125, 210);
insert into HASA (forest_id, action_id)
values (125, 303);
insert into HASA (forest_id, action_id)
values (125, 329);
insert into HASA (forest_id, action_id)
values (126, 86);
insert into HASA (forest_id, action_id)
values (126, 136);
insert into HASA (forest_id, action_id)
values (126, 285);
insert into HASA (forest_id, action_id)
values (127, 31);
insert into HASA (forest_id, action_id)
values (127, 224);
insert into HASA (forest_id, action_id)
values (127, 283);
insert into HASA (forest_id, action_id)
values (128, 295);
insert into HASA (forest_id, action_id)
values (128, 392);
insert into HASA (forest_id, action_id)
values (128, 399);
insert into HASA (forest_id, action_id)
values (129, 108);
insert into HASA (forest_id, action_id)
values (129, 195);
insert into HASA (forest_id, action_id)
values (129, 313);
insert into HASA (forest_id, action_id)
values (129, 332);
insert into HASA (forest_id, action_id)
values (129, 391);
insert into HASA (forest_id, action_id)
values (130, 113);
insert into HASA (forest_id, action_id)
values (130, 161);
insert into HASA (forest_id, action_id)
values (130, 356);
insert into HASA (forest_id, action_id)
values (130, 388);
insert into HASA (forest_id, action_id)
values (131, 107);
insert into HASA (forest_id, action_id)
values (131, 355);
insert into HASA (forest_id, action_id)
values (132, 16);
insert into HASA (forest_id, action_id)
values (132, 17);
insert into HASA (forest_id, action_id)
values (132, 45);
insert into HASA (forest_id, action_id)
values (132, 179);
insert into HASA (forest_id, action_id)
values (132, 248);
insert into HASA (forest_id, action_id)
values (133, 88);
insert into HASA (forest_id, action_id)
values (134, 25);
insert into HASA (forest_id, action_id)
values (134, 69);
insert into HASA (forest_id, action_id)
values (134, 88);
insert into HASA (forest_id, action_id)
values (134, 117);
insert into HASA (forest_id, action_id)
values (135, 30);
insert into HASA (forest_id, action_id)
values (135, 99);
insert into HASA (forest_id, action_id)
values (135, 110);
insert into HASA (forest_id, action_id)
values (135, 144);
insert into HASA (forest_id, action_id)
values (135, 222);
insert into HASA (forest_id, action_id)
values (136, 206);
insert into HASA (forest_id, action_id)
values (136, 249);
insert into HASA (forest_id, action_id)
values (137, 59);
insert into HASA (forest_id, action_id)
values (137, 261);
insert into HASA (forest_id, action_id)
values (137, 288);
insert into HASA (forest_id, action_id)
values (138, 2);
insert into HASA (forest_id, action_id)
values (138, 42);
insert into HASA (forest_id, action_id)
values (138, 317);
insert into HASA (forest_id, action_id)
values (139, 105);
insert into HASA (forest_id, action_id)
values (139, 133);
insert into HASA (forest_id, action_id)
values (139, 163);
commit;
prompt 1300 records committed...
insert into HASA (forest_id, action_id)
values (139, 166);
insert into HASA (forest_id, action_id)
values (139, 168);
insert into HASA (forest_id, action_id)
values (140, 83);
insert into HASA (forest_id, action_id)
values (140, 182);
insert into HASA (forest_id, action_id)
values (140, 250);
insert into HASA (forest_id, action_id)
values (140, 259);
insert into HASA (forest_id, action_id)
values (140, 312);
insert into HASA (forest_id, action_id)
values (142, 31);
insert into HASA (forest_id, action_id)
values (142, 87);
insert into HASA (forest_id, action_id)
values (142, 92);
insert into HASA (forest_id, action_id)
values (142, 119);
insert into HASA (forest_id, action_id)
values (142, 257);
insert into HASA (forest_id, action_id)
values (142, 324);
insert into HASA (forest_id, action_id)
values (142, 328);
insert into HASA (forest_id, action_id)
values (142, 382);
insert into HASA (forest_id, action_id)
values (143, 62);
insert into HASA (forest_id, action_id)
values (143, 210);
insert into HASA (forest_id, action_id)
values (143, 396);
insert into HASA (forest_id, action_id)
values (144, 81);
insert into HASA (forest_id, action_id)
values (144, 125);
insert into HASA (forest_id, action_id)
values (144, 185);
insert into HASA (forest_id, action_id)
values (144, 269);
insert into HASA (forest_id, action_id)
values (144, 312);
insert into HASA (forest_id, action_id)
values (144, 320);
insert into HASA (forest_id, action_id)
values (145, 130);
insert into HASA (forest_id, action_id)
values (145, 250);
insert into HASA (forest_id, action_id)
values (145, 265);
insert into HASA (forest_id, action_id)
values (145, 342);
insert into HASA (forest_id, action_id)
values (146, 112);
insert into HASA (forest_id, action_id)
values (146, 129);
insert into HASA (forest_id, action_id)
values (146, 164);
insert into HASA (forest_id, action_id)
values (146, 293);
insert into HASA (forest_id, action_id)
values (146, 346);
insert into HASA (forest_id, action_id)
values (147, 21);
insert into HASA (forest_id, action_id)
values (147, 118);
insert into HASA (forest_id, action_id)
values (147, 179);
insert into HASA (forest_id, action_id)
values (148, 195);
insert into HASA (forest_id, action_id)
values (148, 253);
insert into HASA (forest_id, action_id)
values (148, 297);
insert into HASA (forest_id, action_id)
values (148, 311);
insert into HASA (forest_id, action_id)
values (148, 388);
insert into HASA (forest_id, action_id)
values (149, 93);
insert into HASA (forest_id, action_id)
values (149, 318);
insert into HASA (forest_id, action_id)
values (149, 372);
insert into HASA (forest_id, action_id)
values (150, 11);
insert into HASA (forest_id, action_id)
values (150, 16);
insert into HASA (forest_id, action_id)
values (150, 63);
insert into HASA (forest_id, action_id)
values (150, 122);
insert into HASA (forest_id, action_id)
values (150, 154);
insert into HASA (forest_id, action_id)
values (150, 364);
insert into HASA (forest_id, action_id)
values (151, 317);
insert into HASA (forest_id, action_id)
values (152, 26);
insert into HASA (forest_id, action_id)
values (152, 75);
insert into HASA (forest_id, action_id)
values (152, 95);
insert into HASA (forest_id, action_id)
values (152, 175);
insert into HASA (forest_id, action_id)
values (152, 176);
insert into HASA (forest_id, action_id)
values (152, 322);
insert into HASA (forest_id, action_id)
values (153, 70);
insert into HASA (forest_id, action_id)
values (153, 163);
insert into HASA (forest_id, action_id)
values (153, 291);
insert into HASA (forest_id, action_id)
values (154, 181);
insert into HASA (forest_id, action_id)
values (154, 225);
insert into HASA (forest_id, action_id)
values (154, 273);
insert into HASA (forest_id, action_id)
values (154, 354);
insert into HASA (forest_id, action_id)
values (155, 41);
insert into HASA (forest_id, action_id)
values (155, 213);
insert into HASA (forest_id, action_id)
values (155, 328);
insert into HASA (forest_id, action_id)
values (156, 144);
insert into HASA (forest_id, action_id)
values (156, 178);
insert into HASA (forest_id, action_id)
values (156, 181);
insert into HASA (forest_id, action_id)
values (156, 196);
insert into HASA (forest_id, action_id)
values (156, 315);
insert into HASA (forest_id, action_id)
values (156, 344);
insert into HASA (forest_id, action_id)
values (157, 41);
insert into HASA (forest_id, action_id)
values (157, 243);
insert into HASA (forest_id, action_id)
values (158, 210);
insert into HASA (forest_id, action_id)
values (159, 107);
insert into HASA (forest_id, action_id)
values (159, 293);
insert into HASA (forest_id, action_id)
values (160, 57);
insert into HASA (forest_id, action_id)
values (160, 106);
insert into HASA (forest_id, action_id)
values (161, 51);
insert into HASA (forest_id, action_id)
values (161, 291);
insert into HASA (forest_id, action_id)
values (162, 121);
insert into HASA (forest_id, action_id)
values (162, 131);
insert into HASA (forest_id, action_id)
values (162, 340);
insert into HASA (forest_id, action_id)
values (162, 342);
insert into HASA (forest_id, action_id)
values (162, 382);
insert into HASA (forest_id, action_id)
values (163, 61);
insert into HASA (forest_id, action_id)
values (163, 185);
insert into HASA (forest_id, action_id)
values (163, 319);
insert into HASA (forest_id, action_id)
values (164, 65);
insert into HASA (forest_id, action_id)
values (164, 217);
insert into HASA (forest_id, action_id)
values (164, 358);
insert into HASA (forest_id, action_id)
values (165, 102);
insert into HASA (forest_id, action_id)
values (166, 235);
insert into HASA (forest_id, action_id)
values (166, 246);
insert into HASA (forest_id, action_id)
values (166, 281);
insert into HASA (forest_id, action_id)
values (166, 374);
insert into HASA (forest_id, action_id)
values (167, 10);
insert into HASA (forest_id, action_id)
values (167, 88);
commit;
prompt 1400 records committed...
insert into HASA (forest_id, action_id)
values (167, 224);
insert into HASA (forest_id, action_id)
values (167, 261);
insert into HASA (forest_id, action_id)
values (167, 360);
insert into HASA (forest_id, action_id)
values (168, 129);
insert into HASA (forest_id, action_id)
values (168, 238);
insert into HASA (forest_id, action_id)
values (168, 274);
insert into HASA (forest_id, action_id)
values (168, 276);
insert into HASA (forest_id, action_id)
values (168, 330);
insert into HASA (forest_id, action_id)
values (169, 17);
insert into HASA (forest_id, action_id)
values (169, 85);
insert into HASA (forest_id, action_id)
values (169, 144);
insert into HASA (forest_id, action_id)
values (169, 309);
insert into HASA (forest_id, action_id)
values (169, 340);
insert into HASA (forest_id, action_id)
values (170, 28);
insert into HASA (forest_id, action_id)
values (170, 56);
insert into HASA (forest_id, action_id)
values (170, 320);
insert into HASA (forest_id, action_id)
values (170, 341);
insert into HASA (forest_id, action_id)
values (171, 89);
insert into HASA (forest_id, action_id)
values (171, 159);
insert into HASA (forest_id, action_id)
values (171, 250);
insert into HASA (forest_id, action_id)
values (171, 326);
insert into HASA (forest_id, action_id)
values (171, 330);
insert into HASA (forest_id, action_id)
values (172, 7);
insert into HASA (forest_id, action_id)
values (172, 216);
insert into HASA (forest_id, action_id)
values (172, 314);
insert into HASA (forest_id, action_id)
values (172, 365);
insert into HASA (forest_id, action_id)
values (172, 393);
insert into HASA (forest_id, action_id)
values (173, 75);
insert into HASA (forest_id, action_id)
values (173, 264);
insert into HASA (forest_id, action_id)
values (173, 304);
insert into HASA (forest_id, action_id)
values (174, 33);
insert into HASA (forest_id, action_id)
values (174, 216);
insert into HASA (forest_id, action_id)
values (174, 221);
insert into HASA (forest_id, action_id)
values (174, 270);
insert into HASA (forest_id, action_id)
values (174, 277);
insert into HASA (forest_id, action_id)
values (174, 313);
insert into HASA (forest_id, action_id)
values (174, 374);
insert into HASA (forest_id, action_id)
values (174, 389);
insert into HASA (forest_id, action_id)
values (175, 49);
insert into HASA (forest_id, action_id)
values (175, 220);
insert into HASA (forest_id, action_id)
values (175, 307);
insert into HASA (forest_id, action_id)
values (176, 135);
insert into HASA (forest_id, action_id)
values (176, 287);
insert into HASA (forest_id, action_id)
values (177, 22);
insert into HASA (forest_id, action_id)
values (177, 85);
insert into HASA (forest_id, action_id)
values (177, 121);
insert into HASA (forest_id, action_id)
values (177, 198);
insert into HASA (forest_id, action_id)
values (177, 373);
insert into HASA (forest_id, action_id)
values (178, 272);
insert into HASA (forest_id, action_id)
values (179, 120);
insert into HASA (forest_id, action_id)
values (179, 169);
insert into HASA (forest_id, action_id)
values (179, 186);
insert into HASA (forest_id, action_id)
values (179, 213);
insert into HASA (forest_id, action_id)
values (179, 264);
insert into HASA (forest_id, action_id)
values (179, 384);
insert into HASA (forest_id, action_id)
values (180, 43);
insert into HASA (forest_id, action_id)
values (180, 106);
insert into HASA (forest_id, action_id)
values (180, 146);
insert into HASA (forest_id, action_id)
values (180, 153);
insert into HASA (forest_id, action_id)
values (180, 176);
insert into HASA (forest_id, action_id)
values (180, 235);
insert into HASA (forest_id, action_id)
values (180, 282);
insert into HASA (forest_id, action_id)
values (180, 330);
insert into HASA (forest_id, action_id)
values (180, 332);
insert into HASA (forest_id, action_id)
values (181, 167);
insert into HASA (forest_id, action_id)
values (181, 182);
insert into HASA (forest_id, action_id)
values (181, 292);
insert into HASA (forest_id, action_id)
values (181, 315);
insert into HASA (forest_id, action_id)
values (182, 77);
insert into HASA (forest_id, action_id)
values (182, 144);
insert into HASA (forest_id, action_id)
values (182, 171);
insert into HASA (forest_id, action_id)
values (183, 145);
insert into HASA (forest_id, action_id)
values (183, 385);
insert into HASA (forest_id, action_id)
values (184, 190);
insert into HASA (forest_id, action_id)
values (184, 195);
insert into HASA (forest_id, action_id)
values (185, 82);
insert into HASA (forest_id, action_id)
values (185, 157);
insert into HASA (forest_id, action_id)
values (185, 187);
insert into HASA (forest_id, action_id)
values (185, 288);
insert into HASA (forest_id, action_id)
values (185, 337);
insert into HASA (forest_id, action_id)
values (186, 96);
insert into HASA (forest_id, action_id)
values (186, 204);
insert into HASA (forest_id, action_id)
values (186, 236);
insert into HASA (forest_id, action_id)
values (186, 305);
insert into HASA (forest_id, action_id)
values (186, 306);
insert into HASA (forest_id, action_id)
values (187, 179);
insert into HASA (forest_id, action_id)
values (187, 203);
insert into HASA (forest_id, action_id)
values (187, 369);
insert into HASA (forest_id, action_id)
values (188, 46);
insert into HASA (forest_id, action_id)
values (188, 48);
insert into HASA (forest_id, action_id)
values (188, 51);
insert into HASA (forest_id, action_id)
values (188, 58);
insert into HASA (forest_id, action_id)
values (188, 70);
insert into HASA (forest_id, action_id)
values (188, 162);
insert into HASA (forest_id, action_id)
values (189, 24);
insert into HASA (forest_id, action_id)
values (189, 97);
insert into HASA (forest_id, action_id)
values (189, 188);
insert into HASA (forest_id, action_id)
values (189, 220);
insert into HASA (forest_id, action_id)
values (189, 370);
insert into HASA (forest_id, action_id)
values (189, 392);
commit;
prompt 1500 records committed...
insert into HASA (forest_id, action_id)
values (190, 63);
insert into HASA (forest_id, action_id)
values (190, 361);
insert into HASA (forest_id, action_id)
values (190, 393);
insert into HASA (forest_id, action_id)
values (191, 178);
insert into HASA (forest_id, action_id)
values (191, 190);
insert into HASA (forest_id, action_id)
values (191, 252);
insert into HASA (forest_id, action_id)
values (191, 269);
insert into HASA (forest_id, action_id)
values (191, 284);
insert into HASA (forest_id, action_id)
values (191, 368);
insert into HASA (forest_id, action_id)
values (192, 262);
insert into HASA (forest_id, action_id)
values (192, 280);
insert into HASA (forest_id, action_id)
values (193, 62);
insert into HASA (forest_id, action_id)
values (193, 70);
insert into HASA (forest_id, action_id)
values (193, 324);
insert into HASA (forest_id, action_id)
values (194, 50);
insert into HASA (forest_id, action_id)
values (194, 93);
insert into HASA (forest_id, action_id)
values (194, 153);
insert into HASA (forest_id, action_id)
values (194, 172);
insert into HASA (forest_id, action_id)
values (194, 218);
insert into HASA (forest_id, action_id)
values (194, 251);
insert into HASA (forest_id, action_id)
values (195, 39);
insert into HASA (forest_id, action_id)
values (195, 165);
insert into HASA (forest_id, action_id)
values (195, 176);
insert into HASA (forest_id, action_id)
values (195, 199);
insert into HASA (forest_id, action_id)
values (196, 63);
insert into HASA (forest_id, action_id)
values (196, 137);
insert into HASA (forest_id, action_id)
values (196, 173);
insert into HASA (forest_id, action_id)
values (196, 177);
insert into HASA (forest_id, action_id)
values (196, 275);
insert into HASA (forest_id, action_id)
values (196, 297);
insert into HASA (forest_id, action_id)
values (196, 336);
insert into HASA (forest_id, action_id)
values (197, 65);
insert into HASA (forest_id, action_id)
values (197, 101);
insert into HASA (forest_id, action_id)
values (197, 168);
insert into HASA (forest_id, action_id)
values (197, 255);
insert into HASA (forest_id, action_id)
values (197, 279);
insert into HASA (forest_id, action_id)
values (197, 305);
insert into HASA (forest_id, action_id)
values (197, 308);
insert into HASA (forest_id, action_id)
values (197, 321);
insert into HASA (forest_id, action_id)
values (197, 370);
insert into HASA (forest_id, action_id)
values (197, 397);
insert into HASA (forest_id, action_id)
values (198, 123);
insert into HASA (forest_id, action_id)
values (199, 245);
insert into HASA (forest_id, action_id)
values (200, 90);
insert into HASA (forest_id, action_id)
values (200, 200);
insert into HASA (forest_id, action_id)
values (200, 204);
insert into HASA (forest_id, action_id)
values (200, 218);
insert into HASA (forest_id, action_id)
values (200, 228);
insert into HASA (forest_id, action_id)
values (200, 256);
insert into HASA (forest_id, action_id)
values (200, 373);
insert into HASA (forest_id, action_id)
values (201, 73);
insert into HASA (forest_id, action_id)
values (201, 114);
insert into HASA (forest_id, action_id)
values (201, 395);
insert into HASA (forest_id, action_id)
values (202, 257);
insert into HASA (forest_id, action_id)
values (202, 307);
insert into HASA (forest_id, action_id)
values (202, 340);
insert into HASA (forest_id, action_id)
values (202, 389);
insert into HASA (forest_id, action_id)
values (202, 390);
insert into HASA (forest_id, action_id)
values (203, 128);
insert into HASA (forest_id, action_id)
values (203, 290);
insert into HASA (forest_id, action_id)
values (203, 304);
insert into HASA (forest_id, action_id)
values (203, 353);
insert into HASA (forest_id, action_id)
values (203, 360);
insert into HASA (forest_id, action_id)
values (203, 371);
insert into HASA (forest_id, action_id)
values (204, 201);
insert into HASA (forest_id, action_id)
values (205, 125);
insert into HASA (forest_id, action_id)
values (205, 192);
insert into HASA (forest_id, action_id)
values (205, 215);
insert into HASA (forest_id, action_id)
values (205, 354);
insert into HASA (forest_id, action_id)
values (206, 249);
insert into HASA (forest_id, action_id)
values (206, 266);
insert into HASA (forest_id, action_id)
values (206, 285);
insert into HASA (forest_id, action_id)
values (206, 361);
insert into HASA (forest_id, action_id)
values (206, 376);
insert into HASA (forest_id, action_id)
values (206, 377);
insert into HASA (forest_id, action_id)
values (206, 399);
insert into HASA (forest_id, action_id)
values (207, 38);
insert into HASA (forest_id, action_id)
values (207, 46);
insert into HASA (forest_id, action_id)
values (207, 78);
insert into HASA (forest_id, action_id)
values (207, 200);
insert into HASA (forest_id, action_id)
values (207, 243);
insert into HASA (forest_id, action_id)
values (207, 314);
insert into HASA (forest_id, action_id)
values (207, 319);
insert into HASA (forest_id, action_id)
values (207, 335);
insert into HASA (forest_id, action_id)
values (208, 75);
insert into HASA (forest_id, action_id)
values (208, 85);
insert into HASA (forest_id, action_id)
values (209, 102);
insert into HASA (forest_id, action_id)
values (209, 301);
insert into HASA (forest_id, action_id)
values (209, 312);
insert into HASA (forest_id, action_id)
values (209, 372);
insert into HASA (forest_id, action_id)
values (210, 47);
insert into HASA (forest_id, action_id)
values (210, 77);
insert into HASA (forest_id, action_id)
values (210, 98);
insert into HASA (forest_id, action_id)
values (210, 110);
insert into HASA (forest_id, action_id)
values (210, 298);
insert into HASA (forest_id, action_id)
values (210, 396);
insert into HASA (forest_id, action_id)
values (211, 62);
insert into HASA (forest_id, action_id)
values (211, 71);
insert into HASA (forest_id, action_id)
values (211, 75);
insert into HASA (forest_id, action_id)
values (211, 110);
commit;
prompt 1600 records loaded
prompt Loading TREE_PLANTING_PROJECTS...
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (1, to_date('29-01-2022', 'dd-mm-yyyy'), to_date('22-02-2024', 'dd-mm-yyyy'), 233);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (2, to_date('21-08-2023', 'dd-mm-yyyy'), to_date('07-05-2024', 'dd-mm-yyyy'), 271);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (3, to_date('02-11-2023', 'dd-mm-yyyy'), to_date('11-02-2024', 'dd-mm-yyyy'), 117);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (4, to_date('21-10-2022', 'dd-mm-yyyy'), to_date('31-07-2023', 'dd-mm-yyyy'), 35);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (5, to_date('05-02-2022', 'dd-mm-yyyy'), to_date('14-10-2023', 'dd-mm-yyyy'), 101);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (6, to_date('13-05-2023', 'dd-mm-yyyy'), to_date('26-10-2023', 'dd-mm-yyyy'), 262);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (7, to_date('15-07-2023', 'dd-mm-yyyy'), to_date('19-03-2024', 'dd-mm-yyyy'), 322);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (8, to_date('14-03-2023', 'dd-mm-yyyy'), to_date('11-10-2023', 'dd-mm-yyyy'), 327);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (9, to_date('15-09-2022', 'dd-mm-yyyy'), to_date('03-11-2023', 'dd-mm-yyyy'), 323);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (10, to_date('02-08-2023', 'dd-mm-yyyy'), to_date('11-05-2024', 'dd-mm-yyyy'), 55);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (11, to_date('09-11-2023', 'dd-mm-yyyy'), to_date('07-02-2024', 'dd-mm-yyyy'), 202);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (12, to_date('01-09-2023', 'dd-mm-yyyy'), to_date('16-05-2024', 'dd-mm-yyyy'), 43);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (13, to_date('09-01-2023', 'dd-mm-yyyy'), to_date('21-03-2024', 'dd-mm-yyyy'), 391);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (14, to_date('07-09-2021', 'dd-mm-yyyy'), to_date('15-12-2021', 'dd-mm-yyyy'), 329);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (15, to_date('05-02-2024', 'dd-mm-yyyy'), to_date('26-03-2024', 'dd-mm-yyyy'), 141);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (16, to_date('16-08-2023', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 321);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (17, to_date('13-01-2024', 'dd-mm-yyyy'), to_date('16-01-2024', 'dd-mm-yyyy'), 272);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (18, to_date('13-11-2021', 'dd-mm-yyyy'), to_date('10-12-2021', 'dd-mm-yyyy'), 386);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (19, to_date('15-04-2022', 'dd-mm-yyyy'), to_date('13-05-2024', 'dd-mm-yyyy'), 352);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (20, to_date('14-04-2024', 'dd-mm-yyyy'), to_date('13-05-2024', 'dd-mm-yyyy'), 19);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (21, to_date('04-06-2023', 'dd-mm-yyyy'), to_date('20-05-2024', 'dd-mm-yyyy'), 96);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (22, to_date('30-05-2022', 'dd-mm-yyyy'), to_date('06-09-2023', 'dd-mm-yyyy'), 216);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (23, to_date('02-04-2021', 'dd-mm-yyyy'), to_date('19-06-2022', 'dd-mm-yyyy'), 181);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (24, to_date('24-01-2023', 'dd-mm-yyyy'), to_date('28-10-2023', 'dd-mm-yyyy'), 148);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (25, to_date('04-04-2021', 'dd-mm-yyyy'), to_date('02-08-2022', 'dd-mm-yyyy'), 181);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (26, to_date('06-02-2023', 'dd-mm-yyyy'), to_date('25-05-2023', 'dd-mm-yyyy'), 28);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (27, to_date('28-07-2022', 'dd-mm-yyyy'), to_date('06-12-2022', 'dd-mm-yyyy'), 158);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (28, to_date('04-05-2021', 'dd-mm-yyyy'), to_date('14-05-2021', 'dd-mm-yyyy'), 348);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (29, to_date('24-01-2023', 'dd-mm-yyyy'), to_date('13-05-2023', 'dd-mm-yyyy'), 206);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (30, to_date('27-03-2021', 'dd-mm-yyyy'), to_date('11-11-2021', 'dd-mm-yyyy'), 252);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (31, to_date('23-02-2021', 'dd-mm-yyyy'), to_date('22-08-2022', 'dd-mm-yyyy'), 274);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (32, to_date('26-11-2023', 'dd-mm-yyyy'), to_date('11-12-2023', 'dd-mm-yyyy'), 113);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (33, to_date('01-04-2022', 'dd-mm-yyyy'), to_date('23-11-2022', 'dd-mm-yyyy'), 282);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (34, to_date('20-04-2022', 'dd-mm-yyyy'), to_date('02-12-2023', 'dd-mm-yyyy'), 188);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (35, to_date('17-02-2022', 'dd-mm-yyyy'), to_date('14-12-2023', 'dd-mm-yyyy'), 308);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (36, to_date('02-12-2022', 'dd-mm-yyyy'), to_date('21-03-2023', 'dd-mm-yyyy'), 209);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (37, to_date('12-09-2023', 'dd-mm-yyyy'), to_date('27-11-2023', 'dd-mm-yyyy'), 252);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (38, to_date('27-08-2023', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 192);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (39, to_date('25-01-2023', 'dd-mm-yyyy'), to_date('09-11-2023', 'dd-mm-yyyy'), 44);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (40, to_date('27-01-2023', 'dd-mm-yyyy'), to_date('03-05-2024', 'dd-mm-yyyy'), 72);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (41, to_date('09-01-2024', 'dd-mm-yyyy'), to_date('13-01-2024', 'dd-mm-yyyy'), 211);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (42, to_date('08-05-2023', 'dd-mm-yyyy'), to_date('08-04-2024', 'dd-mm-yyyy'), 42);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (43, to_date('24-04-2021', 'dd-mm-yyyy'), to_date('28-03-2022', 'dd-mm-yyyy'), 140);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (44, to_date('01-10-2023', 'dd-mm-yyyy'), to_date('24-10-2023', 'dd-mm-yyyy'), 290);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (45, to_date('11-02-2021', 'dd-mm-yyyy'), to_date('11-01-2024', 'dd-mm-yyyy'), 393);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (46, to_date('27-08-2022', 'dd-mm-yyyy'), to_date('26-03-2023', 'dd-mm-yyyy'), 62);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (47, to_date('01-01-2024', 'dd-mm-yyyy'), to_date('13-05-2024', 'dd-mm-yyyy'), 375);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (48, to_date('13-04-2021', 'dd-mm-yyyy'), to_date('23-03-2023', 'dd-mm-yyyy'), 213);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (49, to_date('15-05-2022', 'dd-mm-yyyy'), to_date('08-10-2023', 'dd-mm-yyyy'), 248);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (50, to_date('03-11-2021', 'dd-mm-yyyy'), to_date('20-05-2024', 'dd-mm-yyyy'), 48);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (51, to_date('18-04-2022', 'dd-mm-yyyy'), to_date('27-05-2023', 'dd-mm-yyyy'), 132);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (52, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('20-05-2023', 'dd-mm-yyyy'), 232);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (53, to_date('14-01-2023', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'), 306);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (54, to_date('21-04-2021', 'dd-mm-yyyy'), to_date('06-11-2021', 'dd-mm-yyyy'), 82);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (55, to_date('21-11-2022', 'dd-mm-yyyy'), to_date('06-03-2024', 'dd-mm-yyyy'), 195);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (56, to_date('30-07-2022', 'dd-mm-yyyy'), to_date('29-01-2024', 'dd-mm-yyyy'), 291);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (57, to_date('10-08-2022', 'dd-mm-yyyy'), to_date('17-02-2023', 'dd-mm-yyyy'), 328);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (58, to_date('31-12-2021', 'dd-mm-yyyy'), to_date('08-01-2023', 'dd-mm-yyyy'), 149);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (59, to_date('13-07-2023', 'dd-mm-yyyy'), to_date('10-04-2024', 'dd-mm-yyyy'), 63);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (60, to_date('25-10-2022', 'dd-mm-yyyy'), to_date('03-03-2023', 'dd-mm-yyyy'), 55);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (61, to_date('27-12-2022', 'dd-mm-yyyy'), to_date('27-10-2023', 'dd-mm-yyyy'), 345);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (62, to_date('15-05-2023', 'dd-mm-yyyy'), to_date('23-08-2023', 'dd-mm-yyyy'), 72);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (63, to_date('26-05-2021', 'dd-mm-yyyy'), to_date('26-08-2021', 'dd-mm-yyyy'), 74);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (64, to_date('23-06-2023', 'dd-mm-yyyy'), to_date('18-05-2024', 'dd-mm-yyyy'), 254);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (65, to_date('19-07-2023', 'dd-mm-yyyy'), to_date('05-03-2024', 'dd-mm-yyyy'), 245);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (66, to_date('10-02-2023', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 269);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (67, to_date('11-02-2021', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'), 306);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (68, to_date('13-12-2023', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 96);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (69, to_date('05-01-2023', 'dd-mm-yyyy'), to_date('31-05-2023', 'dd-mm-yyyy'), 171);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (70, to_date('29-06-2023', 'dd-mm-yyyy'), to_date('05-11-2023', 'dd-mm-yyyy'), 334);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (71, to_date('27-03-2022', 'dd-mm-yyyy'), to_date('25-04-2022', 'dd-mm-yyyy'), 325);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (72, to_date('30-11-2023', 'dd-mm-yyyy'), to_date('10-02-2024', 'dd-mm-yyyy'), 72);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (73, to_date('07-01-2023', 'dd-mm-yyyy'), to_date('21-06-2023', 'dd-mm-yyyy'), 50);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (74, to_date('08-11-2023', 'dd-mm-yyyy'), to_date('03-04-2024', 'dd-mm-yyyy'), 95);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (75, to_date('26-05-2023', 'dd-mm-yyyy'), to_date('15-01-2024', 'dd-mm-yyyy'), 25);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (76, to_date('10-10-2021', 'dd-mm-yyyy'), to_date('31-10-2023', 'dd-mm-yyyy'), 107);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (77, to_date('28-07-2021', 'dd-mm-yyyy'), to_date('17-11-2021', 'dd-mm-yyyy'), 319);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (78, to_date('27-03-2024', 'dd-mm-yyyy'), to_date('15-05-2024', 'dd-mm-yyyy'), 8);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (79, to_date('18-06-2021', 'dd-mm-yyyy'), to_date('01-12-2023', 'dd-mm-yyyy'), 143);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (80, to_date('17-02-2024', 'dd-mm-yyyy'), to_date('15-04-2024', 'dd-mm-yyyy'), 255);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (81, to_date('28-09-2022', 'dd-mm-yyyy'), to_date('13-02-2024', 'dd-mm-yyyy'), 156);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (82, to_date('19-04-2021', 'dd-mm-yyyy'), to_date('02-11-2022', 'dd-mm-yyyy'), 152);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (83, to_date('08-02-2021', 'dd-mm-yyyy'), to_date('26-10-2022', 'dd-mm-yyyy'), 47);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (84, to_date('27-12-2023', 'dd-mm-yyyy'), to_date('10-04-2024', 'dd-mm-yyyy'), 297);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (85, to_date('18-07-2023', 'dd-mm-yyyy'), to_date('13-10-2023', 'dd-mm-yyyy'), 338);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (86, to_date('04-09-2023', 'dd-mm-yyyy'), to_date('18-10-2023', 'dd-mm-yyyy'), 100);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (87, to_date('05-09-2021', 'dd-mm-yyyy'), to_date('13-06-2022', 'dd-mm-yyyy'), 293);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (88, to_date('23-01-2024', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 191);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (89, to_date('23-11-2023', 'dd-mm-yyyy'), to_date('18-04-2024', 'dd-mm-yyyy'), 19);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (90, to_date('29-08-2022', 'dd-mm-yyyy'), to_date('03-04-2023', 'dd-mm-yyyy'), 103);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (91, to_date('03-02-2022', 'dd-mm-yyyy'), to_date('27-10-2022', 'dd-mm-yyyy'), 379);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (92, to_date('21-04-2023', 'dd-mm-yyyy'), to_date('29-03-2024', 'dd-mm-yyyy'), 294);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (93, to_date('01-02-2024', 'dd-mm-yyyy'), to_date('27-02-2024', 'dd-mm-yyyy'), 265);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (94, to_date('29-08-2023', 'dd-mm-yyyy'), to_date('04-10-2023', 'dd-mm-yyyy'), 78);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (95, to_date('22-05-2021', 'dd-mm-yyyy'), to_date('11-05-2022', 'dd-mm-yyyy'), 17);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (96, to_date('27-12-2022', 'dd-mm-yyyy'), to_date('29-04-2023', 'dd-mm-yyyy'), 247);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (97, to_date('02-06-2023', 'dd-mm-yyyy'), to_date('28-02-2024', 'dd-mm-yyyy'), 228);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (98, to_date('10-03-2021', 'dd-mm-yyyy'), to_date('03-11-2022', 'dd-mm-yyyy'), 324);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (99, to_date('21-02-2024', 'dd-mm-yyyy'), to_date('08-03-2024', 'dd-mm-yyyy'), 60);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (100, to_date('06-01-2021', 'dd-mm-yyyy'), to_date('28-05-2023', 'dd-mm-yyyy'), 358);
commit;
prompt 100 records committed...
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (101, to_date('03-04-2022', 'dd-mm-yyyy'), to_date('30-12-2023', 'dd-mm-yyyy'), 35);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (102, to_date('19-11-2023', 'dd-mm-yyyy'), to_date('23-02-2024', 'dd-mm-yyyy'), 40);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (103, to_date('05-11-2021', 'dd-mm-yyyy'), to_date('30-11-2022', 'dd-mm-yyyy'), 5);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (104, to_date('04-03-2024', 'dd-mm-yyyy'), to_date('04-05-2024', 'dd-mm-yyyy'), 344);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (105, to_date('20-02-2022', 'dd-mm-yyyy'), to_date('27-10-2023', 'dd-mm-yyyy'), 227);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (106, to_date('09-05-2021', 'dd-mm-yyyy'), to_date('04-01-2023', 'dd-mm-yyyy'), 299);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (107, to_date('16-04-2021', 'dd-mm-yyyy'), to_date('04-02-2022', 'dd-mm-yyyy'), 53);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (108, to_date('22-04-2022', 'dd-mm-yyyy'), to_date('02-05-2023', 'dd-mm-yyyy'), 331);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (109, to_date('05-02-2022', 'dd-mm-yyyy'), to_date('30-03-2023', 'dd-mm-yyyy'), 255);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (110, to_date('10-10-2022', 'dd-mm-yyyy'), to_date('28-01-2023', 'dd-mm-yyyy'), 279);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (111, to_date('25-03-2023', 'dd-mm-yyyy'), to_date('10-11-2023', 'dd-mm-yyyy'), 183);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (112, to_date('29-05-2022', 'dd-mm-yyyy'), to_date('29-05-2023', 'dd-mm-yyyy'), 375);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (113, to_date('28-02-2024', 'dd-mm-yyyy'), to_date('28-04-2024', 'dd-mm-yyyy'), 143);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (114, to_date('26-02-2021', 'dd-mm-yyyy'), to_date('12-12-2022', 'dd-mm-yyyy'), 33);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (115, to_date('07-07-2022', 'dd-mm-yyyy'), to_date('23-11-2022', 'dd-mm-yyyy'), 84);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (116, to_date('22-11-2023', 'dd-mm-yyyy'), to_date('16-12-2023', 'dd-mm-yyyy'), 99);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (117, to_date('21-05-2022', 'dd-mm-yyyy'), to_date('23-02-2023', 'dd-mm-yyyy'), 374);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (118, to_date('11-12-2023', 'dd-mm-yyyy'), to_date('24-04-2024', 'dd-mm-yyyy'), 130);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (119, to_date('25-01-2022', 'dd-mm-yyyy'), to_date('11-07-2023', 'dd-mm-yyyy'), 135);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (120, to_date('04-11-2022', 'dd-mm-yyyy'), to_date('21-06-2023', 'dd-mm-yyyy'), 171);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (121, to_date('13-12-2022', 'dd-mm-yyyy'), to_date('22-03-2023', 'dd-mm-yyyy'), 387);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (122, to_date('20-11-2022', 'dd-mm-yyyy'), to_date('10-12-2022', 'dd-mm-yyyy'), 97);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (123, to_date('19-04-2023', 'dd-mm-yyyy'), to_date('09-10-2023', 'dd-mm-yyyy'), 140);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (124, to_date('05-01-2021', 'dd-mm-yyyy'), to_date('07-06-2021', 'dd-mm-yyyy'), 178);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (125, to_date('01-08-2021', 'dd-mm-yyyy'), to_date('11-09-2023', 'dd-mm-yyyy'), 396);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (126, to_date('21-07-2021', 'dd-mm-yyyy'), to_date('14-12-2021', 'dd-mm-yyyy'), 215);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (127, to_date('18-12-2022', 'dd-mm-yyyy'), to_date('23-10-2023', 'dd-mm-yyyy'), 1);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (128, to_date('01-01-2021', 'dd-mm-yyyy'), to_date('23-04-2022', 'dd-mm-yyyy'), 220);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (129, to_date('19-04-2021', 'dd-mm-yyyy'), to_date('19-04-2021', 'dd-mm-yyyy'), 3);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (130, to_date('20-10-2022', 'dd-mm-yyyy'), to_date('05-09-2023', 'dd-mm-yyyy'), 223);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (131, to_date('23-03-2021', 'dd-mm-yyyy'), to_date('07-01-2023', 'dd-mm-yyyy'), 244);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (132, to_date('24-10-2022', 'dd-mm-yyyy'), to_date('07-03-2024', 'dd-mm-yyyy'), 63);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (133, to_date('24-04-2023', 'dd-mm-yyyy'), to_date('24-04-2024', 'dd-mm-yyyy'), 76);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (134, to_date('14-04-2024', 'dd-mm-yyyy'), to_date('17-04-2024', 'dd-mm-yyyy'), 394);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (135, to_date('06-03-2023', 'dd-mm-yyyy'), to_date('06-02-2024', 'dd-mm-yyyy'), 366);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (136, to_date('04-12-2022', 'dd-mm-yyyy'), to_date('25-06-2023', 'dd-mm-yyyy'), 174);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (137, to_date('05-04-2023', 'dd-mm-yyyy'), to_date('10-08-2023', 'dd-mm-yyyy'), 45);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (138, to_date('08-02-2021', 'dd-mm-yyyy'), to_date('10-10-2023', 'dd-mm-yyyy'), 375);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (139, to_date('20-05-2024', 'dd-mm-yyyy'), to_date('20-05-2024', 'dd-mm-yyyy'), 185);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (140, to_date('03-08-2021', 'dd-mm-yyyy'), to_date('20-02-2022', 'dd-mm-yyyy'), 253);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (141, to_date('04-05-2021', 'dd-mm-yyyy'), to_date('23-02-2023', 'dd-mm-yyyy'), 185);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (142, to_date('07-10-2022', 'dd-mm-yyyy'), to_date('14-03-2024', 'dd-mm-yyyy'), 144);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (143, to_date('11-08-2023', 'dd-mm-yyyy'), to_date('28-09-2023', 'dd-mm-yyyy'), 65);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (144, to_date('17-07-2022', 'dd-mm-yyyy'), to_date('14-05-2024', 'dd-mm-yyyy'), 254);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (145, to_date('19-04-2021', 'dd-mm-yyyy'), to_date('11-02-2023', 'dd-mm-yyyy'), 304);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (146, to_date('28-02-2024', 'dd-mm-yyyy'), to_date('11-03-2024', 'dd-mm-yyyy'), 366);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (147, to_date('16-06-2023', 'dd-mm-yyyy'), to_date('31-01-2024', 'dd-mm-yyyy'), 207);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (148, to_date('07-03-2022', 'dd-mm-yyyy'), to_date('28-12-2023', 'dd-mm-yyyy'), 82);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (149, to_date('30-07-2021', 'dd-mm-yyyy'), to_date('27-03-2022', 'dd-mm-yyyy'), 222);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (150, to_date('16-03-2022', 'dd-mm-yyyy'), to_date('01-07-2023', 'dd-mm-yyyy'), 224);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (151, to_date('03-05-2024', 'dd-mm-yyyy'), to_date('06-05-2024', 'dd-mm-yyyy'), 377);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (152, to_date('19-01-2023', 'dd-mm-yyyy'), to_date('30-04-2023', 'dd-mm-yyyy'), 285);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (153, to_date('10-11-2021', 'dd-mm-yyyy'), to_date('26-06-2022', 'dd-mm-yyyy'), 51);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (154, to_date('04-05-2021', 'dd-mm-yyyy'), to_date('22-12-2022', 'dd-mm-yyyy'), 351);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (155, to_date('01-11-2022', 'dd-mm-yyyy'), to_date('03-05-2024', 'dd-mm-yyyy'), 241);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (156, to_date('31-08-2021', 'dd-mm-yyyy'), to_date('18-02-2022', 'dd-mm-yyyy'), 394);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (157, to_date('10-01-2024', 'dd-mm-yyyy'), to_date('25-02-2024', 'dd-mm-yyyy'), 19);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (158, to_date('28-07-2023', 'dd-mm-yyyy'), to_date('23-01-2024', 'dd-mm-yyyy'), 170);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (159, to_date('23-11-2021', 'dd-mm-yyyy'), to_date('29-05-2023', 'dd-mm-yyyy'), 27);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (160, to_date('29-04-2021', 'dd-mm-yyyy'), to_date('18-10-2022', 'dd-mm-yyyy'), 244);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (161, to_date('21-02-2023', 'dd-mm-yyyy'), to_date('22-03-2023', 'dd-mm-yyyy'), 34);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (162, to_date('11-04-2021', 'dd-mm-yyyy'), to_date('27-06-2022', 'dd-mm-yyyy'), 336);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (163, to_date('14-11-2023', 'dd-mm-yyyy'), to_date('07-06-2024', 'dd-mm-yyyy'), 270);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (164, to_date('04-08-2022', 'dd-mm-yyyy'), to_date('20-09-2022', 'dd-mm-yyyy'), 361);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (165, to_date('18-02-2022', 'dd-mm-yyyy'), to_date('16-02-2024', 'dd-mm-yyyy'), 14);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (166, to_date('12-06-2022', 'dd-mm-yyyy'), to_date('09-07-2023', 'dd-mm-yyyy'), 91);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (167, to_date('29-08-2023', 'dd-mm-yyyy'), to_date('09-12-2023', 'dd-mm-yyyy'), 148);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (168, to_date('24-05-2022', 'dd-mm-yyyy'), to_date('15-05-2024', 'dd-mm-yyyy'), 82);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (169, to_date('24-10-2022', 'dd-mm-yyyy'), to_date('25-01-2024', 'dd-mm-yyyy'), 382);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (170, to_date('16-08-2023', 'dd-mm-yyyy'), to_date('12-05-2024', 'dd-mm-yyyy'), 359);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (171, to_date('30-12-2021', 'dd-mm-yyyy'), to_date('03-02-2024', 'dd-mm-yyyy'), 384);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (172, to_date('13-02-2021', 'dd-mm-yyyy'), to_date('17-03-2024', 'dd-mm-yyyy'), 69);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (173, to_date('10-01-2021', 'dd-mm-yyyy'), to_date('22-06-2022', 'dd-mm-yyyy'), 304);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (174, to_date('22-04-2023', 'dd-mm-yyyy'), to_date('16-08-2023', 'dd-mm-yyyy'), 336);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (175, to_date('20-03-2021', 'dd-mm-yyyy'), to_date('17-10-2023', 'dd-mm-yyyy'), 324);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (176, to_date('07-06-2023', 'dd-mm-yyyy'), to_date('30-03-2024', 'dd-mm-yyyy'), 391);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (177, to_date('11-12-2023', 'dd-mm-yyyy'), to_date('29-02-2024', 'dd-mm-yyyy'), 376);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (178, to_date('18-06-2021', 'dd-mm-yyyy'), to_date('19-05-2022', 'dd-mm-yyyy'), 156);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (179, to_date('01-07-2021', 'dd-mm-yyyy'), to_date('02-10-2023', 'dd-mm-yyyy'), 34);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (180, to_date('04-03-2024', 'dd-mm-yyyy'), to_date('14-04-2024', 'dd-mm-yyyy'), 202);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (181, to_date('10-01-2023', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 99);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (182, to_date('27-02-2022', 'dd-mm-yyyy'), to_date('28-06-2022', 'dd-mm-yyyy'), 246);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (183, to_date('10-04-2024', 'dd-mm-yyyy'), to_date('19-05-2024', 'dd-mm-yyyy'), 93);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (184, to_date('10-12-2022', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 182);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (185, to_date('22-07-2021', 'dd-mm-yyyy'), to_date('26-12-2023', 'dd-mm-yyyy'), 28);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (186, to_date('19-05-2022', 'dd-mm-yyyy'), to_date('09-06-2023', 'dd-mm-yyyy'), 277);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (187, to_date('20-05-2022', 'dd-mm-yyyy'), to_date('26-04-2024', 'dd-mm-yyyy'), 110);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (188, to_date('12-07-2023', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 385);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (189, to_date('09-07-2021', 'dd-mm-yyyy'), to_date('29-09-2021', 'dd-mm-yyyy'), 77);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (190, to_date('18-09-2021', 'dd-mm-yyyy'), to_date('22-11-2021', 'dd-mm-yyyy'), 59);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (191, to_date('16-08-2023', 'dd-mm-yyyy'), to_date('14-05-2024', 'dd-mm-yyyy'), 230);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (192, to_date('22-02-2024', 'dd-mm-yyyy'), to_date('01-05-2024', 'dd-mm-yyyy'), 231);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (193, to_date('11-03-2024', 'dd-mm-yyyy'), to_date('14-03-2024', 'dd-mm-yyyy'), 163);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (194, to_date('21-02-2021', 'dd-mm-yyyy'), to_date('07-06-2023', 'dd-mm-yyyy'), 30);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (195, to_date('11-04-2024', 'dd-mm-yyyy'), to_date('04-05-2024', 'dd-mm-yyyy'), 170);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (196, to_date('06-02-2022', 'dd-mm-yyyy'), to_date('20-04-2023', 'dd-mm-yyyy'), 63);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (197, to_date('26-04-2021', 'dd-mm-yyyy'), to_date('12-10-2023', 'dd-mm-yyyy'), 267);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (198, to_date('26-10-2022', 'dd-mm-yyyy'), to_date('09-12-2022', 'dd-mm-yyyy'), 168);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (199, to_date('19-02-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 367);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (200, to_date('15-08-2022', 'dd-mm-yyyy'), to_date('05-02-2023', 'dd-mm-yyyy'), 234);
commit;
prompt 200 records committed...
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (201, to_date('19-08-2021', 'dd-mm-yyyy'), to_date('19-04-2023', 'dd-mm-yyyy'), 174);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (202, to_date('25-04-2024', 'dd-mm-yyyy'), to_date('08-05-2024', 'dd-mm-yyyy'), 130);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (203, to_date('09-04-2021', 'dd-mm-yyyy'), to_date('05-06-2021', 'dd-mm-yyyy'), 255);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (204, to_date('22-07-2023', 'dd-mm-yyyy'), to_date('04-10-2023', 'dd-mm-yyyy'), 221);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (205, to_date('02-07-2021', 'dd-mm-yyyy'), to_date('05-09-2022', 'dd-mm-yyyy'), 380);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (206, to_date('19-02-2022', 'dd-mm-yyyy'), to_date('17-01-2024', 'dd-mm-yyyy'), 11);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (207, to_date('09-05-2022', 'dd-mm-yyyy'), to_date('06-11-2022', 'dd-mm-yyyy'), 333);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (208, to_date('08-02-2024', 'dd-mm-yyyy'), to_date('14-04-2024', 'dd-mm-yyyy'), 339);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (209, to_date('10-09-2023', 'dd-mm-yyyy'), to_date('26-12-2023', 'dd-mm-yyyy'), 337);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (210, to_date('08-04-2022', 'dd-mm-yyyy'), to_date('20-07-2022', 'dd-mm-yyyy'), 335);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (211, to_date('01-07-2023', 'dd-mm-yyyy'), to_date('21-11-2023', 'dd-mm-yyyy'), 333);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (212, to_date('28-03-2024', 'dd-mm-yyyy'), to_date('11-04-2024', 'dd-mm-yyyy'), 214);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (213, to_date('03-04-2022', 'dd-mm-yyyy'), to_date('14-01-2024', 'dd-mm-yyyy'), 24);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (214, to_date('09-01-2021', 'dd-mm-yyyy'), to_date('01-11-2023', 'dd-mm-yyyy'), 114);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (215, to_date('03-04-2021', 'dd-mm-yyyy'), to_date('10-09-2022', 'dd-mm-yyyy'), 13);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (216, to_date('04-11-2023', 'dd-mm-yyyy'), to_date('25-02-2024', 'dd-mm-yyyy'), 229);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (217, to_date('02-06-2023', 'dd-mm-yyyy'), to_date('23-08-2023', 'dd-mm-yyyy'), 256);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (218, to_date('04-09-2022', 'dd-mm-yyyy'), to_date('06-12-2022', 'dd-mm-yyyy'), 121);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (219, to_date('04-12-2023', 'dd-mm-yyyy'), to_date('03-05-2024', 'dd-mm-yyyy'), 48);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (220, to_date('29-04-2021', 'dd-mm-yyyy'), to_date('11-09-2021', 'dd-mm-yyyy'), 111);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (221, to_date('26-07-2023', 'dd-mm-yyyy'), to_date('30-07-2023', 'dd-mm-yyyy'), 347);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (222, to_date('18-07-2023', 'dd-mm-yyyy'), to_date('02-05-2024', 'dd-mm-yyyy'), 105);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (223, to_date('03-04-2023', 'dd-mm-yyyy'), to_date('08-10-2023', 'dd-mm-yyyy'), 234);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (224, to_date('14-10-2021', 'dd-mm-yyyy'), to_date('30-08-2022', 'dd-mm-yyyy'), 295);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (225, to_date('08-02-2021', 'dd-mm-yyyy'), to_date('17-08-2022', 'dd-mm-yyyy'), 156);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (226, to_date('01-02-2022', 'dd-mm-yyyy'), to_date('31-03-2024', 'dd-mm-yyyy'), 106);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (227, to_date('01-05-2021', 'dd-mm-yyyy'), to_date('10-03-2024', 'dd-mm-yyyy'), 311);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (228, to_date('28-01-2022', 'dd-mm-yyyy'), to_date('26-01-2024', 'dd-mm-yyyy'), 179);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (229, to_date('07-01-2021', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 73);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (230, to_date('02-02-2024', 'dd-mm-yyyy'), to_date('17-05-2024', 'dd-mm-yyyy'), 26);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (231, to_date('25-03-2022', 'dd-mm-yyyy'), to_date('25-07-2023', 'dd-mm-yyyy'), 236);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (232, to_date('27-08-2022', 'dd-mm-yyyy'), to_date('31-08-2023', 'dd-mm-yyyy'), 317);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (233, to_date('14-04-2023', 'dd-mm-yyyy'), to_date('26-11-2023', 'dd-mm-yyyy'), 42);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (234, to_date('03-10-2021', 'dd-mm-yyyy'), to_date('07-05-2022', 'dd-mm-yyyy'), 234);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (235, to_date('04-01-2022', 'dd-mm-yyyy'), to_date('05-04-2023', 'dd-mm-yyyy'), 260);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (236, to_date('12-10-2022', 'dd-mm-yyyy'), to_date('27-02-2024', 'dd-mm-yyyy'), 188);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (237, to_date('17-03-2023', 'dd-mm-yyyy'), to_date('09-03-2024', 'dd-mm-yyyy'), 346);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (238, to_date('17-04-2022', 'dd-mm-yyyy'), to_date('30-07-2022', 'dd-mm-yyyy'), 135);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (239, to_date('04-12-2021', 'dd-mm-yyyy'), to_date('24-05-2023', 'dd-mm-yyyy'), 267);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (240, to_date('15-06-2023', 'dd-mm-yyyy'), to_date('15-11-2023', 'dd-mm-yyyy'), 366);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (241, to_date('29-08-2023', 'dd-mm-yyyy'), to_date('10-02-2024', 'dd-mm-yyyy'), 197);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (242, to_date('07-08-2022', 'dd-mm-yyyy'), to_date('12-03-2023', 'dd-mm-yyyy'), 124);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (243, to_date('11-04-2022', 'dd-mm-yyyy'), to_date('02-07-2023', 'dd-mm-yyyy'), 29);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (244, to_date('29-01-2023', 'dd-mm-yyyy'), to_date('14-09-2023', 'dd-mm-yyyy'), 120);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (245, to_date('09-04-2023', 'dd-mm-yyyy'), to_date('17-09-2023', 'dd-mm-yyyy'), 365);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (246, to_date('11-10-2021', 'dd-mm-yyyy'), to_date('19-03-2024', 'dd-mm-yyyy'), 145);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (247, to_date('01-02-2022', 'dd-mm-yyyy'), to_date('05-04-2023', 'dd-mm-yyyy'), 171);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (248, to_date('05-02-2021', 'dd-mm-yyyy'), to_date('26-03-2023', 'dd-mm-yyyy'), 378);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (249, to_date('26-04-2021', 'dd-mm-yyyy'), to_date('18-04-2023', 'dd-mm-yyyy'), 269);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (250, to_date('23-02-2022', 'dd-mm-yyyy'), to_date('16-01-2023', 'dd-mm-yyyy'), 95);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (251, to_date('02-10-2022', 'dd-mm-yyyy'), to_date('12-01-2024', 'dd-mm-yyyy'), 242);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (252, to_date('05-10-2023', 'dd-mm-yyyy'), to_date('03-05-2024', 'dd-mm-yyyy'), 41);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (253, to_date('05-02-2021', 'dd-mm-yyyy'), to_date('12-01-2023', 'dd-mm-yyyy'), 89);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (254, to_date('09-12-2023', 'dd-mm-yyyy'), to_date('25-12-2023', 'dd-mm-yyyy'), 147);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (255, to_date('14-04-2021', 'dd-mm-yyyy'), to_date('19-02-2023', 'dd-mm-yyyy'), 308);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (256, to_date('27-12-2023', 'dd-mm-yyyy'), to_date('06-01-2024', 'dd-mm-yyyy'), 117);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (257, to_date('04-01-2022', 'dd-mm-yyyy'), to_date('26-05-2023', 'dd-mm-yyyy'), 60);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (258, to_date('12-08-2023', 'dd-mm-yyyy'), to_date('24-04-2024', 'dd-mm-yyyy'), 37);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (259, to_date('25-12-2021', 'dd-mm-yyyy'), to_date('18-02-2022', 'dd-mm-yyyy'), 335);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (260, to_date('19-09-2022', 'dd-mm-yyyy'), to_date('23-08-2023', 'dd-mm-yyyy'), 196);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (261, to_date('10-09-2023', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 288);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (262, to_date('13-06-2022', 'dd-mm-yyyy'), to_date('02-03-2023', 'dd-mm-yyyy'), 131);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (263, to_date('21-04-2024', 'dd-mm-yyyy'), to_date('26-04-2024', 'dd-mm-yyyy'), 109);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (264, to_date('13-12-2023', 'dd-mm-yyyy'), to_date('09-01-2024', 'dd-mm-yyyy'), 272);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (265, to_date('11-03-2024', 'dd-mm-yyyy'), to_date('13-05-2024', 'dd-mm-yyyy'), 309);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (266, to_date('30-08-2022', 'dd-mm-yyyy'), to_date('21-04-2023', 'dd-mm-yyyy'), 208);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (267, to_date('13-12-2022', 'dd-mm-yyyy'), to_date('01-08-2023', 'dd-mm-yyyy'), 229);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (268, to_date('29-04-2023', 'dd-mm-yyyy'), to_date('01-12-2023', 'dd-mm-yyyy'), 182);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (269, to_date('02-09-2022', 'dd-mm-yyyy'), to_date('20-03-2023', 'dd-mm-yyyy'), 48);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (270, to_date('03-03-2022', 'dd-mm-yyyy'), to_date('31-07-2023', 'dd-mm-yyyy'), 33);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (271, to_date('08-08-2022', 'dd-mm-yyyy'), to_date('15-05-2023', 'dd-mm-yyyy'), 297);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (272, to_date('24-12-2022', 'dd-mm-yyyy'), to_date('16-11-2023', 'dd-mm-yyyy'), 83);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (273, to_date('15-07-2023', 'dd-mm-yyyy'), to_date('04-10-2023', 'dd-mm-yyyy'), 110);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (274, to_date('19-11-2023', 'dd-mm-yyyy'), to_date('03-05-2024', 'dd-mm-yyyy'), 43);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (275, to_date('30-08-2021', 'dd-mm-yyyy'), to_date('20-12-2023', 'dd-mm-yyyy'), 330);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (276, to_date('18-05-2022', 'dd-mm-yyyy'), to_date('06-11-2023', 'dd-mm-yyyy'), 193);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (277, to_date('27-03-2021', 'dd-mm-yyyy'), to_date('22-09-2021', 'dd-mm-yyyy'), 253);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (278, to_date('15-09-2021', 'dd-mm-yyyy'), to_date('02-10-2021', 'dd-mm-yyyy'), 15);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (279, to_date('07-10-2021', 'dd-mm-yyyy'), to_date('13-10-2023', 'dd-mm-yyyy'), 183);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (280, to_date('02-12-2021', 'dd-mm-yyyy'), to_date('20-03-2024', 'dd-mm-yyyy'), 360);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (281, to_date('24-03-2023', 'dd-mm-yyyy'), to_date('29-03-2024', 'dd-mm-yyyy'), 125);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (282, to_date('08-01-2022', 'dd-mm-yyyy'), to_date('06-02-2023', 'dd-mm-yyyy'), 217);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (283, to_date('02-05-2021', 'dd-mm-yyyy'), to_date('27-09-2023', 'dd-mm-yyyy'), 111);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (284, to_date('05-03-2022', 'dd-mm-yyyy'), to_date('09-05-2023', 'dd-mm-yyyy'), 358);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (285, to_date('16-11-2022', 'dd-mm-yyyy'), to_date('31-03-2024', 'dd-mm-yyyy'), 111);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (286, to_date('27-03-2023', 'dd-mm-yyyy'), to_date('31-03-2023', 'dd-mm-yyyy'), 377);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (287, to_date('26-02-2021', 'dd-mm-yyyy'), to_date('21-04-2021', 'dd-mm-yyyy'), 41);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (288, to_date('01-12-2022', 'dd-mm-yyyy'), to_date('25-10-2023', 'dd-mm-yyyy'), 197);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (289, to_date('26-07-2023', 'dd-mm-yyyy'), to_date('11-09-2023', 'dd-mm-yyyy'), 320);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (290, to_date('22-02-2024', 'dd-mm-yyyy'), to_date('04-03-2024', 'dd-mm-yyyy'), 350);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (291, to_date('16-03-2021', 'dd-mm-yyyy'), to_date('06-10-2021', 'dd-mm-yyyy'), 220);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (292, to_date('25-08-2022', 'dd-mm-yyyy'), to_date('10-04-2023', 'dd-mm-yyyy'), 391);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (293, to_date('03-07-2022', 'dd-mm-yyyy'), to_date('30-05-2023', 'dd-mm-yyyy'), 58);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (294, to_date('19-12-2021', 'dd-mm-yyyy'), to_date('06-05-2023', 'dd-mm-yyyy'), 229);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (295, to_date('16-01-2023', 'dd-mm-yyyy'), to_date('10-03-2023', 'dd-mm-yyyy'), 114);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (296, to_date('15-09-2022', 'dd-mm-yyyy'), to_date('24-10-2023', 'dd-mm-yyyy'), 251);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (297, to_date('10-04-2024', 'dd-mm-yyyy'), to_date('15-05-2024', 'dd-mm-yyyy'), 242);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (298, to_date('13-07-2021', 'dd-mm-yyyy'), to_date('19-01-2023', 'dd-mm-yyyy'), 11);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (299, to_date('25-11-2023', 'dd-mm-yyyy'), to_date('03-03-2024', 'dd-mm-yyyy'), 395);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (300, to_date('24-07-2022', 'dd-mm-yyyy'), to_date('07-03-2024', 'dd-mm-yyyy'), 242);
commit;
prompt 300 records committed...
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (301, to_date('16-06-2021', 'dd-mm-yyyy'), to_date('07-03-2022', 'dd-mm-yyyy'), 180);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (302, to_date('05-03-2021', 'dd-mm-yyyy'), to_date('19-08-2022', 'dd-mm-yyyy'), 106);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (303, to_date('28-07-2021', 'dd-mm-yyyy'), to_date('10-08-2023', 'dd-mm-yyyy'), 64);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (304, to_date('02-06-2022', 'dd-mm-yyyy'), to_date('17-07-2023', 'dd-mm-yyyy'), 376);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (305, to_date('28-12-2021', 'dd-mm-yyyy'), to_date('15-10-2023', 'dd-mm-yyyy'), 95);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (306, to_date('28-12-2023', 'dd-mm-yyyy'), to_date('30-12-2023', 'dd-mm-yyyy'), 310);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (307, to_date('02-01-2022', 'dd-mm-yyyy'), to_date('04-11-2022', 'dd-mm-yyyy'), 127);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (308, to_date('29-01-2023', 'dd-mm-yyyy'), to_date('24-02-2024', 'dd-mm-yyyy'), 59);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (309, to_date('19-04-2023', 'dd-mm-yyyy'), to_date('05-04-2024', 'dd-mm-yyyy'), 343);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (310, to_date('16-09-2022', 'dd-mm-yyyy'), to_date('17-05-2024', 'dd-mm-yyyy'), 383);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (311, to_date('19-02-2021', 'dd-mm-yyyy'), to_date('16-07-2023', 'dd-mm-yyyy'), 141);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (312, to_date('20-07-2022', 'dd-mm-yyyy'), to_date('02-08-2022', 'dd-mm-yyyy'), 388);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (313, to_date('17-02-2024', 'dd-mm-yyyy'), to_date('25-03-2024', 'dd-mm-yyyy'), 328);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (314, to_date('21-08-2023', 'dd-mm-yyyy'), to_date('02-11-2023', 'dd-mm-yyyy'), 231);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (315, to_date('07-11-2023', 'dd-mm-yyyy'), to_date('06-12-2023', 'dd-mm-yyyy'), 126);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (316, to_date('02-02-2022', 'dd-mm-yyyy'), to_date('12-12-2023', 'dd-mm-yyyy'), 380);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (317, to_date('15-01-2022', 'dd-mm-yyyy'), to_date('10-06-2023', 'dd-mm-yyyy'), 316);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (318, to_date('18-11-2021', 'dd-mm-yyyy'), to_date('24-01-2024', 'dd-mm-yyyy'), 167);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (319, to_date('29-06-2023', 'dd-mm-yyyy'), to_date('26-02-2024', 'dd-mm-yyyy'), 390);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (320, to_date('02-04-2023', 'dd-mm-yyyy'), to_date('01-03-2024', 'dd-mm-yyyy'), 5);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (321, to_date('20-12-2021', 'dd-mm-yyyy'), to_date('24-04-2024', 'dd-mm-yyyy'), 217);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (322, to_date('25-04-2021', 'dd-mm-yyyy'), to_date('05-05-2024', 'dd-mm-yyyy'), 65);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (323, to_date('14-11-2023', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 164);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (324, to_date('21-05-2023', 'dd-mm-yyyy'), to_date('21-10-2023', 'dd-mm-yyyy'), 31);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (325, to_date('27-06-2022', 'dd-mm-yyyy'), to_date('04-11-2022', 'dd-mm-yyyy'), 109);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (326, to_date('22-08-2021', 'dd-mm-yyyy'), to_date('09-05-2024', 'dd-mm-yyyy'), 63);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (327, to_date('28-04-2022', 'dd-mm-yyyy'), to_date('01-11-2023', 'dd-mm-yyyy'), 74);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (328, to_date('18-08-2022', 'dd-mm-yyyy'), to_date('22-04-2024', 'dd-mm-yyyy'), 107);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (329, to_date('05-01-2023', 'dd-mm-yyyy'), to_date('16-02-2023', 'dd-mm-yyyy'), 142);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (330, to_date('14-09-2022', 'dd-mm-yyyy'), to_date('14-12-2022', 'dd-mm-yyyy'), 391);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (331, to_date('04-01-2021', 'dd-mm-yyyy'), to_date('10-01-2023', 'dd-mm-yyyy'), 255);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (332, to_date('13-07-2021', 'dd-mm-yyyy'), to_date('09-08-2023', 'dd-mm-yyyy'), 151);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (333, to_date('28-12-2021', 'dd-mm-yyyy'), to_date('02-12-2023', 'dd-mm-yyyy'), 278);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (334, to_date('30-08-2021', 'dd-mm-yyyy'), to_date('13-09-2022', 'dd-mm-yyyy'), 132);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (335, to_date('26-11-2023', 'dd-mm-yyyy'), to_date('18-03-2024', 'dd-mm-yyyy'), 385);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (336, to_date('17-11-2021', 'dd-mm-yyyy'), to_date('12-04-2024', 'dd-mm-yyyy'), 359);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (337, to_date('03-05-2023', 'dd-mm-yyyy'), to_date('16-03-2024', 'dd-mm-yyyy'), 300);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (338, to_date('24-11-2021', 'dd-mm-yyyy'), to_date('27-09-2023', 'dd-mm-yyyy'), 28);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (339, to_date('17-02-2022', 'dd-mm-yyyy'), to_date('12-01-2023', 'dd-mm-yyyy'), 352);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (340, to_date('14-02-2022', 'dd-mm-yyyy'), to_date('08-02-2023', 'dd-mm-yyyy'), 354);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (341, to_date('27-05-2022', 'dd-mm-yyyy'), to_date('25-07-2022', 'dd-mm-yyyy'), 318);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (342, to_date('26-09-2022', 'dd-mm-yyyy'), to_date('21-05-2024', 'dd-mm-yyyy'), 299);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (343, to_date('09-08-2023', 'dd-mm-yyyy'), to_date('08-09-2023', 'dd-mm-yyyy'), 168);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (344, to_date('19-08-2023', 'dd-mm-yyyy'), to_date('03-09-2023', 'dd-mm-yyyy'), 324);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (345, to_date('16-05-2022', 'dd-mm-yyyy'), to_date('26-05-2022', 'dd-mm-yyyy'), 123);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (346, to_date('18-05-2024', 'dd-mm-yyyy'), to_date('20-05-2024', 'dd-mm-yyyy'), 227);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (347, to_date('13-05-2023', 'dd-mm-yyyy'), to_date('15-05-2023', 'dd-mm-yyyy'), 63);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (348, to_date('16-03-2024', 'dd-mm-yyyy'), to_date('22-04-2024', 'dd-mm-yyyy'), 212);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (349, to_date('31-10-2022', 'dd-mm-yyyy'), to_date('22-11-2023', 'dd-mm-yyyy'), 3);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (350, to_date('14-07-2023', 'dd-mm-yyyy'), to_date('30-01-2024', 'dd-mm-yyyy'), 287);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (351, to_date('22-04-2024', 'dd-mm-yyyy'), to_date('18-05-2024', 'dd-mm-yyyy'), 276);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (352, to_date('18-08-2022', 'dd-mm-yyyy'), to_date('30-12-2023', 'dd-mm-yyyy'), 165);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (353, to_date('30-01-2022', 'dd-mm-yyyy'), to_date('07-11-2023', 'dd-mm-yyyy'), 262);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (354, to_date('06-10-2021', 'dd-mm-yyyy'), to_date('22-03-2024', 'dd-mm-yyyy'), 363);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (355, to_date('01-04-2021', 'dd-mm-yyyy'), to_date('04-08-2021', 'dd-mm-yyyy'), 147);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (356, to_date('02-01-2021', 'dd-mm-yyyy'), to_date('23-04-2023', 'dd-mm-yyyy'), 237);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (357, to_date('12-04-2021', 'dd-mm-yyyy'), to_date('13-03-2023', 'dd-mm-yyyy'), 231);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (358, to_date('10-01-2021', 'dd-mm-yyyy'), to_date('06-07-2023', 'dd-mm-yyyy'), 362);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (359, to_date('13-08-2023', 'dd-mm-yyyy'), to_date('15-09-2023', 'dd-mm-yyyy'), 36);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (360, to_date('09-02-2022', 'dd-mm-yyyy'), to_date('05-06-2023', 'dd-mm-yyyy'), 279);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (361, to_date('17-02-2022', 'dd-mm-yyyy'), to_date('07-04-2022', 'dd-mm-yyyy'), 198);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (362, to_date('28-06-2023', 'dd-mm-yyyy'), to_date('25-04-2024', 'dd-mm-yyyy'), 16);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (363, to_date('30-08-2023', 'dd-mm-yyyy'), to_date('05-10-2023', 'dd-mm-yyyy'), 18);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (364, to_date('31-10-2022', 'dd-mm-yyyy'), to_date('11-01-2024', 'dd-mm-yyyy'), 328);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (365, to_date('31-03-2021', 'dd-mm-yyyy'), to_date('21-09-2021', 'dd-mm-yyyy'), 397);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (366, to_date('05-03-2024', 'dd-mm-yyyy'), to_date('05-04-2024', 'dd-mm-yyyy'), 269);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (367, to_date('16-08-2023', 'dd-mm-yyyy'), to_date('24-08-2023', 'dd-mm-yyyy'), 13);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (368, to_date('16-09-2021', 'dd-mm-yyyy'), to_date('27-12-2023', 'dd-mm-yyyy'), 165);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (369, to_date('13-12-2022', 'dd-mm-yyyy'), to_date('27-02-2024', 'dd-mm-yyyy'), 8);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (370, to_date('05-12-2021', 'dd-mm-yyyy'), to_date('15-01-2023', 'dd-mm-yyyy'), 258);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (371, to_date('04-03-2022', 'dd-mm-yyyy'), to_date('20-05-2024', 'dd-mm-yyyy'), 134);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (372, to_date('08-06-2022', 'dd-mm-yyyy'), to_date('20-08-2023', 'dd-mm-yyyy'), 18);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (373, to_date('19-02-2024', 'dd-mm-yyyy'), to_date('08-04-2024', 'dd-mm-yyyy'), 375);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (374, to_date('02-02-2023', 'dd-mm-yyyy'), to_date('15-12-2023', 'dd-mm-yyyy'), 197);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (375, to_date('08-06-2021', 'dd-mm-yyyy'), to_date('18-01-2024', 'dd-mm-yyyy'), 334);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (376, to_date('12-03-2021', 'dd-mm-yyyy'), to_date('22-04-2021', 'dd-mm-yyyy'), 373);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (377, to_date('21-05-2023', 'dd-mm-yyyy'), to_date('12-04-2024', 'dd-mm-yyyy'), 152);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (378, to_date('25-09-2021', 'dd-mm-yyyy'), to_date('14-11-2022', 'dd-mm-yyyy'), 315);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (379, to_date('03-08-2021', 'dd-mm-yyyy'), to_date('18-12-2023', 'dd-mm-yyyy'), 267);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (380, to_date('10-08-2023', 'dd-mm-yyyy'), to_date('26-09-2023', 'dd-mm-yyyy'), 217);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (381, to_date('12-04-2021', 'dd-mm-yyyy'), to_date('26-05-2022', 'dd-mm-yyyy'), 60);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (382, to_date('26-08-2022', 'dd-mm-yyyy'), to_date('19-08-2023', 'dd-mm-yyyy'), 177);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (383, to_date('31-03-2024', 'dd-mm-yyyy'), to_date('05-04-2024', 'dd-mm-yyyy'), 146);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (384, to_date('26-01-2024', 'dd-mm-yyyy'), to_date('04-02-2024', 'dd-mm-yyyy'), 262);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (385, to_date('27-03-2024', 'dd-mm-yyyy'), to_date('01-04-2024', 'dd-mm-yyyy'), 87);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (386, to_date('08-10-2021', 'dd-mm-yyyy'), to_date('28-03-2024', 'dd-mm-yyyy'), 104);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (387, to_date('05-09-2022', 'dd-mm-yyyy'), to_date('02-12-2022', 'dd-mm-yyyy'), 151);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (388, to_date('21-05-2022', 'dd-mm-yyyy'), to_date('07-07-2023', 'dd-mm-yyyy'), 275);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (389, to_date('30-03-2024', 'dd-mm-yyyy'), to_date('07-04-2024', 'dd-mm-yyyy'), 108);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (390, to_date('09-03-2023', 'dd-mm-yyyy'), to_date('15-01-2024', 'dd-mm-yyyy'), 72);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (391, to_date('08-07-2022', 'dd-mm-yyyy'), to_date('10-08-2023', 'dd-mm-yyyy'), 247);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (392, to_date('20-06-2023', 'dd-mm-yyyy'), to_date('06-05-2024', 'dd-mm-yyyy'), 398);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (393, to_date('31-05-2023', 'dd-mm-yyyy'), to_date('10-09-2023', 'dd-mm-yyyy'), 341);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (394, to_date('09-04-2023', 'dd-mm-yyyy'), to_date('22-01-2024', 'dd-mm-yyyy'), 241);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (395, to_date('01-04-2024', 'dd-mm-yyyy'), to_date('10-05-2024', 'dd-mm-yyyy'), 147);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (396, to_date('25-01-2021', 'dd-mm-yyyy'), to_date('12-03-2024', 'dd-mm-yyyy'), 388);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (397, to_date('11-12-2022', 'dd-mm-yyyy'), to_date('09-03-2023', 'dd-mm-yyyy'), 389);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (398, to_date('03-08-2023', 'dd-mm-yyyy'), to_date('12-11-2023', 'dd-mm-yyyy'), 51);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (399, to_date('17-01-2024', 'dd-mm-yyyy'), to_date('20-02-2024', 'dd-mm-yyyy'), 107);
insert into TREE_PLANTING_PROJECTS (planting_id, start_date, end_date, forest_id)
values (400, to_date('27-04-2022', 'dd-mm-yyyy'), to_date('06-03-2023', 'dd-mm-yyyy'), 109);
commit;
prompt 400 records loaded
prompt Loading ISFOR...
insert into ISFOR (planting_id, forest_id)
values (2, 298);
insert into ISFOR (planting_id, forest_id)
values (3, 145);
insert into ISFOR (planting_id, forest_id)
values (4, 335);
insert into ISFOR (planting_id, forest_id)
values (5, 31);
insert into ISFOR (planting_id, forest_id)
values (5, 205);
insert into ISFOR (planting_id, forest_id)
values (6, 306);
insert into ISFOR (planting_id, forest_id)
values (7, 230);
insert into ISFOR (planting_id, forest_id)
values (8, 176);
insert into ISFOR (planting_id, forest_id)
values (8, 372);
insert into ISFOR (planting_id, forest_id)
values (9, 40);
insert into ISFOR (planting_id, forest_id)
values (9, 337);
insert into ISFOR (planting_id, forest_id)
values (10, 22);
insert into ISFOR (planting_id, forest_id)
values (11, 301);
insert into ISFOR (planting_id, forest_id)
values (12, 7);
insert into ISFOR (planting_id, forest_id)
values (13, 288);
insert into ISFOR (planting_id, forest_id)
values (14, 92);
insert into ISFOR (planting_id, forest_id)
values (14, 320);
insert into ISFOR (planting_id, forest_id)
values (16, 133);
insert into ISFOR (planting_id, forest_id)
values (16, 177);
insert into ISFOR (planting_id, forest_id)
values (17, 70);
insert into ISFOR (planting_id, forest_id)
values (17, 106);
insert into ISFOR (planting_id, forest_id)
values (18, 143);
insert into ISFOR (planting_id, forest_id)
values (18, 298);
insert into ISFOR (planting_id, forest_id)
values (18, 350);
insert into ISFOR (planting_id, forest_id)
values (20, 122);
insert into ISFOR (planting_id, forest_id)
values (20, 289);
insert into ISFOR (planting_id, forest_id)
values (21, 103);
insert into ISFOR (planting_id, forest_id)
values (22, 196);
insert into ISFOR (planting_id, forest_id)
values (24, 169);
insert into ISFOR (planting_id, forest_id)
values (25, 55);
insert into ISFOR (planting_id, forest_id)
values (25, 195);
insert into ISFOR (planting_id, forest_id)
values (25, 288);
insert into ISFOR (planting_id, forest_id)
values (26, 265);
insert into ISFOR (planting_id, forest_id)
values (26, 343);
insert into ISFOR (planting_id, forest_id)
values (27, 33);
insert into ISFOR (planting_id, forest_id)
values (27, 48);
insert into ISFOR (planting_id, forest_id)
values (27, 181);
insert into ISFOR (planting_id, forest_id)
values (27, 327);
insert into ISFOR (planting_id, forest_id)
values (28, 249);
insert into ISFOR (planting_id, forest_id)
values (30, 333);
insert into ISFOR (planting_id, forest_id)
values (33, 229);
insert into ISFOR (planting_id, forest_id)
values (34, 60);
insert into ISFOR (planting_id, forest_id)
values (35, 188);
insert into ISFOR (planting_id, forest_id)
values (35, 254);
insert into ISFOR (planting_id, forest_id)
values (36, 123);
insert into ISFOR (planting_id, forest_id)
values (37, 147);
insert into ISFOR (planting_id, forest_id)
values (38, 92);
insert into ISFOR (planting_id, forest_id)
values (40, 99);
insert into ISFOR (planting_id, forest_id)
values (40, 169);
insert into ISFOR (planting_id, forest_id)
values (40, 268);
insert into ISFOR (planting_id, forest_id)
values (41, 278);
insert into ISFOR (planting_id, forest_id)
values (41, 356);
insert into ISFOR (planting_id, forest_id)
values (42, 243);
insert into ISFOR (planting_id, forest_id)
values (43, 240);
insert into ISFOR (planting_id, forest_id)
values (44, 356);
insert into ISFOR (planting_id, forest_id)
values (44, 372);
insert into ISFOR (planting_id, forest_id)
values (45, 92);
insert into ISFOR (planting_id, forest_id)
values (45, 351);
insert into ISFOR (planting_id, forest_id)
values (46, 282);
insert into ISFOR (planting_id, forest_id)
values (46, 370);
insert into ISFOR (planting_id, forest_id)
values (47, 389);
insert into ISFOR (planting_id, forest_id)
values (48, 315);
insert into ISFOR (planting_id, forest_id)
values (50, 288);
insert into ISFOR (planting_id, forest_id)
values (51, 32);
insert into ISFOR (planting_id, forest_id)
values (51, 160);
insert into ISFOR (planting_id, forest_id)
values (51, 302);
insert into ISFOR (planting_id, forest_id)
values (52, 204);
insert into ISFOR (planting_id, forest_id)
values (53, 107);
insert into ISFOR (planting_id, forest_id)
values (54, 82);
insert into ISFOR (planting_id, forest_id)
values (54, 111);
insert into ISFOR (planting_id, forest_id)
values (55, 329);
insert into ISFOR (planting_id, forest_id)
values (55, 360);
insert into ISFOR (planting_id, forest_id)
values (56, 123);
insert into ISFOR (planting_id, forest_id)
values (58, 199);
insert into ISFOR (planting_id, forest_id)
values (59, 300);
insert into ISFOR (planting_id, forest_id)
values (60, 57);
insert into ISFOR (planting_id, forest_id)
values (60, 253);
insert into ISFOR (planting_id, forest_id)
values (61, 53);
insert into ISFOR (planting_id, forest_id)
values (64, 139);
insert into ISFOR (planting_id, forest_id)
values (64, 376);
insert into ISFOR (planting_id, forest_id)
values (65, 332);
insert into ISFOR (planting_id, forest_id)
values (66, 47);
insert into ISFOR (planting_id, forest_id)
values (66, 223);
insert into ISFOR (planting_id, forest_id)
values (67, 58);
insert into ISFOR (planting_id, forest_id)
values (68, 60);
insert into ISFOR (planting_id, forest_id)
values (68, 260);
insert into ISFOR (planting_id, forest_id)
values (68, 336);
insert into ISFOR (planting_id, forest_id)
values (69, 256);
insert into ISFOR (planting_id, forest_id)
values (70, 171);
insert into ISFOR (planting_id, forest_id)
values (70, 292);
insert into ISFOR (planting_id, forest_id)
values (72, 170);
insert into ISFOR (planting_id, forest_id)
values (73, 94);
insert into ISFOR (planting_id, forest_id)
values (75, 321);
insert into ISFOR (planting_id, forest_id)
values (76, 244);
insert into ISFOR (planting_id, forest_id)
values (77, 30);
insert into ISFOR (planting_id, forest_id)
values (77, 243);
insert into ISFOR (planting_id, forest_id)
values (77, 284);
insert into ISFOR (planting_id, forest_id)
values (78, 138);
insert into ISFOR (planting_id, forest_id)
values (79, 212);
insert into ISFOR (planting_id, forest_id)
values (79, 275);
commit;
prompt 100 records committed...
insert into ISFOR (planting_id, forest_id)
values (79, 279);
insert into ISFOR (planting_id, forest_id)
values (80, 112);
insert into ISFOR (planting_id, forest_id)
values (81, 203);
insert into ISFOR (planting_id, forest_id)
values (81, 249);
insert into ISFOR (planting_id, forest_id)
values (81, 290);
insert into ISFOR (planting_id, forest_id)
values (82, 174);
insert into ISFOR (planting_id, forest_id)
values (83, 99);
insert into ISFOR (planting_id, forest_id)
values (85, 229);
insert into ISFOR (planting_id, forest_id)
values (85, 326);
insert into ISFOR (planting_id, forest_id)
values (86, 140);
insert into ISFOR (planting_id, forest_id)
values (86, 288);
insert into ISFOR (planting_id, forest_id)
values (88, 186);
insert into ISFOR (planting_id, forest_id)
values (88, 295);
insert into ISFOR (planting_id, forest_id)
values (88, 304);
insert into ISFOR (planting_id, forest_id)
values (88, 378);
insert into ISFOR (planting_id, forest_id)
values (89, 100);
insert into ISFOR (planting_id, forest_id)
values (89, 155);
insert into ISFOR (planting_id, forest_id)
values (89, 232);
insert into ISFOR (planting_id, forest_id)
values (90, 174);
insert into ISFOR (planting_id, forest_id)
values (91, 17);
insert into ISFOR (planting_id, forest_id)
values (91, 135);
insert into ISFOR (planting_id, forest_id)
values (92, 218);
insert into ISFOR (planting_id, forest_id)
values (93, 216);
insert into ISFOR (planting_id, forest_id)
values (93, 303);
insert into ISFOR (planting_id, forest_id)
values (95, 155);
insert into ISFOR (planting_id, forest_id)
values (95, 330);
insert into ISFOR (planting_id, forest_id)
values (96, 131);
insert into ISFOR (planting_id, forest_id)
values (96, 192);
insert into ISFOR (planting_id, forest_id)
values (97, 40);
insert into ISFOR (planting_id, forest_id)
values (99, 130);
insert into ISFOR (planting_id, forest_id)
values (102, 158);
insert into ISFOR (planting_id, forest_id)
values (104, 259);
insert into ISFOR (planting_id, forest_id)
values (105, 126);
insert into ISFOR (planting_id, forest_id)
values (105, 198);
insert into ISFOR (planting_id, forest_id)
values (106, 196);
insert into ISFOR (planting_id, forest_id)
values (106, 294);
insert into ISFOR (planting_id, forest_id)
values (108, 211);
insert into ISFOR (planting_id, forest_id)
values (108, 290);
insert into ISFOR (planting_id, forest_id)
values (108, 293);
insert into ISFOR (planting_id, forest_id)
values (109, 81);
insert into ISFOR (planting_id, forest_id)
values (110, 82);
insert into ISFOR (planting_id, forest_id)
values (110, 152);
insert into ISFOR (planting_id, forest_id)
values (110, 153);
insert into ISFOR (planting_id, forest_id)
values (110, 322);
insert into ISFOR (planting_id, forest_id)
values (113, 252);
insert into ISFOR (planting_id, forest_id)
values (113, 270);
insert into ISFOR (planting_id, forest_id)
values (114, 255);
insert into ISFOR (planting_id, forest_id)
values (116, 116);
insert into ISFOR (planting_id, forest_id)
values (118, 208);
insert into ISFOR (planting_id, forest_id)
values (119, 146);
insert into ISFOR (planting_id, forest_id)
values (120, 125);
insert into ISFOR (planting_id, forest_id)
values (120, 294);
insert into ISFOR (planting_id, forest_id)
values (121, 31);
insert into ISFOR (planting_id, forest_id)
values (122, 243);
insert into ISFOR (planting_id, forest_id)
values (123, 98);
insert into ISFOR (planting_id, forest_id)
values (124, 270);
insert into ISFOR (planting_id, forest_id)
values (125, 82);
insert into ISFOR (planting_id, forest_id)
values (125, 108);
insert into ISFOR (planting_id, forest_id)
values (127, 241);
insert into ISFOR (planting_id, forest_id)
values (128, 211);
insert into ISFOR (planting_id, forest_id)
values (128, 321);
insert into ISFOR (planting_id, forest_id)
values (129, 64);
insert into ISFOR (planting_id, forest_id)
values (131, 48);
insert into ISFOR (planting_id, forest_id)
values (131, 192);
insert into ISFOR (planting_id, forest_id)
values (132, 150);
insert into ISFOR (planting_id, forest_id)
values (132, 163);
insert into ISFOR (planting_id, forest_id)
values (132, 301);
insert into ISFOR (planting_id, forest_id)
values (135, 371);
insert into ISFOR (planting_id, forest_id)
values (136, 224);
insert into ISFOR (planting_id, forest_id)
values (136, 254);
insert into ISFOR (planting_id, forest_id)
values (137, 215);
insert into ISFOR (planting_id, forest_id)
values (138, 211);
insert into ISFOR (planting_id, forest_id)
values (138, 372);
insert into ISFOR (planting_id, forest_id)
values (139, 89);
insert into ISFOR (planting_id, forest_id)
values (140, 86);
insert into ISFOR (planting_id, forest_id)
values (141, 175);
insert into ISFOR (planting_id, forest_id)
values (142, 2);
insert into ISFOR (planting_id, forest_id)
values (142, 83);
insert into ISFOR (planting_id, forest_id)
values (143, 6);
insert into ISFOR (planting_id, forest_id)
values (143, 15);
insert into ISFOR (planting_id, forest_id)
values (144, 345);
insert into ISFOR (planting_id, forest_id)
values (145, 98);
insert into ISFOR (planting_id, forest_id)
values (146, 155);
insert into ISFOR (planting_id, forest_id)
values (146, 276);
insert into ISFOR (planting_id, forest_id)
values (147, 92);
insert into ISFOR (planting_id, forest_id)
values (147, 274);
insert into ISFOR (planting_id, forest_id)
values (149, 41);
insert into ISFOR (planting_id, forest_id)
values (150, 247);
insert into ISFOR (planting_id, forest_id)
values (150, 270);
insert into ISFOR (planting_id, forest_id)
values (152, 141);
insert into ISFOR (planting_id, forest_id)
values (153, 394);
insert into ISFOR (planting_id, forest_id)
values (154, 6);
insert into ISFOR (planting_id, forest_id)
values (154, 108);
insert into ISFOR (planting_id, forest_id)
values (156, 78);
insert into ISFOR (planting_id, forest_id)
values (156, 111);
insert into ISFOR (planting_id, forest_id)
values (156, 308);
insert into ISFOR (planting_id, forest_id)
values (158, 72);
insert into ISFOR (planting_id, forest_id)
values (158, 374);
insert into ISFOR (planting_id, forest_id)
values (159, 136);
insert into ISFOR (planting_id, forest_id)
values (160, 228);
commit;
prompt 200 records committed...
insert into ISFOR (planting_id, forest_id)
values (161, 143);
insert into ISFOR (planting_id, forest_id)
values (161, 316);
insert into ISFOR (planting_id, forest_id)
values (162, 55);
insert into ISFOR (planting_id, forest_id)
values (163, 241);
insert into ISFOR (planting_id, forest_id)
values (164, 148);
insert into ISFOR (planting_id, forest_id)
values (166, 142);
insert into ISFOR (planting_id, forest_id)
values (166, 264);
insert into ISFOR (planting_id, forest_id)
values (168, 244);
insert into ISFOR (planting_id, forest_id)
values (170, 158);
insert into ISFOR (planting_id, forest_id)
values (171, 207);
insert into ISFOR (planting_id, forest_id)
values (172, 124);
insert into ISFOR (planting_id, forest_id)
values (173, 91);
insert into ISFOR (planting_id, forest_id)
values (174, 283);
insert into ISFOR (planting_id, forest_id)
values (176, 61);
insert into ISFOR (planting_id, forest_id)
values (176, 259);
insert into ISFOR (planting_id, forest_id)
values (177, 75);
insert into ISFOR (planting_id, forest_id)
values (177, 201);
insert into ISFOR (planting_id, forest_id)
values (178, 126);
insert into ISFOR (planting_id, forest_id)
values (180, 33);
insert into ISFOR (planting_id, forest_id)
values (180, 59);
insert into ISFOR (planting_id, forest_id)
values (181, 177);
insert into ISFOR (planting_id, forest_id)
values (181, 230);
insert into ISFOR (planting_id, forest_id)
values (181, 277);
insert into ISFOR (planting_id, forest_id)
values (181, 291);
insert into ISFOR (planting_id, forest_id)
values (182, 202);
insert into ISFOR (planting_id, forest_id)
values (182, 371);
insert into ISFOR (planting_id, forest_id)
values (183, 205);
insert into ISFOR (planting_id, forest_id)
values (184, 87);
insert into ISFOR (planting_id, forest_id)
values (184, 308);
insert into ISFOR (planting_id, forest_id)
values (185, 375);
insert into ISFOR (planting_id, forest_id)
values (186, 87);
insert into ISFOR (planting_id, forest_id)
values (186, 205);
insert into ISFOR (planting_id, forest_id)
values (186, 286);
insert into ISFOR (planting_id, forest_id)
values (187, 385);
insert into ISFOR (planting_id, forest_id)
values (188, 231);
insert into ISFOR (planting_id, forest_id)
values (188, 292);
insert into ISFOR (planting_id, forest_id)
values (189, 265);
insert into ISFOR (planting_id, forest_id)
values (189, 319);
insert into ISFOR (planting_id, forest_id)
values (190, 204);
insert into ISFOR (planting_id, forest_id)
values (191, 105);
insert into ISFOR (planting_id, forest_id)
values (192, 298);
insert into ISFOR (planting_id, forest_id)
values (193, 55);
insert into ISFOR (planting_id, forest_id)
values (194, 102);
insert into ISFOR (planting_id, forest_id)
values (194, 266);
insert into ISFOR (planting_id, forest_id)
values (194, 314);
insert into ISFOR (planting_id, forest_id)
values (195, 24);
insert into ISFOR (planting_id, forest_id)
values (197, 131);
insert into ISFOR (planting_id, forest_id)
values (199, 5);
insert into ISFOR (planting_id, forest_id)
values (199, 28);
insert into ISFOR (planting_id, forest_id)
values (200, 73);
insert into ISFOR (planting_id, forest_id)
values (201, 275);
insert into ISFOR (planting_id, forest_id)
values (202, 33);
insert into ISFOR (planting_id, forest_id)
values (206, 49);
insert into ISFOR (planting_id, forest_id)
values (206, 255);
insert into ISFOR (planting_id, forest_id)
values (207, 32);
insert into ISFOR (planting_id, forest_id)
values (207, 244);
insert into ISFOR (planting_id, forest_id)
values (208, 12);
insert into ISFOR (planting_id, forest_id)
values (208, 366);
insert into ISFOR (planting_id, forest_id)
values (210, 369);
insert into ISFOR (planting_id, forest_id)
values (211, 51);
insert into ISFOR (planting_id, forest_id)
values (211, 312);
insert into ISFOR (planting_id, forest_id)
values (212, 62);
insert into ISFOR (planting_id, forest_id)
values (212, 240);
insert into ISFOR (planting_id, forest_id)
values (212, 266);
insert into ISFOR (planting_id, forest_id)
values (214, 184);
insert into ISFOR (planting_id, forest_id)
values (215, 174);
insert into ISFOR (planting_id, forest_id)
values (215, 328);
insert into ISFOR (planting_id, forest_id)
values (216, 11);
insert into ISFOR (planting_id, forest_id)
values (216, 369);
insert into ISFOR (planting_id, forest_id)
values (217, 49);
insert into ISFOR (planting_id, forest_id)
values (218, 275);
insert into ISFOR (planting_id, forest_id)
values (218, 283);
insert into ISFOR (planting_id, forest_id)
values (219, 98);
insert into ISFOR (planting_id, forest_id)
values (219, 356);
insert into ISFOR (planting_id, forest_id)
values (220, 349);
insert into ISFOR (planting_id, forest_id)
values (221, 61);
insert into ISFOR (planting_id, forest_id)
values (222, 356);
insert into ISFOR (planting_id, forest_id)
values (223, 249);
insert into ISFOR (planting_id, forest_id)
values (224, 106);
insert into ISFOR (planting_id, forest_id)
values (227, 23);
insert into ISFOR (planting_id, forest_id)
values (229, 80);
insert into ISFOR (planting_id, forest_id)
values (229, 101);
insert into ISFOR (planting_id, forest_id)
values (231, 219);
insert into ISFOR (planting_id, forest_id)
values (231, 364);
insert into ISFOR (planting_id, forest_id)
values (233, 94);
insert into ISFOR (planting_id, forest_id)
values (233, 173);
insert into ISFOR (planting_id, forest_id)
values (234, 161);
insert into ISFOR (planting_id, forest_id)
values (234, 173);
insert into ISFOR (planting_id, forest_id)
values (235, 121);
insert into ISFOR (planting_id, forest_id)
values (235, 200);
insert into ISFOR (planting_id, forest_id)
values (237, 70);
insert into ISFOR (planting_id, forest_id)
values (239, 132);
insert into ISFOR (planting_id, forest_id)
values (239, 331);
insert into ISFOR (planting_id, forest_id)
values (240, 147);
insert into ISFOR (planting_id, forest_id)
values (242, 153);
insert into ISFOR (planting_id, forest_id)
values (242, 372);
insert into ISFOR (planting_id, forest_id)
values (243, 25);
insert into ISFOR (planting_id, forest_id)
values (243, 57);
insert into ISFOR (planting_id, forest_id)
values (244, 47);
insert into ISFOR (planting_id, forest_id)
values (245, 146);
commit;
prompt 300 records committed...
insert into ISFOR (planting_id, forest_id)
values (245, 264);
insert into ISFOR (planting_id, forest_id)
values (246, 112);
insert into ISFOR (planting_id, forest_id)
values (247, 142);
insert into ISFOR (planting_id, forest_id)
values (248, 370);
insert into ISFOR (planting_id, forest_id)
values (249, 258);
insert into ISFOR (planting_id, forest_id)
values (250, 49);
insert into ISFOR (planting_id, forest_id)
values (250, 151);
insert into ISFOR (planting_id, forest_id)
values (250, 217);
insert into ISFOR (planting_id, forest_id)
values (251, 141);
insert into ISFOR (planting_id, forest_id)
values (251, 169);
insert into ISFOR (planting_id, forest_id)
values (252, 44);
insert into ISFOR (planting_id, forest_id)
values (253, 176);
insert into ISFOR (planting_id, forest_id)
values (256, 350);
insert into ISFOR (planting_id, forest_id)
values (257, 147);
insert into ISFOR (planting_id, forest_id)
values (257, 197);
insert into ISFOR (planting_id, forest_id)
values (258, 166);
insert into ISFOR (planting_id, forest_id)
values (258, 204);
insert into ISFOR (planting_id, forest_id)
values (259, 50);
insert into ISFOR (planting_id, forest_id)
values (259, 207);
insert into ISFOR (planting_id, forest_id)
values (259, 310);
insert into ISFOR (planting_id, forest_id)
values (259, 367);
insert into ISFOR (planting_id, forest_id)
values (261, 62);
insert into ISFOR (planting_id, forest_id)
values (261, 113);
insert into ISFOR (planting_id, forest_id)
values (261, 185);
insert into ISFOR (planting_id, forest_id)
values (262, 10);
insert into ISFOR (planting_id, forest_id)
values (262, 112);
insert into ISFOR (planting_id, forest_id)
values (267, 61);
insert into ISFOR (planting_id, forest_id)
values (267, 148);
insert into ISFOR (planting_id, forest_id)
values (267, 197);
insert into ISFOR (planting_id, forest_id)
values (268, 50);
insert into ISFOR (planting_id, forest_id)
values (268, 132);
insert into ISFOR (planting_id, forest_id)
values (268, 388);
insert into ISFOR (planting_id, forest_id)
values (269, 171);
insert into ISFOR (planting_id, forest_id)
values (269, 265);
insert into ISFOR (planting_id, forest_id)
values (270, 267);
insert into ISFOR (planting_id, forest_id)
values (270, 345);
insert into ISFOR (planting_id, forest_id)
values (271, 170);
insert into ISFOR (planting_id, forest_id)
values (271, 301);
insert into ISFOR (planting_id, forest_id)
values (272, 3);
insert into ISFOR (planting_id, forest_id)
values (274, 176);
insert into ISFOR (planting_id, forest_id)
values (274, 277);
insert into ISFOR (planting_id, forest_id)
values (275, 149);
insert into ISFOR (planting_id, forest_id)
values (275, 265);
insert into ISFOR (planting_id, forest_id)
values (277, 178);
insert into ISFOR (planting_id, forest_id)
values (277, 209);
insert into ISFOR (planting_id, forest_id)
values (277, 335);
insert into ISFOR (planting_id, forest_id)
values (278, 333);
insert into ISFOR (planting_id, forest_id)
values (283, 9);
insert into ISFOR (planting_id, forest_id)
values (283, 18);
insert into ISFOR (planting_id, forest_id)
values (283, 201);
insert into ISFOR (planting_id, forest_id)
values (283, 248);
insert into ISFOR (planting_id, forest_id)
values (283, 268);
insert into ISFOR (planting_id, forest_id)
values (284, 96);
insert into ISFOR (planting_id, forest_id)
values (284, 128);
insert into ISFOR (planting_id, forest_id)
values (286, 179);
insert into ISFOR (planting_id, forest_id)
values (288, 330);
insert into ISFOR (planting_id, forest_id)
values (289, 200);
insert into ISFOR (planting_id, forest_id)
values (293, 129);
insert into ISFOR (planting_id, forest_id)
values (294, 106);
insert into ISFOR (planting_id, forest_id)
values (296, 219);
insert into ISFOR (planting_id, forest_id)
values (296, 279);
insert into ISFOR (planting_id, forest_id)
values (297, 115);
insert into ISFOR (planting_id, forest_id)
values (299, 219);
insert into ISFOR (planting_id, forest_id)
values (299, 240);
insert into ISFOR (planting_id, forest_id)
values (300, 53);
insert into ISFOR (planting_id, forest_id)
values (300, 113);
insert into ISFOR (planting_id, forest_id)
values (300, 160);
insert into ISFOR (planting_id, forest_id)
values (300, 263);
insert into ISFOR (planting_id, forest_id)
values (301, 169);
insert into ISFOR (planting_id, forest_id)
values (302, 31);
insert into ISFOR (planting_id, forest_id)
values (302, 218);
insert into ISFOR (planting_id, forest_id)
values (303, 97);
insert into ISFOR (planting_id, forest_id)
values (303, 313);
insert into ISFOR (planting_id, forest_id)
values (303, 327);
insert into ISFOR (planting_id, forest_id)
values (303, 364);
insert into ISFOR (planting_id, forest_id)
values (304, 250);
insert into ISFOR (planting_id, forest_id)
values (306, 37);
insert into ISFOR (planting_id, forest_id)
values (308, 59);
insert into ISFOR (planting_id, forest_id)
values (309, 88);
insert into ISFOR (planting_id, forest_id)
values (309, 184);
insert into ISFOR (planting_id, forest_id)
values (310, 370);
insert into ISFOR (planting_id, forest_id)
values (311, 40);
insert into ISFOR (planting_id, forest_id)
values (311, 296);
insert into ISFOR (planting_id, forest_id)
values (311, 317);
insert into ISFOR (planting_id, forest_id)
values (311, 329);
insert into ISFOR (planting_id, forest_id)
values (311, 380);
insert into ISFOR (planting_id, forest_id)
values (312, 18);
insert into ISFOR (planting_id, forest_id)
values (313, 217);
insert into ISFOR (planting_id, forest_id)
values (315, 43);
insert into ISFOR (planting_id, forest_id)
values (315, 101);
insert into ISFOR (planting_id, forest_id)
values (316, 11);
insert into ISFOR (planting_id, forest_id)
values (317, 47);
insert into ISFOR (planting_id, forest_id)
values (317, 153);
insert into ISFOR (planting_id, forest_id)
values (318, 306);
insert into ISFOR (planting_id, forest_id)
values (319, 18);
insert into ISFOR (planting_id, forest_id)
values (319, 143);
insert into ISFOR (planting_id, forest_id)
values (319, 161);
insert into ISFOR (planting_id, forest_id)
values (322, 212);
insert into ISFOR (planting_id, forest_id)
values (322, 258);
insert into ISFOR (planting_id, forest_id)
values (323, 246);
commit;
prompt 400 records committed...
insert into ISFOR (planting_id, forest_id)
values (324, 371);
insert into ISFOR (planting_id, forest_id)
values (325, 56);
insert into ISFOR (planting_id, forest_id)
values (325, 98);
insert into ISFOR (planting_id, forest_id)
values (326, 109);
insert into ISFOR (planting_id, forest_id)
values (327, 282);
insert into ISFOR (planting_id, forest_id)
values (328, 19);
insert into ISFOR (planting_id, forest_id)
values (328, 65);
insert into ISFOR (planting_id, forest_id)
values (329, 262);
insert into ISFOR (planting_id, forest_id)
values (329, 279);
insert into ISFOR (planting_id, forest_id)
values (330, 307);
insert into ISFOR (planting_id, forest_id)
values (331, 48);
insert into ISFOR (planting_id, forest_id)
values (331, 63);
insert into ISFOR (planting_id, forest_id)
values (331, 104);
insert into ISFOR (planting_id, forest_id)
values (331, 285);
insert into ISFOR (planting_id, forest_id)
values (332, 158);
insert into ISFOR (planting_id, forest_id)
values (332, 283);
insert into ISFOR (planting_id, forest_id)
values (333, 226);
insert into ISFOR (planting_id, forest_id)
values (338, 134);
insert into ISFOR (planting_id, forest_id)
values (339, 186);
insert into ISFOR (planting_id, forest_id)
values (340, 373);
insert into ISFOR (planting_id, forest_id)
values (343, 158);
insert into ISFOR (planting_id, forest_id)
values (344, 325);
insert into ISFOR (planting_id, forest_id)
values (346, 37);
insert into ISFOR (planting_id, forest_id)
values (346, 91);
insert into ISFOR (planting_id, forest_id)
values (346, 285);
insert into ISFOR (planting_id, forest_id)
values (347, 101);
insert into ISFOR (planting_id, forest_id)
values (347, 136);
insert into ISFOR (planting_id, forest_id)
values (347, 159);
insert into ISFOR (planting_id, forest_id)
values (350, 109);
insert into ISFOR (planting_id, forest_id)
values (352, 151);
insert into ISFOR (planting_id, forest_id)
values (352, 290);
insert into ISFOR (planting_id, forest_id)
values (353, 39);
insert into ISFOR (planting_id, forest_id)
values (353, 252);
insert into ISFOR (planting_id, forest_id)
values (354, 45);
insert into ISFOR (planting_id, forest_id)
values (354, 302);
insert into ISFOR (planting_id, forest_id)
values (357, 25);
insert into ISFOR (planting_id, forest_id)
values (357, 144);
insert into ISFOR (planting_id, forest_id)
values (359, 246);
insert into ISFOR (planting_id, forest_id)
values (360, 122);
insert into ISFOR (planting_id, forest_id)
values (360, 245);
insert into ISFOR (planting_id, forest_id)
values (360, 282);
insert into ISFOR (planting_id, forest_id)
values (365, 178);
insert into ISFOR (planting_id, forest_id)
values (365, 344);
insert into ISFOR (planting_id, forest_id)
values (366, 190);
insert into ISFOR (planting_id, forest_id)
values (368, 13);
insert into ISFOR (planting_id, forest_id)
values (368, 70);
insert into ISFOR (planting_id, forest_id)
values (369, 102);
insert into ISFOR (planting_id, forest_id)
values (370, 27);
insert into ISFOR (planting_id, forest_id)
values (370, 46);
insert into ISFOR (planting_id, forest_id)
values (371, 188);
insert into ISFOR (planting_id, forest_id)
values (371, 249);
insert into ISFOR (planting_id, forest_id)
values (371, 332);
insert into ISFOR (planting_id, forest_id)
values (374, 16);
insert into ISFOR (planting_id, forest_id)
values (374, 205);
insert into ISFOR (planting_id, forest_id)
values (376, 6);
insert into ISFOR (planting_id, forest_id)
values (376, 299);
insert into ISFOR (planting_id, forest_id)
values (378, 158);
insert into ISFOR (planting_id, forest_id)
values (378, 318);
insert into ISFOR (planting_id, forest_id)
values (379, 231);
insert into ISFOR (planting_id, forest_id)
values (381, 348);
insert into ISFOR (planting_id, forest_id)
values (383, 193);
insert into ISFOR (planting_id, forest_id)
values (384, 282);
insert into ISFOR (planting_id, forest_id)
values (387, 230);
commit;
prompt 463 records loaded
prompt Loading PREVENTION_ACTIONS...
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (1, 'Burning the Cuttings', 955.95, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (2, 'Pruning', 900.61, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (3, 'Sanitation', 947.41, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (4, 'Watchtowers', 694.34, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (5, 'Burning the Cuttings', 187.04, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (6, 'Pruning', 621.32, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (7, 'Removing the Cuttings and the Tree Waste', 976.33, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (8, 'Thinning', 187.05, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (9, 'Pruning', 493.45, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (10, 'Water', 354.13, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (11, 'Firebreaks', 435.16, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (12, 'Water', 120.74, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (13, 'Firebreaks', 343.33, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (14, 'Watchtowers', 583.31, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (15, 'Removing the Cuttings and the Tree Waste', 315.21, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (16, 'Sanitation', 807.46, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (17, 'Pruning', 95.85, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (18, 'Water', 157.87, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (19, 'Sanitation', 253.36, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (20, 'Pruning', 437.31, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (21, 'Removing the Cuttings and the Tree Waste', 832.34, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (22, 'Sanitation', 604.13, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (23, 'Sanitation', 691.03, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (24, 'access roads', 198.86, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (25, 'Watchtowers', 223, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (26, 'Removing the Cuttings and the Tree Waste', 774.3, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (27, 'Firebreaks', 531.89, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (28, 'Firebreaks', 288.13, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (29, 'Thinning', 480.34, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (30, 'Removing the Cuttings and the Tree Waste', 814.58, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (31, 'Firebreaks', 506.83, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (32, 'Firebreaks', 403.53, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (33, 'Firebreaks', 807.45, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (34, 'Burning the Cuttings', 525.33, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (35, 'Water', 600.36, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (36, 'Water', 95.74, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (37, 'Firebreaks', 627.19, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (38, 'Water', 314.04, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (39, 'Burning the Cuttings', 230.89, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (40, 'Burning the Cuttings', 526.1, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (41, 'Burning the Cuttings', 64.91, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (42, 'access roads', 29.85, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (43, 'Signposting', 112.65, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (44, 'Signposting', 518.07, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (45, 'Sanitation', 443.67, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (46, 'Firebreaks', 901.89, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (47, 'Water', 10.05, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (48, 'Firebreaks', 96.58, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (49, 'Sanitation', 959.19, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (50, 'access roads', 491.63, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (51, 'Pruning', 107.67, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (52, 'Firebreaks', 120.07, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (53, 'Sanitation', 895.74, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (54, 'Signposting', 758.86, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (55, 'Signposting', 755.19, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (56, 'Pruning', 840.13, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (57, 'Sanitation', 387.04, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (58, 'Sanitation', 159.15, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (59, 'Burning the Cuttings', 863.16, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (60, 'Signposting', 496.27, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (61, 'access roads', 270.58, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (62, 'access roads', 18.69, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (63, 'Removing the Cuttings and the Tree Waste', 859.65, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (64, 'Firebreaks', 263.27, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (65, 'access roads', 570.05, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (66, 'Firebreaks', 550.09, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (67, 'Burning the Cuttings', 942.62, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (68, 'access roads', 957.72, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (69, 'access roads', 926.81, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (70, 'Water', 942.4, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (71, 'Signposting', 922.59, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (72, 'Burning the Cuttings', 696.64, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (73, 'Sanitation', 281.18, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (74, 'Watchtowers', 4.8, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (75, 'Burning the Cuttings', 623.16, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (76, 'Sanitation', 449.29, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (77, 'Removing the Cuttings and the Tree Waste', 833.62, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (78, 'Burning the Cuttings', 182.17, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (79, 'Pruning', 551.11, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (80, 'Pruning', 776.81, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (81, 'Thinning', 579.06, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (82, 'Sanitation', 884.83, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (83, 'Burning the Cuttings', 487.29, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (84, 'Water', 173.68, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (85, 'Sanitation', 456.99, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (86, 'Thinning', 574.58, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (87, 'Removing the Cuttings and the Tree Waste', 70.77, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (88, 'Signposting', 801.06, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (89, 'Thinning', 721.98, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (90, 'Watchtowers', 88.59, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (91, 'Firebreaks', 590.69, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (92, 'Thinning', 731.15, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (93, 'access roads', 219.8, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (94, 'Water', 167.73, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (95, 'Watchtowers', 596.2, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (96, 'Watchtowers', 802.37, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (97, 'Burning the Cuttings', 362.19, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (98, 'Firebreaks', 569.04, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (99, 'Watchtowers', 355.29, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (100, 'Pruning', 377.63, 'strong protection for a long time');
commit;
prompt 100 records committed...
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (101, 'Pruning', 801.93, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (102, 'Sanitation', 747.55, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (103, 'Burning the Cuttings', 653.32, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (104, 'Firebreaks', 908.6, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (105, 'Firebreaks', 288.25, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (106, 'Sanitation', 703.31, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (107, 'access roads', 23.64, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (108, 'Removing the Cuttings and the Tree Waste', 326.42, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (109, 'Burning the Cuttings', 719.38, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (110, 'Water', 534.25, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (111, 'Sanitation', 561.87, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (112, 'access roads', 383.15, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (113, 'Pruning', 7.44, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (114, 'access roads', 605.25, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (115, 'Sanitation', 92.79, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (116, 'access roads', 380.77, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (117, 'Pruning', 629.11, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (118, 'Pruning', 12.87, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (119, 'Sanitation', 324.34, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (120, 'Pruning', 208.7, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (121, 'Thinning', 671.51, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (122, 'Removing the Cuttings and the Tree Waste', 22.74, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (123, 'Thinning', 925.12, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (124, 'Signposting', 205.54, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (125, 'Pruning', 80.97, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (126, 'Firebreaks', 67.77, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (127, 'Thinning', 583.61, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (128, 'Firebreaks', 390.84, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (129, 'Pruning', 968, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (130, 'access roads', 253.21, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (131, 'Removing the Cuttings and the Tree Waste', 393.2, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (132, 'Burning the Cuttings', 230.07, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (133, 'Sanitation', 473.57, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (134, 'Pruning', 427.4, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (135, 'Sanitation', 230.65, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (136, 'Sanitation', 767.18, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (137, 'Water', 915.71, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (138, 'Burning the Cuttings', 230.77, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (139, 'Signposting', 973.61, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (140, 'Signposting', 919.94, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (141, 'Sanitation', 148.12, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (142, 'Sanitation', 166.39, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (143, 'Removing the Cuttings and the Tree Waste', 986.47, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (144, 'Water', 105.71, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (145, 'Removing the Cuttings and the Tree Waste', 112.2, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (146, 'Removing the Cuttings and the Tree Waste', 187.93, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (147, 'Firebreaks', 446.97, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (148, 'access roads', 802.62, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (149, 'Water', 804, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (150, 'Water', 510.89, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (151, 'Signposting', 594.24, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (152, 'Signposting', 886.86, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (153, 'Sanitation', 256.57, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (154, 'Water', 420.29, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (155, 'Water', 958.86, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (156, 'Watchtowers', 911.91, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (157, 'Pruning', 944.91, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (158, 'Burning the Cuttings', 353.23, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (159, 'Removing the Cuttings and the Tree Waste', 940.91, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (160, 'access roads', 626.58, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (161, 'Watchtowers', 21.1, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (162, 'Pruning', 480.17, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (163, 'access roads', 551.71, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (164, 'Pruning', 736.18, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (165, 'Burning the Cuttings', 715.71, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (166, 'Thinning', 439.09, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (167, 'Sanitation', 221.57, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (168, 'Watchtowers', 605.93, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (169, 'Burning the Cuttings', 179.39, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (170, 'Water', 883.01, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (171, 'Water', 857.71, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (172, 'Signposting', 637.75, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (173, 'access roads', 379.83, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (174, 'Watchtowers', 769.09, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (175, 'Removing the Cuttings and the Tree Waste', 815.95, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (176, 'Burning the Cuttings', 605.64, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (177, 'Burning the Cuttings', 402.47, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (178, 'Removing the Cuttings and the Tree Waste', 617.06, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (179, 'Thinning', 766.7, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (180, 'Signposting', 670.17, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (181, 'Watchtowers', 370.15, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (182, 'Removing the Cuttings and the Tree Waste', 441.08, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (183, 'Thinning', 880.34, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (184, 'Signposting', 918.49, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (185, 'Firebreaks', 127.46, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (186, 'Burning the Cuttings', 883.09, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (187, 'Pruning', 564.27, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (188, 'Removing the Cuttings and the Tree Waste', 858.01, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (189, 'Water', 674.51, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (190, 'Pruning', 194.46, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (191, 'Removing the Cuttings and the Tree Waste', 551.59, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (192, 'Firebreaks', 708.14, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (193, 'Signposting', 694.16, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (194, 'Watchtowers', 774.53, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (195, 'Thinning', 940.91, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (196, 'Watchtowers', 666.29, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (197, 'Pruning', 645.07, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (198, 'access roads', 806.83, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (199, 'Firebreaks', 256.27, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (200, 'Firebreaks', 707.57, 'medium protection for a while');
commit;
prompt 200 records committed...
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (201, 'access roads', 793.6, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (202, 'Watchtowers', 805.98, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (203, 'Water', 79.26, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (204, 'Water', 513.88, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (205, 'Firebreaks', 58.84, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (206, 'Water', 834.42, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (207, 'Removing the Cuttings and the Tree Waste', 106.84, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (208, 'Burning the Cuttings', 934.33, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (209, 'Burning the Cuttings', 251.56, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (210, 'Burning the Cuttings', 690.76, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (211, 'Thinning', 503.11, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (212, 'Pruning', 223.35, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (213, 'Watchtowers', 182.52, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (214, 'Water', 634.55, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (215, 'Firebreaks', 394.49, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (216, 'Burning the Cuttings', 846.08, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (217, 'Water', 875.28, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (218, 'Removing the Cuttings and the Tree Waste', 660.79, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (219, 'Burning the Cuttings', 778.16, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (220, 'Signposting', 439.02, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (221, 'Firebreaks', 433.11, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (222, 'access roads', 373.68, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (223, 'Pruning', 581.5, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (224, 'Signposting', 303.57, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (225, 'Sanitation', 936.31, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (226, 'Signposting', 363.37, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (227, 'access roads', 554.17, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (228, 'Firebreaks', 801.76, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (229, 'Signposting', 596.1, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (230, 'access roads', 937.2, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (231, 'Burning the Cuttings', 717.38, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (232, 'access roads', 672.87, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (233, 'Sanitation', 216.15, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (234, 'Thinning', 389.08, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (235, 'Sanitation', 308.34, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (236, 'Firebreaks', 360.12, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (237, 'Burning the Cuttings', 410.81, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (238, 'Thinning', 958.72, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (239, 'Water', 793.4, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (240, 'Watchtowers', 485.05, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (241, 'Sanitation', 152.49, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (242, 'Pruning', 629.41, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (243, 'Burning the Cuttings', 930.4, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (244, 'Removing the Cuttings and the Tree Waste', 583.29, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (245, 'Sanitation', 255.53, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (246, 'access roads', 745.07, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (247, 'Burning the Cuttings', 806.36, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (248, 'Water', 800.76, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (249, 'Pruning', 196.24, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (250, 'Watchtowers', 191.55, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (251, 'access roads', 522.1, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (252, 'Burning the Cuttings', 979.51, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (253, 'Signposting', 573.44, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (254, 'Removing the Cuttings and the Tree Waste', 213.2, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (255, 'Thinning', 715.44, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (256, 'Removing the Cuttings and the Tree Waste', 820.16, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (257, 'Thinning', 16.53, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (258, 'Sanitation', 247.28, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (259, 'Water', 20.86, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (260, 'Firebreaks', 195.45, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (261, 'Water', 611.75, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (262, 'Watchtowers', 825.75, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (263, 'access roads', 359.4, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (264, 'Burning the Cuttings', 622.97, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (265, 'Pruning', 324.8, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (266, 'Signposting', 190.62, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (267, 'Removing the Cuttings and the Tree Waste', 955.84, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (268, 'Water', 558.78, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (269, 'Signposting', 60.71, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (270, 'Watchtowers', 146.32, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (271, 'Water', 757.48, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (272, 'Thinning', 194.94, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (273, 'access roads', 853.73, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (274, 'Pruning', 942.12, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (275, 'Firebreaks', 389.92, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (276, 'Removing the Cuttings and the Tree Waste', 166.85, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (277, 'Firebreaks', 510.31, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (278, 'Removing the Cuttings and the Tree Waste', 617.12, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (279, 'Sanitation', 109.01, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (280, 'Burning the Cuttings', 969.38, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (281, 'Sanitation', 325.73, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (282, 'Burning the Cuttings', 890.81, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (283, 'Water', 641.59, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (284, 'Water', 165.04, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (285, 'Water', 116.72, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (286, 'Removing the Cuttings and the Tree Waste', 663.38, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (287, 'Firebreaks', 130.69, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (288, 'Firebreaks', 297.57, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (289, 'Water', 645.42, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (290, 'Sanitation', 299.08, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (291, 'Burning the Cuttings', 453.03, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (292, 'Sanitation', 630.09, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (293, 'Removing the Cuttings and the Tree Waste', 842.79, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (294, 'Pruning', 560.55, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (295, 'Sanitation', 69.33, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (296, 'Sanitation', 662.92, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (297, 'Pruning', 852.36, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (298, 'Burning the Cuttings', 701.18, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (299, 'Sanitation', 452.27, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (300, 'access roads', 260.47, 'strong protection for a long time');
commit;
prompt 300 records committed...
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (301, 'Removing the Cuttings and the Tree Waste', 610.86, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (302, 'Water', 522.29, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (303, 'Watchtowers', 183.52, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (304, 'Watchtowers', 655.22, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (305, 'Sanitation', 937.95, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (306, 'Watchtowers', 676.09, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (307, 'Sanitation', 439.08, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (308, 'Water', 893.95, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (309, 'access roads', 471.56, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (310, 'Thinning', 73.79, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (311, 'Removing the Cuttings and the Tree Waste', 403.32, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (312, 'access roads', 191.83, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (313, 'Burning the Cuttings', 51.2, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (314, 'Water', 558.09, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (315, 'Signposting', 526.04, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (316, 'Water', 50.65, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (317, 'Sanitation', 659.93, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (318, 'Water', 600.56, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (319, 'Signposting', 94.73, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (320, 'Signposting', 968.82, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (321, 'Water', 949.87, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (322, 'Sanitation', 34.59, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (323, 'Signposting', 587.05, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (324, 'Signposting', 278.05, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (325, 'Water', 673.27, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (326, 'access roads', 969.23, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (327, 'Thinning', 949.17, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (328, 'Watchtowers', 290.43, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (329, 'Sanitation', 442.56, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (330, 'Firebreaks', 587.63, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (331, 'Thinning', 124.79, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (332, 'Burning the Cuttings', 424.4, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (333, 'Water', 445.7, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (334, 'Firebreaks', 192.61, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (335, 'Sanitation', 774.84, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (336, 'Water', 747.64, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (337, 'Firebreaks', 283.27, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (338, 'Burning the Cuttings', 407.21, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (339, 'Thinning', 83.97, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (340, 'Sanitation', 82.17, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (341, 'Water', 188.77, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (342, 'Signposting', 162.75, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (343, 'access roads', 712.8, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (344, 'Burning the Cuttings', 610.33, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (345, 'Thinning', 71.19, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (346, 'Removing the Cuttings and the Tree Waste', 761.36, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (347, 'Sanitation', 796.81, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (348, 'Removing the Cuttings and the Tree Waste', 980.6, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (349, 'Sanitation', 741.65, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (350, 'Water', 702.61, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (351, 'Burning the Cuttings', 992.02, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (352, 'Pruning', 728.26, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (353, 'Sanitation', 68.36, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (354, 'Water', 980.01, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (355, 'Removing the Cuttings and the Tree Waste', 265.13, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (356, 'Sanitation', 466.54, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (357, 'Signposting', 22.29, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (358, 'Thinning', 721.22, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (359, 'Burning the Cuttings', 598.06, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (360, 'Water', 543.08, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (361, 'Water', 255.55, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (362, 'Thinning', 473.21, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (363, 'Burning the Cuttings', 473.52, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (364, 'Removing the Cuttings and the Tree Waste', 395.41, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (365, 'Watchtowers', 150.48, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (366, 'Firebreaks', 334.09, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (367, 'Thinning', 796.92, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (368, 'access roads', 666.52, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (369, 'Pruning', 280.59, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (370, 'Firebreaks', 445.75, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (371, 'Watchtowers', 313.42, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (372, 'Thinning', 40.48, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (373, 'Thinning', 373.87, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (374, 'access roads', 351.34, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (375, 'Burning the Cuttings', 831.18, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (376, 'Signposting', 884.47, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (377, 'Signposting', 998.44, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (378, 'access roads', 371.91, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (379, 'Thinning', 112, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (380, 'Firebreaks', 915.59, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (381, 'Signposting', 510.61, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (382, 'Pruning', 956.02, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (383, 'Burning the Cuttings', 4.49, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (384, 'Pruning', 291.24, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (385, 'Water', 292.33, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (386, 'Thinning', 722.66, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (387, 'Pruning', 6.49, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (388, 'Sanitation', 734.5, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (389, 'access roads', 563.54, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (390, 'Firebreaks', 921.55, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (391, 'Sanitation', 174.18, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (392, 'access roads', 892.95, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (393, 'Burning the Cuttings', 150.6, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (394, 'Pruning', 689.11, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (395, 'Watchtowers', 702.43, 'strong protection for a long time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (396, 'Burning the Cuttings', 29.13, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (397, 'access roads', 823.98, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (398, 'Signposting', 744.76, 'medium protection for a while');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (399, 'Pruning', 104.55, 'low protection for a short time');
insert into PREVENTION_ACTIONS (action_id, action_name, cost, action_duration)
values (400, 'Signposting', 490.25, 'medium protection for a while');
commit;
prompt 400 records loaded
prompt Loading TREES...
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'Russia', 201);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Yew', 'Switzerland', 202);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'Mexico', 203);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'Italy', 204);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'Canada', 205);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'France', 206);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'United Kingdom', 207);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Rowan', 'Israel', 208);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'Russia', 209);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'Argentina', 210);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Sweden', 211);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sycamore', 'Switzerland', 212);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'France', 213);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'France', 214);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Larch', 'Japan', 215);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'Spain', 216);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'Switzerland', 217);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Rowan', 'Greece', 218);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'United States', 219);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Mexico', 220);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Fir', 'Spain', 221);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'China', 222);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'India', 223);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Fir', 'South Africa', 224);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'China', 225);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Switzerland', 226);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hickory', 'Austria', 227);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'Japan', 228);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Mahogany', 'United States', 229);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'Germany', 230);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Spain', 231);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'Norway', 232);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'Germany', 233);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Austria', 234);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'Poland', 235);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hickory', 'Netherlands', 236);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Italy', 237);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'Switzerland', 238);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Eucalyptus', 'Italy', 239);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Poplar', 'Austria', 240);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Belgium', 241);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Poplar', 'Canada', 242);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'Denmark', 243);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'New Zealand', 244);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'India', 245);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'New Zealand', 246);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Elm', 'Greece', 247);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'Russia', 248);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Elm', 'France', 249);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'Sweden', 250);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Israel', 251);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Poplar', 'Argentina', 252);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sycamore', 'Switzerland', 253);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'Mexico', 254);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'United Kingdom', 255);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Germany', 256);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Spain', 257);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Larch', 'United Kingdom', 258);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'United States', 259);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Juniper', 'India', 260);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Italy', 261);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Spain', 262);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'Israel', 263);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'Netherlands', 264);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hickory', 'China', 265);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'Sweden', 266);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'Denmark', 267);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Larch', 'India', 268);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Eucalyptus', 'Russia', 269);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Japan', 270);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Larch', 'United States', 271);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Palm', 'Denmark', 272);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'Russia', 273);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'Russia', 274);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'Norway', 275);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'Switzerland', 276);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'South Africa', 277);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cypress', 'France', 278);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'Germany', 279);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Austria', 280);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'Germany', 281);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Palm', 'Japan', 282);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Mahogany', 'United States', 283);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'Argentina', 284);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Rowan', 'United States', 285);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Juniper', 'Italy', 286);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'Netherlands', 287);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'Canada', 288);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'Austria', 289);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'Brazil', 290);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Rowan', 'Australia', 291);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Yew', 'Israel', 292);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'Germany', 293);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Brazil', 294);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Elm', 'Germany', 295);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Boxelder', 'Japan', 296);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'Spain', 297);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'Austria', 298);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Palm', 'India', 299);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Poland', 300);
commit;
prompt 100 records committed...
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Portugal', 301);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'Germany', 302);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Yew', 'India', 303);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Redwood', 'Italy', 304);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cypress', 'Portugal', 305);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'Italy', 306);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Boxelder', 'Israel', 307);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'India', 308);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Boxelder', 'China', 309);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Rowan', 'Canada', 310);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sycamore', 'Greece', 311);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'China', 312);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'China', 313);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'Japan', 314);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cypress', 'Spain', 315);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Boxelder', 'New Zealand', 316);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'Spain', 317);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'Japan', 318);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Netherlands', 319);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'India', 320);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'South Africa', 321);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Austria', 322);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Redwood', 'Italy', 323);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Argentina', 324);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'Norway', 325);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Italy', 326);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'France', 327);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Juniper', 'Netherlands', 328);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Mahogany', 'Italy', 329);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Palm', 'Mexico', 330);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Fir', 'Switzerland', 331);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'Canada', 332);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Spain', 333);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Palm', 'Portugal', 334);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'Spain', 335);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'United Kingdom', 336);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'Switzerland', 337);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'Russia', 338);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'Sweden', 339);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'Belgium', 340);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Fir', 'Israel', 341);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Palm', 'South Africa', 342);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'Portugal', 343);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Israel', 344);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Argentina', 345);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Denmark', 346);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Russia', 347);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Argentina', 348);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Eucalyptus', 'Japan', 349);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Canada', 350);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Greece', 351);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Australia', 352);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'Belgium', 353);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'China', 354);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'Germany', 355);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cypress', 'Poland', 356);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Eucalyptus', 'Israel', 357);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Elm', 'France', 358);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'India', 359);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Eucalyptus', 'Poland', 360);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'Austria', 361);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'Poland', 362);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'New Zealand', 363);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Argentina', 364);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'France', 365);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'Belgium', 366);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'Spain', 367);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Rowan', 'Argentina', 368);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cypress', 'Argentina', 369);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Rowan', 'China', 370);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'China', 371);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'Argentina', 372);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'United States', 373);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'Israel', 374);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Russia', 375);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Netherlands', 376);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'France', 377);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Elm', 'Portugal', 378);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Portugal', 379);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hickory', 'China', 380);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'France', 381);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Poplar', 'Ireland', 382);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'Denmark', 383);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Redwood', 'United States', 384);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'China', 385);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Switzerland', 386);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Palm', 'Spain', 387);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Australia', 388);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Eucalyptus', 'India', 389);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cypress', 'France', 390);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Fir', 'Argentina', 391);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'Russia', 392);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'Canada', 393);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'South Africa', 394);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Redwood', 'Russia', 395);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Eucalyptus', 'Finland', 396);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Mexico', 397);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'Russia', 398);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'Denmark', 399);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'Canada', 400);
commit;
prompt 200 records committed...
insert into TREES (tree_id, type, origin, forest_id)
values (81, 'Juniper', 'France', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (82, 'Cherry Blossom', 'China', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (83, 'Eucalyptus', 'Canada', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (84, 'Redwood', 'South Africa', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (85, 'Sycamore', 'Israel', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (86, 'Pine', 'United States', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (87, 'Spruce', 'Spain', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (88, 'Hemlock', 'China', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (89, 'Cherry Blossom', 'Portugal', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (90, 'Fir', 'Denmark', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (91, 'Boxelder', 'Austria', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (92, 'Maple', 'Ireland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (93, 'Poplar', 'Argentina', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (94, 'Ash', 'South Africa', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (95, 'Sycamore', 'Russia', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (96, 'Hickory', 'Finland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (97, 'Oak', 'Mexico', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (98, 'Poplar', 'Poland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (99, 'Douglas Fir', 'Mexico', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (100, 'Sycamore', 'Netherlands', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (101, 'Yew', 'Ireland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (102, 'Palm', 'Austria', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (103, 'Elm', 'Mexico', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (104, 'Cherry Blossom', 'Japan', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (105, 'Hemlock', 'China', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (106, 'Maple', 'Brazil', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (107, 'Pine', 'India', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (108, 'Palm', 'Israel', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (109, 'Ash', 'United Kingdom', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (110, 'Boxelder', 'South Africa', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (111, 'Willow', 'Germany', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (112, 'Mahogany', 'Switzerland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (113, 'Hemlock', 'Austria', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (114, 'Sequoia', 'China', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (115, 'Cedar', 'Japan', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (116, 'Cypress', 'Russia', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (117, 'Hemlock', 'Norway', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (118, 'Willow', 'South Africa', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (119, 'Sycamore', 'Greece', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (120, 'Ash', 'Switzerland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (121, 'Birch', 'Finland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (122, 'Hickory', 'Brazil', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (123, 'Birch', 'Argentina', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (124, 'Redwood', 'Greece', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (125, 'Elm', 'Mexico', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (126, 'Pine', 'Germany', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (127, 'Mahogany', 'New Zealand', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (128, 'Poplar', 'Ireland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (129, 'Eucalyptus', 'Italy', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (130, 'Willow', 'Sweden', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (131, 'Spruce', 'India', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (132, 'Oak', 'Italy', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (133, 'Palm', 'Finland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (134, 'Douglas Fir', 'Austria', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (135, 'Hickory', 'Israel', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (136, 'Ash', 'Netherlands', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (137, 'Fir', 'Brazil', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (138, 'Beech', 'Belgium', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (139, 'Cedar', 'United Kingdom', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (140, 'Cedar', 'Australia', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (141, 'Poplar', 'Austria', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (142, 'Pine', 'Russia', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (143, 'Palm', 'New Zealand', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (144, 'Eucalyptus', 'United States', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (145, 'Fir', 'United States', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (146, 'Boxelder', 'Australia', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (147, 'Beech', 'South Africa', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (148, 'Douglas Fir', 'Belgium', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (149, 'Palm', 'Australia', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (150, 'Ash', 'Brazil', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Boxelder', 'South Africa', 5);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'China', 6);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'Austria', 7);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Belgium', 8);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Eucalyptus', 'Australia', 9);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Fir', 'China', 10);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'Italy', 11);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'South Africa', 12);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Juniper', 'Austria', 13);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Fir', 'China', 14);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Rowan', 'United States', 15);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'United Kingdom', 16);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'France', 17);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'Finland', 18);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'Belgium', 19);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Germany', 20);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'Italy', 21);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'Israel', 22);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'Netherlands', 23);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Yew', 'New Zealand', 24);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Elm', 'South Africa', 25);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'Canada', 26);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Italy', 27);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Poplar', 'France', 28);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Japan', 29);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Juniper', 'Switzerland', 30);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Eucalyptus', 'Sweden', 31);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hickory', 'Japan', 32);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Juniper', 'Mexico', 33);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Fir', 'Sweden', 34);
commit;
prompt 300 records committed...
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Redwood', 'Israel', 35);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'Portugal', 36);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Canada', 37);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Japan', 38);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'Argentina', 39);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Redwood', 'Germany', 40);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'China', 41);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Israel', 42);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Redwood', 'China', 43);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sycamore', 'United Kingdom', 44);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Netherlands', 45);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'Belgium', 46);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'United Kingdom', 47);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Juniper', 'Spain', 48);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'New Zealand', 49);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Fir', 'United Kingdom', 50);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'Greece', 51);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'New Zealand', 52);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Sweden', 53);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Palm', 'United States', 54);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hickory', 'Austria', 55);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'United Kingdom', 56);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Finland', 57);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Mexico', 58);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hickory', 'Belgium', 59);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cypress', 'Spain', 60);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Palm', 'United Kingdom', 61);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'China', 62);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Redwood', 'Norway', 63);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Israel', 64);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'Spain', 65);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Mexico', 66);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Rowan', 'New Zealand', 67);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Portugal', 68);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'New Zealand', 69);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Netherlands', 70);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Redwood', 'New Zealand', 71);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'Belgium', 72);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Juniper', 'Russia', 73);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Greece', 74);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Rowan', 'Portugal', 75);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Argentina', 76);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Elm', 'Poland', 77);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Elm', 'Belgium', 78);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'Belgium', 79);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'South Africa', 80);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'Poland', 81);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'Italy', 82);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Russia', 83);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hickory', 'Japan', 84);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'Australia', 85);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Germany', 86);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hickory', 'Austria', 87);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Larch', 'Finland', 88);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Palm', 'Poland', 89);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Eucalyptus', 'China', 90);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Mahogany', 'United States', 91);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'Israel', 92);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Juniper', 'Finland', 93);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Boxelder', 'Sweden', 94);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Yew', 'United Kingdom', 95);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Poplar', 'Argentina', 96);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'United States', 97);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Argentina', 98);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Juniper', 'Denmark', 99);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Rowan', 'Germany', 100);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'United Kingdom', 101);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Portugal', 102);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'Poland', 103);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Larch', 'Norway', 104);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'Canada', 105);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Ash', 'Portugal', 106);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Boxelder', 'Poland', 107);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cypress', 'Russia', 108);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Mexico', 109);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Switzerland', 110);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Mahogany', 'Mexico', 111);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Redwood', 'Greece', 112);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Canada', 113);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Poplar', 'Portugal', 114);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Sweden', 115);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Mahogany', 'Brazil', 116);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'China', 117);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Brazil', 118);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Portugal', 119);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'Mexico', 120);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Poland', 121);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'Japan', 122);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'Greece', 123);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Juniper', 'Russia', 124);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Yew', 'Mexico', 125);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'Spain', 126);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Willow', 'Italy', 127);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Brazil', 128);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'Belgium', 129);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hickory', 'Japan', 130);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Argentina', 131);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Russia', 132);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Poland', 133);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Elm', 'Sweden', 134);
commit;
prompt 400 records committed...
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Poplar', 'Greece', 135);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'Russia', 136);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Mahogany', 'Netherlands', 137);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Yew', 'Switzerland', 138);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'Russia', 139);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Eucalyptus', 'Germany', 140);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'Argentina', 141);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'Germany', 142);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Finland', 143);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'United Kingdom', 144);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Mahogany', 'Norway', 145);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Elm', 'Argentina', 146);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Elm', 'Portugal', 147);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Yew', 'United States', 148);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Poplar', 'India', 149);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'South Africa', 150);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Maple', 'Austria', 151);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Russia', 152);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'Ireland', 153);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Austria', 154);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sequoia', 'Portugal', 155);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Norway', 156);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'United Kingdom', 157);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Poplar', 'Sweden', 158);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'Italy', 159);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Israel', 160);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Mahogany', 'Switzerland', 161);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sycamore', 'Germany', 162);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'United Kingdom', 163);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Israel', 164);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'Norway', 165);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'Greece', 166);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Larch', 'Mexico', 167);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'China', 168);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cherry Blossom', 'Germany', 169);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Larch', 'India', 170);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Oak', 'Greece', 171);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'United States', 172);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hickory', 'United Kingdom', 173);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'China', 174);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'Argentina', 175);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'New Zealand', 176);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Yew', 'Finland', 177);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Rowan', 'South Africa', 178);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Mahogany', 'Brazil', 179);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Poplar', 'Canada', 180);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Cedar', 'Australia', 181);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'Portugal', 182);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Fir', 'China', 183);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'Italy', 184);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Redwood', 'Denmark', 185);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Birch', 'Netherlands', 186);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Fir', 'United Kingdom', 187);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Aspen', 'Netherlands', 188);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Redwood', 'Japan', 189);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Palm', 'Denmark', 190);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sycamore', 'Poland', 191);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Larch', 'Israel', 192);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Pine', 'Brazil', 193);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Fir', 'Finland', 194);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sycamore', 'France', 195);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Beech', 'Brazil', 196);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Acacia', 'Finland', 197);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Douglas Fir', 'Denmark', 198);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Palm', 'China', 199);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Spruce', 'Sweden', 200);
insert into TREES (tree_id, type, origin, forest_id)
values (68, 'Rowan', 'Finland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (69, 'Maple', 'Italy', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (70, 'Spruce', 'Mexico', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (71, 'Oak', 'Poland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (72, 'Yew', 'France', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (73, 'Boxelder', 'Switzerland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (74, 'Juniper', 'New Zealand', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (75, 'Redwood', 'Belgium', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (76, 'Hickory', 'Norway', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (77, 'Hemlock', 'Portugal', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (78, 'Larch', 'Finland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (79, 'Pine', 'Finland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (80, 'Elm', 'Sweden', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (81, 'Douglas Fir', 'Belgium', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (82, 'Oak', 'Belgium', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (83, 'Spruce', 'Switzerland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (84, 'Maple', 'Norway', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (85, 'Pine', 'Israel', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (86, 'Sequoia', 'Spain', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (87, 'Yew', 'Belgium', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (88, 'Douglas Fir', 'France', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (89, 'Birch', 'Japan', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (90, 'Hickory', 'South Africa', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (91, 'Oak', 'Ireland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (92, 'Rowan', 'China', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (93, 'Oak', 'United States', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (94, 'Sequoia', 'South Africa', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (95, 'Oak', 'South Africa', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (96, 'Spruce', 'Norway', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (97, 'Juniper', 'Netherlands', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (98, 'Acacia', 'Brazil', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (99, 'Mahogany', 'Ireland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (100, 'Pine', 'India', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (101, 'Spruce', 'Canada', 3);
commit;
prompt 500 records committed...
insert into TREES (tree_id, type, origin, forest_id)
values (102, 'Ash', 'Italy', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (103, 'Cherry Blossom', 'Argentina', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (104, 'Palm', 'Norway', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (105, 'Elm', 'Greece', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (106, 'Eucalyptus', 'Switzerland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (107, 'Cypress', 'Spain', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (108, 'Yew', 'South Africa', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (109, 'Yew', 'Portugal', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (110, 'Douglas Fir', 'Poland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (111, 'Yew', 'Denmark', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (112, 'Fir', 'United Kingdom', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (113, 'Birch', 'Germany', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (114, 'Hemlock', 'Poland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (115, 'Maple', 'Switzerland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (116, 'Juniper', 'Mexico', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (117, 'Willow', 'Argentina', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (118, 'Cherry Blossom', 'Poland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (119, 'Eucalyptus', 'Greece', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (120, 'Maple', 'New Zealand', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (121, 'Yew', 'Portugal', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (122, 'Palm', 'Spain', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (123, 'Elm', 'Ireland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (124, 'Willow', 'New Zealand', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (125, 'Sequoia', 'Poland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (126, 'Fir', 'Spain', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (127, 'Beech', 'Netherlands', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (128, 'Hemlock', 'Brazil', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (129, 'Acacia', 'United States', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (130, 'Birch', 'Switzerland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (131, 'Boxelder', 'Russia', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (132, 'Beech', 'Germany', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (133, 'Maple', 'United Kingdom', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (134, 'Redwood', 'Israel', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (135, 'Juniper', 'United States', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (136, 'Oak', 'United Kingdom', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (137, 'Willow', 'Mexico', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (138, 'Aspen', 'Netherlands', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (139, 'Beech', 'France', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (140, 'Willow', 'Mexico', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (141, 'Ash', 'Mexico', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (142, 'Willow', 'Norway', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (143, 'Elm', 'France', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (144, 'Beech', 'Japan', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (145, 'Cedar', 'Greece', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (146, 'Mahogany', 'Mexico', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (147, 'Ash', 'Greece', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (148, 'Juniper', 'Canada', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (149, 'Willow', 'Russia', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (150, 'Sequoia', 'Norway', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Sycamore', 'Portugal', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (2, 'Juniper', 'Italy', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (3, 'Rowan', 'Ireland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (4, 'Hickory', 'Switzerland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (5, 'Oak', 'Netherlands', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (6, 'Sycamore', 'Japan', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (7, 'Hemlock', 'Argentina', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (8, 'Spruce', 'Ireland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (9, 'Beech', 'United States', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (10, 'Poplar', 'Portugal', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (11, 'Douglas Fir', 'United States', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (12, 'Ash', 'France', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (13, 'Cherry Blossom', 'Brazil', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (14, 'Sequoia', 'Israel', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (15, 'Acacia', 'Switzerland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (16, 'Boxelder', 'Finland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (17, 'Mahogany', 'Denmark', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (18, 'Redwood', 'Norway', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (19, 'Sequoia', 'Greece', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (20, 'Juniper', 'Mexico', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (21, 'Pine', 'Finland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (22, 'Beech', 'United Kingdom', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (23, 'Rowan', 'Norway', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (24, 'Willow', 'Austria', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (25, 'Oak', 'Sweden', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (26, 'Beech', 'Argentina', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (27, 'Mahogany', 'South Africa', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (28, 'Cedar', 'Israel', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (29, 'Ash', 'China', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (30, 'Poplar', 'Netherlands', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (31, 'Spruce', 'Australia', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (32, 'Poplar', 'Norway', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (33, 'Rowan', 'Switzerland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (34, 'Cherry Blossom', 'New Zealand', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (35, 'Willow', 'Switzerland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (36, 'Cherry Blossom', 'Norway', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (37, 'Palm', 'South Africa', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (38, 'Maple', 'India', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (39, 'Boxelder', 'Italy', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (40, 'Yew', 'Brazil', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (41, 'Birch', 'New Zealand', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (42, 'Larch', 'Mexico', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (43, 'Yew', 'Ireland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (44, 'Aspen', 'India', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (45, 'Cherry Blossom', 'Sweden', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (46, 'Douglas Fir', 'Finland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (47, 'Willow', 'Italy', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (48, 'Birch', 'India', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (49, 'Eucalyptus', 'Germany', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (50, 'Eucalyptus', 'Poland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (51, 'Spruce', 'Israel', 4);
commit;
prompt 600 records committed...
insert into TREES (tree_id, type, origin, forest_id)
values (52, 'Cherry Blossom', 'Austria', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (53, 'Beech', 'Switzerland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (54, 'Hickory', 'Canada', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (55, 'Poplar', 'Sweden', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (56, 'Sequoia', 'Brazil', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (57, 'Larch', 'Norway', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (58, 'Aspen', 'Germany', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (59, 'Palm', 'South Africa', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (60, 'Poplar', 'Portugal', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (61, 'Rowan', 'United Kingdom', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (62, 'Sequoia', 'Israel', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (63, 'Ash', 'South Africa', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (64, 'Pine', 'Austria', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (65, 'Oak', 'Greece', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (66, 'Spruce', 'Denmark', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (67, 'Hemlock', 'Portugal', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (68, 'Mahogany', 'South Africa', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (69, 'Beech', 'Ireland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (70, 'Sequoia', 'Finland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (71, 'Douglas Fir', 'Finland', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (72, 'Fir', 'Italy', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (73, 'Fir', 'Brazil', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (74, 'Spruce', 'Japan', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (75, 'Ash', 'New Zealand', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (76, 'Poplar', 'United Kingdom', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (77, 'Hemlock', 'Australia', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (78, 'Spruce', 'Argentina', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (79, 'Cedar', 'Germany', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (80, 'Sycamore', 'Denmark', 4);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Elm', 'Canada', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (2, 'Hemlock', 'Canada', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (3, 'Cypress', 'New Zealand', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (4, 'Fir', 'Germany', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (5, 'Cedar', 'China', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (6, 'Hemlock', 'Greece', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (7, 'Palm', 'South Africa', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (8, 'Acacia', 'Russia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (9, 'Ash', 'Brazil', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (10, 'Poplar', 'Denmark', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (11, 'Birch', 'Russia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (12, 'Aspen', 'Israel', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (13, 'Oak', 'Switzerland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (14, 'Acacia', 'France', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (15, 'Birch', 'Portugal', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (16, 'Eucalyptus', 'Poland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (17, 'Boxelder', 'Australia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (18, 'Eucalyptus', 'Poland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (19, 'Palm', 'Belgium', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (20, 'Pine', 'Greece', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (21, 'Rowan', 'Portugal', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (22, 'Maple', 'France', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (23, 'Aspen', 'Australia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (24, 'Ash', 'Denmark', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (25, 'Oak', 'United Kingdom', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (26, 'Aspen', 'Belgium', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (27, 'Aspen', 'Sweden', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (28, 'Redwood', 'Australia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (29, 'Hickory', 'New Zealand', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (30, 'Yew', 'Denmark', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (31, 'Sycamore', 'Poland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (32, 'Yew', 'Switzerland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (33, 'Beech', 'Israel', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (34, 'Maple', 'Italy', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (35, 'Elm', 'Austria', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (36, 'Palm', 'Switzerland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (37, 'Sycamore', 'United States', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (38, 'Juniper', 'Switzerland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (39, 'Eucalyptus', 'Finland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (40, 'Pine', 'Australia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (41, 'Cypress', 'China', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (42, 'Sycamore', 'Mexico', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (43, 'Juniper', 'Russia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (44, 'Boxelder', 'Russia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (45, 'Willow', 'Spain', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (46, 'Willow', 'Mexico', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (47, 'Sycamore', 'Argentina', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (48, 'Beech', 'France', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (49, 'Cherry Blossom', 'India', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (50, 'Willow', 'Mexico', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (51, 'Willow', 'Netherlands', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (52, 'Douglas Fir', 'Japan', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (53, 'Ash', 'Japan', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (54, 'Sycamore', 'Canada', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (55, 'Redwood', 'France', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (56, 'Mahogany', 'Ireland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (57, 'Elm', 'Denmark', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (58, 'Maple', 'New Zealand', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (59, 'Oak', 'New Zealand', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (60, 'Acacia', 'Israel', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (61, 'Cypress', 'Australia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (62, 'Aspen', 'Canada', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (63, 'Willow', 'Japan', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (64, 'Acacia', 'Canada', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (65, 'Cedar', 'Australia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (66, 'Oak', 'Russia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (67, 'Douglas Fir', 'Finland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (68, 'Birch', 'United Kingdom', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (69, 'Mahogany', 'Australia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (70, 'Eucalyptus', 'Finland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (71, 'Cherry Blossom', 'Denmark', 1);
commit;
prompt 700 records committed...
insert into TREES (tree_id, type, origin, forest_id)
values (72, 'Redwood', 'Argentina', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (73, 'Douglas Fir', 'Canada', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (74, 'Maple', 'Spain', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (75, 'Yew', 'China', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (76, 'Pine', 'Spain', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (77, 'Hemlock', 'Switzerland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (78, 'Redwood', 'Italy', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (79, 'Aspen', 'Australia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (80, 'Poplar', 'Austria', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (81, 'Hemlock', 'Mexico', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (82, 'Hickory', 'United States', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (83, 'Maple', 'Switzerland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (84, 'Yew', 'Australia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (85, 'Ash', 'New Zealand', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (86, 'Fir', 'France', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (87, 'Mahogany', 'Spain', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (88, 'Sycamore', 'Portugal', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (89, 'Aspen', 'Canada', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (90, 'Yew', 'United States', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (91, 'Cypress', 'United Kingdom', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (92, 'Cypress', 'Russia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (93, 'Maple', 'United States', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (94, 'Aspen', 'Canada', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (95, 'Juniper', 'Sweden', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (96, 'Sequoia', 'Italy', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (97, 'Hemlock', 'Ireland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (98, 'Aspen', 'Italy', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (99, 'Mahogany', 'Mexico', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (100, 'Hemlock', 'New Zealand', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (52, 'Sequoia', 'Austria', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (53, 'Sycamore', 'Denmark', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (54, 'Elm', 'Sweden', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (55, 'Redwood', 'South Africa', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (56, 'Ash', 'France', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (57, 'Cherry Blossom', 'Norway', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (58, 'Boxelder', 'Australia', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (59, 'Mahogany', 'Russia', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (60, 'Douglas Fir', 'China', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (61, 'Hemlock', 'Portugal', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (62, 'Hickory', 'Portugal', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (63, 'Fir', 'Brazil', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (64, 'Eucalyptus', 'Netherlands', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (65, 'Sycamore', 'Brazil', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (66, 'Cypress', 'Argentina', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (67, 'Hemlock', 'Australia', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (68, 'Hickory', 'United States', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (69, 'Poplar', 'Netherlands', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (70, 'Eucalyptus', 'Sweden', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (71, 'Spruce', 'Argentina', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (72, 'Douglas Fir', 'Switzerland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (73, 'Mahogany', 'Portugal', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (74, 'Hickory', 'United States', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (75, 'Birch', 'United Kingdom', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (76, 'Cherry Blossom', 'Germany', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (77, 'Acacia', 'France', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (78, 'Mahogany', 'Russia', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (79, 'Douglas Fir', 'Finland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (80, 'Juniper', 'Israel', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (81, 'Oak', 'Switzerland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (82, 'Poplar', 'Brazil', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (83, 'Mahogany', 'Germany', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (84, 'Willow', 'Poland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (85, 'Elm', 'Finland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (86, 'Cypress', 'Portugal', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (87, 'Poplar', 'Israel', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (88, 'Juniper', 'United States', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (89, 'Ash', 'Norway', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (90, 'Maple', 'Italy', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (91, 'Oak', 'Sweden', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (92, 'Eucalyptus', 'Sweden', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (93, 'Willow', 'Germany', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (94, 'Juniper', 'Canada', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (95, 'Eucalyptus', 'Netherlands', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (96, 'Aspen', 'Germany', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (97, 'Douglas Fir', 'Argentina', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (98, 'Acacia', 'Brazil', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (99, 'Rowan', 'Australia', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (100, 'Sequoia', 'Portugal', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (101, 'Ash', 'Russia', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (102, 'Rowan', 'Brazil', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (103, 'Douglas Fir', 'Canada', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (104, 'Beech', 'China', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (105, 'Mahogany', 'Austria', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (106, 'Yew', 'Spain', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (107, 'Acacia', 'Australia', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (108, 'Spruce', 'India', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (109, 'Poplar', 'Spain', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (110, 'Oak', 'Portugal', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (111, 'Aspen', 'Germany', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (112, 'Larch', 'Sweden', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (113, 'Birch', 'Belgium', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (114, 'Ash', 'Norway', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (115, 'Ash', 'China', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (116, 'Douglas Fir', 'India', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (117, 'Larch', 'Canada', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (118, 'Yew', 'Germany', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (119, 'Palm', 'Germany', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (120, 'Oak', 'Finland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (121, 'Cherry Blossom', 'Australia', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (122, 'Maple', 'Norway', 2);
commit;
prompt 800 records committed...
insert into TREES (tree_id, type, origin, forest_id)
values (123, 'Mahogany', 'Italy', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (124, 'Eucalyptus', 'New Zealand', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (125, 'Palm', 'New Zealand', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (126, 'Hickory', 'Canada', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (127, 'Maple', 'Brazil', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (128, 'Beech', 'Germany', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (129, 'Yew', 'Switzerland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (130, 'Elm', 'United Kingdom', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (131, 'Hemlock', 'Switzerland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (132, 'Eucalyptus', 'Switzerland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (133, 'Elm', 'India', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (134, 'Acacia', 'France', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (135, 'Juniper', 'France', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (136, 'Yew', 'Portugal', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (137, 'Juniper', 'China', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (138, 'Pine', 'New Zealand', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (139, 'Beech', 'Austria', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (140, 'Hemlock', 'Finland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (141, 'Beech', 'South Africa', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (142, 'Birch', 'Canada', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (143, 'Cypress', 'Norway', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (144, 'Pine', 'France', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (145, 'Willow', 'Norway', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (146, 'Mahogany', 'France', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (147, 'Cypress', 'Finland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (148, 'Mahogany', 'Finland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (149, 'Hemlock', 'Brazil', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (150, 'Oak', 'Portugal', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Mahogany', 'Austria', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (2, 'Willow', 'New Zealand', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (3, 'Eucalyptus', 'New Zealand', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (4, 'Ash', 'South Africa', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (5, 'Larch', 'Poland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (6, 'Fir', 'India', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (7, 'Oak', 'Spain', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (8, 'Poplar', 'Netherlands', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (9, 'Oak', 'Portugal', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (10, 'Sycamore', 'Greece', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (11, 'Redwood', 'Sweden', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (12, 'Spruce', 'Sweden', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (13, 'Palm', 'Mexico', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (14, 'Spruce', 'Australia', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (15, 'Ash', 'China', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (16, 'Hemlock', 'Canada', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (17, 'Pine', 'New Zealand', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (18, 'Juniper', 'Mexico', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (19, 'Cedar', 'Ireland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (20, 'Elm', 'United States', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (21, 'Aspen', 'Australia', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (22, 'Larch', 'China', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (23, 'Elm', 'Mexico', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (24, 'Larch', 'Portugal', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (25, 'Oak', 'Sweden', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (26, 'Rowan', 'United Kingdom', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (27, 'Sequoia', 'Greece', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (101, 'Sequoia', 'New Zealand', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (102, 'Maple', 'Finland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (103, 'Beech', 'Argentina', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (104, 'Rowan', 'Poland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (105, 'Eucalyptus', 'Germany', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (106, 'Juniper', 'India', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (107, 'Oak', 'Australia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (108, 'Eucalyptus', 'Spain', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (109, 'Boxelder', 'Spain', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (110, 'Oak', 'Portugal', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (111, 'Aspen', 'Poland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (112, 'Oak', 'Poland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (113, 'Yew', 'Austria', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (114, 'Cherry Blossom', 'Denmark', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (115, 'Ash', 'Argentina', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (116, 'Cherry Blossom', 'Australia', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (117, 'Sequoia', 'Argentina', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (118, 'Palm', 'New Zealand', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (119, 'Hickory', 'Japan', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (120, 'Elm', 'Brazil', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (121, 'Sequoia', 'Netherlands', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (122, 'Redwood', 'Netherlands', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (123, 'Beech', 'United States', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (124, 'Aspen', 'Greece', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (125, 'Cherry Blossom', 'Portugal', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (126, 'Oak', 'France', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (127, 'Pine', 'Spain', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (128, 'Sycamore', 'Netherlands', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (129, 'Palm', 'Denmark', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (130, 'Rowan', 'Israel', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (131, 'Redwood', 'Portugal', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (132, 'Redwood', 'India', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (133, 'Cherry Blossom', 'Greece', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (134, 'Hickory', 'Germany', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (135, 'Elm', 'France', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (136, 'Pine', 'Argentina', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (137, 'Yew', 'Brazil', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (138, 'Birch', 'Argentina', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (139, 'Redwood', 'Canada', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (140, 'Larch', 'Israel', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (141, 'Sequoia', 'United States', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (142, 'Fir', 'Italy', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (143, 'Mahogany', 'Canada', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (144, 'Birch', 'Switzerland', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (145, 'Larch', 'China', 1);
commit;
prompt 900 records committed...
insert into TREES (tree_id, type, origin, forest_id)
values (146, 'Larch', 'Mexico', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (147, 'Cherry Blossom', 'Argentina', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (148, 'Sycamore', 'Norway', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (149, 'Poplar', 'Brazil', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (150, 'Sycamore', 'Brazil', 1);
insert into TREES (tree_id, type, origin, forest_id)
values (1, 'Hemlock', 'Canada', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (2, 'Acacia', 'Portugal', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (3, 'Maple', 'New Zealand', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (4, 'Sequoia', 'Spain', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (5, 'Hemlock', 'Russia', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (25, 'Cypress', 'Brazil', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (26, 'Larch', 'Belgium', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (27, 'Redwood', 'Sweden', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (28, 'Cedar', 'Norway', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (29, 'Yew', 'South Africa', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (30, 'Ash', 'Greece', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (31, 'Larch', 'Poland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (32, 'Mahogany', 'New Zealand', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (33, 'Larch', 'Australia', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (34, 'Boxelder', 'Austria', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (35, 'Cherry Blossom', 'Netherlands', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (36, 'Oak', 'China', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (37, 'Eucalyptus', 'Portugal', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (38, 'Elm', 'Italy', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (39, 'Pine', 'United States', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (40, 'Boxelder', 'Switzerland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (41, 'Cypress', 'Austria', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (42, 'Pine', 'Switzerland', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (43, 'Ash', 'Portugal', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (44, 'Eucalyptus', 'Netherlands', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (45, 'Hickory', 'Japan', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (46, 'Hickory', 'United Kingdom', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (47, 'Willow', 'Germany', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (48, 'Birch', 'Denmark', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (49, 'Willow', 'China', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (50, 'Cedar', 'Germany', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (51, 'Douglas Fir', 'France', 2);
insert into TREES (tree_id, type, origin, forest_id)
values (28, 'Redwood', 'South Africa', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (29, 'Cypress', 'Belgium', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (30, 'Oak', 'Greece', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (31, 'Ash', 'United Kingdom', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (32, 'Redwood', 'Belgium', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (33, 'Cherry Blossom', 'Norway', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (34, 'Sequoia', 'Argentina', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (35, 'Palm', 'Germany', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (36, 'Juniper', 'Canada', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (37, 'Boxelder', 'Finland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (38, 'Elm', 'Norway', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (39, 'Yew', 'Portugal', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (40, 'Aspen', 'Finland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (41, 'Mahogany', 'Spain', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (42, 'Hemlock', 'Israel', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (43, 'Eucalyptus', 'Australia', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (44, 'Cherry Blossom', 'Israel', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (45, 'Cherry Blossom', 'Norway', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (46, 'Fir', 'Spain', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (47, 'Juniper', 'Finland', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (48, 'Spruce', 'Greece', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (49, 'Sycamore', 'Belgium', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (50, 'Spruce', 'Italy', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (51, 'Yew', 'Spain', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (52, 'Oak', 'Italy', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (53, 'Hemlock', 'United Kingdom', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (54, 'Spruce', 'India', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (55, 'Palm', 'South Africa', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (56, 'Rowan', 'Mexico', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (57, 'Palm', 'Norway', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (58, 'Acacia', 'Italy', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (59, 'Elm', 'United Kingdom', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (60, 'Cypress', 'Israel', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (61, 'Birch', 'Portugal', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (62, 'Boxelder', 'Japan', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (63, 'Larch', 'United States', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (64, 'Ash', 'India', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (65, 'Rowan', 'Brazil', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (66, 'Maple', 'United States', 3);
insert into TREES (tree_id, type, origin, forest_id)
values (67, 'Cypress', 'Switzerland', 3);
commit;
prompt 977 records loaded
prompt Loading TREE_PLANTING_PROJECTS_DONORS...
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Abby Heake', 301);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Abigail Bogart', 170);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Abran Massel', 251);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Adolf Braddock', 138);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ag Lorinez', 257);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Aggy Yearron', 317);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Alanna Matantsev', 74);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Alaster Tomasino', 93);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Aldis MacEllen', 314);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Alexandre Okeshott', 345);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Algernon Ringsell', 322);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Allianora Stede', 151);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Allx Coke', 142);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Alvie Corroyer', 273);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Amata Pietruszewicz', 197);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Amity Ohrt', 341);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Anastasie Booy', 175);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Anatollo Mourge', 369);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Andy Doige', 149);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Angelo Dunn', 1);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Annemarie Gladtbach', 65);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Anselm Facer', 148);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Anson Ballingal', 133);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Anthiathia Magowan', 114);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Archie Browell', 64);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ariadne Breckon', 393);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ariana Duiged', 383);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Arleen Jeandeau', 227);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Arther Belson', 105);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ashly Germon', 224);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Aubert Basill', 373);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Audre Paulich', 138);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Audrey Lawrenceson', 95);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Baird Pluthero', 280);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Barb Batchley', 235);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Barbe Marklund', 190);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Bat Lathan', 281);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Beckie Fogel', 45);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Beilul Reynard', 13);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Bellina Flipsen', 302);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Bent Mudge', 176);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Berkly Phythien', 230);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Bev McKelvey', 197);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Biddy Ceyssen', 139);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Blayne Arlt', 160);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Boyd Churchlow', 86);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Bram Vereker', 253);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Brandise Ickovicz', 264);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Bridie Stairmand', 62);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Caitrin Hansed', 225);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Camey Chatainier', 156);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Carley Simenel', 341);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Carly Milham', 219);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Carny Nicely', 321);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Carolyne Brooksby', 246);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Carree Seater', 209);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Casar MacGuffie', 168);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Caterina Chatwood', 221);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Cathi Bengtsson', 28);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Cecily Gorwood', 304);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Celene Medd', 232);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Celestina Gilham', 312);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Chandler Millen', 79);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Charil Blint', 338);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Charissa Symcoxe', 223);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Charity Minshall', 348);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Charlene Gelletly', 342);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Chauncey Denman', 62);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ches Warrell', 103);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Chiquia Greatex', 399);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Christoph Jeannaud', 181);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Chrysler Tradewell', 235);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Claudelle D''Hooghe', 33);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Codi Rudgerd', 333);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Colman Grimm', 359);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Conrad Wilsee', 226);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Constanta Dirand', 357);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Constantina Pryn', 76);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Corabel Faraker', 134);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Corena Patel', 282);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Cory Haville', 243);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Daisi Kays', 233);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Dale Korn', 173);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Dania Waddicor', 331);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Danita Boyington', 123);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Danita Craythorn', 198);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Darbie Zink', 77);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Debora Woollin', 372);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Deeyn Crehan', 91);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Dehlia Duffit', 302);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Delano Domico', 392);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Delmer Smalcombe', 187);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Den Chsteney', 273);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Derrick Wheildon', 3);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Derrik Ruppele', 261);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Devora Hassan', 171);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Didi Blackbourn', 70);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Dillon Silkston', 220);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Dinnie Rotherforth', 220);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Dorolisa Koop', 350);
commit;
prompt 100 records committed...
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Drucy Davidovitch', 331);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Dyanne Postans', 45);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Edouard Twomey', 137);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Eilis Wadeson', 94);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Eldon Dewfall', 58);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Eleanor Drepp', 134);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Elenore Stive', 21);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Elfie Collinette', 257);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ellie Magner', 62);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ellynn Cowap', 151);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Elna Feldmark', 364);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Emeline Skullet', 193);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ennis Moroney', 234);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ermentrude Battabee', 269);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Erroll Hugueville', 399);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Eulalie Baudouin', 125);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Eziechiele Pacitti', 163);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Fanchette Mose', 90);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Felipe Murcott', 376);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ferguson Stepto', 369);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Fernande Garfirth', 232);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Florencia Ilchuk', 21);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Florinda Cancellario', 273);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Flossie Rapson', 247);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Fowler Winterbotham', 270);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Frans Pottberry', 376);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Fred Lattin', 86);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Fulton Longford', 359);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Gare Simenel', 363);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Georgette Mould', 39);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Georgi Garlick', 75);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Georgie Markushkin', 351);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Geri Castle', 79);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Gianina Peeters', 166);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Giovanni Ofen', 82);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Gleda Shepcutt', 81);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Glen Vasyunichev', 118);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Glenine Goundsy', 187);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Gloriane Georgi', 80);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Goldina Fawkes', 270);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Grannie Greenmon', 211);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Grannie Tremayne', 77);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Grier Mableson', 379);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Gunilla Brownscombe', 240);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Gwendolin Moro', 106);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Halie Saph', 278);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Hally Ourtic', 370);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Harley Derr', 88);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Harli Langstone', 126);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Hedvige Arkcoll', 278);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Heida Matchett', 154);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Hercules Borthram', 18);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Hilde Tume', 185);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Hinda Longworthy', 123);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Honor Ussher', 81);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Horatio Peyes', 104);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Hubert Klewi', 186);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ibrahim Thieme', 280);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ingeborg Derrington', 57);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Iolande Hucke', 240);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jacquette Camidge', 25);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jaimie Stroton', 374);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Janet Rozsa', 30);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jehu Dundredge', 206);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jeniffer Banaszkiewicz', 204);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jenna Gear', 367);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jennilee Godmar', 105);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jeremiah Betteson', 80);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jermaine Yesinov', 10);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jerrie Kynman', 290);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jock Presnall', 146);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Johnnie Fishpoole', 134);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Johnnie Sharpless', 27);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jordan Kupker', 125);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jorry Woodwin', 349);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Jourdan Wapplington', 83);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Judd Pawels', 260);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Justinian Trustrie', 286);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Kaia Hitzke', 164);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Kailey Oty', 137);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Karissa Climie', 249);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Karla Ramel', 88);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Karly Izac', 49);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Karol Konneke', 26);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Karon Fattori', 192);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Katalin Swinburne', 98);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Katerine Mallia', 4);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Katey Toman', 335);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Kathlin Diggin', 112);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Katuscha Bohl', 8);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Kelli Brettoner', 112);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Kenneth Hallatt', 107);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Kiley Blight', 370);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Kipper Cowburn', 111);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Kippy Bushill', 17);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Kirby Polamontayne', 251);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Kirstin Rizzillo', 334);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Kitti Bold', 13);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Kordula Fragino', 25);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Krishna Ferrieres', 119);
commit;
prompt 200 records committed...
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lacie Flory', 67);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lanny Huddlestone', 342);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Laraine Smithies', 283);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lauren Giacobelli', 393);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Laurianne Routham', 315);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Layne Escoffier', 176);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lazare MacLaren', 152);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lea Densell', 155);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Leigh Largan', 66);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Leigh Lovekin', 272);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lenette Leathwood', 358);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lesley Rabidge', 148);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lewes Burgan', 27);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lexine Van Zon', 294);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lidia Waistall', 246);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Linea Plaunch', 246);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lissa Harse', 371);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Llewellyn Dix', 274);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lorens Cuppitt', 286);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lorilee Lidyard', 183);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lorine Penhale', 135);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lotta Reynard', 262);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lotte Hardcastle', 178);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Louie Portal', 319);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Luca MacKegg', 231);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lucais Pietzner', 373);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lucias Troup', 186);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lucina Allaker', 267);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lucina O''Griffin', 162);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ludwig Gaymar', 226);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Lynelle Tight', 336);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Maddie Varndall', 326);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Maddy Panchen', 392);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Malia Trumble', 63);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Mamie Rieflin', 339);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Manda Beton', 359);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Marena Lockie', 119);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Margaret Baskerfield', 100);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Margaretta Balfour', 216);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Margaretta Ivanishev', 5);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Marget Conrath', 263);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Margo Bernet', 140);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Margy Galilee', 185);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Maris Devas', 305);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Marius Solomon', 280);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Marjie Butter', 292);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Marris Willbond', 382);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Meir Diter', 105);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Melessa Maylin', 366);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Melisse Gilmore', 76);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Melosa Codling', 392);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Merell Kobes', 245);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Merrill Wheadon', 178);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Michelina Belfield', 316);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Mil Mathews', 94);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Minnie Biffen', 230);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Minta Manners', 145);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Mohammed Figgs', 182);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Moyra Dwelley', 61);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Muffin Davidowsky', 382);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Murial Fillan', 225);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Muriel Guyan', 17);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Mychal Brunet', 19);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Myer Salkild', 235);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Natasha Bleakman', 330);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Natty Swiggs', 27);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Neale Garbett', 245);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ned Tallach', 271);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Nedda Marzellano', 80);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Nerty Christaeas', 326);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Nessi Wilshin', 105);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Netty Lyosik', 74);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Nevile Malter', 70);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Niki Kisbee', 74);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Nilson Colston', 216);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Nina Pountain', 369);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ninnetta Mathouse', 392);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Obadiah Ugoni', 354);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Odey Erskine Sandys', 162);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Olia Luckie', 387);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Orelle Pavlasek', 22);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Osbourn Maxstead', 146);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Packston Balshen', 110);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Page Zamora', 72);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Pammy Devo', 39);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Patsy Heinle', 41);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Pattin Scarlon', 84);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Payton Endean', 239);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Percy Godleman', 37);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Perl Longfut', 381);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Petronia Gonnin', 16);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Philipa Lardeux', 218);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Phyllis Beavon', 261);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Pietrek Crowne', 58);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Powell Glawsop', 211);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Pru Verlander', 30);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Quinta Grogono', 342);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ragnar Speer', 355);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Randy Mylchreest', 50);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Raoul Amsden', 145);
commit;
prompt 300 records committed...
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Raquela Letteresse', 335);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Raynard Clayhill', 373);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Reginald De Freitas', 345);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Reine Lincey', 89);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Renell Dobey', 29);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Renell Skule', 400);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Richmound Avrashin', 119);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Rickie Pfiffer', 122);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Robby Cota', 124);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Robinia Leroux', 106);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Roddy Shory', 227);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Romain Hampshire', 198);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Romeo Swallow', 122);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Roobbie Fagge', 230);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Rosalinde Minci', 27);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Rosaline Barbisch', 305);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Rossie Roof', 353);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Royce Harses', 397);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Rube Silverthorne', 7);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Rudy Fransseni', 71);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ruthe Dummigan', 39);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ruthy Jedras', 315);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ryon Walklot', 127);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Saidee Belvard', 378);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Sal Smidmore', 90);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Salem Farquhar', 47);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Sander Faustin', 270);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Scot Murrow', 109);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Sean Tott', 347);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Sebastiano Nettle', 171);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Selena Purdy', 388);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Shannon Haffenden', 75);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Shannon Pollock', 38);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Shawn Gynni', 293);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Shawna Lathee', 58);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Shay Vaugham', 242);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Shayla Behrendsen', 342);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Shelton Towey', 257);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Shurwood Jandourek', 192);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Si Rathbone', 303);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Silas Finnes', 277);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Sondra Mafham', 353);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Staci Smallshaw', 318);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Stacia Cawcutt', 337);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Staford Filpi', 394);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Stavro Yuranovev', 14);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Sully Keelan', 62);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Susanna Fernley', 100);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Sutton Sheavills', 72);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Suzie Feige', 100);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Sylvia Burgoin', 181);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Tanitansy Karolowski', 85);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Tanney McKissack', 85);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Tate Cumber', 33);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Teddie Todeo', 289);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Terrijo Dottridge', 306);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Thelma Godmer', 233);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Theressa Ayars', 72);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Thom Eyree', 82);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Thomasine Keenlayside', 75);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Tiena Kummerlowe', 185);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Tim Galley', 248);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Timothy O''Duilleain', 392);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Tobit Girardengo', 197);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Tove Tickel', 303);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Trace Dorant', 20);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Tristam Senett', 211);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Tucky Goozee', 100);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ty Farden', 34);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Tyrone Eva', 219);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ulla Godden', 41);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Upton Dodwell', 183);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ursulina Peacock', 102);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Valentina Bryde', 252);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Vanya Driscoll', 282);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Verge Swindells', 302);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Vic Lowmass', 271);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Vin Glavis', 308);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Vita Hartless', 87);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Wake Phillpotts', 26);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Walsh Drowsfield', 381);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Walther Fulford', 359);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Ware Betjeman', 44);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Wendel Pentelow', 399);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Wildon Filde', 169);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Winnifred Oleszcuk', 89);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Winonah Harvatt', 389);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Wolfgang Blanket', 321);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Xenos Le Port', 130);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Xymenes Perrin', 128);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Yalonda Pancost', 300);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Yasmeen Greydon', 363);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Yetty Llorente', 42);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Yolane Spon', 47);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Yorker Stopforth', 309);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Zara Copcote', 65);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Zita Manns', 10);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Zollie MacDermot', 317);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Zollie Szymanski', 368);
insert into TREE_PLANTING_PROJECTS_DONORS (donors, planting_id)
values ('Zonda Dawson', 177);
commit;
prompt 400 records loaded
prompt Enabling foreign key constraints for EDUCATION_PROGRAMS...
alter table EDUCATION_PROGRAMS enable constraint SYS_C007409;
prompt Enabling foreign key constraints for HASA...
alter table HASA enable constraint SYS_C007437;
prompt Enabling foreign key constraints for ISFOR...
alter table ISFOR enable constraint SYS_C007421;
alter table ISFOR enable constraint SYS_C007438;
prompt Enabling foreign key constraints for TREES...
alter table TREES enable constraint SYS_C007439;
prompt Enabling foreign key constraints for TREE_PLANTING_PROJECTS_DONORS...
alter table TREE_PLANTING_PROJECTS_DONORS enable constraint SYS_C007430;
prompt Enabling triggers for RESEARCH_STATIONS...
alter table RESEARCH_STATIONS enable all triggers;
prompt Enabling triggers for EDUCATION_PROGRAMS...
alter table EDUCATION_PROGRAMS enable all triggers;
prompt Enabling triggers for FORESTS...
alter table FORESTS enable all triggers;
prompt Enabling triggers for HASA...
alter table HASA enable all triggers;
prompt Enabling triggers for TREE_PLANTING_PROJECTS...
alter table TREE_PLANTING_PROJECTS enable all triggers;
prompt Enabling triggers for ISFOR...
alter table ISFOR enable all triggers;
prompt Enabling triggers for PREVENTION_ACTIONS...
alter table PREVENTION_ACTIONS enable all triggers;
prompt Enabling triggers for TREES...
alter table TREES enable all triggers;
prompt Enabling triggers for TREE_PLANTING_PROJECTS_DONORS...
alter table TREE_PLANTING_PROJECTS_DONORS enable all triggers;
set feedback on
set define on
prompt Done.
