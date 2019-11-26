cd "C:\Users\WB459082\Documents\IND_NSS_75_2017\Education\1. literacy\"

import delimited "Table2.1.csv", encoding(UTF-8) clear

* Wide

gen lit_gap = round(lit_female-lit_male,0.01)
export delimited using "tableau_literacy_wide .csv", replace

* Graph 1
	encode urban, gen(urban2)
	recode urban2 (1=1)(2=3)(3=2)
	label define labelrururb 1 "Rural" 2 "Urban" 3 "Total"
	label values urban2 labelrururb
	drop urban
	rename urban2 urban

	keep if lit_gap!=.

	#delimit;
	graph hbar (first) lit_gap if urban==1, 
	over(state, sort(lit_gap) descending) 
	title("Table 2.1: Gap in rural literacy rates by gender among persons of age >=7", size(small))
	xalternate nofill 
	ytitle("Female literacy % - Male literacy %", size(vsmall))  
	blabel(bar, size(tiny));

#delimit cr

* Long

reshape long lit_, i(state urban) j(gender) string
order country year variable state urban gender lit_
sort country year variable state urban gender lit_
export delimited using "tableau_literacy_long.csv", replace

* Graph 2
	drop if gender=="gap"
	graph hbox lit_ if urban==1, over(state, sort(lit_) descending) ytitle(Literacy rate %) title(Range between female and male literacy rates)