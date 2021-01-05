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