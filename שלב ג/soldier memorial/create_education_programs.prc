CREATE OR REPLACE FUNCTION create_education_programs_func(
    p_forest_id IN INTEGER,
    p_name_of_soldier IN VARCHAR2
) RETURN SYS.ODCINUMBERLIST
IS
    l_added_stations SYS.ODCINUMBERLIST := SYS.ODCINUMBERLIST();
    CURSOR research_stations_cur IS
        SELECT station_ID FROM Research_Stations WHERE forest_ID = p_forest_id;
    v_station_id Research_Stations.station_ID%TYPE;
    p_program_description VARCHAR2(1000) := 'honoring '|| p_name_of_soldier;
    p_ages VARCHAR2(100) := 'all'; 
    v_program_id INTEGER;

BEGIN
   
    
    OPEN research_stations_cur;
    LOOP
        -- Find the next available program id
        SELECT COALESCE(MAX(program_id), 0) + 1 INTO v_program_id FROM education_programs;
    
        FETCH research_stations_cur INTO v_station_id;
        EXIT WHEN research_stations_cur%NOTFOUND;

        -- Insert education program record
        INSERT INTO Education_Programs (program_id, program_name, program_description, ages, station_ID)
        VALUES (v_program_id, p_name_of_soldier, p_program_description, p_ages, v_station_id);

        -- Collect station ID where the program was added
        l_added_stations.EXTEND;
        l_added_stations(l_added_stations.LAST) := v_station_id;
    END LOOP;
    CLOSE research_stations_cur;
    
    DBMS_OUTPUT.PUT_LINE('education program added with id '|| v_program_id );
       
    -- Return the list of station IDs
    RETURN l_added_stations;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM || 'in education program');
        RETURN l_added_stations; -- Return whatever stations were added before the error
END;
/
