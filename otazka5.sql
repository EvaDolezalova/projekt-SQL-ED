
-- Má výška HDP vliv na změny ve mzdách a cenách potravin?
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
-- připojit 2.tabulku z důvodu HDP a vybrat tam pouze ČR

-- využití view z výsledku otázky 4


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
    GROUP BY rok, prumerny_rocni_narust_cena, prumerny_rocni_narust_mzdy;


    
