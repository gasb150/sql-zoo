-- TUTORIAL 

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

-- 8+ NSS Tutorial
-- Check out one row
SELECT A_STRONGLY_AGREE
  FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science'

-- Calculate how many agree or strongly agree
SELECT institution, subject
  FROM nss
 WHERE score >= 100 AND question = 'Q15'

 -- Unhappy Computer Students
 SELECT institution, score
  FROM nss
 WHERE score < 50 AND question = 'Q15'AND subject = '(8) Computer Science' 
 -- More Computing or Creative Students?
 SELECT subject, SUM(response)
  FROM nss
 WHERE (subject='(8) Computer Science' OR subject = '(H) Creative Arts and Design')  AND question='Q22' 
GROUP BY subject

--Strongly Agree Numbers
SELECT subject, SUM(response*A_STRONGLY_AGREE/100)
  FROM nss
 WHERE question='Q22'
   AND (subject='(8) Computer Science' OR subject = '(H) Creative Arts and Design')
GROUP BY subject

-- Scores for Institutions in Manchester
SELECT institution, ROUND((SUM(score*response))/SUM(response))
  FROM nss
 WHERE question='Q22'
   AND (institution LIKE '%Manchester%')

GROUP BY institution
ORDER BY institution

-- Number of Computing Students in Manchester
SELECT institution, SUM(sample), 
(SELECT sample 
FROM nss x
WHERE subject='(8) Computer Science'
AND y.institution = x.institution
AND question='Q01')
FROM nss y
WHERE question='Q01'
AND (institution LIKE '%Manchester%')
GROUP BY institution
