
clear

cd "E:\ReplicationCode"

clear

ssc install reghdfe
ssc install ftools


use "intermediate_data\MergedPatentData.dta"

egen groupPY = group(issue_year permco)


* regressions: Drop patents with multiple assignees
replace lkpssW=. if multiple>0

drop if missing(lkpssW)

egen slrrfsim01W=std(lrrfsim01W)  if  issue_year<=2012
egen slrrfsim05W=std(lrrfsim05W)  if  issue_year<=2007
egen slrrfsim010W=std(lrrfsim010W)  if  issue_year<=2002
 
egen slfcit01W=std(lfcit01W)  if  issue_year<=2012
egen slfcit05W=std(lfcit05W)  if  issue_year<=2007
egen slfcit010W=std(lfcit010W) if  issue_year<=2002
 

gen quality = slrrfsim01W
gen cites = slfcit01W
eststo r1: reghdfe lkpssW  quality   lmkcapW  myclass1-myclass129        if  issue_year<=2012, absorb( groupPY ) vce(cluster issue_year)  nosample
eststo r1a: reghdfe lkpssW  quality   lmkcapW     cites   myclass1-myclass129  if  issue_year<=2012, absorb(groupPY) vce(cluster issue_year)  nosample

replace quality = slrrfsim05W
replace cites = slfcit05W
eststo r2: reghdfe lkpssW  quality   lmkcapW         myclass1-myclass129  if  issue_year<=2007, absorb(groupPY) vce(cluster issue_year)  
eststo r2a: reghdfe lkpssW  quality   lmkcapW     cites   myclass1-myclass129   if  issue_year<=2007, absorb(groupPY) vce(cluster issue_year)  

replace quality = slrrfsim010W
replace cites = slfcit010W
eststo r3: reghdfe lkpssW  quality   lmkcapW     myclass1-myclass129     if  issue_year<=2002, absorb(groupPY) vce(cluster issue_year)  
eststo r3a: reghdfe lkpssW  quality   lmkcapW   cites    myclass1-myclass129   if  issue_year<=2002, absorb(groupPY ) vce(cluster issue_year)  

 
esttab r1 r1a r2 r2a r3 r3a using ".\tables\Table_A3.tex", r2  booktab replace b(4) se(4) star(* 0.1 ** 0.05 *** 0.01) drop(myclass* lmkcapW)



 
 