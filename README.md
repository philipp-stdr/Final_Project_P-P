# Can we have it all? Reconcilability of career pursuits and life satisfaction for women and men

by Philipp Ständer and Philip Unger

This repository contains our research paper, webpage and presentation for the final project in the course 'Introduction to Collaborative Data Science' at the Hertie School of Governance taught by <a href="https://github.com/christophergandrud
" target="_blank">@ChristopherGandrud</a>.

- <a href="http://philipp-stdr.github.io/Final_Project_P-P/" target="_blank"> Link to the project webpage </a>

## The Research Project

In our paper we investigate on survey data from the US whether reconcilability of career and family differs between college educated women and men, and explore some of the potential drivers. We address the research question: *"Are career pursuits reconcilable with a happy life?"* We approach the research question in four steps. First, we show across different specifications and samples that women report lower life-satisfaction when having both a high-income job and a family, whereas this is not the case for men. Second, we show that the reconciliation of a high-income job and a family is particularly difficult for women who have a young child, and that it is not the case for men. Third, we investigate how marital happiness depends on the spouse's work status. We find that women tend to report higher happiness when their partner work full-time, while high-earning men report higher marital happiness their partners to stay at home or work part-time. Last, we examine whether younger female cohorts are more able to reconcile work and family than older female cohorts. Our descriptive results indicate that this indeed is the case, which could suggest a change in gender norms. 

## How to reproduce the paper

The repository includes all files necessary to reproduce our research. The markdown-file 'final_paper.Rmd' is dynamically reproducible and sources 'data_combine.R', which downloads and transforms all relevant sub-datasets into the final dataset 'data_final.rda'. Note, however, that it is computational demanding and can take 15-35 minutes to run. To ease computation, each of the data-generation files saves a dataset after their first run, and if they are present in the "data_sets" folder, the 'data_combine.R' skips the phase. Further, if the final dataset is present in the working directory, the markdown-file simply loads the final dataset rather than re-download and re-transform all the sub-datasets. 

## Folder and file structure

### master branch (contains research paper)

    .
    ├── final_paper.rmd               # Rmd file used to produce the final paper as pdf
    ├── final_paper.pdf               # Final paper as pdf
    ├── presentation.rmd              # Rmd file used to produce the presentation of the results as html
    ├── presentation.pdf              # Presentation as pdf
    ├── main_paper.bib                # Contains literature cited in the final paper
    ├── packages_paper.bib            # Contains packages used in throughout the analysis 
    ├── packages_presentation.bib     # Contains packages used in presentation 
    ├── README.md                     # Readme file
    ├── Data                          # Folder containing data files and R files to gather and prepare the data
    │   ├── data_combine.R            # Sources the four below mentioned files sequentially 
    │   ├── GSS_data_downloader.R     # Downloads the General Social Survey (GSS) from 1972-2014
    │   ├── deflator.R                # Downloads the Personal Consumption Expenditure (PCE) index
    │   ├── CPS_Bertrand.R            # Downloads the Bertrand (2013) replication file & extracts data on income percentiles
    │   ├── GSS_prep_dynamic          # Combines the data from all three previous data sources and prepares final data set
    │   ├── data_sets                 # Folder containing the data sets
    |       ├── GSS.CS.rda            # General Social Survey from 1972-2014
    |       ├── CPS_Bertrand.rda      # Replication file from Bertrand (2013)
    |       ├── data_final.rda        # Final data set
    
### gh-pages branch (hosts website)

    .
    ├── index.rmd                     # Rmd file used to produce the website hosted at the gh-pages branch
    ├── index.html                    # Website hosted at the gh-pages branch
    ├── Data                          # Folder containing final data set
    │   ├── data_final.rda            # Copy of the final data set



