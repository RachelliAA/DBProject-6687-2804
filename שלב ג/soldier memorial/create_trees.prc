CREATE OR REPLACE PROCEDURE create_trees(
    p_forest_id IN INTEGER,
    p_type IN VARCHAR2,
    p_origin IN VARCHAR2,
    p_num_of_trees IN INTEGER
) IS
    v_tree_id INTEGER;
BEGIN
    FOR i IN 1..p_num_of_trees LOOP
        -- Find the next available tree_id
        SELECT COALESCE(MAX(tree_id), 0) + 1 INTO v_tree_id FROM Trees;
        
        -- Insert into Trees table
        INSERT INTO Trees (tree_id, forest_ID, type, origin)
        VALUES (v_tree_id, p_forest_id, p_type, p_origin);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Successfully created ' || p_num_of_trees || ' trees.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM||' in create_trees');
END;
/
