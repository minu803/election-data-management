# Create audit table
CREATE TABLE IF NOT EXISTS voter_audit (
    id INT(11) NOT NULL AUTO_INCREMENT,
    voter_reg_num BIGINT(20),
    first_name VARCHAR(255),
    middle_name VARCHAR(255),
    last_name VARCHAR(255),
    name_suffix_lbl VARCHAR(255),
    party_cd VARCHAR(255),
    
    action_type ENUM('INSERT', 'UPDATE', 'DELETE'),
    action_ts DATETIME,
    action_user VARCHAR(255),
    PRIMARY KEY (id)
);

#######################################################################################################################

# Create Trigger
-- This trigger checks if the party code exists in 'person' table before inserting a new row.
-- If it doesn't exist, set it to 'N/A'.
DELIMITER //

CREATE TRIGGER PartyCheck
BEFORE INSERT 
ON person 
FOR EACH ROW 
IF NEW.party_cd NOT IN (SELECT party_cd FROM person) THEN
SET NEW.party_cd = 'N/A';
END IF;
//
DELIMITER ;

#######################################################################################################################

# Create Procedure
-- This stored procedure inserts a new voter into the 'person' table and logs the action into the 'voter_audit' table
DELIMITER //

CREATE PROCEDURE insert_voter(
    IN p_reg_num BIGINT(20),
    IN p_first_name VARCHAR(255),
    IN p_middle_name VARCHAR(255),
    IN p_last_name VARCHAR(255),
    IN p_suffix VARCHAR(255),
    IN p_party_cd VARCHAR(255),
    OUT msg VARCHAR(255)
)
BEGIN
    DECLARE v_ts DATETIME DEFAULT NOW();
    DECLARE v_user VARCHAR(255) DEFAULT USER();

    -- Insert into person table
    INSERT INTO person (
        voter_reg_num, first_name, middle_name, last_name, full_name_mail, name_suffix_lbl, party_cd) 
        VALUES (
        p_reg_num, p_first_name, p_middle_name, p_last_name, 
        CONCAT (p_first_name,p_middle_name,p_last_name),
        p_suffix, p_party_cd);
	
    -- Insert into audit table
    INSERT INTO voter_audit (
        voter_reg_num, first_name, middle_name, last_name, name_suffix_lbl,party_cd,
        action_type,action_ts,action_user) 
        VALUES (
        p_reg_num, p_first_name, p_middle_name, p_last_name,p_suffix,p_party_cd,'INSERT',v_ts, v_user);
        
	SELECT "insertion completed" INTO msg;
END //

DELIMITER ;
#######################################################################################################################
# Testing
Call insert_voter (11,"qi",'na', 'lin','','DEM', @msg);
SELECT @msg;
Call insert_voter (222,"qi",'na', 'lin','','D');

SELECT * FROM person;
SELECT * FROM person where voter_reg_num = 33;
SELECT * FROM voter_audit;

