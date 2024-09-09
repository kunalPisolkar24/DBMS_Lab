-- Create the N_RollCall table
CREATE TABLE N_RollCall (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

-- Create the O_RollCall table
CREATE TABLE O_RollCall (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

-- Insert some dummy data into the N_RollCall table
INSERT INTO N_RollCall (name) VALUES
    ('John'),
    ('Alice'),
    ('Bob'),
    ('Eve');

-- Insert some dummy data into the O_RollCall table
INSERT INTO O_RollCall (name) VALUES
    ('Alice'),
    ('Charlie'),
    ('David');


DELIMITER //
CREATE PROCEDURE MergeRollCallData()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE n_id INT;
    DECLARE n_name VARCHAR(255);
    DECLARE o_id INT;
    DECLARE o_name VARCHAR(255);
    
    -- Declare a cursor for the N_RollCall table
    DECLARE n_cursor CURSOR FOR
    SELECT id, name FROM N_RollCall;
    
    -- Declare a cursor for the O_RollCall table
    DECLARE o_cursor CURSOR FOR
    SELECT id, name FROM O_RollCall;
    
    -- Declare variables to hold the values from the cursors
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    -- Open the cursors
    OPEN n_cursor;
    OPEN o_cursor;
    
    -- Loop through the N_RollCall table
    n_loop: LOOP
        FETCH n_cursor INTO n_id, n_name;
        IF done = 1 THEN
            LEAVE n_loop;
        END IF;
        
        -- Check if the data from N_RollCall already exists in O_RollCall
        SET @count = 0;
        SELECT COUNT(*) INTO @count FROM O_RollCall WHERE id = n_id;
        
        -- If the data doesn't exist in O_RollCall, insert it
        IF @count = 0 THEN
            INSERT INTO O_RollCall (id, name) VALUES (n_id, n_name);
        END IF;
    END LOOP;
    
    -- Close the cursors
    CLOSE n_cursor;
    CLOSE o_cursor;
    
END;
//
DELIMITER ;

INSERT INTO N_RollCall (name) VALUES ("Linda"),("Omega");
select * from N_RollCall;

call MergeRollCallData();

select * from O_RollCall;
