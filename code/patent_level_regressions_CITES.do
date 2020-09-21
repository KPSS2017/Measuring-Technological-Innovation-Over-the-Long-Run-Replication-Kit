cd "E:\ReplicationCode"

clear

ssc install reghdfe
ssc install ftools


use "intermediate_data\MergedPatentData.dta"
 
 

egen groupFY = group(issue_year firm_id)
gen fcit05W = exp(lfcit05W)-1
gen fcit010W = exp(lfcit010W)-1
gen rfsim010W=exp(lrrfsim010W)
gen rfsim05W=exp(lrrfsim05W)
gen rfsim01W=exp(lrrfsim01W)
gen fcit01W = exp(lfcit01W)-1

gen fcit210 = fcit25 + fcit610
gen fcit620 = fcit610 + fcit1120
gen fcit2A = fcitALL - fcit01
gen fcit6A = fcitALL - fcit01 - fcit25
gen fcit11A = fcitALL - fcit01 - fcit25 - fcit610

gen lfcit2A  = log(1+fcitALL - fcit01)
gen lfcit6A  = log(1+fcitALL - fcit01 - fcit25)
gen lfcit11A = log(1+fcitALL - fcit01 - fcit25 - fcit610)


winsorizeJ lfcit2A lfcit6A lfcit11A, cuts(1 99) by(issue_year)

 
* regressions: Cites



eststo rC1R1a: reghdfe   lfcit01W lrrfsim01W  myclass1-myclass129    if  issue_year<2013 & issue_year>=1947, absorb(issue_year ) vce(cluster issue_year) nosample
eststo rC1R1b: reghdfe   lfcit01W lrrfsim01W   myclass1-myclass129    if  issue_year<2013 & issue_year>=1947, absorb(groupFY) vce(cluster issue_year) nosample

eststo rC1R2a: reghdfe   lfcit05W lrrfsim05W  myclass1-myclass129     if  issue_year<2007 & issue_year>=1947, absorb(issue_year) vce(cluster issue_year) nosample
eststo rC1R2b: reghdfe   lfcit05W lrrfsim05W   myclass1-myclass129    if  issue_year<2007 & issue_year>=1947, absorb(groupFY) vce(cluster issue_year) nosample

eststo rC1R3a: reghdfe   lfcit010W lrrfsim010W  myclass1-myclass129     if  issue_year<2003 & issue_year>=1947, absorb(issue_year) vce(cluster issue_year) nosample
eststo rC1R3b: reghdfe   lfcit010W lrrfsim010W  myclass1-myclass129     if  issue_year<2003 & issue_year>=1947, absorb(groupFY) vce(cluster issue_year) nosample

eststo rC1R4a: reghdfe   lfcit2AW  lfcit01W lrrfsim01W   myclass1-myclass129   if   issue_year>=1947  &  issue_year<2013, absorb(issue_year) vce(cluster issue_year)
eststo rC1R4b: reghdfe   lfcit2AW  lfcit01W lrrfsim01W   myclass1-myclass129   if   issue_year>=1947  &  issue_year<2013, absorb(groupFY) vce(cluster issue_year)

eststo rC1R5a:  reghdfe   lfcit6AW lfcit05W lrrfsim05W   myclass1-myclass129   if   issue_year>=1947 &  issue_year<2008, absorb(issue_year) vce(cluster issue_year)
eststo rC1R5b:  reghdfe   lfcit6AW lfcit05W lrrfsim05W   myclass1-myclass129   if   issue_year>=1947 &  issue_year<2008, absorb(groupFY) vce(cluster issue_year)

eststo rC1R6a:  reghdfe   lfcit11AW lfcit010W lrrfsim010W  myclass1-myclass129    if    issue_year>=1947 &  issue_year<2003, absorb(issue_year) vce(cluster issue_year)
eststo rC1R6b:  reghdfe   lfcit11AW lfcit010W lrrfsim010W  myclass1-myclass129    if    issue_year>=1947 &  issue_year<2003, absorb(groupFY) vce(cluster issue_year)

esttab rC1R1? rC1R2? rC1R3? rC1R4? rC1R5? rC1R6? using ".\tables\Table_A2", r2 b(3) se(3)  booktab replace scalars("N Observations")  sfmt(%9.0fc) noobs 

 
