/************************************************************
*                                                           *
*  Project:                                                 *
*                                                           *
*  SAS Version:                                             *
*                                                           *
*  Program Name:                                            *
*                                                           *
*  Created by:                                              *
*                                                           *
*  Date:                                                    *
*                                                           *
*  Purpose:                                                 *
*                                                           *
*                                                           *
*                                                           *
************************************************************/




data goulet;
   infile "/folders/myfolders/learnin/limit_cut.txt" firstobs=2;
   input patient_id        9-17
         code           $ 18-28
         provider_id      29-36
         svc_dt         $ 37-46;
run;

proc import datafile="/folders/myfolders/learnin/limit.csv"
            out=test2
            dbms=csv
            replace;
            getnames=yes;
            GUESSINGROWS=2000;
run;

title "provider_id is 0";
proc sql;
   select count(*)  as Zero_Counts from test2
      where provider_id eq 0;
quit;

data test3;
   input id @@;
datalines;
1 2 3 5 . . 1 1 1 3 . 4 . 5 6 7 8 1
;

proc sql;
   select count(*) as missing from test3
      where missing(id);
quit;

data test4;
   input sex $ value;
datalines;
M 4
F 2
F 1
F .
M 6
F 1
F 2
F .
M 9
M 5
M 2
F 2
;

proc sql;
   select sex, count(*) as count
      from test4
         group by sex;
quit;



