## Delete Voter

-- This procedure takes a voter registration number as an argument and deletes the corresponding voter record.
-- Before deleting, it backs up the deleted voter information to the 'voter_audit' table for auditing purposes.
DELIMITER //

CREATE PROCEDURE delete_voter (IN reg_num BIGINT(20))
BEGIN
	DECLARE old_first_name VARCHAR(255);
	DECLARE old_middle_name VARCHAR(255);
	DECLARE old_last_name VARCHAR(255);
	DECLARE old_suffix VARCHAR(255);
	DECLARE old_party_cd VARCHAR(255);
	DECLARE deleted_at DATETIME DEFAULT NOW();
    DECLARE v_user VARCHAR(255) DEFAULT USER();

	SELECT first_name, middle_name, last_name, name_suffix_lbl, party_cd
	INTO old_first_name, old_middle_name, old_last_name, old_suffix, old_party_cd
	FROM person
	WHERE voter_reg_num = reg_num;

	DELETE FROM person
	WHERE voter_reg_num = reg_num;

	INSERT INTO voter_audit (voter_reg_num, first_name, middle_name, last_name, name_suffix_lbl, party_cd, action_type,action_ts, action_user)
	VALUES (reg_num, old_first_name, old_middle_name, old_last_name, old_suffix, old_party_cd, 'DELETE',deleted_at, v_user);
END //

DELIMITER ;

#######################################################################################################################
# Testing
Call delete_voter (13);
SELECT * FROM voter_audit;
