USE voter_data; 

-- trigger check for party input
DROP TRIGGER IF EXISTS check_insert_voter;
DELIMITER // 
CREATE TRIGGER check_insert_voter
BEFORE INSERT ON person
FOR EACH ROW 
BEGIN 
-- unknown party cd 
	IF NEW.party_cd <> 'DEM' 
		OR NEW.party_cd <> 'UNA' 
        OR NEW.party_cd <> 'REP' 
        OR NEW.party_cd <> 'LIB' 
        OR NEW.party_cd <> 'CST' 
        OR NEW.party_cd <> 'GRE' THEN 
        -- insert the data into miscellaneous table 
		INSERT INTO audit_insert(voter_reg_num, party_cd) 
		VALUES (NEW.voter_reg_num, NEW.party_cd);
        -- change party cd to N/A
        SET NEW.party_cd = 'N/A';
        
	END IF;
END //
DELIMITER ;

-- insertion procedure 
DROP PROCEDURE IF EXISTS insert_voter;

DElIMITER // 
CREATE PROCEDURE insert_voter(
	IN voter_reg_num CHAR(12), 
    IN frist_name VARCHAR(45), 
    IN middle_name VARCHAR(45), 
    IN last_name VARCHAR(45), 
    IN name_suffix_lbl VARCHAR(45), 
    IN party_cd CHAR(3),
    OUT msg VARCHAR(45))
BEGIN 
	DECLARE sql_error INT DEFAULT FALSE;
	DECLARE CONTINUE HANDLER FOR 1062 SET sql_error = TRUE;
    -- SELECT 'Duplicate key error encountered' INTO msg;
    -- DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'SQL exception encountered' INTO msg;
    
    INSERT INTO person (voter_reg_num, party_cd, first_name, middle_name, last_name, name_suffix_lbl, full_name_mail )
    VALUES (voter_reg_num, party_cd, frist_name, middle_name, last_name, name_suffix_lbl, 
    CONCAT(frist_name,' ', middle_name,' ', last_name, ' ', name_suffix_lbl));
    
    -- INSERT INTO demographic_data(voter_reg_num, party_cd)
    -- VALUES (voter_reg_num, party_cd);
    IF sql_error= FALSE THEN
		SELECT 'INSERTED SUCCESSFULLY' INTO msg;
    ELSE
		SELECT 'Duplicate key error encountered' INTO msg;
	END IF;
    SELECT msg;
END //
DELIMITER ;
    

    
	