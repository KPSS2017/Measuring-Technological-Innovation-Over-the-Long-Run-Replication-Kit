set more off
clear all
cd "E:\ReplicationCode"

use "./input_data/PatentChar.dta"

 
* similarity impact file
merge 1:1 wku using "./input_data/PatentSimilarity.dta"
drop _merge
merge 1:1 wku using "./other_data/HistoricalPatents.dta"
drop _merge
merge 1:1 wku using "./input_data/PatentCitations.dta"
drop _merge
merge 1:1 wku using  "./intermediate_data/Breakthrough_Patents.dta"
drop _merge
 
replace fcitALL = 0 if missing(fcitALL)
replace fcit01 = 0 if missing(fcit01)
replace fcit25 = 0 if missing(fcit25)
replace fcit610 = 0 if missing(fcit610)
replace fcit1120 = 0 if missing(fcit1120)

gen lrfsim01 = log((fsim01)/bsim5)
gen lrfsim05 = log((fsim01+fsim25)/bsim5)
gen lrfsim010 = log((fsim01+fsim25+fsim610)/bsim5)

replace lfcit05 = log(1+fcit01+fcit25)
replace lfcit010 = log(1+fcit01+fcit25+fcit610)
replace lfcitALL = log(1+fcitALL)


 
gen year=issue_year

drop if year>2012

replace lrfsim010=. if year>2002
replace lrfsim05=.  if year>2007
replace lfcit05=.  if year>2007
replace lfcit010=. if year>2002

 
egen urank_lrfsim01=rank(lrfsim01), field
egen mrank_lrfsim01=max(urank_lrfsim01)
replace urank_lrfsim01 = 1-urank_lrfsim01/mrank_lrfsim01

 
egen urank_lrfsim05=rank(lrfsim05), field 
egen mrank_lrfsim05=max(urank_lrfsim05)
replace urank_lrfsim05 = 1-urank_lrfsim05/mrank_lrfsim05

egen urank_lrfsim010=rank(lrfsim010), field
egen mrank_lrfsim010=max(urank_lrfsim010)
replace urank_lrfsim010 = 1-urank_lrfsim010/mrank_lrfsim010

egen urank_lfcit05=rank(lfcit05), field
egen mrank_lfcit05=max(urank_lfcit05)
replace urank_lfcit05 = 1-urank_lfcit05/mrank_lfcit05
 
egen urank_lfcit010=rank(lfcit010), field
egen mrank_lfcit010=max(urank_lfcit010)
replace urank_lfcit010 = 1-urank_lfcit010/mrank_lfcit010

egen urank_fcitA=rank(lfcitALL), field
egen mrank_fcitA=max(urank_fcitA)
replace urank_fcitA =1- urank_fcitA/mrank_fcitA
  
drop mrank*

egen crank_lrfsim01=rank(lrfsim01), field by(year)
egen mrank_lrfsim01=max(crank_lrfsim01), by(year)
replace crank_lrfsim01 = 1-crank_lrfsim01/mrank_lrfsim01


egen crank_lrfsim05=rank(lrfsim05), field by(year)
egen mrank_lrfsim05=max(crank_lrfsim05), by(year)
replace crank_lrfsim05 = 1-crank_lrfsim05/mrank_lrfsim05

egen crank_lrfsim010=rank(lrfsim010), field by(year)
egen mrank_lrfsim010=max(crank_lrfsim010), by(year)
replace crank_lrfsim010 = 1-crank_lrfsim010/mrank_lrfsim010

egen crank_lfcit05=rank(lfcit05), field by(year)
egen mrank_lfcit05=max(crank_lfcit05), by(year)
replace crank_lfcit05 = 1-crank_lfcit05/mrank_lfcit05
 
egen crank_lfcit010=rank(lfcit010), field by(year)
egen mrank_lfcit010=max(crank_lfcit010), by(year)
replace crank_lfcit010 = 1-crank_lfcit010/mrank_lfcit010

egen crank_fcitA=rank(lfcitALL), field by(year)
egen mrank_fcitA=max(crank_fcitA), by(year)
replace crank_fcitA =1- crank_fcitA/mrank_fcitA
 
drop if issue_year<1840
drop if issue_year>2007

keep if important==1

keep urank_lrfsim05 rank_rrfsim05 urank_lrfsim010 rank_rrfsim010 urank_lfcit05 rank_rlfcit05 urank_lfcit010 rank_rlfcit010 urank_fcitA rank_fcitA crank* issue_year wku fcitALL
duplicates drop wku , force



export delimited using "E:\ReplicationCode\intermediate_data\important_patents_list.csv", replace

drop wku fcitALL

order urank_lrfsim05 rank_rrfsim05 urank_lrfsim010 rank_rrfsim010 urank_lfcit05 rank_rlfcit05 urank_lfcit010 rank_rlfcit010 urank_fcitA rank_fcitA crank_lrfsim05 crank_lrfsim010 crank_lfcit05 crank_lfcit010 crank_fcitA issue_year
 
export delimited using "E:\ReplicationCode\intermediate_data\important_patents.csv", replace

 
