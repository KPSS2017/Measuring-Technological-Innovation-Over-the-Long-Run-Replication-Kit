clear
cd "E:\ReplicationCode"


 
use "intermediate_data\Breakthrough_Patents.dta", clear
  
 

merge 1:1 wku using "input_data\PatentChar.dta"
drop if _merge==1
drop if _merge==2

drop _merge
 
 
merge 1:m wku using "input_data\full_CPC_class.dta"
keep if _merge==3
drop _merge

gen cpc4=substr(CPC,1,4)

duplicates drop wku cpc4, force

egen num_cpc4=count(cpc4), by(wku)

 
joinby cpc4 using  "other_data\Cross-walks\CPC_2_1997NAICS5.dta"
 
gen wnpats   = probability_weight / num_cpc4

 
 
gen wbreak_p95_rrfsim010  = break_p95_rrfsim010  * probability_weight / num_cpc4
gen wbreak_p95_rlfcit010  = break_p95_rlfcit010  * probability_weight / num_cpc4
gen wbreak_p95_rrfsim05   = break_p95_rrfsim05  * probability_weight / num_cpc4
gen wbreak_p95_rlfcit05   = break_p95_rlfcit05  * probability_weight / num_cpc4

gen wbreak_p90_rrfsim010  = break_p90_rrfsim010  * probability_weight / num_cpc4
gen wbreak_p90_rlfcit010  = break_p90_rlfcit010  * probability_weight / num_cpc4
gen wbreak_p90_rrfsim05   = break_p90_rrfsim05  * probability_weight / num_cpc4
gen wbreak_p90_rlfcit05   = break_p90_rlfcit05  * probability_weight / num_cpc4

gen wbreak_p80_rrfsim010  = break_p80_rrfsim010  * probability_weight / num_cpc4
gen wbreak_p80_rlfcit010  = break_p80_rlfcit010  * probability_weight / num_cpc4
gen wbreak_p80_rrfsim05   = break_p80_rrfsim05  * probability_weight / num_cpc4
gen wbreak_p80_rlfcit05   = break_p80_rlfcit05  * probability_weight / num_cpc4

 

gen wbreak_p95_rlfcitALL  = break_p95_rlfcitALL  * probability_weight / num_cpc4
gen wbreak_p90_rlfcitALL  = break_p90_rlfcitALL  * probability_weight / num_cpc4
gen wbreak_p80_rlfcitALL  = break_p80_rlfcitALL  * probability_weight / num_cpc4


ren issue_year year

collapse (sum) wbreak* wnpats, by(naics97_5  year)

replace wbreak_p95_rrfsim010=. if year>2002
replace wbreak_p90_rrfsim010=. if year>2002
replace wbreak_p80_rrfsim010=. if year>2002

replace wbreak_p95_rrfsim05= . if year>2007
replace wbreak_p90_rrfsim05= . if year>2007
replace wbreak_p80_rrfsim05= . if year>2007

 


save "intermediate_data\naics1997_5_indices.dta", replace



 
 






 
