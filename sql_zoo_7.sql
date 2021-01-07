-- TUTORIAL 

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
