data mnthly_sales; 
 length zip $ 5 cty $ 8 var $ 10; 
input zip $ cty $ var $ sales; 
label zip="Zip Code" cty="County"  var="Variety" sales="Monthly Sales"; 
datalines; 
52423 Scott Merlot 186.00
52423 Scott Merlot  145.00
52423 Scott Chardonnay 178.06
 52388 Scott Chardonnay 35.09
52423 Scott Zinfandel 56.09
52388 Scott Zinfandel 58.00
 52423 Scott Merlot  45
52200 Adams Merlot 88
52388 Scott Merlot 88
52200 Adams Chardonnay 78
52388 Scott Chardonnay 166
52200 Adams Zinfandel  56
52388 Scott Zinfandel 45.0
52200 Adams Chardonnay 77.01
52200 Adams Merlot 50
52199 Adams Merlot 49
52200 Adams Chardonnay 55
52199 Adams Chardonnay 56
52200 Adams Zinfandel 78
52199 Adams Zinfandel 79
52200 Adams Chardonnay 90
52199 Adams Merlot 34
52199 Adams Chardonnay 119
52199 Adams Zinfandel 200
; 
 proc print data=mnthly_sales; 
title "Raw Data";
 run;


/*title1 "Simple Report";
SELECT THE GIVEN VARIABLES cty zip var sales AND DISPLAY THEM*/
proc print data=mnthly_sales;
title1 "Simple Report";
var cty zip var sales;
run;

/*RENAME CTY AS ‘County/Name’ AND SORT THE DATA;
FORMAT SALES TO DECIMAL PLACES
I REQUIRE A LINE DIVIDING THE VARIABLES FROM THE OBSERVATIONS*/
data mnthly_sales1;
set mnthly_sales;
County_Name=cty;
drop cty;
run;

proc sort data=mnthly_sales1;
by sales;
run;

proc print data=mnthly_sales1;
title1 "Simple Report";
var County_Name zip var sales;
format sales 3.2;
run;

/*USE THE DATA FROM Q1 
SELECT THE GIVEN VARIABLES cty zip var sales AND DISPLAY THEM*/
proc print data=mnthly_sales;
title1 "Simple Report";
var cty zip var sales;
run;

/*title1 "Grouped Report (Group Type)";
GROUP COUNTRY ZIP VAR 
ORDER THE ROWS WITHIN THE GROUP FOR VAR BY DESCENDING*/
proc report data=mnthly_sales;
title1 "Grouped Report (cty)";
column cty zip var sales;
define cty / group;
define zip / group;
define var /group descending;
run;

/*USE THE DATA FROM Q1 
SELECT THE GIVEN VARIABLES cty zip var sales AND DISPLAY THEM
SALES CALCULATE MEAN SUM*/
proc means data=mnthly_sales mean sum;
var sales;
class cty zip var;
run;

/*5) title1 "Report with Breaks";
 SELECT THE COLUMNS cty zip var,sales; 
cty / group  AND RENAME ‘County/Name’
 zip / group
var / across ORDER BY descending  AND RENAME TO '- Grape Variety -';
sales /  sum format RENAME  'Revenue'; 
AFTER CTY SUMMARIZE*/
proc report data=mnthly_sales;
column cty zip var sales;
define cty / group "County/Name";
define zip / group;
define var / across '- Grape Variety -' descending;
define sales / analysis sum "Revenue" format=3.2;
break after cty / summarize;
run;