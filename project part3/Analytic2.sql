-- This view categorizes Democratic party members into different generations based on their age.
-- It also calculates the count and percentage of members in each age group.

# differnt generation

DROP VIEW dem_generation;
CREATE VIEW dem_generation AS
SELECT party_cd,
  CASE 
    WHEN age BETWEEN 18 AND 26 THEN 'GEN Z'
    WHEN age BETWEEN 27 AND 42 THEN 'Millennials'
    WHEN age BETWEEN 43 AND 58 THEN 'Gen X'
    WHEN age BETWEEN 59 AND 77 THEN 'Boomers'
    ELSE 'Silent Generation' 
  END AS age_range, 
  COUNT(*) AS count, 
  (COUNT(*) / (SELECT COUNT(*) FROM person WHERE party_cd = 'DEM')) * 100 AS percentage
FROM 
  person 
WHERE party_cd = 'DEM'
GROUP BY 
  party_cd, age_range
ORDER BY percentage DESC;	
########################################################################################################################

-- This view calculates the count and percentage of people with the race code 'B' in each political party.
# race_party_stats

DROP VIEW race_party_stats;
CREATE VIEW race_party_stats AS
SELECT race_code, 
	party_cd, 
    COUNT(*) AS count,
    (COUNT(*) / (SELECT COUNT(*) FROM person WHERE race_code = 'B')) * 100 AS percentage
FROM person
WHERE race_code = 'B'
GROUP BY race_code, party_cd
ORDER BY percentage DESC;	


    
    









