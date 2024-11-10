-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají

/*Zemědělství, lesnictví, rybářství
Těžba a dobývání
Zpracovatelský průmysl
Výroba a rozvod elektřiny, plynu, tepla a klimatiz. vzduchu
Zásobování vodou; činnosti související s odpady a sanacemi
Stavebnictví
Velkoobchod a maloobchod; opravy a údržba motorových vozidel
Doprava a skladování
Ubytování, stravování a pohostinství
Informační a komunikační činnosti
Peněžnictví a pojišťovnictví
Činnosti v oblasti nemovitostí
Profesní, vědecké a technické činnosti
Administrativní a podpůrné činnosti
Veřejná správa a obrana; povinné sociální zabezpečení
Vzdělávání
Zdravotní a sociální péče
Kulturní, zábavní a rekreační činnosti
Ostatní činnosti*/


CREATE VIEW v_odvetviA as
SELECT kod_odvetvi, odvetvi, rok, round(avg(value),0) AS prumerna_mzda
  FROM t_eva_dolezalova_project_sql_primary_final tedpspf 
       WHERE tedpspf.kod_odvetvi = 'A'
        AND rok IN ('2006', '2007', '2008','2009', '2010', '2011','2012', '2013', '2014','2015', '2016', '2017','2018')
   GROUP BY kod_odvetvi, odvetvi, rok 

SELECT *
FROM v_odvetvia vo 

-- 1. varianta
SELECT vo.kod_odvetvi, vo.odvetvi, vo.prumerna_mzda, vo.prumerna_mzda AS mzda_2006,
       vo2.prumerna_mzda AS mzda_2007,
       vo3.prumerna_mzda AS mzda_2008,
       vo4.prumerna_mzda AS mzda_2009,
       vo5.prumerna_mzda AS mzda_2010,
       vo6.prumerna_mzda AS mzda_2011,
       vo7.prumerna_mzda AS mzda_2012,
       vo8.prumerna_mzda AS mzda_2013,
       vo9.prumerna_mzda AS mzda_2014,
       v10.prumerna_mzda AS mzda_2015,
       v11.prumerna_mzda AS mzda_2016,
       v12.prumerna_mzda AS mzda_2017,
       v13.prumerna_mzda AS mzda_2018,
      CASE WHEN (v13.prumerna_mzda > v12.prumerna_mzda 
      			AND v12.prumerna_mzda > v11.prumerna_mzda
      			AND v11.prumerna_mzda > v10.prumerna_mzda
      			AND v10.prumerna_mzda > vo9.prumerna_mzda
      			AND vo9.prumerna_mzda > vo8.prumerna_mzda
      			AND vo8.prumerna_mzda > vo7.prumerna_mzda
      			AND vo7.prumerna_mzda > vo6.prumerna_mzda
      			AND vo6.prumerna_mzda > vo5.prumerna_mzda
      			AND vo5.prumerna_mzda > vo4.prumerna_mzda
      			AND vo4.prumerna_mzda > vo3.prumerna_mzda
      			AND vo3.prumerna_mzda > vo2.prumerna_mzda
      			AND vo2.prumerna_mzda > vo.prumerna_mzda) THEN 'růst mezi roky'
            ELSE 'výkyvy'
            END zmena
FROM v_odvetvia vo 
LEFT JOIN (SELECT kod_odvetvi, odvetvi, rok, prumerna_mzda 
FROM v_odvetvia 
WHERE rok = '2007'
GROUP BY kod_odvetvi, odvetvi, rok) vo2 ON vo.kod_odvetvi = vo2.kod_odvetvi 
LEFT JOIN (SELECT kod_odvetvi, odvetvi, rok, prumerna_mzda 
FROM v_odvetvia 
WHERE rok = '2008'
GROUP BY kod_odvetvi, odvetvi, rok)vo3 ON vo.kod_odvetvi = vo3.kod_odvetvi
LEFT JOIN (SELECT kod_odvetvi, odvetvi, rok, prumerna_mzda 
FROM v_odvetvia 
WHERE rok = '2009'
GROUP BY kod_odvetvi, odvetvi, rok)vo4 ON vo.kod_odvetvi = vo4.kod_odvetvi
LEFT JOIN (SELECT kod_odvetvi, odvetvi, rok, prumerna_mzda 
FROM v_odvetvia 
WHERE rok = '2010'
GROUP BY kod_odvetvi, odvetvi, rok)vo5 ON vo.kod_odvetvi = vo5.kod_odvetvi
LEFT JOIN (SELECT kod_odvetvi, odvetvi, rok, prumerna_mzda 
FROM v_odvetvia 
WHERE rok = '2011'
GROUP BY kod_odvetvi, odvetvi, rok)vo6 ON vo.kod_odvetvi = vo6.kod_odvetvi
LEFT JOIN (SELECT kod_odvetvi, odvetvi, rok, prumerna_mzda 
FROM v_odvetvia 
WHERE rok = '2012'
GROUP BY kod_odvetvi, odvetvi, rok)vo7 ON vo.kod_odvetvi = vo7.kod_odvetvi
LEFT JOIN (SELECT kod_odvetvi, odvetvi, rok, prumerna_mzda 
FROM v_odvetvia 
WHERE rok = '2013'
GROUP BY kod_odvetvi, odvetvi, rok)vo8 ON vo.kod_odvetvi = vo8.kod_odvetvi
LEFT JOIN (SELECT kod_odvetvi, odvetvi, rok, prumerna_mzda 
FROM v_odvetvia 
WHERE rok = '2014'
GROUP BY kod_odvetvi, odvetvi, rok)vo9 ON vo.kod_odvetvi = vo9.kod_odvetvi
LEFT JOIN (SELECT kod_odvetvi, odvetvi, rok, prumerna_mzda 
FROM v_odvetvia 
WHERE rok = '2015'
GROUP BY kod_odvetvi, odvetvi, rok)v10 ON vo.kod_odvetvi = v10.kod_odvetvi
LEFT JOIN (SELECT kod_odvetvi, odvetvi, rok, prumerna_mzda 
FROM v_odvetvia 
WHERE rok = '2016'
GROUP BY kod_odvetvi, odvetvi, rok)v11 ON vo.kod_odvetvi = v11.kod_odvetvi
LEFT JOIN (SELECT kod_odvetvi, odvetvi, rok, prumerna_mzda 
FROM v_odvetvia 
WHERE rok = '2017'
GROUP BY kod_odvetvi, odvetvi, rok)v12 ON vo.kod_odvetvi = v12.kod_odvetvi
LEFT JOIN (SELECT kod_odvetvi, odvetvi, rok, prumerna_mzda 
FROM v_odvetvia 
WHERE rok = '2018'
GROUP BY kod_odvetvi, odvetvi, rok)v13 ON vo.kod_odvetvi = v13.kod_odvetvi

-- druhy pokus
SELECT kod_odvetvi, rok, prumerna_mzda, 
  LAG(prumerna_mzda)OVER (PARTITION BY kod_odvetvi ORDER BY rok) AS prumerna_mzda_pred_rokem,
  CASE 
	  WHEN prumerna_mzda > LAG(prumerna_mzda)OVER (PARTITION BY kod_odvetvi ORDER BY rok) THEN 'stoupala'
      WHEN prumerna_mzda < LAG(prumerna_mzda)OVER (PARTITION BY kod_odvetvi ORDER BY rok) THEN 'pokles'
      ELSE 'rovnocena'
  END AS vyvoj
FROM v_odvetvia vo 


