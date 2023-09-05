-- CREATE the DATABASE
DROP DATABASE IF EXISTS voterDB;
CREATE DATABASE voterDB;

-- select the DATABASE
USE voterDB;

/* Delete the TABLEs if they already exist */
DROP TABLE IF EXISTS voter;

/* CREATE the schema for our TABLEs */
CREATE TABLE voter(precinct_desc VARCHAR(255), 
party_cd VARCHAR(255), 
race_code VARCHAR(255), 
ethnic_code VARCHAR(255), 
sex_code VARCHAR(255), 
age INT, 
pct_portion VARCHAR(255), 
first_name VARCHAR(255), 
middle_name VARCHAR(255), 
last_name VARCHAR(255), 
name_suffix_lbl VARCHAR(255), 
full_name_mail VARCHAR(255), 
mail_addr1 VARCHAR(255),
mail_addr2 VARCHAR(255),
mail_city_state_zip VARCHAR(255), 
house_num INT, 
street_dir VARCHAR(255), 
street_name VARCHAR(255), 
street_type_cd VARCHAR(255), 
street_sufx_cd VARCHAR(255), 
unit_num VARCHAR(255), 
res_city_desc VARCHAR(255), 
state_cd VARCHAR(255), 
zip_code INT, 
registr_dt VARCHAR(255), 
voter_reg_num INT, 
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
E5_PartyCd VARCHAR(255))ENGINE=INNODB;


LOAD DATA LOCAL INFILE '~/Desktop/voterDataF22.csv'
INTO TABLE voter
FIELDS ENCLOSED BY '$'
TERMINATED BY ';'
LINES TERMINATED BY '\r\n';

# Ifyou	successfully imported datain	your	MySQL	server,	then	run	the	following query:
SELECT *
FROM voter;

SELECT street_sufx_cd, street_dir, COUNT(*)
FROM voter
GROUP BY street_sufx_cd, street_dir;

# Question 8
# a)
SELECT COUNT(*) AS "Missing voter Count"
FROM voter
WHERE nc_senate_desc = '';

# b)
SELECT full_name_mail
FROM voter
WHERE precinct_desc = '' AND E1_date IS NOT NULL OR E2_date IS NOT NULL OR E3_date IS NOT NULL OR E4_date IS NOT NULL OR E5_date IS NOT NULL ;

# c)
SELECT full_name_mail AS "name", mail_addr1 AS "address"
FROM voter
WHERE SUBSTRING(precinct_desc, 5, 7) <> SUBSTRING(pct_portion, 1, 3);

# d)
SELECT COUNT(*) AS "Number of female democrat voters"
FROM voter
WHERE sex_code = 'F' AND party_cd = 'DEM';







