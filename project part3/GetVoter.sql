#######################################################################################################################
DELIMITER //

-- This stored procedure fetches the full name (for mailing) of a voter based on their registration number.
CREATE PROCEDURE GetName2 (IN voter_reg_num_in BIGINT(20))
BEGIN
	SELECT full_name_mail
    FROM person
    WHERE voter_reg_num = voter_reg_num_in;

END //

DELIMITER ;

Call GetName2(2);

#######################################################################################################################
DELIMITER //

-- This stored procedure fetches the voting history of a voter based on their registration number.
-- The history includes the election ID, voting method, and party code.
CREATE PROCEDURE GetHistory (IN voter_reg_num_in BIGINT(20))
BEGIN
	SELECT election_ID, voting_method, party_cd
    FROM voting_history
    WHERE voter_reg_num = voter_reg_num_in;

END //

DELIMITER ;
#######################################################################################################################
Call GetHistory(2);