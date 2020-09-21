

clear
clear all
ssc install ivreg2
ssc install ranktest

cd "E:\ReplicationCode"

use "intermediate_data\Agg_Indices.dta"


merge 1:1 year using "other_data\USpop.dta"
drop _merge


merge 1:1 year using "other_data\KPSS_timeseries.dta", keepusing(AA1 AA2) 
drop _merge

merge 1:1 year using  "other_data\kendrick_productivity.dta"
drop _merge

merge 1:1 year using "other_data\basu_tfp.dta"
drop _merge


gen IndexSim10  =  log(break_p90_rrfsim010 / pop  *1000*1000)


drop if year<1840
drop if missing(year)

gen Npats_pc = npats / pop
gen logNpats_pc = log(npats / pop)

tsset year
sort year
replace IndexSim10=. if year>2002

 
replace dtfp=0 if missing(dtfp)
 

gen logTFPa = log(ylinput)

sort year
gen logTFP = dtfp/100
replace logTFP=logTFP[_n-1] + dtfp/100 if _n>1
 
replace logTFP=. if logTFP==0
 
egen slogIndexSim10=std(IndexSim10)

qui: eststo m3r: ivreg2 L3.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(4) robust  
qui: eststo m2r: ivreg2 L2.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(3) robust  
qui: eststo m1r: ivreg2 L1.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(2) robust  
qui: eststo a1r: ivreg2 F1.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(2) robust  
qui: eststo a2r: ivreg2 F2.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(3) robust  
qui: eststo a3r: ivreg2 F3.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(4) robust  
qui: eststo a4r: ivreg2 F4.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(5) robust  
qui: eststo a5r: ivreg2 F5.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(6) robust  
qui: eststo a6r: ivreg2 F6.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(7) robust  
qui: eststo a7r: ivreg2 F7.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(8) robust  
qui: eststo a8r: ivreg2 F8.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(9) robust  
qui: eststo a9r: ivreg2 F9.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(10) robust  
qui: eststo a10r: ivreg2 F10.logTFP logTFP   slogIndexSim10 logNpats_pc , bw(11) robust  

esttab m3r m2r m1r a1r a2r a3r a4r a5r  a6r a7r a8r a9r a10r, keep(slogIndexSim10) compress  


esttab m3r m2r m1r a1r a2r a3r a4r a5r a6r a7r a8r a9r a10r using ".\figures\AggTFP_NW_New_v201907.csv" , keep(slogIndexSim10) csv nostar r2 b(4) se(4) plain compress replace

  
qui: eststo m3r: ivreg2 L3.logTFPa logTFPa   slogIndexSim10 logNpats_pc , bw(4) robust  
qui: eststo m2r: ivreg2 L2.logTFPa logTFPa   slogIndexSim10 logNpats_pc , bw(3) robust  
qui: eststo m1r: ivreg2 L1.logTFPa logTFPa   slogIndexSim10 logNpats_pc , bw(2) robust  
qui: eststo a1r: ivreg2 F1.logTFPa logTFPa   slogIndexSim10 logNpats_pc , bw(2) robust  
qui: eststo a2r: ivreg2 F2.logTFPa logTFPa   slogIndexSim10 logNpats_pc , bw(3) robust  
qui: eststo a3r: ivreg2 F3.logTFPa logTFPa   slogIndexSim10 logNpats_pc , bw(4) robust  
qui: eststo a4r: ivreg2 F4.logTFPa logTFPa   slogIndexSim10 logNpats_pc , bw(5) robust  
qui: eststo a5r: ivreg2 F5.logTFPa logTFPa   slogIndexSim10 logNpats_pc , bw(6) robust  
qui: eststo a6r: ivreg2 F6.logTFPa logTFPa   slogIndexSim10 logNpats_pc , bw(7) robust  
qui: eststo a7r: ivreg2 F7.logTFPa logTFPa   slogIndexSim10 logNpats_pc , bw(8) robust  
qui: eststo a8r: ivreg2 F8.logTFPa logTFPa   slogIndexSim10 logNpats_pc , bw(9) robust  
qui: eststo a9r: ivreg2 F9.logTFPa logTFPa   slogIndexSim10 logNpats_pc , bw(10) robust  
qui: eststo a10r: ivreg2 F10.logTFPa logTFPa  slogIndexSim10 logNpats_pc , bw(11) robust  

esttab m3r m2r m1r a1r a2r a3r a4r a5r  a6r a7r a8r a9r a10r, keep(slogIndexSim10) compress  


esttab m3r m2r m1r a1r a2r a3r a4r a5r a6r a7r a8r a9r a10r using ".\figures\AggTFP_NW_Old_v201907.csv" , keep(slogIndexSim10)  csv nostar r2 b(4) se(4) plain compress replace


 
 







