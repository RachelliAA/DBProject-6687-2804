CREATE OR REPLACE PROCEDURE updateActions IS
  low_cost CONSTANT NUMBER := 10.3;
  medium_cost CONSTANT NUMBER := 40.5;
  strong_cost CONSTANT NUMBER := 70.1;
  new_action_cost NUMBER;
BEGIN
  -- Delete duplicates based on action_name
  DELETE FROM prevention_actions
  WHERE ROWID NOT IN (
    SELECT MIN(ROWID)
    FROM prevention_actions
    GROUP BY action_name
  );
  
  DBMS_OUTPUT.PUT_LINE('Duplicate actions deleted');

  -- Loop through prevention_actions to update costs
  FOR action_rec IN (SELECT * FROM prevention_actions) LOOP
    -- Determine the cost based on action_duration
    new_action_cost := CASE
      WHEN action_rec.action_duration LIKE 'low%' THEN low_cost
      WHEN action_rec.action_duration LIKE 'medium%' THEN medium_cost
      WHEN action_rec.action_duration LIKE 'strong%' THEN strong_cost
      ELSE 0
    END;
    
    UPDATE prevention_actions
    SET action_id = rownum;
    -- Update the cost for the current action
    UPDATE prevention_actions
    SET cost = new_action_cost
    WHERE action_id = action_rec.action_id;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Costs updated');

EXCEPTION
  WHEN OTHERS THEN
    -- Handle all exceptions
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
    ROLLBACK;
END;
/
