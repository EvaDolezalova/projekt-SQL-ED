
-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

-- 1. způsob výpočtu
CREATE VIEW v_prumerna_cena AS
SELECT produkt, 
	   rok, 
	   rok+1 AS rok_nasledujici,
	   Round(avg(tedpspf.cena),2) AS prumer_cena
FROM t_eva_dolezalova_project_sql_primary_final tedpspf 
GROUP BY produkt, rok, rok_nasledujici;


SELECT vpc.produkt,
       Round (avg(((vpc2.prumer_cena_nasledujici-vpc.prumer_cena)/vpc.prumer_cena)*100),2) AS prumerny_rocni_narust
       FROM v_prumerna_cena vpc    
 LEFT JOIN (SELECT prumer_cena AS prumer_cena_nasledujici,produkt, rok FROM v_prumerna_cena) vpc2 
 ON vpc.rok_nasledujici = vpc2.rok AND vpc2.produkt = vpc.produkt 
 GROUP BY produkt
 ORDER BY prumerny_rocni_narust ASC;
 

-- 2. způsob výpočtu - zatím bez celkového průměru - problém s NULL
 -- WITH cte_prumer_cen AS (
	SELECT 
			Round(avg(tedpspf.cena),2) AS prumer_cena, 
			tedpspf.rok,
			tedpspf.produkt,
			LAG(Round(avg(tedpspf.cena),2)) OVER (PARTITION BY tedpspf.produkt ORDER BY rok) AS prumerna_cena_predchozi_rok,
			(((Round(avg(tedpspf.cena),2)) - LAG(Round(avg(tedpspf.cena),2)) OVER (PARTITION BY tedpspf.produkt ORDER BY rok))
			/LAG(Round(avg(tedpspf.cena),2)) OVER (PARTITION BY tedpspf.produkt ORDER BY rok)*100) AS prumerny_rocni_narust
	FROM t_eva_dolezalova_project_sql_primary_final tedpspf
	GROUP BY produkt, rok
	/*)
	SELECT produkt,
		LAG(Round(avg(prumerny_rocni_narust),2)) OVER (ORDER BY produkt) AS prumerny_narust_pres_produkt
	FROM cte_prumer_cen
		GROUP BY produkt*/
	
	
			
	