
-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

-- 1.způsob výpočtu

 CREATE VIEW v_prumerne_ceny_mzdy as
 SELECT round(avg(tedpspf.cena),2)AS prumer_cena,
 		round(avg(tedpspf.value),2)AS prumer_mzda,
 		rok,
 		rok+1 AS rok_nasledujici
 FROM t_eva_dolezalova_project_sql_primary_final tedpspf 
 GROUP BY rok, rok_nasledujici;
 
 CREATE OR replace VIEW v_prirustky_cen_mezd AS 
 SELECT vpcm.rok, 
 		vpcm.rok_nasledujici,
 		vpcm.prumer_mzda,
 		vpcm2.prumer_mzda_nasledujici,
 		vpcm.prumer_cena,
 		vpcm2.prumer_cena_nasledujici,
 		Round (avg(((vpcm2.prumer_cena_nasledujici-vpcm.prumer_cena)/vpcm.prumer_cena)*100),2) AS prumerny_rocni_narust_cena,
 		Round (avg(((vpcm2.prumer_mzda_nasledujici-vpcm.prumer_mzda)/vpcm.prumer_mzda)*100),2) AS prumerny_rocni_narust_mzdy,
 		(Round (avg(((vpcm2.prumer_cena_nasledujici-vpcm.prumer_cena)/vpcm.prumer_cena)*100),2)
 		 -Round (avg(((vpcm2.prumer_mzda_nasledujici-vpcm.prumer_mzda)/vpcm.prumer_mzda)*100),2)) AS rozdíl,
  CASE WHEN (ABS(Round (avg(((vpcm2.prumer_cena_nasledujici-vpcm.prumer_cena)/vpcm.prumer_cena)*100),2)
 			-Round (avg(((vpcm2.prumer_mzda_nasledujici-vpcm.prumer_mzda)/vpcm.prumer_mzda)*100),2)) > 10) 
 			then 'vyšší' ELSE 'nižší' END 'vysledek'
       FROM v_prumerne_ceny_mzdy vpcm  
 LEFT JOIN 
 (SELECT prumer_cena AS prumer_cena_nasledujici, rok, rok_nasledujici, prumer_mzda AS prumer_mzda_nasledujici FROM v_prumerne_ceny_mzdy) vpcm2 
 ON vpcm.rok_nasledujici = vpcm2.rok  
 GROUP BY rok,vpcm2.prumer_cena_nasledujici,vpcm2.prumer_mzda_nasledujici, vpcm.rok_nasledujici, vpcm.prumer_mzda,
 		  vpcm.prumer_cena;
 		
 SELECT *
 FROM v_prirustky_cen_mezd vpcm 

 
  
 -- 2. způsob výpočtu 
 
 WITH 
 	cte_prumerne_ceny_produktu AS (
  SELECT AVG(cena) AS prumer_cena, 
		 rok,
		 LAG(AVG(cena)) OVER (ORDER BY rok) AS prumer_cena_predchozi_rok,
		 Round (((AVG(cena) - LAG(AVG(cena)) OVER (ORDER BY rok))/LAG(AVG(cena)) OVER (ORDER BY rok)*100),2) AS prumerny_rocni_narust_cen
  FROM t_eva_dolezalova_project_sql_primary_final tedpspf 
  GROUP BY rok
	), 
	cte_prumerne_mzdy AS (
		SELECT 
			AVG(value) AS prumer_mzda,
			rok,
			LAG(AVG(value)) OVER (ORDER BY rok) AS prumer_mzda_predchozi_rok,
			Round (((AVG(value) - LAG(AVG(value)) OVER (ORDER BY rok))/LAG(AVG(value)) OVER (ORDER BY rok)*100),2) AS prumerny_rocni_narust_mezd
		FROM t_eva_dolezalova_project_sql_primary_final tedpspf 
		GROUP BY rok
	)
SELECT 
	cpcp.rok,
	cpcp.prumerny_rocni_narust_cen,
	cpm.rok,
	cpm.prumerny_rocni_narust_mezd,
	(cpcp.prumerny_rocni_narust_cen - cpm.prumerny_rocni_narust_mezd) AS rozdíl,
	CASE WHEN (ABS(cpcp.prumerny_rocni_narust_cen - cpm.prumerny_rocni_narust_mezd) > 10) 
 			then 'vyšší' ELSE 'nižší' END 'vysledek'
FROM cte_prumerne_ceny_produktu cpcp
JOIN cte_prumerne_mzdy cpm ON cpcp.rok = cpm.rok;

