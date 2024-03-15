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
%macro subset( cust=); proc print data= feedback;
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