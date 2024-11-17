
-- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

SELECT 
tedpspf.produkt,
Max(tedpspf.rok) AS posledni_rok,
min(tedpspf.rok)AS prvni_rok,
Round(avg(tedpspf.cena),2) AS prumer_cena,
Round(avg(tedpspf.value),2)AS prumer_mzda,
cpc.name,
Round(avg(tedpspf.value)/avg(tedpspf.cena),0)AS pocet
FROM t_eva_dolezalova_project_sql_primary_final tedpspf 
LEFT JOIN czechia_price_category cpc ON tedpspf.produkt = cpc.name 
WHERE tedpspf.produkt IN ('Chléb konzumní kmínový','Mléko polotučné pasterované') AND rok IN ('2006', '2018')
GROUP BY produkt,rok