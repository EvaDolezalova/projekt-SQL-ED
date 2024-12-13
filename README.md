# projekt-SQL-ED

## **Zadání projektu**

*Pomocí dostupných podkladů odpovědět na 5 otázek, které adresují dostupnost základních potravin široké veřejnosti.*

1. *Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?*
2. *Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?*
3. *Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?*
4. *Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?*
5. *Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?*

## **Realizace projektu**

V rámci projektu jsem nejprve vytvořila 2 tabulky, které jsou následně využity jako podklad pro získání odpovědí k jednotlivým otázkám. Dále byly vytvořeny i pomocné view, buď při sestavení tabulek, nebo i dále v jednotlivých otázkách.
- První tabulka *t_Eva_Dolezalova_project_SQL_primary_final* obsahuje údaje o mzdách a potravinách za sledované   období, které je mezi lety 2006 až 2018. Postupně byly k tabulce *czechia_payroll* pomocí funkce join připojeny vybrané údaje z tabulek o kalkulacích a odvětvích v ČR, stejně pak i tabulka *czechia_price* včetně hodnot a produktů. 
- Druhá tabulka *t_eva_dolezalova_project_sql_secondary_final* obsahuje údaje o HDP evropských států.
- k odpovědím na jednotlivé otázky byly využity u některých otázek i dva způsoby dotazů

## **Odpovědi**

### **Otázka č. 1** ###

Za sledované období byl zaznamenán růst každý rok pouze ve čtyřech odvětví – a sice odvětví
 - Zemědělství, lesnictví, rybářství
 - Zpracovatelský průmysl
 - Doprava a skladování
 - Zdravotní a sociální péče

V ostatních odvětvích docházelo mezi roky i k poklesům. 
Nejvíce poklesů bylo v roce 2013 oproti roku 2012, a sice v 11 odvětví – nejvyšší pokles v tento rok byl zaznamenán v odvětví Peněžnictví a pojišťovnictví.
Nejčastěji ve sledovaném období zaznamenalo pokles odvětví Těžba a dobývání, a sice v letech 2009, 2013, 2014 a 2016.

### **Otázka č. 2** ###

V roce 2006 bylo možné koupit 1285 kg chleba a 1435 litrů mléka za průměrnou cenu při průměrné mzdě.
V roce 2018 bylo možné koupit 1342 kg chleba a 1642 litrů mléka za průměrnou cenu při průměrné mzdě.

### **Otázka č. 3** ###

Nejpomalejší zdražování za celé období *(tedy nejnižší percentuální meziroční nárůst)* zaznamenaly banány 0,81 %, naopak papriky zdražují nejrychleji cca 7,29 % nárůst mezi lety sledovaného období. 

Meziroční pokles zaznamenaly 2 potraviny, a sice cukr krystal až 1,92 % pokles a rajská jablka kulatá 0,74 % pokles.

Např. papriky zaznamenaly nejvyšší nárůst ceny v roce 2007, kdy stoupla cena o 94,82 % oproti předchozímu roku. 
Cukr zaznamenal nejvyšší pokles ceny v roce 2018 o 21,1 % oproti roku 2017

*Jakostní víno bílé je pouze za sledované období 2015-2018*

### **Otázka č. 4** ###

Dle porovnání meziročního nárůstu cen potravin *(bez ohledu na produkty)* a mezd nebyl zaznamenán v žádném roce výrazně vyšší nárůst cen potravin než byl růst mezd.

V roce 2012 rostly ceny potravin rychleji než mzdy, a to o 3,9 % více *(potraviny +6,94 %, mzdy +3,04 %)* než v roce 2011.

V roce 2017 byl růst cen potravin nejvyšší, a sice + 9,98 %, ale i mzdy v tomto roce měly vysoký nárůst + 6,29 %, tj. rozdíl 3,69 %.

Naopak v roce 2010 byl zaznamenán nejnižší rozdíl růstu cen oproti mzdám 0,08 % *(potraviny +1,76 %, mzdy +1,68 %)*.

Jediným rokem, kdy je rozdíl mezi cenami potravin a mzdami vyšší než 10% je rok 2009 ve srovnání s rokem 2008, ale v daný rok byl zaznamenán výrazný pokles cen potravin, a to o - 6,79 %, naopak mzdy rostly +4,05 %.

Rovněž v roce 2013 je zaznamenán vysoký rozdíl cen potravin a mezd 7,12 %, ale je to dáno naopak poklesem mezd. 

### **Otázka č. 5** ###

Z dostupných údajů vyplývá, že výrazný nárůst HDP neměl přímý vliv na výrazný růst cen či mezd.
 
Lze však říct, že na začátku sledovaného období vedlo výrazné zvýšení HDP v roce 2007 k obdobnému růstu cen i mezd v následujícím roce *(+6,41 %, +7,01 %)*.

Podobně i výrazný pokles HDP v roce 2009 vedl k nižšímu, ale stále srovnatelnému růstu cen a mezd v roce následujícím *(+1,76 %, +1,68 %)*.

Ale tento trend se v posledních letech již neprojevuje. V dalších letech se např. zvýšení HDP v roce 2015 projevuje v následujícím roce spíše na rychlejším růstu mezd *(+3,65 %)*, než cen, u kterých je zaznamenán pokles *(-1,12 %)*.




