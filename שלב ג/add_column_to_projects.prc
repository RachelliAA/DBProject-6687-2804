-- Procedure to add a column for amount of trees in tree planting project numbers and populate it
CREATE OR REPLACE PROCEDURE add_column_to_projects IS
    v_random_number NUMBER;
BEGIN
    -- Step 1: Add a new column to store amount of trees
    EXECUTE IMMEDIATE 'ALTER TABLE tree_planting_projects ADD (amount_of_trees NUMBER)';
  
    -- Step 2: Use a cursor to fetch planting_id for the loop
    FOR rec IN (SELECT planting_id FROM tree_planting_projects) LOOP
        BEGIN
            -- Generate random number between 10 and 5000
            v_random_number := ROUND(DBMS_RANDOM.VALUE(10, 5000));

            -- Use dynamic SQL to update amount_of_trees column
            EXECUTE IMMEDIATE 'UPDATE tree_planting_projects SET amount_of_trees = :1 WHERE planting_id = :2'
                USING v_random_number, rec.planting_id;

            DBMS_OUTPUT.PUT_LINE('Updated planting_id ' || rec.planting_id || ' with amount_of_trees: ' || v_random_number);       
        END;
    END LOOP;

    -- COMMIT; -- Commit changes if needed

    --DBMS_OUTPUT.PUT_LINE('Random numbers added and updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END add_column_to_projects;
/
