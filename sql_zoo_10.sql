-- TUTORIAL 

-- 10 Self join
--How many stops
SELECT COUNT(id)
FROM stops
-- Find the id value
SELECT id
FROM stops
WHERE name = 'Craiglockhart'

-- Give the id and the name for the stops 
SELECT id, name
FROM stops 
JOIN route ON (stops.id = route.stop)
WHERE num = 4 AND company = 'LRT'
ORDER BY pos

-- number of routes that visit
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) =2

--Execute the self join
SELECT a.company, a.num, a.stop, b.stop
FROM route a, route b 
WHERE a.stop=53 AND b.stop=149 AND a.num=b.num

--stops by name rather than by number
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a
JOIN route b ON (a.num = b.num)
JOIN stops stopa ON (a.stop = stopa.id)
JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' 
AND stopb.name = 'London Road'

-- services which connect stops by num
SELECT DISTINCT a.company, a.num
FROM route a, route b 
WHERE a.stop=115 AND b.stop=137 AND a.num=b.num

-- services which connect the stops bu name
SELECT a.company, a.num
FROM route a
JOIN route b ON (a.num = b.num)
JOIN stops stopa ON (a.stop = stopa.id)
JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' 
AND stopb.name = 'Tollcross'

-- Distinct list of the stops' 
SELECT stopb.name, b.company, b.num
FROM route a
JOIN route b ON (a.num = b.num AND a.company = b.company)
JOIN stops stopa ON (a.stop = stopa.id)
JOIN stops stopb ON (b.stop = stopb.id)
WHERE stopa.name = 'Craiglockhart' 

-- Find the routes involving two buses that can go from Craiglockhart to Lochend.
SELECT a.num, a.company, a.name, b.num, b.company 
FROM 
    (SELECT DISTINCT t_1.num, t_1.company, st_2.name 
     FROM route t_1 JOIN route t_2 ON (t_1.num = t_2.num AND t_1.company = t_2.company) 
                  JOIN stops st_1 ON st_1.id = t_1.stop 
                  JOIN stops st_2 ON st_2.id = t_2.stop 
     WHERE st_1.name = 'Craiglockhart' AND st_2.name <> 'Craiglockhart'
)a ,

    (SELECT t_1.num, t_1.company, st_2.name 
     FROM route t_1 JOIN route t_2 ON (t_1.num = t_2.num AND t_1.company = t_2.company) 
                  JOIN stops st_1 ON st_1.id = t_1.stop 
                  JOIN stops st_2 ON st_2.id = t_2.stop 
     WHERE st_1.name =  'Lochend' AND st_2.name <> 'Lochend'
    )b

WHERE (a.name = b.name)
ORDER BY a.num, a.name, b.num
