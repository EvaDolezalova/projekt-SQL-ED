CREATE TABLE t_Eva_DOLEZALOVA_project_SQL_primary_final
SELECT 
  	cp.id,
	cp.value, 
	cp.value_type_code AS kod_hodnot_mezd,
	cpvt.name AS hodnota_mezd,
	cp.unit_code AS kod_jednotek,
	cpu.name AS jednotka,
	cp.calculation_code AS kod_kalkulaci,
	cpc.name AS kalkulace,
	cp.industry_branch_code AS kod_odvetvi,
	cpib.name AS odvetvi,
	cp2.value AS cena,
	cp2.category_code AS kod_kategorie,
	cp2.date_from AS datum_od,
	cp2.date_to AS datum_do,
	cp2.region_code AS kod_regionu,
	YEAR (date_from) AS rok,
	quarter(date_from) AS kvartal,
	produkt
	FROM czechia_payroll cp
	LEFT JOIN czechia_payroll_calculation cpc ON cp.calculation_code = cpc.code
	LEFT JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code =cpib.code 
	LEFT JOIN czechia_payroll_unit cpu ON cp.unit_code =cpu.code 
	LEFT JOIN czechia_payroll_value_type cpvt  ON cp.value_type_code = cpvt.code
	LEFT JOIN czechia_price cp2 ON YEAR (date_from) = cp.payroll_year AND quarter(date_from) = cp.payroll_quarter
	LEFT JOIN v_nazev_regionu_cena ON kod_produktu = cp2.category_code;
	

SELECT *
FROM 

SELECT *
FROM czechia_price_category cpc 
