--Druhá tabulka

SELECT *
FROM (SELECT * FROM countries WHERE continent = 'Europe')c
INNER JOIN economies e ON c.country = e.country 



SELECT *
FROM economies e 
WHERE country LIKE '%Cz%'


SELECT *
FROM demographics d 
WHERE country LIKE '%Eur%'

SELECT *
FROM religions r 
WHERE region LIKE '%Eur%'

SELECT *
FROM life_expectancy le 
