
-- Má výška HDP vliv na změny ve mzdách a cenách potravin?
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?


-- 1.varianta výpočtu -  využití view z výsledku otázky 4, využití druhé tabulky

SELECT *
FROM v_prirustky_cen_mezd vpcm 

CREATE VIEW v_prirustky_HDP as
SELECT tedpssf.zeme, 
	   tedpssf.HDP, 
	   tedpssf.rok,
	   tedpssf.rok+1 AS rok_nasledujici
FROM t_eva_dolezalova_project_sql_secondary_final tedpssf 
      WHERE tedpssf.zeme = 'Czech Republic'
      
 
SELECT vpcm.rok,
	   vpcm.rok_nasledujici, 
	   vpcm.prumerny_rocni_narust_cena,
	   vpcm.prumerny_rocni_narust_mzdy,
	  Round (avg(((vph2.HDP2-vph.HDP)/vph.HDP)*100),2) AS prumerny_rocni_narust_HDP
FROM v_prirustky_hdp vph 
     LEFT JOIN v_prirustky_cen_mezd vpcm 
          ON vpcm.rok = vph.rok 
     LEFT JOIN (SELECT HDP AS HDP2, rok, rok_nasledujici FROM v_prirustky_hdp) vph2
          ON vph.rok_nasledujici = vph2.rok
    GROUP BY rok, rok_nasledujici, prumerny_rocni_narust_cena, prumerny_rocni_narust_mzdy;


  -- 2. varianta výpočtu, využití view z 1. varianty
   
 WITH 
 	cte_prumerne_ceny_produktu AS (
  		SELECT 
  			AVG(cena) AS prumer_cena, 
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
	),
	cte_prumerne_HDP AS (
		SELECT 
			HDP,
			rok,
			LAG(HDP) OVER (ORDER BY rok) AS HDP_predchozi_rok,
			Round (((((HDP - LAG(HDP) OVER (ORDER BY rok)))/LAG(HDP) OVER (ORDER BY rok))*100),2) AS prumerny_rocni_narust_HDP
		FROM v_prirustky_HDP 
		GROUP BY rok
	)
SELECT 
	cpcp.rok,
	cpcp.prumerny_rocni_narust_cen,
	cpm.rok,
	cpm.prumerny_rocni_narust_mezd,
	cph.rok,
	cph.prumerny_rocni_narust_HDP
FROM cte_prumerne_ceny_produktu cpcp
	JOIN cte_prumerne_mzdy cpm ON cpcp.rok = cpm.rok
	JOIN cte_prumerne_HDP cph ON cpcp.rok = cph.rok
   WHERE prumerny_rocni_narust_HDP > 5;