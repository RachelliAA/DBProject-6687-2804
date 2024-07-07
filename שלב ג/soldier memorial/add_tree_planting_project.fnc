CREATE OR REPLACE FUNCTION add_tree_planting_project(
    p_forest_id IN INTEGER,
    p_num_of_trees_planted IN INTEGER
) RETURN INTEGER IS
    v_planting_id INTEGER;
    start_date DATE;
    end_date DATE;
BEGIN
    -- Calculate start and end dates
    start_date := TRUNC(SYSDATE);
    end_date := ADD_MONTHS(TRUNC(SYSDATE), 1);
    
    -- Find the next available planting_id 
    SELECT COALESCE(MAX(planting_id), 0) + 1 INTO v_planting_id FROM Tree_Planting_Projects;
    
    -- Insert into Tree_Planting_Projects table
    INSERT INTO Tree_Planting_Projects (planting_id, start_date, end_date, forest_ID, amount_of_trees)
    VALUES (v_planting_id, start_date, end_date, p_forest_id, p_num_of_trees_planted);

     DBMS_OUTPUT.PUT_LINE('Tree Planting project added successfully');
     
     --adds the planting id and forest id to the IsFor table
     INSERT INTO IsFor (planting_id, forest_ID)
       VALUES (v_planting_id, p_forest_id);
     DBMS_OUTPUT.PUT_LINE('added to IsFor table successfully');
    
    
    
    -- Return the planting_ID of the newly inserted record
    RETURN v_planting_id;

EXCEPTION
    WHEN OTHERS THEN
        -- Handle exceptions if needed
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM||'in planting project');
raise;
        RETURN NULL; -- if something goes wrong returns nothing
END;
