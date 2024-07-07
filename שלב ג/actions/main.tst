PL/SQL Developer Test script 3.0
102
DECLARE
  -- Variables
  random_forest NUMBER;
  random_action NUMBER;
  min_value INTEGER := 1;
  max_forest INTEGER := 400;
  max_action INTEGER := 10;
  v_cursor SYS_REFCURSOR;
  v_station_record research_stations%ROWTYPE;

  -- Exception to handle table lock
  e_table_busy EXCEPTION;
  PRAGMA EXCEPTION_INIT(e_table_busy, -54);
  
BEGIN
  DBMS_OUTPUT.PUT_LINE('Calling updateActions procedure...');
  -- Call procedure updateActions that updates prevention_actions table
  updateActions();
  DBMS_OUTPUT.PUT_LINE('updateActions completed.');
  
  /*
  -- Drop and recreate the HasA table
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Dropping table HasA...');
    EXECUTE IMMEDIATE 'DROP TABLE HasA';
    DBMS_OUTPUT.PUT_LINE('Table HasA dropped.');
  EXCEPTION
    WHEN e_table_busy THEN
      DBMS_OUTPUT.PUT_LINE('Table HasA is busy, retrying...');
      DBMS_LOCK.SLEEP(1); -- Wait for 1 second before retrying
      EXECUTE IMMEDIATE 'DROP TABLE HasA';
      DBMS_OUTPUT.PUT_LINE('Table HasA dropped after retry.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error dropping table HasA: ' || SQLERRM);
  END;

  EXECUTE IMMEDIATE 'CREATE TABLE HasA (
                        forest_ID INT NOT NULL,
                        action_ID INT NOT NULL,
                        PRIMARY KEY (forest_ID, action_ID),
                        FOREIGN KEY (forest_ID) REFERENCES Forests(forest_ID),
                        FOREIGN KEY (action_ID) REFERENCES Prevention_Actions(action_ID)
                     )';
  DBMS_OUTPUT.PUT_LINE('Table HasA created successfully.');
  */

  -- Seed the random number generator (optional, but recommended for better randomness)
  DBMS_RANDOM.SEED(TO_NUMBER(TO_CHAR(SYSDATE, 'SSSSS')));

  -- Insert random data into HasA table
  FOR i IN 1..400 LOOP
    -- Generate random numbers within specified ranges
    random_forest := TRUNC(DBMS_RANDOM.VALUE(min_value, max_forest));
    random_action := TRUNC(DBMS_RANDOM.VALUE(min_value, max_action));
    
    BEGIN
      -- Attempt to insert
      INSERT INTO HASA (forest_id, action_id) VALUES (random_forest, random_action);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
           DELETE FROM hasa 
           WHERE forest_id = random_forest AND action_id = random_action;
      WHEN OTHERS THEN
        -- Handle any other exceptions
        DBMS_OUTPUT.PUT_LINE('Error inserting into HasA: ' || SQLERRM);
    END;
  END LOOP;
  
  
  -- Call function researchAction
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Calling researchAction function...');
    v_cursor := researchAction(f_id => 214, a_id => 8);
    DBMS_OUTPUT.PUT_LINE('researchAction function called.');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error calling researchAction: ' || SQLERRM);
  END;

  -- Display result
  -- Check if cursor is not null
  IF v_cursor IS NOT NULL THEN
    DBMS_OUTPUT.PUT_LINE('Fetching results from cursor...');
    -- Fetch and print the results
    LOOP
      FETCH v_cursor INTO v_station_record;
      EXIT WHEN v_cursor%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Station ID: ' || v_station_record.station_id 
                           || ', Station Name: ' || v_station_record.station_name 
                           || ', Research subject: ' || v_station_record.research_subject);
    END LOOP;
    -- Close the cursor
    CLOSE v_cursor;
  ELSE
    DBMS_OUTPUT.PUT_LINE('v_cursor is null, no results to display.');
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;

0
0
