
-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

CREATE VIEW v_prumerna_cena AS
SELECT produkt, 
	   rok, 
	   rok+1 AS rok_nasledujici,
	   Round(avg(tedpspf.cena),2) AS prumer_cena
FROM t_eva_dolezalova_project_sql_primary_final tedpspf 
GROUP BY produkt, rok, rok_nasledujici

SELECT vpc.produkt,
       vpc.rok,
       vpc.rok_nasledujici,
       vpc.prumer_cena,
       vpc2.prumer_cena_nasledujici,
       Round (avg(((vpc2.prumer_cena_nasledujici-vpc.prumer_cena)/vpc.prumer_cena)*100),2) AS prumerny_rocni_narust
     FROM v_prumerna_cena vpc    
 LEFT JOIN (SELECT prumer_cena AS prumer_cena_nasledujici,produkt, rok FROM v_prumerna_cena) vpc2 
 ON vpc.rok_nasledujici = vpc2.rok AND vpc2.produkt = vpc.produkt 
 GROUP BY produkt, rok, rok_nasledujici, prumer_cena, prumer_cena_nasledujici