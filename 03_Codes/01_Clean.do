/*******************************************************************************
File: 01_Clean.do
Purpose: Cleaning and conversion of excel files to dta files
Author: Bishmay Barik
*******************************************************************************/

clear all 

set more off

*******************************************************************************
**************************** MOTHER TONGUE ************************************
*******************************************************************************

********************************* 1991 *****************************************

import excel "$raw/Mother Tongue/1991/1991-C7C2-0100.xlsx", sheet("C7 C(ii)") clear

* Dropping the irrelavant columns

cap drop A I J K L M N O P

rename B mother_tongue
rename C total_people
rename D percent_to_tot_pop
rename E rural
rename F urban
rename G prop_rural
rename H prop_urban

gen i = _n
cap drop if i < 10

cap drop i

save "$output/Mother Tongue/1991/1991_mt_india.dta", replace 

********************************* 2001 *****************************************

// Define a list of state codes and their names
local state_codes "01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34"
local state_names "jammu_kashmir himachal_pradesh punjab chandigarh uttarakhand haryana delhi rajasthan uttar_pradesh bihar sikkim arunachal_pradesh nagaland manipur mizoram tripura meghalaya assam west_bengal jharkhand orissa chhattisgarh madhya_pradesh gujarat daman_diu dadra_nagar_haveli maharashtra andhra_pradesh karnataka goa lakshadweep kerala tamil_nadu pondicherry"

// Split the state names into a local macro for reference
local state_count: word count `state_codes'

// Loop through each state
forval i = 1/`state_count' {
    // Get the state code and state name
    local code : word `i' of `state_codes'
    local name : word `i' of `state_names'
    
    // File path for the current state
    local filepath "$raw/Mother Tongue/2001/PC01_C16_`code'.xls"
    local outputpath "$output/Mother Tongue/2001/`name'.dta"
    
    // Import Excel file
    import excel "`filepath'", sheet("Sheet1") clear
    
    // Dropping irrelevant variables
    cap drop A

    // Renaming the columns
    rename B state
    rename C district
    rename D tehsil
    rename E area_name 
    rename F mother_tongue_code
    rename G mother_tongue
    rename H total_people
    rename I total_male
    rename J total_female
    rename K rural_people
    rename L rural_male
    rename M rural_female 
    rename N urban_people
    rename O urban_male
    rename P urban_female

    // Drop unnecessary rows
    cap gen i = _n
    cap drop if i < 7
	cap drop if area_name == ""

    // Extract place names
    gen place = ""
    replace place = regexs(1) if regexm(area_name, "District - ([A-Za-z &/-]+) ?[0-9]*$")
    replace place = regexs(1) if regexm(area_name, "Sub district - ([A-Za-z &/-]+) ?[0-9]*$")
    replace place = regexs(1) if regexm(area_name, "State - ([A-Za-z &/-]+) ?[0-9]*$")
    replace place = regexs(1) if regexm(area_name, "Tehsil - ([A-Za-z &/-]+) ?[0-9]*$")
    list area_name place if place != ""

    // Extract language names
    gen language = ""
    replace language = regexs(1) if regexm(trim(mother_tongue), "^[0-9]+ ([A-Za-z /-]+)")
    list mother_tongue language if language != ""

    // Clean up
    cap drop i

    // Save the file
    save "`outputpath'", replace
}

********************************* 2011 *****************************************

import excel "$raw/Mother Tongue/2011/DDW-C16-STMT-MDDS-0000.XLSX", sheet("Sheet1") clear

* Dropping unnecessary columns

cap drop A

* Renaming the variables

rename B state_codes
rename C district_code
rename D sub_dist_code
rename E area_name 
rename F mother_tongue_code
rename G mother_tongue
rename H total_people
rename I total_male
rename J total_female
rename K rural_people
rename L rural_male
rename M rural_female 
rename N urban_people
rename O urban_male
rename P urban_female

cap gen i = _n
cap drop if i < 7
cap drop i 

save "$output/Mother Tongue/2011/2011_india.dta", replace 

*******************************************************************************
******************************* MIGRANTS **************************************
*******************************************************************************

********************************* 2011 *****************************************

clear all

* Importing the dataset

import excel "$raw/Migrants/2011/DS-0000-D05-MDDS.XLSX", sheet("D-05") clear

* Dropping irrelavant variables

cap drop A

* renaming the columns

rename B state_codes
rename C district_code
rename D area_name
rename E place_of_enumeration
rename F duration_of_residence
rename G age_group
rename H last_residence
rename I tot_mig_people
rename J tot_mig_males
rename K tot_mig_females
rename L people_for_work
rename M males_for_work
rename N females_for_work
rename O people_for_business
rename P males_for_business
rename Q females_for_business
rename R people_for_education
rename S males_for_education
rename T females_for_education
rename U people_for_marriage
rename V males_for_marriage
rename W females_for_marriage
rename X people_after_birth
rename Y males_after_birth
rename Z females_after_birth
rename AA people_moved_with_hh
rename AB males_moved_with_hh
rename AC females_moved_with_hh
rename AD people_other_reasons
rename AE males_other_reasons
rename AF females_other_reasons

cap gen i = _n
cap drop if i < 6
cap drop i

save "$output/Migrants/2011/2011_migrant_india.dta", replace 

********************************* 2001 *****************************************

* importing the dataset

import excel "$raw/Migrants/2001/PC01_D05_00.xls", sheet("D-05") clear

* Dropping irrelavant variables

cap drop A

* renaming the columns

rename B state_codes
rename C district_code
rename D area_name
rename E place_of_enumeration
rename F duration_of_residence
rename G age_group
rename H last_residence
rename I tot_mig_people
rename J tot_mig_males
rename K tot_mig_females
rename L people_for_work
rename M males_for_work
rename N females_for_work
rename O people_for_business
rename P males_for_business
rename Q females_for_business
rename R people_for_education
rename S males_for_education
rename T females_for_education
rename U people_for_marriage
rename V males_for_marriage
rename W females_for_marriage
rename X people_after_birth
rename Y males_after_birth
rename Z females_after_birth
rename AA people_moved_with_hh
rename AB males_moved_with_hh
rename AC females_moved_with_hh
rename AD people_other_reasons
rename AE males_other_reasons
rename AF females_other_reasons

cap gen i = _n
cap drop if i < 6
cap drop i

save "$output/Migrants/2001/2001_migrant_india.dta", replace 

********************************* 1991 *****************************************

import excel "$raw/Migrants/1991/1991-D03R-0100.xlsx", sheet("D03R") clear 

* Dropping irrelevant variables

cap drop A

* Renaming the variables

rename B state_code
rename C state_name
rename D duration_of_residence
rename E last_residence
rename F region_type
rename G previous_region_type
rename H total_migrants
rename I total_male_migrants
rename J total_female_migrants
rename K males_for_employment
rename L females_for_employment
rename M males_for_business
rename N females_for_business
rename O males_for_education
rename P females_for_education
rename Q males_for_family_moved
rename R female_for_family_moved
rename S males_for_marriage
rename T females_for_marriage
rename U males_for_nat_calamity
rename V females_for_nat_calamity
rename W males_for_other_reasons
rename X females_for_other_reasons

cap gen i = _n
cap drop if i < 9
cap drop i

save "/Users/bishmaybarik/Library/CloudStorage/OneDrive-ShivNadarInstitutionofEminence/Migrant_Loans/02_Output/Migrants/1991/1991_migrant_india", replace

******************************

* People of India

use "$raw/People of India/people_of_india_migration.dta", clear

cap drop if caste_category == "Not Applicable"
cap drop if caste_category == "Not Stated"
cap drop if caste_category == "Data Not Available"
cap drop if religion == "Data Not Available"
cap drop if religion == "Not Applicable"
cap drop if religion == "Religion not stated"

save "$output/People of India/people_of_india_migration", replace

* Aspirational India appending

* Define the directory containing the datasets
local raw_dir "/Users/bishmaybarik/Library/CloudStorage/OneDrive-ShivNadarInstitutionofEminence/Merge_CPHS_Census/01. Raw/CPHS/Aspirational India"

* List of datasets to be appended
local datasets aspirational_india_20210501_20210831_R aspirational_india_20210901_20211231_R aspirational_india_20220101_20220430_R ///
               aspirational_india_20220501_20220831_R aspirational_india_20220901_20221231_R aspirational_india_20230101_20230430_R ///
               aspirational_india_20230501_20230831_R aspirational_india_20230901_20231231_R aspirational_india_20240101_20240430_R ///
               

* List of variables to keep
local vars wave_no hh_id state district has_outstanding_borrowing borrowed_from_bank borrowed_from_money_lender ///
           borrowed_from_employer borrowed_from_rel_friends borrowed_from_nbfc_dealer borrowed_from_shg ///
           borrowed_from_mfi borrowed_from_chitfunds borrowed_from_credit_cards borrowed_from_other_sources

* Load the first dataset as the master dataset, keeping only the specified variables
use "`raw_dir'/aspirational_india_20210101_20210430_R", clear
keep `vars'

* Loop through the remaining datasets and append them
foreach file in `datasets' {
    display "Appending `file'..."
    append using "`raw_dir'/`file'", keep(`vars')
}

* Check if the datasets were appended correctly
display "All datasets have been appended successfully!"
summarize

save "$output/People of India/aspirationa_india.dta", replace

********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************

************* Now working with the district level data *************************

********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************

************************************** 2011 ************************************


clear all

* Importing the datasets

local states "west_bengal delhi jammu_kashmir jharkhand karnataka kerala lakshadweep madhya_pradesh maharashtra manipur meghalaya mizoram nagaland odisha puducherry punjab rajasthan sikkim tamil_nadu tripura uttar_pradesh uttarakhand goa gujarat haryana himachal_pradesh andaman_nicobar andhra_pradesh arunachal_pradesh assam bihar chandigarh chhatisgarh dadra_nagar_haveli daman_diu" // All states present in the raw data folder

foreach state in `states' {
    // Construct file paths
    local input_path "$raw/Census Districts Data/2011/`state'.XLSX"
    local output_path "$output/Census Districts Data/2011/`state'.dta"

    // Import the Excel file
    import excel "`input_path'", sheet("D-05") clear

    // Rename variables
    drop A
    rename B state
    rename C district 
    rename D area_name
    rename E place_of_enumeration
    rename F duration_of_residence
    rename G age_group
    rename H last_residence
    rename I total_people
    rename L people_for_work
    rename O people_for_business
    rename R people_for_education
    rename U people_for_marriage
    rename X people_after_birth
    rename AA people_moved_with_hh
    rename AD people_other_reasons

    // Keep only necessary variables
    keep state district area_name place_of_enumeration duration_of_residence age_group last_residence total_people people_for_work people_for_business people_for_education people_for_marriage people_after_birth people_moved_with_hh people_other_reasons

    // Retain only district-level data
    drop if _n < 6
    drop if district == "000"

    // Add state name as a new variable
    // gen state_name = "`: proper `state''" // Converts to proper case, e.g., "Andaman & Nicobar"

    // Reorder variables
    order state district area_name 

    // Save the dataset in .dta format
    save "`output_path'", replace
}

***** Appending all 2011 datasets which is at the state (district) level ******

clear

// List of states to append
local states "west_bengal delhi jammu_kashmir jharkhand karnataka kerala lakshadweep madhya_pradesh maharashtra manipur meghalaya mizoram nagaland odisha puducherry punjab rajasthan sikkim tamil_nadu tripura uttar_pradesh uttarakhand goa gujarat haryana himachal_pradesh andaman_nicobar andhra_pradesh arunachal_pradesh assam bihar chandigarh chhatisgarh dadra_nagar_haveli daman_diu"

// Initialize the combined dataset
local first = 1

foreach state in `states' {
    local input_path "$output/Census Districts Data/2011/`state'.dta"
    
    if `first' {
        use "`input_path'", clear
        gen source_state = "`state'" // Create a variable to track the source state
        save "$output/Census Districts Data/2011/all_states_combined.dta", replace
        local first = 0
    }
    else {
        append using "`input_path'"
        replace source_state = "`state'" if missing(source_state) // Update source state for appended data
        save "$output/Census Districts Data/2011/all_states_combined.dta", replace
    }
}

sort state district

drop if missing(state)

// Final save of the combined dataset
save "$output/Census Districts Data/2011/all_india.dta", replace

************************************** 2001 ************************************

clear all

* Importing the datasets

local states "west_bengal delhi jammu_kashmir jharkhand karnataka kerala lakshadweep madhya_pradesh maharashtra manipur meghalaya mizoram nagaland odisha puducherry punjab rajasthan sikkim tamil_nadu tripura uttar_pradesh uttarakhand goa gujarat haryana himachal_pradesh andaman_nicobar andhra_pradesh arunachal_pradesh assam bihar chandigarh chhatisgarh dadra_nagar_haveli daman_diu" // All states present in the raw data folder

foreach state in `states' {
    // Construct file paths
    local input_path "$raw/Census Districts Data/2001/`state'.xls"
    local output_path "$output/Census Districts Data/2001/`state'.dta"

    // Import the Excel file
    import excel "`input_path'", sheet("D-10") clear

    // Rename variables
    drop A
    rename B state
    rename C district 
    rename D area_name
    rename E place_of_enumeration
    rename F age_group
    rename G last_residence
    rename H total_people

    // Keep only necessary variables
    keep state district area_name place_of_enumeration age_group last_residence total_people

    // Retain only district-level data
    drop if _n < 6
    drop if district == "00"

    // Add state name as a new variable
    // gen state_name = "`: proper `state''" // Converts to proper case, e.g., "Andaman & Nicobar"

    // Reorder variables
    order state district area_name 

    // Save the dataset in .dta format
    save "`output_path'", replace
}

***** Appending all 2001 datasets which is at the state (district) level ******

clear

// List of states to append
local states "west_bengal delhi jammu_kashmir jharkhand karnataka kerala lakshadweep madhya_pradesh maharashtra manipur meghalaya mizoram nagaland odisha puducherry punjab rajasthan sikkim tamil_nadu tripura uttar_pradesh uttarakhand goa gujarat haryana himachal_pradesh andaman_nicobar andhra_pradesh arunachal_pradesh assam bihar chandigarh chhatisgarh dadra_nagar_haveli daman_diu"

// Initialize the combined dataset
local first = 1

foreach state in `states' {
    local input_path "$output/Census Districts Data/2001/`state'.dta"
    
    if `first' {
        use "`input_path'", clear
        gen source_state = "`state'" // Create a variable to track the source state
        save "$output/Census Districts Data/2001/all_states_combined.dta", replace
        local first = 0
    }
    else {
        append using "`input_path'"
        replace source_state = "`state'" if missing(source_state) // Update source state for appended data
        save "$output/Census Districts Data/2001/all_states_combined.dta", replace
    }
}

sort state district

drop if missing(state)

// Final save of the combined dataset
save "$output/Census Districts Data/2001/all_india.dta", replace
