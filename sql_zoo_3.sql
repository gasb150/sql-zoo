-- TUTORIAL 

-- 3 SELECT_NOBEL_TUTORIAL

--Winners from 1950
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950
 --1962 Literature
 SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'
--Albert Einstein
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'
--Recent Peace Prizes
SELECT winner
FROM nobel
WHERE subject = 'Peace' AND yr >= 2000
--Literature in the 1980's
SELECT * 
FROM nobel 
WHERE yr BETWEEN 1980 AND 1989 AND subject = 'Literature'
--Only Presidents
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
    'Woodrow Wilson',
    'Jimmy Carter',
    'Barack Obama')
--John
SELECT winner
FROM nobel
WHERE winner LIKE ('john%')
-- Chemistry and Physics from different years
SELECT * 
FROM nobel
WHERE (subject = 'physics' AND yr = 1980) OR (subject = 'chemistry' AND yr = 1984)
--Exclude Chemists and Medics
SELECT * 
FROM nobel
WHERE yr = 1980 AND subject != 'chemistry' AND subject != 'medicine'
--Early Medicine, Late Literature
SELECT * 
FROM nobel
WHERE (subject = 'medicine' AND yr < 1910) OR (subject = 'literature' AND yr >= 2004)
-- Umlaut
SELECT * 
FROM nobel
WHERE winner = 'PETER GRÜNBERG' 
--Apostrophe
SELECT * 
FROM nobel
WHERE winner = 'EUGENE O''NEILL'
--Knights of the realm
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
-- Chemistry and Physics last
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics', 'Chemistry'), subject, winner
 