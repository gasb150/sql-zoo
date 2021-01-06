-- TUTORIAL 

-- 0 SELECT_BASICS

-- Show the population of Germany.
SELECT population FROM world
  WHERE name = 'Germany';
-- Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');
-- Show the country and the area for countries with an area between 200,000 and 250,000. 
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

-- 1 SELECT_NAME
-- Find the country that start with Y
SELECT name FROM world
  WHERE name LIKE 'Y%'
-- Find the countries that end with y
SELECT name FROM world
  WHERE name LIKE '%y'
-- Find the countries that contain the letter x
SELECT name FROM world
  WHERE name LIKE '%x%'
-- Find the countries that end with land
SELECT name FROM world
  WHERE name LIKE '%land'
-- Find the countries that start with C and end with ia
SELECT name FROM world
  WHERE name LIKE 'C%' AND name LIKE '%ia'
-- Find the country that has oo in the name
SELECT name FROM world
  WHERE name LIKE '%oo%'
-- Find the countries that have three or more a in the name
SELECT name FROM world
  WHERE name LIKE '%a%a%a%'
-- Find the countries that have "t" as the second character.
SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name
-- Find the countries that have two "o" characters separated by two others.
SELECT name FROM world
 WHERE name LIKE '%o__o%'
-- Find the countries that have exactly four characters.
SELECT name FROM world
 WHERE name LIKE '____'
-- Find the country where the name is the capital city.
SELECT name
  FROM world
 WHERE name LIKE capital
-- Find the country where the capital is the country plus "City".
SELECT name
  FROM world
 WHERE capital = concat(name, ' city')
 -- Find the capital and the name where the capital includes the name of the country.
 SELECT capital, name
FROM world
WHERE capital LIKE CONCAT ('%', name, '%')
--Find the capital and the name where the capital is an extension of name of the country.
SELECT capital, name
FROM world
WHERE capital != name AND capital LIKE CONCAT ('%', name, '%')
-- Show the name and the extension where the capital is an extension of name of the country.
SELECT name, 
REPLACE (capital, name, '')
FROM world 
 WHERE capital LIKE concat(name, '%') AND capital <> name

-- 2 SELECT_FROM_WORLD
-- Introduction
SELECT name, continent, population FROM world
-- Large Countries
SELECT name
  FROM world
 WHERE population >= 200000000
 --Per capita GDP
 SELECT name, gdp/population
  FROM world
 WHERE population >= 200000000
 --South America In millions
 SELECT name, population/1000000
FROM world
WHERE continent = 'south america'
--France, Germany, Italy
SELECT name, population
FROM world
WHERE name IN('france', 'germany', 'italy')
-- United
SELECT name
FROM world
WHERE name LIKE ('%united%')
--Two ways to be big
SELECT name, population, area
FROM world
WHERE area >= 3000000 OR population >= 250000000
--One or the other (but not both)
SELECT name, population, area
FROM world
WHERE (area > 3000000 AND population <= 250000000) OR (area <= 3000000 AND population > 250000000)
--Rounding
SELECT name, ROUND(population/1000000,2), ROUND(GDP/1000000000,2)
FROM world
WHERE continent = 'south America'
--Trillion dollar economies
SELECT name, ROUND(GDP/population,-3)
FROM world
WHERE GDP >= 1000000000000
--Name and capital have the same length
SELECT name, capital 
  FROM world
 WHERE LENGTH(name) = LENGTH(capital)
 --Matching name and capital
 SELECT name, capital
FROM world
WHERE LEFT(name,1) = LEFT(capital,1) AND capital <> name
-- All the vowels
SELECT name
   FROM world
WHERE name NOT LIKE '% %' AND name LIKE '%a%'
AND name LIKE '%e%'
AND name LIKE '%i%'
AND name LIKE '%o%'
AND name LIKE '%u%'

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
 
-- 4 SELECT within SELECT Tutorial

--Bigger than Russia
 SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
--Richer than UK
SELECT name
FROM world
WHERE gdp/population > 
 (SELECT gdp/population
 FROM world
 WHERE name = 'United Kingdom') AND continent = 'Europe'
--Neighbours of Argentina and Australia
 SELECT name, continent
FROM world
WHERE continent IN
(SELECT continent
FROM world
WHERE name IN ('Argentina','Australia'))
ORDER BY name
--Between Canada and Poland
SELECT name, population
FROM world
WHERE population > 
(SELECT population FROM world WHERE name = 'Canada') 
AND population < 
(SELECT population FROM world WHERE name = 'Poland')
--Percentages of Germany
SELECT name, CONCAT(ROUND(population/(SELECT population
FROM world
WHERE name = 'germany')*100),'%') AS percentage
FROM world
WHERE continent = 'Europe'
-- Bigger than every country in Europe
SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp
FROM world
WHERE gdp>0
AND continent = 'EUROPE')
--Largest in each continent
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)
-- First country of each continent (alphabetically)
SELECT continent, name
FROM world base
WHERE name = 
(SELECT name 
FROM world compare
WHERE base.continent = compare.continent
LIMIT 1)
-- Difficult Questions That Utilize Techniques Not Covered In Prior Sections
SELECT name, continent, population FROM world
WHERE continent IN
  (SELECT continent FROM world x
    WHERE
      (SELECT MAX(population) FROM world y
        WHERE x.continent = y.continent) <= 25000000);

--  countries have populations more than three times that of any of their neighbours
SELECT name, continent
FROM world x
WHERE population > ALL
 (SELECT MAX(population * 3) FROM world y
   WHERE
     x.continent = y.continent
       AND x.name <> y.name);

-- 5 SUM and COUNT

-- Total world population
SELECT SUM(population)
FROM world

-- List of continents
SELECT DISTINCT continent
FROM world

-- GDP of Africa
SELECT SUM(gdp)
FROM world
WHERE continent = 'africa'

--Count the big countries
SELECT COUNT(name)
FROM world
WHERE area >= 1000000

-- Baltic states population
SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

-- Counting the countries of each continent
SELECT continent, COUNT(name)
FROM world
GROUP BY continent

--Counting big countries in each continent
SELECT continent, COUNT(name)
FROM world
WHERE population > 10000000
GROUP BY continent

--Counting big continents
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) > 100000000


-- 6 The JOIN operation
-- show the matchid and player name
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

-- Know what teams were playing in match 1012
SELECT id,stadium,team1,team2
  FROM game
 WHERE id = 1012

-- show the player, teamid, stadium and mdate for every German goal.
 SELECT player,teamid,stadium,mdate
  FROM game 
  JOIN goal 
  ON (id=matchid)
  WHERE teamid = 'GER'

-- Show the team1, team2 and player for every goal scored by a player 
 SELECT team1, team2, player
FROM game
JOIN goal
ON (id=matchid)
WHERE player LIKE 'Mario%'

--using the phrase goal JOIN eteam on teamid=id
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON teamid=id
WHERE gtime <=10

-- because id is a column name in bothyou must specify instead of just id
SELECT mdate, teamname
  FROM game JOIN eteam ON team1=eteam.id
WHERE   'Fernando Santos'= coach

--  player for every goal scored in a game where the stadium 
SELECT player
FROM goal JOIN game ON (goal.matchid = game.id)
WHERE stadium = 'National Stadium, Warsaw'

-- show the name of all players who scored a goal against Germany.
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='Ger' or team2='Ger') AND teamid != 'GER'

-- Show teamname and the total number of goals scored.
SELECT teamname, COUNT(gtime)
  FROM eteam JOIN goal ON id=teamid
GROUP BY teamname
 ORDER BY teamname

 -- Show the stadium and the number of goals scored in each stadium.
 SELECT stadium, COUNT(gtime)
  FROM game JOIN goal ON id=matchid
GROUP BY stadium
 ORDER BY stadium

-- For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid,mdate, COUNT(teamid)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY  matchid, mdate

-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(teamid)
FROM goal JOIN game ON matchid = id
WHERE teamid = 'GER'
GROUP BY matchid, mdate

-- List every match with the goals scored by each team as shown.

SELECT mdate, team1,
       SUM(CASE WHEN goal.teamid = game.team1 THEN 1 ELSE 0 END) AS score1,
       game.team2,
       SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) AS score2
 
  FROM game LEFT JOIN goal ON matchid = id
GROUP by mdate, matchid, team1, team2

-- 7 More JOIN operations

-- 1962 movies
SELECT id, title
 FROM movie
 WHERE yr=1962

 -- When was Citizen Kane released?
 SELECT yr
 FROM movie
 WHERE title = 'Citizen Kane'

 --Star Trek movies
 SELECT id, title, yr
 FROM movie
 WHERE title LIKE 'Star trek%'
ORDER BY yr

-- id for actor Glenn Close
SELECT id
FROM actor
WHERE name = 'Glenn Close'

-- id for Casablanca
SELECT id
FROM movie
WHERE title = 'Casablanca'

-- Cast list for Casablanca
SELECT name
FROM actor
JOIN casting ON (actor.id = casting.actorid)
WHERE movieid = 11768

-- Alien cast list
SELECT name
FROM actor
JOIN casting ON (actor.id = casting.actorid)
JOIN movie ON (movie.id = casting.movieid)
WHERE movie.title = 'Alien'

-- Harrison Ford movies
SELECT title 
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (casting.actorid = actor.id)
WHERE actor.name = 'Harrison Ford'

-- Harrison Ford as a supporting actor
SELECT title 
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (casting.actorid = actor.id)
WHERE actor.name = 'Harrison Ford' AND ord != 1

-- Lead actors in 1962 movies
SELECT title, name
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (casting.actorid = actor.id)
WHERE ord = 1 AND yr = 1962

-- Busy years for Rock Hudson
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

-- Lead actor in Julie Andrews movies
SELECT title, name FROM movie
JOIN casting ON (casting.movieid= movie.id) AND casting.ord = 1
JOIN actor ON (actor.id=casting.actorid)
WHERE movie.id IN (
SELECT movieid  FROM casting 
WHERE actorid IN (
  SELECT id FROM actor
  WHERE name='Julie Andrews'))

-- Actors with 15 leading roles
SELECT name
FROM actor
JOIN casting ON (actor.id = casting.actorid)
WHERE ord = 1
GROUP BY name
HAVING SUM(ord)>=15
ORDER BY name

-- Films released in the year 1978
SELECT title, COUNT(actorid)
FROM movie
JOIN casting ON (movie.id = casting.movieid)
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actorid) DESC, title

-- people who have worked with 'Art Garfunkel'. 
JOIN casting ON (actor.id = casting.actorid)
WHERE id IN (
SELECT actorid 
FROM casting
WHERE movieid IN (
SELECT movieid
FROM casting
WHERE actorid =( SELECT id
FROM actor
WHERE name = 'Art Garfunkel'))) AND name != 'Art Garfunkel'

-- 8 Using Null
-- teachers who have NULL
SELECT name
FROM teacher
WHERE dept IS NULL

--  INNER JOIN misses the teachers with no department and the departments with no teacher. 
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)

-- Use a different JOIN so that all teachers are listed. 
SELECT teacher.name, dept.name
FROM teacher
LEFT JOIN dept ON (teacher.dept = dept.id)

-- Use a different JOIN so that all departments are listed. 
SELECT teacher.name, dept.name
FROM teacher
RIGHT JOIN dept ON (teacher.dept = dept.id)

-- Use COALESCE to print the name and mobile number
SELECT name,
COALESCE (mobile, '07986 444 2266')
FROM teacher

-- Use the COALESCE function and a LEFT JOIN to print the teacher name and department name
SELECT teacher.name,
COALESCE(dept.name, 'None') AS dept
FROM teacher
LEFT JOIN dept ON (teacher.dept = dept.id)

-- Use COUNT to show the number of teachers and the number of mobile phones. 
SELECT COUNT(teacher.name), COUNT(teacher.mobile)
FROM teacher

-- department and the number of staff.
SELECT dept.name, COUNT(teacher.dept)
FROM dept
LEFT JOIN teacher ON (dept.id = teacher.dept)
GROUP BY dept.name

-- Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise.
SELECT name,
CASE WHEN dept IS NOT NULL
     THEN 'Sci' 
     ELSE 'Art'
END
FROM teacher

-- Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2, show 'Art' if the teacher's dept is 3 and 'None' otherwise. 
SELECT name,
CASE WHEN dept = 1 OR dept = 2 
     THEN 'Sci'
     WHEN dept = 3 THEN 'Art'
     ELSE 'None'
END
FROM teacher

