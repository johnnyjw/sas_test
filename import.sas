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

libname learning "/folders/myfolders/learnin";

*import the datafile;
data learning.in_via_pos;
   infile "/folders/myfolders/learnin/limit_cut.txt" firstobs=2;
   input patient_id        9-17
         code           $ 18-28
         provider_id      29-36
         svc_dt         $ 37-46;
run;

proc import datafile="/folders/myfolders/learnin/limit.csv"
            out=learning.in_via_import
            dbms=csv
            replace;
            getnames=yes;
            GUESSINGROWS=2000;
run;

*(a) proc contents;
proc contents data=learning.in_via_import;
run;


*(b) check of duplicates;
proc sort data=learning.in_via_import out=in_via_input dupout=input_dups nodup;
   by patient_id;
run;

*(c) check missing patient id and key dates - would check other rows missing too if had time;
%macro missing_items(var);
   title "Missing count of &var.";
   proc sql;
   select count(*) as missing_items from in_via_input
      where missing(&var.);
   quit;
%mend;

%missing_items(patient_id)
%missing_items(svc_dt)
;

*(d) proc freq of relevant category variables (those that should have a small number of values);
proc freq data=in_via_input;
   tables pat_gender_cd data_typ_cd specialty_name cohort;
run;

*(e) boxplots of continuous variables;
proc sgplot data=in_via_input;
   vbox index_month_id / category=pat_gender_cd;
run;

*(f) proc means on continuous variables;
proc sort data=in_via_input out=input_gender;
   by pat_gender_cd;
run;

proc means data=input_gender;
   by pat_gender_cd;
   var index_month_id pat_age;
run;








title "provider_id is 0";
proc sql;
   select count(*)  as Zero_Counts from test2
      where provider_id eq 0;
quit;