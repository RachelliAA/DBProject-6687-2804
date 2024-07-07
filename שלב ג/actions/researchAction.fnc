CREATE OR REPLACE FUNCTION researchAction(f_id forests.forest_id%type, a_id prevention_actions.action_id%type) 
RETURN SYS_REFCURSOR IS
  TYPE ref_cursor_type IS REF CURSOR;
  Result ref_cursor_type;
  action VARCHAR2(50);
  v_planting_id INTEGER;
BEGIN
  -- Find the next available planting_id 
  SELECT COALESCE(MAX(planting_id), 0) + 1 INTO v_planting_id FROM Tree_Planting_Projects;
  -- New planting project
  INSERT INTO TREE_PLANTING_PROJECTS (PLANTING_ID, START_DATE, END_DATE, FOREST_ID)
  VALUES (v_planting_id, TO_DATE('04-Jul-27', 'DD-Mon-YY'), TO_DATE('25-Aug-24', 'DD-Mon-YY'), f_id);
  DBMS_OUTPUT.PUT_LINE('Created planting project #' || v_planting_id);
  -- Add action to the forest
  -- Use a MERGE statement to insert only if the combination does not exist
  MERGE INTO HASA t
  USING (SELECT f_id AS forest_id, a_id AS action_id FROM DUAL) s
  ON (t.forest_id = s.forest_id AND t.action_id = s.action_id)
  WHEN NOT MATCHED THEN
    INSERT (forest_id, action_id)
    VALUES (s.forest_id, s.action_id);

  DBMS_OUTPUT.PUT_LINE('Insert check completed for HASA');

  -- Select action name into action variable
  SELECT action_name INTO action 
  FROM prevention_actions 
  WHERE action_id = a_id;

  -- Update the forest's research station subject and name
  UPDATE research_stations
  SET research_subject = action,
      station_name = 'Fire prevention research lab'
  WHERE rowid IN (
    SELECT rowid
    FROM research_stations
    WHERE forest_id = f_id
    AND ROWNUM = 1
  );

  -- Open the cursor for the result set
  OPEN Result FOR 
    SELECT * 
    FROM research_stations 
    WHERE research_subject = action;

  RETURN Result;
END researchAction;
/
