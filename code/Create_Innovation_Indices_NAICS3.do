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


joinby cpc4 using  "other_data\Cross-walks\CPC_2_NAICS3.dta"

 
gen wnpats   = probability_weight / num_cpc4
 
gen wbreak_p90_rrfsim010  = break_p90_rrfsim010  * probability_weight / num_cpc4
gen wbreak_p90_rlfcit010  = break_p90_rlfcit010  * probability_weight / num_cpc4


 
collapse (sum) wbreak_p90_rrfsim010 wnpats wbreak_p90_rlfcit010  , by(naicsuscode naicsustitle issue_year)

 
encode naicsustitle , gen(ind)


ren issue_year year

tsset ind year



save "intermediate_data\naics_3_indices.dta", replace


 






 
