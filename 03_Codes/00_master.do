/*******************************************************************************
File: 00_master.do
Purpose: Cleaning and conversion of excel files to dta files
Author: Bishmay Barik
*******************************************************************************/

clear all

set more off

* Setting the master root directory

global dir "/Users/bishmaybarik/Library/CloudStorage/OneDrive-ShivNadarInstitutionofEminence/Migrant_Loans" // Bishmay's Macbook Directory

* Setting the subpaths

global raw "$dir/01_Raw" // The raw Excel Data files are stored here
global output "$dir/02_Output" // Converted and cleaned dta files are stored here
global latex "$dir/04_Latex" // Created tables and figures will be stored here



