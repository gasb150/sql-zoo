-- TUTORIAL 

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
