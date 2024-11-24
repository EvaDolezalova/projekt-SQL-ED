
-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
-- zatím za bez ohledu na produkt a odvětví
-- pokud by se jednalo o nárůst, tak nebylo nikde překročeno 10%, pouze mezi rok 2008 a 2009 je rozdíl větší, jak 10%, ale je dán tím, že je výrazný pokles v cenách 


 CREATE VIEW v_prumerne_ceny_mzdy as
 SELECT round(avg(tedpspf.cena),2)AS prumer_cena,
 		round(avg(tedpspf.value),2)AS prumer_mzda,
 		rok,
 		rok+1 AS rok_nasledujici
 FROM t_eva_dolezalova_project_sql_primary_final tedpspf 
 GROUP BY rok, rok_nasledujici
 
 
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
  -Round (avg(((vpcm2.prumer_mzda_nasledujici-vpcm.prumer_mzda)/vpcm.prumer_mzda)*100),2)) > 10) then 'vyšší' ELSE 'nižší' END 'vysledek'
       FROM v_prumerne_ceny_mzdy vpcm  
 LEFT JOIN 
 (SELECT prumer_cena AS prumer_cena_nasledujici, rok, rok_nasledujici, prumer_mzda AS prumer_mzda_nasledujici FROM v_prumerne_ceny_mzdy) vpcm2 
 ON vpcm.rok_nasledujici = vpcm2.rok  
 GROUP BY rok,vpcm2.prumer_cena_nasledujici,vpcm2.prumer_mzda_nasledujici 

 
  
 
 SELECT rok, avg(cena) AS prumerna_cena
 FROM t_eva_dolezalova_project_sql_primary_final tedpspf 
 GROUP BY rok