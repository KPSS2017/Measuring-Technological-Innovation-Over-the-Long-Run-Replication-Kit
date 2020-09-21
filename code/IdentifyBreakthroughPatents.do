clear

cd "E:\ReplicationCode"


use  "input_data\PatentSimilarity.dta"
 

merge 1:1 wku using  "input_data\PatentChar.dta"
keep if _merge==3
drop _merge

merge 1:1 wku using "input_data\PatentCitations.dta"
drop _merge 

 

replace fcit01 =0 if missing(fcit01)
replace fcit25 =0 if missing(fcit25)
replace fcit610=0 if missing(fcit610)
replace fcit1120=0 if missing(fcit1120)
replace fcitALL=0 if missing(fcitALL)

duplicates drop wku  , force


gen rfsim01  = log((fsim01 )/bsim5)
gen rfsim05  = log((fsim01+fsim25 )/bsim5)
gen rfsim010 = log((fsim01+fsim25+fsim610)/bsim5)
gen rfsim020 = log((fsim01+fsim25+fsim610 +fsim1120)/bsim5)

gen lfcit01  = log(1+fcit01)
gen lfcit05  = log(1+fcit01+fcit25)
gen lfcit010 = log(1+fcit01+fcit25+fcit610)
gen lfcit020 = log(1+fcit01+fcit25+fcit610 +fcit1120)

gen lfcitALL = log(1+fcitALL)

replace rfsim01 = . if issue_year>2012
replace lfcit01 = . if issue_year>2012

replace rfsim05 = . if issue_year>2007
replace lfcit05 = . if issue_year>2007

replace rfsim010 = . if issue_year>2002
replace lfcit010 = . if issue_year>2002

replace rfsim020 = . if issue_year>1992
replace lfcit020 = . if issue_year>1992


drop if issue_year>2010


areg rfsim01, absorb(issue_year)
predict rrfsim01,r
areg rfsim05, absorb(issue_year)
predict rrfsim05,r
areg rfsim010, absorb(issue_year)
predict rrfsim010,r
areg rfsim020, absorb(issue_year)
predict rrfsim020,r


areg lfcit020, absorb(issue_year)
predict rlfcit020,r
areg lfcit010, absorb(issue_year)
predict rlfcit010,r
areg lfcit05 , absorb(issue_year)
predict rlfcit05,r
areg lfcit01 , absorb(issue_year)
predict rlfcit01,r
areg lfcitALL, absorb(issue_year)
predict rlfcitALL,r
 
local c=95
egen p`c'_rrfsim01 =pctile(rrfsim01 ), p(`c')   
egen p`c'_rrfsim05 =pctile(rrfsim05 ), p(`c')   
egen p`c'_rrfsim010=pctile(rrfsim010), p(`c')   
egen p`c'_rlfcit010=pctile(rlfcit010), p(`c')   
egen p`c'_rlfcit05 =pctile(rlfcit05 ), p(`c')   
egen p`c'_rlfcit01 =pctile(rlfcit01 ), p(`c')   
egen p`c'_rlfcitALL=pctile(rlfcitALL), p(`c')   
egen p`c'_rrfsim020=pctile(rrfsim020), p(`c')   
egen p`c'_rlfcit020=pctile(rlfcit020), p(`c')  

gen break_p`c'_rrfsim01=0
gen break_p`c'_rrfsim05=0
gen break_p`c'_rrfsim010=0
gen break_p`c'_rlfcit010=0
gen break_p`c'_rlfcit05 =0
gen break_p`c'_rlfcit01 =0
gen break_p`c'_rlfcitALL=0
gen break_p`c'_rrfsim020=0
gen break_p`c'_rlfcit020=0

replace break_p`c'_rrfsim01 =1 if rrfsim01 >=p`c'_rrfsim01  & !missing(rrfsim01)
replace break_p`c'_rrfsim05 =1 if rrfsim05 >=p`c'_rrfsim05  & !missing(rrfsim05)
replace break_p`c'_rrfsim010=1 if rrfsim010>=p`c'_rrfsim010 & !missing(rrfsim010)
replace break_p`c'_rrfsim020=1 if rrfsim020>=p`c'_rrfsim020 & !missing(rrfsim020)

replace break_p`c'_rlfcit01 =1 if rlfcit01 >=p`c'_rlfcit01  & !missing(rlfcit01 )
replace break_p`c'_rlfcit05 =1 if rlfcit05 >=p`c'_rlfcit05  & !missing(rlfcit05 )
replace break_p`c'_rlfcit010=1 if rlfcit010>=p`c'_rlfcit010 & !missing(rlfcit010)
replace break_p`c'_rlfcit020=1 if rlfcit020>=p`c'_rlfcit020 & !missing(rlfcit020)

replace break_p`c'_rlfcitALL=1 if rlfcitALL>=p`c'_rlfcitALL & !missing(rlfcitALL)


local c=90
egen p`c'_rrfsim01 =pctile(rrfsim01 ), p(`c')   
egen p`c'_rrfsim05 =pctile(rrfsim05 ), p(`c')   
egen p`c'_rrfsim010=pctile(rrfsim010), p(`c')   
egen p`c'_rlfcit010=pctile(rlfcit010), p(`c')   
egen p`c'_rlfcit05 =pctile(rlfcit05 ), p(`c')   
egen p`c'_rlfcit01 =pctile(rlfcit01 ), p(`c')   
egen p`c'_rlfcitALL=pctile(rlfcitALL), p(`c')   
egen p`c'_rrfsim020=pctile(rrfsim020), p(`c')   
egen p`c'_rlfcit020=pctile(rlfcit020), p(`c')  

gen break_p`c'_rrfsim01=0
gen break_p`c'_rrfsim05=0
gen break_p`c'_rrfsim010=0
gen break_p`c'_rlfcit010=0
gen break_p`c'_rlfcit05 =0
gen break_p`c'_rlfcit01 =0
gen break_p`c'_rlfcitALL=0
gen break_p`c'_rrfsim020=0
gen break_p`c'_rlfcit020=0

replace break_p`c'_rrfsim01 =1 if rrfsim01 >=p`c'_rrfsim01  & !missing(rrfsim01)
replace break_p`c'_rrfsim05 =1 if rrfsim05 >=p`c'_rrfsim05  & !missing(rrfsim05)
replace break_p`c'_rrfsim010=1 if rrfsim010>=p`c'_rrfsim010 & !missing(rrfsim010)
replace break_p`c'_rrfsim020=1 if rrfsim020>=p`c'_rrfsim020 & !missing(rrfsim020)

replace break_p`c'_rlfcit01 =1 if rlfcit01 >=p`c'_rlfcit01  & !missing(rlfcit01 )
replace break_p`c'_rlfcit05 =1 if rlfcit05 >=p`c'_rlfcit05  & !missing(rlfcit05 )
replace break_p`c'_rlfcit010=1 if rlfcit010>=p`c'_rlfcit010 & !missing(rlfcit010)
replace break_p`c'_rlfcit020=1 if rlfcit020>=p`c'_rlfcit020 & !missing(rlfcit020)

replace break_p`c'_rlfcitALL=1 if rlfcitALL>=p`c'_rlfcitALL & !missing(rlfcitALL)


local c=80
egen p`c'_rrfsim01 =pctile(rrfsim01 ), p(`c')   
egen p`c'_rrfsim05 =pctile(rrfsim05 ), p(`c')   
egen p`c'_rrfsim010=pctile(rrfsim010), p(`c')   
egen p`c'_rlfcit010=pctile(rlfcit010), p(`c')   
egen p`c'_rlfcit05 =pctile(rlfcit05 ), p(`c')   
egen p`c'_rlfcit01 =pctile(rlfcit01 ), p(`c')   
egen p`c'_rlfcitALL=pctile(rlfcitALL), p(`c')   
egen p`c'_rrfsim020=pctile(rrfsim020), p(`c')   
egen p`c'_rlfcit020=pctile(rlfcit020), p(`c')  

gen break_p`c'_rrfsim01=0
gen break_p`c'_rrfsim05=0
gen break_p`c'_rrfsim010=0
gen break_p`c'_rlfcit010=0
gen break_p`c'_rlfcit05 =0
gen break_p`c'_rlfcit01 =0
gen break_p`c'_rlfcitALL=0
gen break_p`c'_rrfsim020=0
gen break_p`c'_rlfcit020=0

replace break_p`c'_rrfsim01 =1 if rrfsim01 >=p`c'_rrfsim01  & !missing(rrfsim01)
replace break_p`c'_rrfsim05 =1 if rrfsim05 >=p`c'_rrfsim05  & !missing(rrfsim05)
replace break_p`c'_rrfsim010=1 if rrfsim010>=p`c'_rrfsim010 & !missing(rrfsim010)
replace break_p`c'_rrfsim020=1 if rrfsim020>=p`c'_rrfsim020 & !missing(rrfsim020)

replace break_p`c'_rlfcit01 =1 if rlfcit01 >=p`c'_rlfcit01  & !missing(rlfcit01 )
replace break_p`c'_rlfcit05 =1 if rlfcit05 >=p`c'_rlfcit05  & !missing(rlfcit05 )
replace break_p`c'_rlfcit010=1 if rlfcit010>=p`c'_rlfcit010 & !missing(rlfcit010)
replace break_p`c'_rlfcit020=1 if rlfcit020>=p`c'_rlfcit020 & !missing(rlfcit020)

replace break_p`c'_rlfcitALL=1 if rlfcitALL>=p`c'_rlfcitALL & !missing(rlfcitALL)

 
egen rank_rrfsim05=rank(rrfsim05), field
egen mrank_rrfsim05=max(rank_rrfsim05)
replace rank_rrfsim05 = 1-rank_rrfsim05/mrank_rrfsim05

egen    rank_rrfsim010  = rank(rrfsim010), field
egen   mrank_rrfsim010  = max(rank_rrfsim010)
replace rank_rrfsim010 = 1-rank_rrfsim010/mrank_rrfsim010

egen    rank_rrfsim01  = rank(rrfsim01), field
egen   mrank_rrfsim01  = max(rank_rrfsim01)
replace rank_rrfsim01 = 1-rank_rrfsim01/mrank_rrfsim01
 
egen rank_rlfcit05=rank(rlfcit05), field
egen mrank_rlfcit05=max(rank_rlfcit05)
replace rank_rlfcit05 = 1-rank_rlfcit05/mrank_rlfcit05
 
egen rank_rlfcit010=rank(rlfcit010), field
egen mrank_rlfcit010=max(rank_rlfcit010)
replace rank_rlfcit010 = 1-rank_rlfcit010/mrank_rlfcit010

egen rank_fcitA=rank(rlfcitALL), field
egen mrank_fcitA=max(rank_fcitA)
replace rank_fcitA =1- rank_fcitA/mrank_fcitA
 
keep wku  rfsim0* lfcit* break*   rank* issue_year filed_year rrfsim* rlfcit* p??_rrfsim* p??_rlfcit*

save "intermediate_data\Breakthrough_Patents.dta", replace
