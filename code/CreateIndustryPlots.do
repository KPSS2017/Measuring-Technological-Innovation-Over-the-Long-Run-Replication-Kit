clear
cd "E:\ReplicationCode"


use "intermediate_data\naics_3_indices.dta"

append using "intermediate_data\naics_4_indices.dta"

drop ind

encode naicsustitle , gen(ind)


fillin ind   year
egen mnaicsuscode=mean(naicsuscode) , by(ind)
replace naicsuscode = mnaicsuscode if missing(naicsuscode )

merge m:1 year using "other_data\USpop.dta"
keep if _merge==3
drop _merge


replace wnpats=0 if _fillin
replace wbreak_p90_rrfsim010=0 if _fillin
replace wbreak_p90_rlfcit010=0 if _fillin
 


gen wnpats_pc = wnpats / pop * 1000 * 1000
gen wqual_pc10 = wbreak_p90_rrfsim010/pop* 1000 * 1000
gen wqual_cites_pc10 = wbreak_p90_rlfcit010/pop* 1000 * 1000



egen   mean_pats = mean(wnpats_pc), by(ind)
egen   mean_qual_pc10 = mean(wqual_pc10), by(ind)
egen   rank_wqual_pc10=rank(mean_qual_pc10), by(year) field
 


 

replace wqual_pc10=. if year>2002

replace naicsustitle="Electrical Equipment" if naicsuscode==335
replace naicsustitle="Computers and Electronic Products" if naicsuscode==334
replace naicsustitle="Construction" if naicsuscode==236
replace naicsustitle="Fabricated Metals" if naicsuscode==332
replace naicsustitle="Petroleum and Coal Products" if naicsuscode==324
replace naicsustitle="Plastics and Rubber Products" if naicsuscode==326
replace naicsustitle="Mineral Processing" if naicsuscode==327
replace naicsustitle="Transportation Equipment" if naicsuscode==336
replace naicsustitle="Medical Equipment" if naicsuscode==3391

tostring naicsuscode, gen(naicsuscode1) force
gen ind_name = naicsustitle + " (" + naicsuscode1 + ")"
gen ind_code = naicsuscode

 
replace ind_code = 11 if naicsuscode==112 |  naicsuscode==111 |     naicsuscode==114  |  naicsuscode==115 | naicsuscode==311 |  naicsuscode==312
replace ind_name = "Agriculture and Food (111, 112, 114, 115,311, 312)" if ind_code == 11 

replace ind_code = 23 if naicsuscode==236 |  naicsuscode==237 |  naicsuscode==238
replace ind_name = "Construction (236, 237, 238)" if ind_code == 23 

replace ind_code = 21 if naicsuscode==212 |  naicsuscode==211  |  naicsuscode==213
replace ind_name = "Mining and Extraction (211, 212, 213)" if ind_code == 21

replace ind_code = 31 if naicsuscode==313 |  naicsuscode==314 |  naicsuscode==315 |  naicsuscode==337
replace ind_name = "Furniture, Textiles and Apparel (313, 314, 315, 337)" if ind_code == 31

replace ind_code = 33 if naicsuscode==331 |  naicsuscode==332 
replace ind_name = "Metal Manufacturing (331, 332)" if ind_code == 33

replace ind_code = 32 if naicsuscode==322 |  naicsuscode==323  |  naicsuscode==321
replace ind_name = "Wood, Paper and Printing (321, 322, 323)" if ind_code == 32
 

gen keep =0 
replace keep=1 if  ind_code==3110 | ind_code==11| ind_code==21  | ind_code==23 | ind_code==22 | ind_code==31 | ind_code==32 | ind_code==33 | ind_code==335 | ind_code==334 | ind_code==324  | ind_code==326 | ind_code==327 | ind_code==3361 | ind_code==3391 | ind_code==3364 | ind_code ==325 | ind_code ==336  | ind_code ==333 | ind_code ==221

replace keep = 0 if ind_code==3364 | ind_code==3361

 
keep if keep==1

encode ind_name, gen(indd)


drop if year>2002


collapse (sum) wnpats_pc wqual_pc10 wqual_cites_pc10, by(indd ind_code year)
 

tsset indd year

ren wqual_pc10 break_kpst


xtline break_kpst  , byopts(yrescale xrescale     style(538) imargin(small)  ) name(breakr2_5all,replace) 
 

keep year ind_code  break_kpst
 
drop if year<1840


reshape wide break_kpst, i(year) j(ind_code)

 export delimited using "figures\Fig_IndInnovationLR.csv", replace
