CREATE TABLE t_Eva_Dolezalova_project_SQL_primary_final AS
SELECT
  	cp.id,
	cp.value, 
	cp.value_type_code AS kod_hodnot_mezd,
	cpvt.name AS hodnota_mezd,
	cp.unit_code AS kod_jednotek,
	cpu.name AS jednotka,
	cp.calculation_code AS kod_kalkulaci,
	cpc. name AS kalkulace,
	cp.industry_branch_code AS kod_odvetvi,
	cpib.name AS odvetvi,
	vpr.cena,
	vpr.kod_kategorie,
	vpr.datum_od,
	vpr.datum_do,
	vpr.kod_regionu,
	cp.payroll_year,
	vpr.rok,
	vpr.kvartal,
	vpr.produkt,
	vpr.region
	FROM czechia_payroll cp
	LEFT JOIN czechia_payroll_calculation cpc ON cp.calculation_code = cpc.code
	LEFT JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code =cpib.code 
	LEFT JOIN czechia_payroll_unit cpu ON cp.unit_code =cpu.code 
	LEFT JOIN czechia_payroll_value_type cpvt ON cp.value_type_code = cpvt.code
	LEFT JOIN v_produkt_region vpr ON vpr.rok = cp.payroll_year AND vpr.kvartal = cp.payroll_quarter;

CREATE OR REPLACE VIEW v_produkt_region AS
SELECT cp.value AS cena,
	cp.category_code AS kod_kategorie,
	cp.date_from AS datum_od,
	cp.date_to AS datum_do,
	cp.region_code AS kod_regionu,
	YEAR (date_from) AS rok, 
	quarter(date_from)AS kvartal, 
	cpc.name AS produkt,
	cr.name AS region
FROM czechia_price cp 
LEFT JOIN czechia_price_category cpc ON cp.category_code = cpc.code
LEFT JOIN czechia_region cr ON cp.region_code = cr.code;


SELECT *
FROM t_eva_dolezalova_project_sql_primary_final tedpspf
WHERE odvetvi IS Null



