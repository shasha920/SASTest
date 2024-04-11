data Customer; 
length ID $ 1 Product $ 20; 
input ID $ Product $; 
label ID="ID" Product="Product"; 
datalines; 
A Checking
B Credit
D Saving
; 
proc print data=Customer; 
title "Customer";
run;
 
data Transaction; 
input ID $ Amount; 
label ID="ID" Amount="Amount"; 
datalines; 
B 100
C 200
C 300
; 
proc print data=Transaction; 
title "Transaction";
run;
 
 
/*1.Write a Proc SQL to perform an inner join of the two data sets, and also fill in the Result table below.*/
proc sql;
create table x as
select *
from Customer c inner join Transaction t on c.ID=t.ID;
quit;

/*2.Write a Proc SQL to perform a left join of the two data sets, and also fill in the Result table below.*/
proc sql;
create table x as
select *
from Customer c left join Transaction t on c.ID=t.ID;
quit;

/*3.Write a Proc SQL to perform a full outer join of the two data sets, and also fill in the Result table below.*/
proc sql;
create table x as
select *
from Customer c full join Transaction t on c.ID=t.ID;
quit;

/*4.Please write a SAS program that will create this result:*/
data x2; 
input ID $ Checking_Amount Saving_Amount; 
label ID="ID" Checking_Amount="Checking_Amount" Saving_Amount="Saving Amount"; 
datalines; 
A 150 20
A 150 20
A 150 20
B 250 25
B 250 25
C . .
; 

proc means data=x2 noprint NWAY;
class ID;
var Checking_Amount Saving_Amount;
output out=Avg(drop=_TYPE_)  mean=Average_Checking Average_Saving;
run;

proc print data=Avg;
title "Avg";
var ID _FREQ_ Average_Checking Average_Saving;
run;


/*For the remaining questions, suppose you are given the following data set and a macro code:*/
%macro subset( cust=); 
proc print data= feedback;
  where customer = "&cust";
  run;
%mend;

data feedback; 
input customer $ 1 score comment $ 50.; 
datalines; 
A 3 The is no parking
A 5 The food is expensive
B . I like the food
C 5 It tastes good
C .
C 3 I like the drink
D 4 The dessert is tasty
C 2 I don't like the services
; 
proc print data=feedback; 
title "feedback";
run;

/*5.	Write a program that will programmatically call %subset for each customer value in Feedback.  Note that we do not know 
how many unique values of customer there are in the data set.  Also, you cannot modify the macro %subset itself.*/
proc sql noprint;
create table unique_customer as 
select distinct customer
from feedback;
quit;


data _null_;
set unique_customer;
call execute('%nrstr(%subset(cust=' || customer || '))');
run;

/*6.	Write a program to find out which CUSTOMER has given a "5" score immediately followed by a missing score (among
 the data shown above, it is C).*/
data _null_;
set feedback;
retain pre_scores .;

if score=5 and pre_scores=. then do;
put customer "has given '5'score immediately followed by a missing score";
end;

pre_scores=score;

run;

/*7.	Write a program to find out which CUSTOMER has commented on “parking” and “expensive” (among the data shown
 above, it is A).*/
data _null_;
set feedback;

retain has_parking 0;
retain has_expensive 0;

if index(comment,'parking')>0 then has_parking=1;
if index(comment,'expensive')>0 then has_expensive=1;

if has_parking and has_expensive then do;
put customer "has commented on 'parking' and 'expensive'";
stop;
end;

run;

/*8.	Using Proc SQL create the below dataset and instruct SAS to show the Landline Number of the customer,
 if the Mobile number column is missing otherwise show the Mobile number.*/
data customer;
input Obs custid Mobile Landline;
datalines;
1 1 9800131356 9800232356
2 2 8900230356 .
3 3 . 9743231250
;
run;

proc sql;
create table final_customer as 
select custid,
case when Landline is null or Landline=. then Mobile
else
Landline
end as phone
from customer;
quit;

proc print data=final_customer;
title"customer's phone";
run;


/*9.Use SASHELP.SHOES and create the below output using like clause for the variable Product*/
data africa_shoes;
set sashelp.SHOES;
where (Product like 'Boot%' and  Region='Africa' and Subsidiary like 'A%') or (Product like 'Women''s%' and Region='Africa' and Subsidiary like 'A%');
rename Store=Number_of_Stores Sales=Total_sales Inventory=Total_Inventory Returns=Total_Returns;
run;

Proc print data=africa_shoes;
title "Africa Shoes"
run;