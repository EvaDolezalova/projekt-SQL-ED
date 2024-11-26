
-- Má výška HDP vliv na změny ve mzdách a cenách potravin?
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
-- připojit 2.tabulku z důvodu HDP a vybrat tam pouze ČR

SELECT *
FROM v_prumerne_ceny_mzdy vpcm 

SELECT tedpssf.zeme, 
	   tedpssf.HDP, 
	   vpcm.prumer_cena,
	   vpcm.prumer_mzda,
	   vpcm.rok,
	   vpcm.rok_nasledujici 
FROM t_eva_dolezalova_project_sql_secondary_final tedpssf 
LEFT JOIN v_prumerne_ceny_mzdy vpcm ON vpcm.rok = tedpssf.rok 
WHERE tedpssf.zeme = 'Czech Republic'