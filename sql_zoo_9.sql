-- TUTORIAL 

-- 9- Window functions

-- Warming up
SELECT lastName, party, votes
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC
--Who won?
SELECT party, votes,
       RANK() OVER (ORDER BY votes DESC) AS posn
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party
-- PARTITION BY
SELECT yr,party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000021'
ORDER BY party,yr
-- Edinburgh Constituency
SELECT constituency, party, votes,
 RANK() OVER (PARTITION BY constituency ORDER BY votes DESC)  as posn 
  FROM ge
 WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
   AND yr  = 2017

ORDER BY posn, constituency

--Winners Only

SELECT constituency,party
  FROM ge x
 WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
   AND yr  = 2017 AND votes >= ALL (SELECT votes FROM ge y WHERE x.constituency = y.constituency AND y.yr = 2017) 
ORDER BY constituency,votes DESC

-- Scottish seats
SELECT party, COUNT(votes)
  FROM ge x
 WHERE constituency LIKE 'S%'
   AND yr  = 2017 AND votes >= ALL(SELECT votes FROM ge y  WHERE x.constituency = y. constituency AND y.yr = 2017)
GROUP BY party
ORDER BY party,votes DESC

-- 9+ COVID 19 (Window LAG)

-- Introducing the covid table
SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3
ORDER BY whn
-- Introducing the LAG function
SELECT name, DAY(whn), confirmed,
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)dbf
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn
-- Number of new cases
SELECT name, DAY(whn),
   confirmed-(LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn))
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn  
-- Weekly changes
SELECT name, DATE_FORMAT(whn,'%Y-%m-%d'),confirmed-(LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn))
 FROM covid
WHERE name = 'Italy'
AND WEEKDAY(whn) = 0
ORDER BY whn
-- LAG using a JOIN
SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'), 
 (tw.confirmed - lw.confirmed)
 FROM covid tw LEFT JOIN covid lw ON 
  DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
   AND tw.name=lw.name
WHERE tw.name = 'Italy' AND WEEKDAY(tw.whn)=0
ORDER BY tw.whn

-- RANK
SELECT 
   name,
   confirmed,
   RANK() OVER (ORDER BY confirmed DESC) rc,
   deaths,
RANK() OVER (ORDER BY deaths DESC) rc
  FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC

-- Infection rate
SELECT 
   world.name,
   ROUND(100000*confirmed/population,0),
   RANK() OVER (ORDER BY confirmed/population ) rc
   FROM covid JOIN world ON covid.name=world.name
WHERE whn = '2020-04-20' AND population > 10000000
ORDER BY population DESC
-- Turning the corner
--- ////
