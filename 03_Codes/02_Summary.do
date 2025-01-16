/*******************************************************************************
File: 02_Summary.do
Purpose: Summary Stats and Creating final datasets
Author: Bishmay Barik
*******************************************************************************/

clear all

* Loading the dataset

********************************************************************************
********************************** 2011 ****************************************
********************************************************************************

************************* Total Migration Data *********************************

use "$output/Migrants/2011/2011_migrant_india.dta", clear 

* Keeping only the state data

cap drop if area_name == "INDIA"
cap drop district_code state_codes

* Step 1: Keeping only the number of people who have migrated

encode tot_mig_people, gen (total_migration)
encode tot_mig_males, gen (total_males_migrated)
encode tot_mig_females, gen (total_females_migrated)

collapse (sum) total_migration total_males_migrated total_females_migrated, by (area_name)

format total_migration %15.0f
format total_males_migrated %15.0f
format total_females_migrated %15.0f

cap gen i = _n 
cap drop if i == 1
cap drop i

* Format change for area_name

gen name_only = regexs(0) if regexm(area_name, "State - ([A-Za-z ]+)")
replace name_only = substr(area_name, strpos(area_name, "- ") + 2, strpos(area_name, " (") - strpos(area_name, "- ") - 2)

cap drop area_name 
rename name_only state

export delimited "$output/Migrants/2011/2011_migrant_india_no.csv", replace

****************** Duration of Residence after Migration Data ******************

use "$output/Migrants/2011/2011_migrant_india.dta", clear 

* Keeping only the state data

cap drop if area_name == "INDIA"
cap drop district_code state_codes

encode tot_mig_people, gen (total_migration)

collapse (sum) total_migration, by (area_name duration_of_residence)

format total_migration %15.0f

cap gen i = _n 
cap drop if i == 1
cap drop i

* Format change for area_name

gen name_only = regexs(0) if regexm(area_name, "State - ([A-Za-z ]+)")
replace name_only = substr(area_name, strpos(area_name, "- ") + 2, strpos(area_name, " (") - strpos(area_name, "- ") - 2)

cap drop area_name 
rename name_only state

cap drop if duration_of_residence == "All durations of residence"

export delimited "$output/Migrants/2011/2011_migrant_india_duration.csv", replace

******************** Reason for Migration Data *********************************

* people_for_work people_for_business people_for_education people_for_marriage people_after_birth people_moved_with_hh people_other_reasons

use "$output/Migrants/2011/2011_migrant_india.dta", clear 

* Keeping only the state data

cap drop if area_name == "INDIA"
cap drop district_code state_codes

// Encoding string variables to numeric versions
encode people_for_work, gen(people_for_work_num)
encode people_for_business, gen(people_for_business_num)
encode people_for_education, gen(people_for_education_num)
encode people_for_marriage, gen(people_for_marriage_num)
encode people_after_birth, gen(people_after_birth_num)
encode people_moved_with_hh, gen(people_moved_with_hh_num)
encode people_other_reasons, gen(people_other_reasons_num)

// Dropping original string variables
drop people_for_work people_for_business people_for_education people_for_marriage people_after_birth people_moved_with_hh people_other_reasons

// Renaming numeric variables to replace originals
rename people_for_work_num people_for_work
rename people_for_business_num people_for_business
rename people_for_education_num people_for_education
rename people_for_marriage_num people_for_marriage
rename people_after_birth_num people_after_birth
rename people_moved_with_hh_num people_moved_with_hh
rename people_other_reasons_num people_other_reasons

cap keep area_name people_for_work people_for_business people_for_education people_for_marriage people_after_birth people_moved_with_hh people_other_reasons

collapse (sum) people_for_work people_for_business people_for_education people_for_marriage people_after_birth people_moved_with_hh people_other_reasons, by (area_name)

format people_for_work %15.0f
format people_for_business %15.0f
format people_for_education %15.0f
format people_for_marriage %15.0f
format people_after_birth %15.0f
format people_moved_with_hh %15.0f
format people_other_reasons %15.0f

cap gen i = _n 
cap drop if i == 1
cap drop i

* Format change for area_name

gen name_only = regexs(0) if regexm(area_name, "State - ([A-Za-z ]+)")
replace name_only = substr(area_name, strpos(area_name, "- ") + 2, strpos(area_name, " (") - strpos(area_name, "- ") - 2)

cap drop area_name 
rename name_only state

export delimited "$output/Migrants/2011/2011_migrant_india_reason.csv", replace

********************************************************************************
********************************** 2001 ****************************************
********************************************************************************

use "$output/Migrants/2001/2001_migrant_india.dta", clear

cap drop if area_name == "INDIA"
cap drop district_code state_codes

* Step 1: Keeping only the number of people who have migrated

encode tot_mig_people, gen (total_migration)
encode tot_mig_males, gen (total_males_migrated)
encode tot_mig_females, gen (total_females_migrated)

collapse (sum) total_migration total_males_migrated total_females_migrated, by (area_name)

format total_migration %15.0f
format total_males_migrated %15.0f
format total_females_migrated %15.0f

cap gen i = _n 
cap drop if i == 1
cap drop i

* Format change for area_name

gen state = ""
replace state = regexs(1) if regexm(area_name, "STATE - ([A-Za-z &]+)")
replace state = regexs(1) if regexm(area_name, "UNION TERRITORY - ([A-Za-z &]+)")

cap drop area_name 

export delimited "$output/Migrants/2001/2001_migrant_india_no.csv", replace

****************** Duration of Residence after Migration Data ******************

use "$output/Migrants/2001/2001_migrant_india.dta", clear 

* Keeping only the state data

cap drop if area_name == "INDIA"
cap drop district_code state_codes

encode tot_mig_people, gen (total_migration)

collapse (sum) total_migration, by (area_name duration_of_residence)

format total_migration %15.0f

cap gen i = _n 
cap drop if i == 1
cap drop i

* Format change for area_name

gen state = ""
replace state = regexs(1) if regexm(area_name, "STATE - ([A-Za-z &]+)")
replace state = regexs(1) if regexm(area_name, "UNION TERRITORY - ([A-Za-z &]+)")

cap drop area_name 

cap drop if duration_of_residence == "All durations of residence"

export delimited "$output/Migrants/2001/2001_migrant_india_duration.csv", replace

******************** Reason for Migration Data *********************************

use "$output/Migrants/2001/2001_migrant_india.dta", clear 

* Keeping only the state data

cap drop if area_name == "INDIA"
cap drop district_code state_codes

// Encoding string variables to numeric versions
encode people_for_work, gen(people_for_work_num)
encode people_for_business, gen(people_for_business_num)
encode people_for_education, gen(people_for_education_num)
encode people_for_marriage, gen(people_for_marriage_num)
encode people_after_birth, gen(people_after_birth_num)
encode people_moved_with_hh, gen(people_moved_with_hh_num)
encode people_other_reasons, gen(people_other_reasons_num)

// Dropping original string variables
drop people_for_work people_for_business people_for_education people_for_marriage people_after_birth people_moved_with_hh people_other_reasons

// Renaming numeric variables to replace originals
rename people_for_work_num people_for_work
rename people_for_business_num people_for_business
rename people_for_education_num people_for_education
rename people_for_marriage_num people_for_marriage
rename people_after_birth_num people_after_birth
rename people_moved_with_hh_num people_moved_with_hh
rename people_other_reasons_num people_other_reasons

cap keep area_name people_for_work people_for_business people_for_education people_for_marriage people_after_birth people_moved_with_hh people_other_reasons

collapse (sum) people_for_work people_for_business people_for_education people_for_marriage people_after_birth people_moved_with_hh people_other_reasons, by (area_name)

format people_for_work %15.0f
format people_for_business %15.0f
format people_for_education %15.0f
format people_for_marriage %15.0f
format people_after_birth %15.0f
format people_moved_with_hh %15.0f
format people_other_reasons %15.0f

cap gen i = _n 
cap drop if i == 1
cap drop i

* Format change for area_name

gen state = ""
replace state = regexs(1) if regexm(area_name, "STATE - ([A-Za-z &]+)")
replace state = regexs(1) if regexm(area_name, "UNION TERRITORY - ([A-Za-z &]+)")

cap drop area_name 

export delimited "$output/Migrants/2001/2001_migrant_india_reason.csv", replace


********************************** 1991 ****************************************

use "$output/Migrants/1991/1991_migrant_india.dta", clear

cap drop state_code

cap keep state_name total_migrants total_male_migrants total_female_migrants

encode total_migrants, gen (total_migration)
encode total_male_migrants, gen (total_males_migrated)
encode total_female_migrants, gen (total_females_migrated)

collapse (sum) total_migration total_males_migrated total_females_migrated, by (state_name)

cap gen i = _n
cap drop if i == 1
cap drop i

cap drop if state_name == "India (Excluding J&K)"

gen state = substr(state_name, strpos(state_name, "-") + 1, .)

cap drop state_name

export delimited "$output/Migrants/1991/1991_migrant_india_no.csv", replace

********************************************************************************
********************* People of India - CPHS ***********************************
********************************************************************************

* Loading dataset

use "$output/People of India/people_of_india_migration", clear

merge m:1 hh_id wave_no using "$output/People of India/aspirationa_india.dta"

cap drop if member_status == "Member of the household"

cap drop if _merge != 3

cap drop _merge

gen migration = 1

* Genrating formal and informal borrowing variables

cap gen formal_borr = 0

replace formal_borr = 1 if borrowed_from_bank == "Y" | borrowed_from_nbfc_dealer == "Y" | borrowed_from_credit_cards == "Y"

cap gen informal_borr = 0

replace informal_borr = 1 if borrowed_from_money_lender == "Y" | borrowed_from_employer == "Y" | borrowed_from_rel_friends == "Y" | borrowed_from_shg == "Y" | borrowed_from_mfi == "Y" | borrowed_from_chitfunds == "Y" | borrowed_from_other_sources == "Y"

preserve
cap keep state formal_borr informal_borr 
collapse (mean) formal_borr informal_borr, by (state)
save "$output/People of India/mig_state_loans.dta", replace 
export delimited "$output/People of India/mig_state_loans.csv", replace
restore

// Out of all migrated people, only 60% people have an outstanding borrowing. 

collapse (sum) migration , by (state emigrated_immigrated_state member_status caste_category emigration_immigration_reason)

cap drop if state == emigrated_immigrated_state

save "$output/People of India/main.dta", replace

* For everyone

preserve
collapse (sum) migration, by (state emigrated_immigrated_state)
export delimited "$output/People of India/population.csv", replace
restore

* Migration with Caste Categories

preserve
collapse (sum) migration, by (state emigrated_immigrated_state caste_category)
export delimited "$output/People of India/population_with_caste.csv", replace
restore

* Migration with Reason

preserve
collapse (sum) migration, by (state emigrated_immigrated_state emigration_immigration_reason)
export delimited "$output/People of India/population_with_migration_reason.csv", replace
restore

********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************

************* And now at the district level Census data 2011 *******************

********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************

clear

* importing the dataset

******************************** 2011 ******************************************

use "$output/Census Districts Data/2011/all_india.dta", clear

keep if age_group == "All ages" & place_of_enumeration == "Total" & last_residence == "Total" // & duration_of_residence == "All durations of residence"

drop if duration_of_residence == "All durations of residence"

drop place_of_enumeration age_group last_residence

export delimited "$output/Census Districts Data/2011/total_migration_with_duration.csv", replace

// Encoding some variables

encode total_people, gen(total_people_enc)
drop total_people
rename total_people_enc total_people
format total_people %12.0f

encode people_for_work, gen(people_for_work_enc)
drop people_for_work 
rename people_for_work_enc people_for_work
format people_for_work %12.0f

encode people_for_business, gen(people_for_business_enc)
drop people_for_business
rename people_for_business_enc people_for_business
format people_for_business %12.0f

encode people_for_education, gen(people_for_education_enc)
drop people_for_education
rename people_for_education_enc people_for_education
format people_for_education %12.0f

encode people_for_marriage, gen(people_for_marriage_enc)
drop people_for_marriage
rename people_for_marriage_enc people_for_marriage  
format people_for_marriage %12.0f

encode people_after_birth, gen(people_after_birth_enc)
drop people_after_birth
rename people_after_birth_enc people_after_birth
format people_after_birth %12.0f

encode people_moved_with_hh, gen(people_moved_with_hh_enc)
drop people_moved_with_hh
rename people_moved_with_hh_enc people_moved_with_hh
format people_moved_with_hh %12.0f

encode people_other_reasons, gen(people_other_reasons_enc)
drop people_other_reasons
rename people_other_reasons_enc people_other_reasons
format people_other_reasons %12.0f

* collapse (sum) total_people people_for_work people_for_business people_for_education people_for_marriage people_after_birth people_moved_with_hh people_other_reasons, by (state district source_state area_name)

sort state district

export delimited "$output/Census Districts Data/2011/total_migration_with_reasons.csv", replace

******************************** 2001 ******************************************

use "$output/Census Districts Data/2001/all_india.dta", clear

keep if age_group == "All ages" & place_of_enumeration == "Total" & last_residence == "Total"

// Encoding some variables

encode total_people, gen(total_people_enc)
drop total_people
rename total_people_enc total_people
format total_people %12.0f

sort state district

export delimited "$output/Census Districts Data/2001/total_migration_with_reasons.csv", replace
