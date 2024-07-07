-- Created on 30/06/2024 by RACHELLI 

DECLARE 

  v_forest_id INTEGER := 63;
  v_num_of_trees INTEGER := 5;
  v_name_of_donor VARCHAR2(1000) := 'The charlie Foundation';
  v_name_of_soldier VARCHAR2(1000) := 'charlie';
  v_type VARCHAR2(1000) := 'maple';
  v_origin VARCHAR2(1000) := 'canada';
  v_planting_id INTEGER; 
  
  stations SYS.ODCINUMBERLIST;
  
begin
  
    --dops the column amount_of_trees
    --EXECUTE IMMEDIATE 'ALTER TABLE tree_planting_projects DROP COLUMN amount_of_trees';
    
    --adds a column in tree planting project representing how much trees we are going to plant
    --add_column_to_projects();
    


 -- Step 1: Add a new tree planting project
    v_planting_id := add_tree_planting_project(
        p_forest_id => v_forest_id,
        p_num_of_trees_planted => v_num_of_trees
    );
    
    -- Step 2: Add donors for the project
    add_donors(
       p_planting_id => v_planting_id,
       p_donors => v_name_of_donor
    );

    -- Step 3: Create trees for the project
    create_trees(
        p_forest_id => v_forest_id,
        p_type => v_type,
        p_origin => v_origin,
        p_num_of_trees => v_num_of_trees
    );
    
      
   -- Step 4: Create education programs for research stations associated with the forest
   stations := create_education_programs_func(
        p_forest_id => v_forest_id,
        p_name_of_soldier => v_name_of_soldier);

    FOR i IN 1..stations.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Program added to station ID: ' || stations(i));
    END LOOP;
commit;
end;
