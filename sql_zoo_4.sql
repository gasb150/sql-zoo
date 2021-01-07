-- TUTORIAL 

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
