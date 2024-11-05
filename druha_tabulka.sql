-- Druhá tabulka

CREATE TABLE t_eva_dolezalova_project_SQL_secondary_final AS
SELECT
c.country AS zeme,
c.avg_height AS prumerna_vyska,
c.calling_code AS predvolba,
c.capital_city AS hlavni_mesto,
c.continent AS kontinent,
c.currency_name AS mena,
c.religion AS nabozenstvi,
c.government_type AS vlada,
c.population_density AS hustota_obyvatel,
e.GDP AS HDP,
e.gini AS gini,
e.taxes AS dane,
e.YEAR AS rok
FROM (SELECT * FROM countries WHERE continent = 'Europe')c
INNER JOIN economies e ON c.country = e.country
WHERE year BETWEEN 2006 AND 2018; 



