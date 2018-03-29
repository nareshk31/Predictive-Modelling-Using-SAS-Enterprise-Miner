/* -----------------------------------
      First and Last Observations 
   ----------------------------------- */
/*If you use a by statement along with a set statement in a data step
then SAS creates two automatic variables, FIRST.variables and LAST.variables,
where variable is the name of the by variable.*/

/*FIRST.variable has a value 1 for the first observation in the by group and 0  
for all other observations in the by group.

LAST.variable has a value 1 for the last observation in the by group and 0 
for all other observations in the by group.*/

--------------------------------------------------------------------------;
data temp;
input group x;
cards;
1 23
1 34
1 .
1 45
2 78
2 92
2 45
2 89
2 34
2 76
3 31
4 23
4 12
;
run;
proc print data=temp;
run;

/************************************
The automatic variables first.group and last.group are
not saved with the data set.
**************************************/

data new1;
set temp;
by group;
first=first.group;
last=last.group;
run;

proc print data=new1;
run;

/********************************************
A common task in data cleaning is to identify observations 
with a duplicate ID Number. If we set the data set by ID, then the observations
which are not duplicated will be both the first and the last with that ID Number. 
We can therefore wriite any observations which are not both first.id and last.id 
to a separate data set and examine them.
*********************************************/

data sin;
input ID name$ Age;
datalines;
1 Sushma 23
2 dipti 34
3 savitha 44
4 naren 54
;
run;

proc print data=sin;
run;

data see;
set sin;
by ID;
first=first.ID;
last= last.ID;
run;

proc print data=see;
run;

options formdlim="-";
data sin1;
input ID name$ Age;
datalines;
1 sushma 23
2 dipti 34
3 savita 44
4 naren 54
1 sushma 23
;
run;

proc print data=sin1;
run;

proc sort data=sin1;
by ID;
run;

data see1;
set sin1;
by ID;
first=first.ID;
last=last.ID;
run;

proc print data=see1;
run;

data single dup;
set sin;
by ID;
if first.ID and last.ID then output single;
else output dup;
run;

proc print data=single;
run;

proc print data=dup;
run;

/******************************************************
we may also want to do data set processing within each by group. In this example we 
construct the cumulative sum of the variable X within each group.
********************************************************/

data cusum(keep=group sum);
set temp;
by group;
if first.group then sum=0;
sum+x;
if last.group then output;
run;

proc print data=cusum noobs;
title 'Sum of X within each group';
run;















