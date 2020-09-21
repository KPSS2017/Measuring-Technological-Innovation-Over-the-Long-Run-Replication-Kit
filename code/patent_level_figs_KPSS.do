cd "E:\ReplicationCode"

clear
discard

use "intermediate_data\MergedPatentData.dta"


ssc install binscatter
 
*drop if total_max >950

  



 

egen groupPY = group(issue_year permco)


* regressions: KPSS
replace lkpssW=. if multiple>0
drop if missing(lkpssW)

gen rfsim010W=exp(lrrfsim010W)
gen rfsim05W=exp(lrrfsim05W)
gen rfsim01W=exp(lrrfsim01W)
gen kpssW=exp(lkpssW) 





binscatter  kpssW rfsim010W  if  issue_year<2003 , control(myclass1-myclass129) absorb(groupPY) linetype(none)  nq(25) xtitle("Patent Importance, 0-10 years") ytitle("KPSS value, USDm")
graph export ".\figures\Quality_Vs_kpss_010.eps", as(eps) preview(off) replace
binscatter  kpssW rfsim05W  if  issue_year<2008 , control(myclass1-myclass129) absorb(groupPY) linetype(none)  nq(25) xtitle("Patent Importance, 0-5 years") ytitle("KPSS value, USDm")
graph export ".\figures\Quality_Vs_kpss_05.eps", as(eps) preview(off) replace
binscatter  kpssW rfsim01W  if  issue_year<2013 , control(myclass1-myclass129) absorb(groupPY) linetype(none)   nq(25) xtitle("Patent Importance, 0-1 years") ytitle("KPSS value, USDm")
graph export ".\figures\Quality_Vs_kpss_01.eps", as(eps) preview(off) replace





 