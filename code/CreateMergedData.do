set more off
clear

 
cd "E:\ReplicationCode"

use "input_data\PatentDatesClasses.dta"

merge 1:1 wku using  "input_data\PatentChar.dta"
keep if _merge==3
drop _merge


merge 1:1 wku using "input_data\PatentCitations.dta"
drop _merge


merge 1:1 wku using "input_data\PatentSimilarity"
drop _merge

merge 1:m wku using "input_data\KPSS.dta"
drop if _merge==2
drop _merge

duplicates drop wku, force

gen patnum = wku
merge 1:m patnum using "input_data\Assignees.dta"
drop if _merge==2
drop _merge
gen firm_id=FIRMID


duplicates tag wku, gen(multiple)

replace fcit01 =0 if missing(fcit01)
replace fcit25 =0 if missing(fcit25)
replace fcit610=0 if missing(fcit610)
replace fcit1120=0 if missing(fcit1120)
replace fcitALL=0 if missing(fcitALL)


gen lrfsim01 = log(fsim01)
gen lrfsim05 = log(fsim01+fsim25)
gen lrfsim010 = log(fsim01+fsim25+fsim610) 
gen lrfsim020 = log(fsim01+fsim25+fsim610+fsim1120) 
gen lbsim5=log(bsim5)

gen lrrfsim01 = log(fsim01)-lbsim5
gen lrrfsim05 = log(fsim01+fsim25)-lbsim5
gen lrrfsim010 = log(fsim01+fsim25+fsim610) -lbsim5


gen lfcit01 = log(1+fcit01)
gen lfcit05 = log(1+fcit01+fcit25)
gen lfcit010 = log(1+fcit01+fcit25+fcit610)
gen lfcit020 = log(1+fcit01+fcit25+fcit610+fcit1120)

gen lkpss = log(_1982adjval)

gen lfcitALL = log(1+fcitALL)

 
winsorizeJ lkpss lfcit* lrfsim* lrrfsim*  lbsim*  lmkcap , cuts(1 99) by(issue_year)

 

save "intermediate_data\MergedPatentData.dta", replace

 




 
 
