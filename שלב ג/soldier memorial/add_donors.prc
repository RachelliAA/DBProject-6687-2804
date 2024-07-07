CREATE OR REPLACE PROCEDURE add_donors (
    p_planting_id IN INTEGER,
    p_donors IN VARCHAR2
) IS
BEGIN
    -- Insert into Donors table associated with the planting project
    INSERT INTO tree_planting_projects_donors (planting_id, donors)
    VALUES (p_planting_id, p_donors);
    
    DBMS_OUTPUT.PUT_LINE('Donor ' || p_donors || ' added for planting ID ' || p_planting_id);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM ||'in adding donors');
END;
/
