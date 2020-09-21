set more off
clear all
cd "E:\ReplicationCode"
*##############################Load Data############################*

use "./intermediate_data/Breakthrough_Patents.dta", clear

 
merge 1:1 wku using "./input_data/Patent2CPCdummy2.dta"
drop if _merge==1
drop if _merge==2
drop _merge

merge 1:1 wku using "./input_data/PatentChar.dta"
drop if _merge==1
drop if _merge==2
drop _merge


 
gen class=""
replace class="AGRICULTURE/FOOD (A0, A2)" if CPC_1==1
replace class="AGRICULTURE/FOOD (A0, A2)" if CPC_2==1
replace class="CONSUMER GOODS (A4)" if CPC_3==1
replace class="HEALTH AND ENTERTAINMENT (A6)" if CPC_4==1
replace class="MANUFACTURING PROCESS (B0, B2, B3, B4, B8, D0, D1, D2)" if CPC_5==1
replace class="MANUFACTURING PROCESS (B0, B2, B3, B4, B8, D0, D1, D2)" if CPC_6==1
replace class="MANUFACTURING PROCESS (B0, B2, B3, B4, B8, D0, D1, D2)" if CPC_7==1
replace class="MANUFACTURING PROCESS (B0, B2, B3, B4, B8, D0, D1, D2)" if CPC_8==1
replace class="TRANSPORTATION (B6)" if CPC_9==1
replace class="MANUFACTURING PROCESS (B0, B2, B3, B4, B8, D0, D1, D2)" if CPC_10==1
replace class="CHEMISTRY AND METALLURGY (C)"   if CPC_11==1
replace class="CHEMISTRY AND METALLURGY (C)"   if CPC_12==1
replace class="CHEMISTRY AND METALLURGY (C)"   if CPC_13==1
*replace class="CRYSTAL"     if CPC_14==1
replace class="CHEMISTRY AND METALLURGY (C)"   if CPC_15==1
*replace class="" if CPC_16==1
replace class="MANUFACTURING PROCESS (B0, B2, B3, B4, B8, D0, D1, D2)" if CPC_17==1
replace class="MANUFACTURING PROCESS (B0, B2, B3, B4, B8, D0, D1, D2)" if CPC_18==1
replace class="MANUFACTURING PROCESS (B0, B2, B3, B4, B8, D0, D1, D2)" if CPC_19==1
replace class="ENGINEERING, CONSTRUCTION AND MINING (E0, E2, F0, F1)" if CPC_20==1
replace class="ENGINEERING, CONSTRUCTION AND MINING (E0, E2, F0, F1)" if CPC_21==1
replace class="ENGINEERING, CONSTRUCTION AND MINING (E0, E2, F0, F1)"   if CPC_22==1
replace class="ENGINEERING, CONSTRUCTION AND MINING (E0, E2, F0, F1)" if CPC_23==1
replace class="LIGHTING, HEATING, NUCLEAR (F2, G2)" if CPC_24==1
replace class="WEAPONS (F4)" if CPC_25==1
replace class="INSTRUMENTS, INFORMATION  (G, Y1)" if CPC_26==1
replace class="INSTRUMENTS, INFORMATION  (G, Y1)" if CPC_27==1
replace class="LIGHTING, HEATING, NUCLEAR (F2, G2)"     if CPC_28==1
*replace class="" if CPC_29==1
replace class="ELECTRICITY AND ELECTRONICS (H0)" if CPC_30==1
replace class="INSTRUMENTS, INFORMATION  (G, Y1)" if CPC_31==1
*replace class="AGRICULTURE" if CPC_32==1

tab class

preserve

keep if break_p90_rrfsim010==1

encode class, gen(class1)

tab class1

drop if missing(class1)

gen dec=floor(issue_year /10)*10

egen twku = count(wku), by(dec)

egen nwku = count(wku), by(dec class1)

collapse (mean) twku nwku, by(dec class1)
 
gen wku=nwku/twku

drop if dec==1830 | dec==2010

keep wku dec class1

reshape wide wku, i(dec) j(class1)

export delimited using "E:\ReplicationCode\figures\Fig_TechInnovationLR.csv", replace

restore

encode class, gen(class1)

tab class1

drop if missing(class1)

gen dec=floor(issue_year /10)*10

egen twku = count(wku), by(dec)

egen nwku = count(wku), by(dec class1)

collapse (mean) twku nwku, by(dec class1)

gen wku=nwku/twku

drop if dec==1830 | dec==2010

keep wku dec class1

reshape wide wku, i(dec) j(class1)

export delimited using "E:\ReplicationCode\figures\Fig_TechNpatsLR.csv", replace






