-- Project 1 Part 1 

-- Creating a new database, voter table
CREATE DATABASE IF NOT EXISTS voterData;
DROP TABLE voter;
CREATE TABLE IF NOT EXISTS voter (
  precinct_desc VARCHAR(255),
  party_cd VARCHAR(255),
  race_code VARCHAR(255),
  ethnic_code VARCHAR(255),
  sex_code VARCHAR(255),
  age INTEGER,
  pct_portion VARCHAR(255),
  first_name VARCHAR(255),
  middle_name VARCHAR(255),
  last_name VARCHAR(255),
  name_suffix_lbl VARCHAR(255),
  full_name_mail VARCHAR(255),
  mail_addr1 VARCHAR(255),
  mail_addr2 VARCHAR(255),
  mail_city_state_zip VARCHAR(255),
  house_num VARCHAR(255),
  street_dir VARCHAR(255),
  street_name VARCHAR(255),
  street_type_cd VARCHAR(255),
  street_sufx_cd VARCHAR(255),
  unit_num VARCHAR(255),
  res_city_desc VARCHAR(255),
  state_cd VARCHAR(255),
  zip_code VARCHAR(255),
  registr_dt VARCHAR(255),
  voter_reg_num VARCHAR(255),
  status_cd VARCHAR(255),
  municipality_desc VARCHAR(255),
  ward_desc VARCHAR(255),
  cong_dist_desc VARCHAR(255),
  super_court_desc VARCHAR(255),
  nc_senate_desc VARCHAR(255),
  nc_house_desc VARCHAR(255),
  county_commiss_desc VARCHAR(255),
  school_dist_desc VARCHAR(255),
  E1 VARCHAR(255),
  E1_date VARCHAR(255),
  E1_VotingMethod VARCHAR(255),
  E1_PartyCd VARCHAR(255),
  E2 VARCHAR(255),
  E2_Date VARCHAR(255),
  E2_VotingMethod VARCHAR(255),
  E2_PartyCd VARCHAR(255),
  E3 VARCHAR(255),
  E3_Date VARCHAR(255),
  E3_VotingMethod VARCHAR(255),
  E3_PartyCd VARCHAR(255),
  E4 VARCHAR(255),
  E4_Date VARCHAR(255),
  E4_VotingMethod VARCHAR(255),
  E4_PartyCd VARCHAR(255),
  E5 VARCHAR(255),
  E5_Date VARCHAR(255),
  E5_VotingMethod VARCHAR(255),
  E5_PartyCd VARCHAR(255)
) ENGINE = INNODB;

-- Importing data from a CSV file into the voter table
-- The file is on the desktop
LOAD DATA LOCAL INFILE '~/Desktop/voterDataF22.csv'
INTO TABLE voter
FIELDS ENCLOSED BY '$'
TERMINATED BY ';'
LINES TERMINATED BY '\r\n';


-- Count of voters grouped by street suffix code and street direction
-- 7 
SELECT street_sufx_cd, street_dir, COUNT(*)
FROM voter 
GROUP BY street_sufx_cd, street_dir;

-- Count of voters without NC Senate District Information
-- 8 a
SELECT COUNT(*) 
FROM voter
WHERE nc_senate_desc = '';

-- Comment: There are 258 voters who don't include NC Senate District Information

-- List of voters who participated in at least one election but have no precinct information
-- 8 b
SELECT full_name_mail
FROM voter
WHERE precinct_desc = ''
	AND (E1_Date != '' OR E2_Date != '' OR E3_Date != '' OR
		E4_Date != '' OR E5_Date != '');
 
 

SELECT COUNT(DISTINCT full_name_mail)
FROM voter
WHERE precinct_desc = ''
	AND (E1_Date != '' OR E2_Date != '' OR E3_Date != '' OR
		E4_Date != '' OR E5_Date != '');
 
-- Comment: There are 40 voters found who have missing precint information but they participated in one election


-- Voters with inconsistent precinct and pct_portion        
-- 8 c
SELECT full_name_mail, mail_addr1
FROM voter
WHERE RIGHT(precinct_desc, 3) != LEFT(pct_portion,3);

-- Comment: EDGAR EUGENE MALKER had the different numerical portion in precint_desc and pct_port.
-- His address was found to be 7405 SURPRISE CT

-- Count of female voters who are registered as Democrat
-- 8 d
SELECT COUNT(*)
FROM voter
WHERE sex_code = 'F' AND party_cd = 'DEM';

-- Comment: There are 98,181 female voters who are registered as Democrat 