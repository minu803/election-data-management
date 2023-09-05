-- Minwoo Sohn
-- minwoo.sohn@vanderbilt.edu
-- Project 1 Part 2

-- Find dependencies in a table R.
-- A -> B

-- Should return empty set if FD holds
SELECT *  
FROM R 
GROUP BY A 
HAVING COUNT (DISTINCT B) > 1;

-- A -> B 

SELECT * 
FROM R r1 
	JOIN R r2 ON r1.A = r2.A 
WHERE r1.B <> r2.B;


-- A -> B,C

SELECT *  
FROM R 
GROUP BY A 
HAVING COUNT (DISTINCT B) > 1 OR COUNT (DISTINCT C)>1;


-- A,B -> C

SELECT R.A, R.B
FROM R
GROUP BY R.A, R.B
HAVING NOT (MIN(R.C) <=> MAX(R.C)); /* <=> is NULL safe equality */

 