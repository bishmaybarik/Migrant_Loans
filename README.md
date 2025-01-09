# Migration of People and their Loan Behaviour across Indian States

## Introduction

This repository consists of codes and graphical representations of migration of citizens across states, and how has their movement affected the loan taking behaviour across states. When I say the loan taking behaviour, I mean their dependence on Formal and Informal Loan structures. 

To begin with, here is the repository structure, and the graphical results which you can find across states. 

```
Migrant_Loans/
│
├── 01_Raw/                             # Raw datasets (Census 2001, Census 2011, CPHS, etc.)
│
├── 02_Output/                          # Processed datasets and intermediate outputs
│
├── 03_Codes/                           # Code scripts and notebooks for data processing and analysis
│   ├── 00_master.do                    # Master script to run all Stata do-files
│   ├── 01_Clean.do                     # Stata script for data cleaning and preprocessing
│   ├── 02_Summary.do                   # Stata script for generating summary statistics
│   ├── maps.ipynb                      # Jupyter notebook for generating migration maps
│   ├── migration.ipynb                 # Jupyter notebook for analyzing migration trends
│
├── 04_Results/                         # Final outputs and visualizations
│   ├── Total_Migration/                # Data and visuals for total migration (Census 2001 & 2011)
│       ├── Census_2001/                # Visuals and data for Census 2001
│       ├── Census_2011/                # Visuals and data for Census 2011
│
│   ├── Migration_with_Duration/        # Migration data with duration of residence (Census 2001 & 2011)
│       ├── Census_2001/                # Visuals and data for Census 2001
│       ├── Census_2011/                # Visuals and data for Census 2011
│
│   ├── Reason_of_Migration/            # Migration data categorized by reasons (Census 2001 & 2011)
│       ├── Census_2001/                # Visuals and data for Census 2001
│       ├── Census_2011/                # Visuals and data for Census 2011
│
│   ├── People_of_India/                # CPHS data on migration and loans
│       ├── Population_Migration/       # Data and visuals for entire migrated population
│           ├── Informal/               # Migration data with informal loans percentage across states
│           ├── Formal/                 # Migration data with formal loans percentage across states
│           ├── state_division_plots/   # Other state-level migration visualizations
│
│       ├── Population_with_Caste/      # Migration data categorized by caste across states
│
│       ├── Migration_with_Reason/      # Migration data categorized by reasons (from CPHS dataset)
│
│   ├── CPHS_with_Loan/                 # Borrowing patterns among CPHS population
│       ├── Total_Population/           # Heatmaps of borrowing patterns across states
│           ├── formal_borrowings_heatmap.png    # Heatmap for formal borrowings
│           ├── informal_borrowings_heatmap.png  # Heatmap for informal borrowings
│
├── .gitignore                          # Specifies files and folders to be ignored by Git
│                                        # Example: *.csv, *.xlsx, __pycache__/, etc.
│
├── LICENSE                             # License file for the project (e.g., MIT, GPL, or custom license)
│
├── README.md                           # Project overview and documentation
```

## Formal and Informal Loans

According to the CPHS-CMIE data, these are the distinctions I have made between the formal and the informal loan sources:

Formal Loan Sources:
- Borrowings from Banks
- Borrowings from NBFC dealers
- Credit Card Borrowings

Informal Loan Sources:
- Borrowings from Money Lenders
- Borrowings from Employers
- Borrowings from Relatives and Friends
- Borrowings from Self-Help Groups
- Borrowings from Microfinance Institutions
- Borrowings from Chitfunds
- Borrowings from Other Sources

