
CREATE TABLE IF NOT EXISTS name_info(
first_name VARCHAR(255),
middle_name VARCHAR(255),
last_name VARCHAR(255),
name_suffix_lbl VARCHAR(255),
full_name_mail VARCHAR(255),
PRIMARY KEY(full_name_mail)
) ENGINE = INNODB;

INSERT IGNORE INTO name_info(first_name,middle_name,last_name,name_suffix_lbl,full_name_mail)
SELECT first_name,middle_name,last_name, name_suffix_lbl,full_name_mail
FROM voter;

SELECT COUNT(*)  
FROM voter;


