
cd "E:\ReplicationCode"


use "other_data\series_id.dta", clear

 
keep if measure_code=="M00"
 
keep if type_code =="I"
gen ind = substr(industry_code ,2,5)
gen indX = substr(ind,5,1)
keep if indX=="_"
drop indX
gen indX = substr(ind,4,1)
drop if indX=="_"
drop indX
replace ind = substr(ind,1,4)

keep series_id ind


merge 1:m series_id using "other_data\series_data.dta"
keep if _merge==3
drop _merge
 
destring ind, gen(naicsuscode) force
drop ind
drop if missing(naicsuscode)

merge 1:1 naicsuscode year using "intermediate_data\naics_4_indices.dta"
drop _merge

merge m:1 year using "other_data\USpop.dta"
drop if _merge==2

*egen   mean_pats = mean(wnpats), by(ind)

gen wnpats_pc           = wnpats / pop * 1000 * 1000
gen wqual5_pc           = wbreak_p90_rrfsim05/pop* 1000 * 1000
gen wqual5_pcC 		    = wbreak_p90_rlfcit05/pop* 1000 * 1000
gen wqual10_pc          = wbreak_p90_rrfsim010/pop* 1000 * 1000
gen wqual10_pcC 		= wbreak_p90_rlfcit010/pop* 1000 * 1000

 

tsset naicsuscode year
gen ind = naicsuscode
gen logX = log(value)

gen L5q5 =   log(wqual5_pc)
gen L5c5 =   log(wqual5_pcC)
gen L5q10 =   log(wqual10_pc)
gen L5c10 =   log(wqual10_pcC)
gen L5n = log(wnpats_pc)

gen AL5q =  log(wqual10_pc + F.wqual10_pc + F2.wqual10_pc + L.wqual10_pc + L2.wqual10_pc)
gen AL5n = log(wqual10_pc + F.wqual10_pc + F2.wqual10_pc + L.wqual10_pc + L2.wqual10_pc)

* drop agriculture
gen fi=floor(naicsuscode /1000)
drop if fi>3
 

tab year if !missing(logX)
 
drop if missing(logX)

 

sum L5q10
 
egen sL5q10=std(L5q10)
egen sL5c10=std(L5c10)

egen sL5q5=std(L5q5)
egen sL5c5=std(L5c5)

egen sL5n=std(L5n)

 

gen D1logX=F1.logX-logX
gen D2logX=F2.logX-logX
gen D3logX=F3.logX-logX
gen D4logX=F4.logX-logX
gen D5logX=F5.logX-logX
gen D10logX=F10.logX-logX

gen L1logX=L1.logX-logX
gen L2logX=L2.logX-logX
gen L3logX=L3.logX-logX 




* control for Number of patents
qui: eststo m1: reghdfe    L1logX logX sL5q10 L5n, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo m2: reghdfe    L2logX logX sL5q10 L5n, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo m3: reghdfe    L3logX logX sL5q10 L5n, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo r1: reghdfe    D1logX logX sL5q10 L5n, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo r2: reghdfe    D2logX logX sL5q10 L5n, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo r3: reghdfe    D3logX logX sL5q10 L5n, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo r4: reghdfe    D4logX logX sL5q10 L5n, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo r5: reghdfe    D5logX logX sL5q10 L5n, absorb(year naicsuscode) cluster(naicsuscode)  
esttab  m3 m2 m1 r1 r2 r3 r4 r5, booktabs star (* 0.1 ** 0.05 *** 0.01 ) r2 b(4) t(2) plain compress
esttab m3 m2 m1 r1 r2 r3 r4 r5 using "figures\ind_tfp_naics4.csv" , csv nostar r2 b(4) se(4) plain compress replace



* compare to Citations
qui: eststo m1: reghdfe    L1logX logX   L5n sL5c10, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo m2: reghdfe    L2logX logX   L5n sL5c10, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo m3: reghdfe    L3logX logX   L5n sL5c10, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo r1: reghdfe    D1logX logX   L5n sL5c10, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo r2: reghdfe    D2logX logX   L5n sL5c10, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo r3: reghdfe    D3logX logX   L5n sL5c10, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo r4: reghdfe    D4logX logX   L5n sL5c10, absorb(year naicsuscode) cluster(naicsuscode)  
qui: eststo r5: reghdfe    D5logX logX   L5n sL5c10, absorb(year naicsuscode) cluster(naicsuscode)  
esttab m3 m2 m1 r1 r2 r3 r4 r5, booktabs star (* 0.1 ** 0.05 *** 0.01 ) r2 b(4) t(2)
esttab m3 m2 m1 r1 r2 r3 r4 r5 using "figures\ind_tfp_naics4_cites.csv" , csv nostar r2 b(4) se(4) plain compress replace






 