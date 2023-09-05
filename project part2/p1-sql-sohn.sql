-- Minwoo Sohn
-- minwoo.sohn@vanderbilt.edu
-- Project 1 Part 2

-- create a raw mega table
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

LOAD DATA LOCAL INFILE '~/Desktop/voterDataF22.csv'
INTO TABLE voter
FIELDS ENCLOSED BY '$'
TERMINATED BY ';'
LINES TERMINATED BY '\r\n';


-- DECOMPOSED TABLES

-- -----------------------------------------------------
-- Table `voter`.`election`
-- -----------------------------------------------------
DROP TABLE IF EXISTS election ;
CREATE TABLE IF NOT EXISTS election(
	voter_reg_num INT NOT NULL,
	E1 VARCHAR(45),
	E1_date VARCHAR(45),
	E1_VotingMethod VARCHAR(45),
	E1_PartyCd VARCHAR(45),
	E2 VARCHAR(45),
	E2_Date VARCHAR(45),
	E2_VotingMethod VARCHAR(45),
	E2_PartyCd VARCHAR(45),
	E3 VARCHAR(45),
	E3_Date VARCHAR(45),
	E3_VotingMethod VARCHAR(45),
	E3_PartyCd VARCHAR(45),
	E4 VARCHAR(45),
	E4_Date VARCHAR(45),
	E4_VotingMethod VARCHAR(45),
	E4_PartyCd VARCHAR(45),
	E5 VARCHAR(45),
	E5_Date VARCHAR(45),
	E5_VotingMethod VARCHAR(45),
	E5_PartyCd VARCHAR(45),
	PRIMARY KEY (voter_reg_num)
  ) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `voter`.`demographic`
-- -----------------------------------------------------
DROP TABLE IF EXISTS demographic ;

CREATE TABLE IF NOT EXISTS demographic(
	precinct_desc INT NULL,
	party_cd VARCHAR(45),
	race_code VARCHAR(45),
	ethnic_code VARCHAR(45),
	sex_code VARCHAR(45),
	age VARCHAR(45),
	pct_portion VARCHAR(45),
	voter_reg_num INT NOT NULL,
	PRIMARY KEY (voter_reg_num),
	CONSTRAINT fk_demo_voter_reg_num FOREIGN KEY (voter_reg_num)
		REFERENCES election (voter_reg_num)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `voter`.`name_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS name_info;
CREATE TABLE IF NOT EXISTS name_info(
	first_name VARCHAR(45),
	middle_name VARCHAR(45),
	last_name VARCHAR(45),
	name_suffix_lbl VARCHAR(45),
	full_name_mail VARCHAR(45),
	voter_reg_num INT NOT NULL,
	PRIMARY KEY (voter_reg_num),
	CONSTRAINT fk_name_voter_reg_num FOREIGN KEY (voter_reg_num)
		REFERENCES election (voter_reg_num)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `voter`.`street_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS street_address ;

CREATE TABLE IF NOT EXISTS street_address (
	mail_addr1 VARCHAR(45),
	mail_addr2 VARCHAR(45),
	house_num VARCHAR(45),
	street_dir VARCHAR(45),
	street_name VARCHAR(45),
	street_type_cd VARCHAR(45),
	street_sufx_cd VARCHAR(45),
	unit_num VARCHAR(45),
	voter_reg_num INT NOT NULL,
	PRIMARY KEY (voter_reg_num),
	CONSTRAINT fk_address_voter_reg_num FOREIGN KEY (voter_reg_num)
		REFERENCES election (voter_reg_num)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `voter`.`district`
-- -----------------------------------------------------
DROP TABLE IF EXISTS district ;

CREATE TABLE IF NOT EXISTS district (
	status_cd INT,
	municipality_desc VARCHAR(45),
	ward_desc VARCHAR(45),
	cong_dist_desc VARCHAR(45),
	super_court_desc VARCHAR(45),
	nc_senate_desc VARCHAR(45) ,
	nc_house_desc VARCHAR(45) ,
	county_commiss_desc VARCHAR(45),
	school_dist_desc VARCHAR(45) ,
	voter_reg_num INT NOT NULL,
	PRIMARY KEY (voter_reg_num),
	CONSTRAINT fk_district_voter_reg_num FOREIGN KEY (voter_reg_num)
		REFERENCES election (voter_reg_num)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `voter`.`zip_code`
-- -----------------------------------------------------
DROP TABLE IF EXISTS zip_code ;

CREATE TABLE IF NOT EXISTS zip_code (
	mail_city_state_zip VARCHAR(45),
	zip_code VARCHAR(45),
	res_city_desc VARCHAR(45),
	state_cd VARCHAR(45),
	voter_reg_num INT NOT NULL,
	PRIMARY KEY (voter_reg_num),
	CONSTRAINT fk_zip_voter_reg_num FOREIGN KEY (voter_reg_num)
		REFERENCES election (voter_reg_num)
		ON DELETE CASCADE
		ON UPDATE CASCADE
) ENGINE = InnoDB;



-- table 'election' insert
INSERT IGNORE INTO election(voter_reg_num,  E1,E1_date, E1_VotingMethod, E1_PartyCd,  
E2, E2_Date, E2_VotingMethod, E2_PartyCd,  
E3, E3_Date, E3_VotingMethod, E3_PartyCd,  
E4, E4_Date, E4_VotingMethod, E4_PartyCd,   
E5, E5_Date, E5_VotingMethod, E5_PartyCd ) 
SELECT voter_reg_num,  E1,E1_date, E1_VotingMethod, E1_PartyCd,  
E2, E2_Date, E2_VotingMethod, E2_PartyCd,  E3, E3_Date, 
E3_VotingMethod, E3_PartyCd,  
E4, E4_Date, E4_VotingMethod, E4_PartyCd,   
E5, E5_Date, E5_VotingMethod, E5_PartyCd 
FROM voter;

SELECT COUNT(*)
FROM election;

-- table 'demographic' insert
INSERT IGNORE INTO demographic(precinct_desc, party_cd, race_code,
ethnic_code, sex_code, age,
pct_portion, voter_reg_num
)
SELECT precinct_desc, party_cd, race_code,
ethnic_code, sex_code, age,
pct_portion, voter_reg_num
FROM voter;

SELECT COUNT(*)
FROM demographic;

-- table 'name_info' insert
INSERT IGNORE INTO name_info(first_name, middle_name, last_name,
name_suffix_lbl, full_name_mail,voter_reg_num
)
SELECT first_name, middle_name, last_name,
name_suffix_lbl, full_name_mail,voter_reg_num
FROM voter;

SELECT COUNT(*)
FROM name_info;

-- table 'street_address' insert
INSERT IGNORE INTO street_address(mail_addr1, mail_addr2, house_num,
street_dir, street_name, street_type_cd,
street_sufx_cd, unit_num, voter_reg_num
)
SELECT mail_addr1, mail_addr2, house_num,
street_dir, street_name, street_type_cd,
street_sufx_cd, unit_num, voter_reg_num
FROM voter;

SELECT COUNT(*)
FROM street_address;


-- table 'district' insert
INSERT IGNORE INTO district(status_cd ,municipality_desc, ward_desc, 
cong_dist_desc, super_court_desc, nc_senate_desc,  
nc_house_desc, county_commiss_desc, school_dist_desc, voter_reg_num
)
SELECT status_cd ,municipality_desc, ward_desc, 
cong_dist_desc, super_court_desc, nc_senate_desc,  
nc_house_desc, county_commiss_desc, school_dist_desc, voter_reg_num
FROM voter;

SELECT COUNT(*)
FROM district;

-- table 'zip_code' insert
INSERT IGNORE INTO zip_code(mail_city_state_zip, zip_code, res_city_desc,
state_cd, voter_reg_num
)
SELECT mail_city_state_zip, zip_code, res_city_desc,
state_cd, voter_reg_num
FROM voter;

SELECT COUNT(*)
FROM zip_code;


-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;