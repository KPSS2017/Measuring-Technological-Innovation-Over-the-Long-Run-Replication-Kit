clear

cd "E:\ReplicationCode"

use "intermediate_data\Breakthrough_Patents.dta"
 

ren wku npats 
ren issue_year year
 
collapse (sum) break* (count) npats , by(year)



save "intermediate_data\Agg_Indices.dta", replace
 
 
drop if year<1840

clear
clear all

use "intermediate_data\Agg_Indices.dta"

merge 1:1 year using "other_data\USpop.dta"
keep if _merge==3
drop _merge

 

merge 1:1 year using "other_data\KPSS_timeseries.dta", keepusing(AA1 AA2) 
drop _merge


tsset year


* Our indices


gen Breakthrough_pc     = break_p90_rrfsim010 / pop  *1000 *1000

gen Breakthrough_cites10_pc = break_p90_rlfcit010 / pop *1000 *1000

gen Breakthrough_citesA_pc = break_p90_rlfcitALL / pop *1000 *1000

gen kpss = exp(AA2)


gen npats_pc = npats / pop
 
 
replace Breakthrough_cites10_pc=. if year>2002 
replace Breakthrough_pc=. if year>2002 
 

tsline Breakthrough_pc, name(Breakthrough_pc, replace)
tsline Breakthrough_cites10_pc, name(Breakthrough_cites10_pc, replace)
tsline npats_pc, name(npats_pc, replace)
tsline kpss, name(kpss, replace)



keep  year  Breakthrough_pc Breakthrough_cites10_pc   npats_pc   kpss Breakthrough_citesA_pc 
order year  Breakthrough_pc Breakthrough_cites10_pc   npats_pc   kpss Breakthrough_citesA_pc 

export delimited using "Figures\time_series_measures_compare.csv", replace

 
