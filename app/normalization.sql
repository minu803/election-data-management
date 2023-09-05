################################################
-- Now Create and INSERT into new tables
-- ################################################
SET FOREIGN_KEY_CHECKS=0; -- to disable them
#SET FOREIGN_KEY_CHECKS=1; -- to re-enable them
-- Table 1: city_state
DROP TABLE IF EXISTS city_state;
CREATE TABLE IF NOT EXISTS city_state(
	res_city_desc VARCHAR(45),
    state_cd VARCHAR(45),
    PRIMARY KEY (res_city_desc)
);
INSERT INTO city_state (res_city_desc, state_cd)
SELECT DISTINCT res_city_desc, state_cd
FROM voter;
#######################################################################################################################
-- Table 2: zip_city
DROP TABLE IF EXISTS zip_city;
CREATE TABLE IF NOT EXISTS zip_city(
	zip_code CHAR(5),
    res_city_desc VARCHAR(45),
    PRIMARY KEY (zip_code),
    FOREIGN KEY (res_city_desc)
		REFERENCES city_state(res_city_desc)
);
INSERT INTO zip_city(zip_code, res_city_desc)
SELECT DISTINCT zip_code, res_city_desc
FROM voter;
#######################################################################################################################
-- Table 3: person
DROP TABLE IF EXISTS person;
CREATE TABLE IF NOT EXISTS person(
	voter_reg_num BIGINT(20),
    party_cd VARCHAR(255),
    race_code VARCHAR(255),
    ethnic_code VARCHAR(255),
    sex_code VARCHAR(255),
    age INT(10),
    first_name VARCHAR(255),
    middle_name VARCHAR(255),
    last_name VARCHAR(255),
    full_name_mail VARCHAR(255),
    name_suffix_lbl VARCHAR(255),
    registr_dt DATETIME,
    status_cd VARCHAR(255),
    PRIMARY KEY (voter_reg_num)
);
INSERT INTO person
SELECT voter_reg_num, party_cd, race_code, ethnic_code, sex_code, age, first_name, middle_name, last_name,
	full_name_mail, name_suffix_lbl, registr_dt, status_cd
FROM voter;
#######################################################################################################################
-- Table 4: area
DROP TABLE IF EXISTS area;
CREATE TABLE IF NOT EXISTS area(
	pct_portion CHAR(200),
    precinct_desc VARCHAR(255),
    ward_desc VARCHAR(255),
    cong_dist_desc VARCHAR(255),
    super_court_desc VARCHAR(255),
    nc_senate_desc VARCHAR(255),
    nc_house_desc VARCHAR(255),
    county_commiss_desc VARCHAR(255),
    school_dist_desc VARCHAR(255),
    PRIMARY KEY (pct_portion)
);
INSERT IGNORE INTO area
SELECT pct_portion, precinct_desc,ward_desc, cong_dist_desc, super_court_desc, nc_senate_desc,
	nc_house_desc, county_commiss_desc, school_dist_desc
FROM voter;
#######################################################################################################################
-- Table 5: residential_address_info
CREATE TABLE IF NOT EXISTS residential_address_info(
	voter_reg_num BIGINT(20),
    house_num VARCHAR(45),
    street_dir VARCHAR(45),
    street_type_cd VARCHAR(45),
    street_sufx_cd VARCHAR(45),
    unit_num VARCHAR(45),
    zip_code CHAR(5),
    pct_portion CHAR(200),
    PRIMARY KEY (zip_code, pct_portion),
    FOREIGN KEY (zip_code) REFERENCES zip_city(zip_code),
    FOREIGN KEY (voter_reg_num) REFERENCES person(voter_reg_num)
);
INSERT IGNORE INTO residential_address_info
SELECT voter_reg_num, house_num, street_dir,street_type_cd, street_sufx_cd,
	unit_num, zip_code, pct_portion
FROM voter;
#######################################################################################################################
-- Table 6: election
DROP TABLE election;
CREATE TABLE IF NOT EXISTS election(
	election_ID INT,
    election_Name CHAR(2),
    election_Date DATE,
    PRIMARY KEY (election_ID)
);
INSERT IGNORE INTO election (election_ID, election_Name, election_Date)
SELECT DISTINCT E1, 'E1', STR_TO_DATE(E1_date, '%m/%d/%y') FROM voter
UNION ALL
SELECT DISTINCT E2, 'E2', STR_TO_DATE(E2_date, '%m/%d/%y') FROM voter
UNION ALL
SELECT DISTINCT E3, 'E3', STR_TO_DATE(E3_date, '%m/%d/%y') FROM voter
UNION ALL
SELECT DISTINCT E4, 'E4', STR_TO_DATE(E4_date, '%m/%d/%y') FROM voter
UNION ALL
SELECT DISTINCT E5, 'E5', STR_TO_DATE(E5_date, '%m/%d/%y') FROM voter;


#######################################################################################################################
-- Table 7: voting_history
DROP TABLE IF EXISTS voting_history;
CREATE TABLE IF NOT EXISTS voting_history(
	voter_reg_num BIGINT(20),
    election_ID INT,
    voting_method CHAR(1),
    party_cd CHAR(3),
    PRIMARY KEY (voter_reg_num, election_ID),
    FOREIGN KEY (election_ID) REFERENCES election(election_ID)
);
INSERT IGNORE INTO voting_history(voter_reg_num, election_ID, voting_method, party_cd)
SELECT 	voter_reg_num, 1 AS election_ID,
		E1_VotingMethod AS voting_method,
        E1_PartyCd AS party_cd
FROM voter
WHERE E1_date IS NOT NULL
UNION ALL
SELECT voter_reg_num, 2 AS election_ID, E2_VotingMethod AS voting_method, E2_PartyCd AS party_cd
from voter
WHERE E2_date IS NOT NULL
UNION ALL
SELECT voter_reg_num, 3 AS election_ID,  E3_VotingMethod AS voting_method, E3_PartyCd AS party_cd
from voter
WHERE E3_date IS NOT NULL
UNION ALL
SELECT voter_reg_num, 4 AS election_ID,  E4_VotingMethod AS voting_method, E4_PartyCd AS party_cd
from voter
WHERE E4_date IS NOT NULL
UNION ALL
SELECT voter_reg_num,5 AS election_ID,  E5_VotingMethod AS voting_method, E5_PartyCd AS party_cd
from voter
WHERE E5_date IS NOT NULL;
#######################################################################################################################
# All looking good baby
# Table 1 city_state
select * from city_state;
# Table 2 zip_city
select * from zip_city;
# Table 3 person
select * from person;
# Table 4 area
select * from area;
# Table 5 residential_address_info
select * from residential_address_info;
# Table 6 election
select * from election;
# Table 7 voting_history
select * from voting_history;
select * from voter;
#######################################################################################################################