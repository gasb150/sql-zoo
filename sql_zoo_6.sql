-- TUTORIAL 

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
