-- This view calculates the distribution of parties among persons.
-- The output includes the party code, count of persons in each party, and the percentage of total persons in each party.

# constituent_stats
DROP VIEW constituent_stats;
CREATE VIEW constituent_stats AS
SELECT party_cd,
       COUNT(*),
       (COUNT(*) / (SELECT COUNT(*) FROM person)) * 100 AS percentage
FROM person
GROUP BY party_cd
ORDER BY percentage DESC;


SELECT * FROM constituent_stats;

#######################################################################################################################
-- This view focuses on Democratic voters and calculates statistics by city.
-- For each city, it counts Democratic voters and calculates the percentage of total Democratic voters in that city.
DROP VIEW IF EXISTS dem_region_stats;
CREATE VIEW dem_region_stats AS
SELECT res_city_desc,
       COUNT(*),
       (COUNT(res_city_desc)/
       (SELECT COUNT(*) FROM zip_city 
							JOIN residential_address_info_test USING(zip_code)
                            JOIN voting_history USING (voter_reg_num)
							WHERE party_cd = 'DEM')) * 100 AS percentage
FROM zip_city
JOIN residential_address_info_test USING(zip_code)
JOIN voting_history USING(voter_reg_num)
WHERE party_cd = 'DEM'
GROUP BY res_city_desc
ORDER BY percentage DESC;

SELECT * FROM dem_region_stats;
#######################################################################################################################

-- This view calculates the distribution of genders among Democratic voters.
-- The output includes the gender code, count of genders, and the percentage of each gender among Democratic voters.
# dem_gender_stats
DROP VIEW dem_gender_stats;
CREATE VIEW dem_gender_stats AS
SELECT sex_code,
       COUNT(sex_code),
      (COUNT(sex_code) /
      (SELECT COUNT(*) FROM person WHERE voter_reg_num IN (SELECT voter_reg_num FROM person WHERE party_cd = 'DEM'))) * 100 AS percentage
FROM person
WHERE party_cd = 'DEM'
GROUP BY sex_code;

SELECT * FROM dem_gender_stats;

#######################################################################################################################
-- This procedure calculates the count of voters who switched parties in a specific election.
-- It first creates a temporary table 'switched_voters' and populates it with voter registration numbers and party codes for the given election.
-- Then it selects the count of distinct voter registration numbers where the party has been switched.

DELIMITER //
CREATE PROCEDURE switched_election(IN party_cd CHAR(3), IN election_num INT)
BEGIN
  DROP TABLE IF EXISTS switched_voters;
  CREATE TEMPORARY TABLE switched_voters AS
    SELECT p.voter_reg_num, p.party_cd, vh.election_ID, vh.party_cd AS selected_party
    FROM voting_history vh
    INNER JOIN person p ON vh.voter_reg_num = p.voter_reg_num
    WHERE p.party_cd = party_cd AND vh.election_ID = election_num;
  SELECT COUNT(DISTINCT voter_reg_num) AS count
  FROM switched_voters
	WHERE party_cd <> ''
	AND selected_party <> '' 
    AND party_cd <> selected_party;

END//

DELIMITER ;

-- CALL switched_election2('DEM', 3);
CALL switched_election('GRE', 5);



