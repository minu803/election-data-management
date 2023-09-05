-- Minwoo Sohn
-- minwoo.sohn@vanderbilt.edu
-- Project 1 Part 2


-- FD in Demogrphy table

-- SELECT precinct_desc, COUNT(DISTINCT pct_portion) 
-- FROM voter
-- GROUP BY precinct_desc
-- HAVING COUNT(DISTINCT pct_portion) > 1;

-- SELECT pct_portion, COUNT(DISTINCT precinct_desc) 
-- FROM voter
-- GROUP BY pct_portion
-- HAVING COUNT(DISTINCT precinct_desc) > 1;

-- empty pct | count 2

SELECT pct_portion, precinct_desc
FROM voter
GROUP BY pct_portion,precinct_desc
HAVING COUNT(DISTINCT age) > 1 OR
	COUNT(DISTINCT race_code) > 1 OR
    COUNT(DISTINCT ethnic_code) > 1;

-- IT IS NOT WORKING
SELECT race_code, COUNT(DISTINCT ethnic_code) 
FROM voter
GROUP BY race_code
HAVING COUNT(DISTINCT ethnic_code) > 1;


SELECT party_cd, race_code
FROM voter
GROUP BY party_cd, race_code
HAVING NOT (MIN(voter.ethnic_code) <=> MAX(voter.ethnic_code));


SELECT precinct_desc, pct_portion,
	COUNT(DISTINCT party_cd), COUNT(DISTINCT race_code), 
	COUNT(DISTINCT ethnic_code), COUNT(DISTINCT sex_code), 
	COUNT(DISTINCT age)  
FROM voter
GROUP BY precinct_desc, pct_portion
HAVING COUNT(DISTINCT party_cd) > 1 OR
	COUNT(DISTINCT race_code) > 1 OR
	COUNT(DISTINCT ethnic_code) > 1 OR
	COUNT(DISTINCT sex_code) > 1 OR
	COUNT(DISTINCT age) > 1;

    
-- FD in name_info

-- first_name, middle_name, last_name,name_suffix_lbl --> full_name_mail
SELECT first_name, middle_name, last_name,name_suffix_lbl 
FROM voter
GROUP BY first_name, middle_name, last_name,name_suffix_lbl 
HAVING NOT (MIN(voter.full_name_mail) <=> MAX(voter.full_name_mail));


-- FD mailing_address

SELECT full_name_mail, 
COUNT(DISTINCT first_name), COUNT(DISTINCT middle_name),
COUNT(DISTINCT last_name), COUNT(DISTINCT name_suffix_lbl) 
FROM voter
GROUP BY full_name_mail
HAVING COUNT(DISTINCT first_name) > 1 OR
	COUNT(DISTINCT middle_name) > 1 OR
	COUNT(DISTINCT last_name) > 1 OR
    COUNT(DISTINCT name_suffix_lbl) > 1;
--

-- A B --> C
SELECT street_name, street_type_cd   
FROM voter
GROUP BY street_name, street_type_cd
HAVING NOT (MIN(voter.mail_addr1) <=> MAX(voter.mail_addr1));

SELECT mail_addr1, COUNT(DISTINCT street_name), COUNT(DISTINCT street_type_cd)
FROM voter
GROUP BY mail_addr1 
HAVING COUNT(DISTINCT street_name) > 1 OR COUNT(DISTINCT street_type_cd) > 1;

-- A -> B, C
SELECT zip_code, COUNT(DISTINCT res_city_desc), COUNT(DISTINCT state_cd)
FROM voter
GROUP BY zip_code 
HAVING COUNT(DISTINCT res_city_desc) > 1 OR COUNT(DISTINCT state_cd) > 1;

-- A -> B , C, D
SELECT house_num, COUNT(DISTINCT mail_addr1),
	COUNT(DISTINCT mail_addr2),COUNT(DISTINCT mail_city_state_zip),
    COUNT(DISTINCT zip_code)
FROM voter 
GROUP BY house_num 
HAVING COUNT(DISTINCT mail_addr1) > 1 OR COUNT(DISTINCT mail_addr2) > 1 OR
	COUNT(DISTINCT mail_city_state_zip) > 1 OR COUNT(DISTINCT zip_code) > 1;

SELECT house_num
FROM voter
GROUP BY house_num
HAVING COUNT(DISTINCT mail_addr1) > 1 OR
	COUNT(DISTINCT mail_addr2) > 1 OR COUNT(DISTINCT mail_city_state_zip) > 1 OR 
    COUNT(DISTINCT zip_code) > 1 OR COUNT(DISTINCT street_dir) > 1 OR
    COUNT(DISTINCT street_name) > 1 OR COUNT(DISTINCT street_type_cd) > 1 OR
    COUNT(DISTINCT street_sufx_cd) > 1 OR COUNT(DISTINCT unit_num) > 1 OR
    COUNT(DISTINCT res_city_desc) > 1 OR COUNT(DISTINCT state_cd) > 1 OR
    COUNT(DISTINCT zip_code) > 1;
 
SELECT mail_addr1, mail_addr2,registr_dt
FROM voter
GROUP BY mail_addr1, mail_addr2,registr_dt
HAVING COUNT(DISTINCT house_num) > 1 OR
	COUNT(DISTINCT mail_city_state_zip) > 1 OR 
	COUNT(DISTINCT street_dir) > 1 OR
    COUNT(DISTINCT street_name) > 1 OR COUNT(DISTINCT street_type_cd) > 1 OR
    COUNT(DISTINCT street_sufx_cd) > 1 OR COUNT(DISTINCT unit_num) > 1;
 
SELECT mail_city_state_zip
FROM voter
GROUP BY mail_city_state_zip
HAVING COUNT(DISTINCT res_city_desc) > 1 OR
	COUNT(DISTINCT state_cd) > 1 OR 
	COUNT(DISTINCT zip_code) > 1;


-- full_name_mail(381654) , mail_addr1(203678) , mail_addr2 (1087), mail_city_state_zip(3862), 
-- house_num(14980) , street_dir(5) , street_name(8594) , street_type_cd(22), street_sufx_cd (5), 
-- unit_num(4025), res_city_desc (6), state_cd(1), zip_code(32), registr_dt (8774)




-- district table 

SELECT mail_addr1, mail_addr2,
COUNT(DISTINCT status_cd), COUNT(DISTINCT municipality_desc),
COUNT(DISTINCT ward_desc), COUNT(DISTINCT cong_dist_desc),
COUNT(DISTINCT super_court_desc), COUNT(DISTINCT nc_senate_desc),
COUNT(DISTINCT nc_house_desc), COUNT(DISTINCT county_commiss_desc),
COUNT(DISTINCT school_dist_desc)
FROM voter
GROUP BY mail_addr1, mail_addr2
HAVING COUNT(DISTINCT status_cd) > 1 OR 
	COUNT(DISTINCT municipality_desc) > 1 OR COUNT(DISTINCT ward_desc) > 1 OR 
    COUNT(DISTINCT cong_dist_desc) > 1 OR COUNT(DISTINCT super_court_desc) > 1 OR
    COUNT(DISTINCT street_name) > 1 OR COUNT(DISTINCT street_type_cd) > 1 OR
    COUNT(DISTINCT nc_senate_desc) > 1 OR COUNT(DISTINCT nc_house_desc) > 1 OR
    COUNT(DISTINCT county_commiss_desc) > 1 OR COUNT(DISTINCT school_dist_desc) > 1;



SELECT COUNT(DISTINCT school_dist_desc)  
FROM voter;

status_cd(2) ,municipality_desc(9), ward_desc(8) , cong_dist_desc(3), 
super_court_desc(9), nc_senate_desc(6),  nc_house_desc(13), 
county_commiss_desc(7), school_dist_desc(7),


