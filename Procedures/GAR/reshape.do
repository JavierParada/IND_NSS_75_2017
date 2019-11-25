cd "C:\Users\WB459082\Documents\IND_NSS_75_2017\Procedures\GAR\"
use "GAR.dta", clear
sum

rename primarylevel gar_primarylevel
rename upperprimarymiddlelevel gar_upperprimarymiddlelevel
rename primaryandupperprimarymiddleleve gar_primaryandupperprima
rename secondarylevel gar_secondarylevel
rename highersecondarylevel gar_highersecondarylevel
rename posthighersecondarylevel gar_posthighersecondarylevel

reshape long gar_, i(group state) j(educ) string

gen country = "India"

sort variable country state educ group   gar_
order variable country state educ group  gar_


export delimited using "tableau.csv", replace