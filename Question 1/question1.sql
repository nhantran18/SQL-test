-- QUESTION 1
-- Create schema for question 1 
CREATE TABLE committee (
	commname VARCHAR(100),
	profname VARCHAR(100)
);

CREATE TABLE professor (
	profname VARCHAR(100),
	deptname VARCHAR(100)
);

CREATE TABLE department (
	deptname VARCHAR(100),
	building VARCHAR(100)
);

-- Insert some data for testing 
INSERT INTO committee (commname, profname)
VALUES 
	('committee1', 'Piper'),
	('committee1', 'Piper'),
	('committee2', 'Piper'),
	('committee3', 'Piper'),
	('committee4', 'Louis'),
	('committee5', 'Andy'),
	('committee6', 'Miley'),
	('committee1', 'Andy'),
	('committee2', 'Andy'),
	('committee3', 'Andy'),
	('committee4', 'Andy'),
	('committee5', 'Miley'),
	('committee6', 'Louis');

-- Answer for question 1.1
SELECT DISTINCT profname 
FROM committee
WHERE commname IN (
	SELECT commname 
	FROM committee
	WHERE profname = 'Piper'
)
AND profname <> 'Piper';

-- Answer for question 1.2

SELECT c1.profname
FROM committee c1
JOIN (
	SELECT DISTINCT commname 
	FROM committee
	WHERE profname = 'Piper'
) c2
ON c1.commname = c2.commname
GROUP BY c1.profname
HAVING COUNT(DISTINCT c1.commname) = (
	SELECT COUNT(DISTINCT commname)
	FROM committee
	WHERE profname = 'Piper'
)
AND c1.profname <> 'Piper';