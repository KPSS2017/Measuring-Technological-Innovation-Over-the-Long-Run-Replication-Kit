cd "E:\ReplicationCode"

clear
discard

use "intermediate_data\MergedPatentData.dta"


ssc install binscatter

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


winsorizeJ lfcit2A lfcit6A lfcit11A fcit2A fcit6A fcit11A, cuts(1 99) by(issue_year)



 


binscatter  fcit010W rfsim010W  if  issue_year<2003 & issue_year>=1947, control(  myclass1-myclass129) absorb(groupFY) linetype(none) nq(25) xtitle("Patent Importance, 0-10 years") ytitle("Forward Citations, 0-10 years")
graph export ".\figures\Quality_Vs_cites_010.eps", as(eps) preview(off) replace
binscatter  fcit05W rfsim05W  if  issue_year<2008 & issue_year>=1947, control(  myclass1-myclass129) absorb(groupFY) linetype(none)  nq(25) xtitle("Patent Importance, 0-5 years") ytitle("Forward Citations, 0-5 years")
graph export ".\figures\Quality_Vs_cites_05.eps", as(eps) preview(off) replace
binscatter  fcit01W rfsim01W  if  issue_year<2013 & issue_year>=1947, control(  myclass1-myclass129) absorb(groupFY) linetype(none)  nq(25) xtitle("Patent Importance, 0-1 years") ytitle("Forward Citations, 0-1 years")
graph export ".\figures\Quality_Vs_cites_01.eps", as(eps) preview(off) replace



binscatter  fcit2AW  rfsim01W if  issue_year<2013  & issue_year>=1947, control(fcit01  myclass1-myclass129) absorb(groupFY) linetype(none)  nq(25) xtitle("Patent Importance, 0-1 years") ytitle("Forward Citations, 2+ years")
graph export ".\figures\Quality_Vs_cites_01_2plus.eps", as(eps) preview(off) replace
binscatter  fcit6AW  rfsim05W  if  issue_year<2008 & issue_year>=1947, control(fcit05W  myclass1-myclass129) absorb(groupFY)linetype(none)   nq(25) xtitle("Patent Importance, 0-5 years") ytitle("Forward Citations, 6+ years")
graph export ".\figures\Quality_Vs_cites_05_6plus.eps", as(eps) preview(off) replace
binscatter  fcit11AW  rfsim010W   if  issue_year<2003 & issue_year>=1947, control(fcit05W  myclass1-myclass129) absorb(groupFY) linetype(none)  nq(25) xtitle("Patent Importance, 0-10 years") ytitle("Forward Citations, 11+ years")
graph export ".\figures\Quality_Vs_cites_10_11plus.eps", as(eps) preview(off) replace



