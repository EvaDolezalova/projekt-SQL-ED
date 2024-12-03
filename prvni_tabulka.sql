CREATE TABLE t_Eva_Dolezalova_project_SQL_primary_final as
SELECT
  	cp.id,
	cp.value, 
	cp.value_type_code AS kod_hodnot_mezd,
	cpvt.name AS hodnota_mezd,
	cp.unit_code AS kod_jednotek,
	cpu.name AS mena,
	cp.calculation_code AS kod_kalkulaci,
	/*cpc.name AS kalkulace,*/
	cp.industry_branch_code AS kod_odvetvi,
	cpib.name AS odvetvi,
	cp.payroll_year,
	vccr.rok,
	vccr.kvartal,
	vccr.produkt,
	vccr.cena,
	vccr.hodnota_mnozstvi,
	vccr.jednotka,
	vccr.region
FROM (SELECT id,value,value_type_code,unit_code,calculation_code,industry_branch_code,payroll_year,payroll_quarter
       FROM czechia_payroll WHERE payroll_year BETWEEN 2006 AND 2018 AND value_type_code = 5958 AND calculation_code = 100)cp 
	/*JOIN czechia_payroll_calculation cpc ON cp.calculation_code = cpc.code*/
	JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code =cpib.code 
	JOIN czechia_payroll_unit cpu ON cp.unit_code =cpu.code 
	JOIN czechia_payroll_value_type cpvt  ON cp.value_type_code = cpvt.code
	LEFT JOIN v_cprice_cathegory_region vccr ON vccr.rok = cp.payroll_year AND vccr.kvartal = cp.payroll_quarter;

	

CREATE OR REPLACE VIEW v_cprice_cathegory_region AS
SELECT 
	cp.value AS cena,
	cp.category_code AS kod_kategorie_produkt,
	cp.date_from AS datum_od,
	cp.date_to AS datum_do,
	YEAR (date_from) AS rok, 
	quarter(date_from)AS kvartal, 
	cpc.name AS produkt,
	cpc.price_value AS hodnota_mnozstvi,
	cpc.price_unit AS jednotka,
	cp.region_code AS kod_regionu,
	cr.name AS region
FROM czechia_price cp 
JOIN czechia_price_category cpc ON cp.category_code = cpc.code
JOIN czechia_region cr ON cp.region_code = cr.code;

SELECT *
FROM v_cprice_cathegory_region vccr 

SELECT *
FROM t_eva_dolezalova_project_sql_primary_final tedpspf 





