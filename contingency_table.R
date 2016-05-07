########################################
#         Contingency Tables           #
########################################


library(stargazer)

# Set working directory
#setwd("~/Documents/CDA/collaborative_projects/Final_Project_P-P")
setwd("~/R_data/Final_Project_P-P") # Staender

# Load the data set
load("data/data_sets/data_final.rda")


# Create a variable for partner's income
z$othinccat <- trunc(z$def_othinc/10000)
z$othinccat[is.na(z$othinc)] <- -1
table(z$othinccat)

z$rinccat <- trunc(z$def_rinc/10000)
z$rinccat[is.na(z$def_rinc)] <- -1
table(z$rinccat)

z$inccat <- trunc(z$def_inc/10000)
z$inccat[is.na(z$def_inc)] <- -1
table(z$inccat)


# Create career1
z$career1 <- z$rinc > z$p50
z$career1 <- as.numeric(z$career1)
z$career1[is.na(z$career1)] <- 0 

# Create spouse work categories

z$spouse_work <- NULL
z$spouse_work[z$spwrksta==1] <- 1
z$spouse_work[z$spwrksta==2] <- 2
z$spouse_work[z$spwrksta==7] <- 7

z$spouse_ft <- NULL
z$spouse_ft[z$spwrksta==1] <- 1
z$spouse_ft[z$spwrksta==2 | z$spwrksta==7] <- 0

z$spouse_pt <- NULL
z$spouse_pt[z$spwrksta==2] <- 1
z$spouse_pt[z$spwrksta==1 | z$spwrksta==7] <- 0

z$spouse_home <- NULL
z$spouse_home[z$spwrksta==7] <- 1
z$spouse_home[z$spwrksta==1 | z$spwrksta==2] <- 0

z$sp_nonft <- NULL
z$sp_nonft[z$spwrksta==1] <- 0
z$sp_nonft[z$spwrksta==7 | z$spwrksta==2] <- 1

z$nonft <- NULL
z$nonft[z$wrksta==1] <- 0
z$nonft[z$wrksta==7 | z$wrksta==2] <- 1  

z$sp_hardw <- NULL
z$sp_hardw[z$sphrs1>=50] <- 1
z$sp_hardw[z$sphrs1<50] <- 0
z$sp_hardw <- as.numeric(z$sp_hardw)

z$hardw <- NULL
z$hardw[z$hrs1 >= 50] <- 1
z$hardw[z$hrs1 < 50] <- 0
z$hardw <- as.numeric(z$hardw)

##Marriage happiness
z$hapmarr <- NA
z$hapmarr[z$hapmar==3] <- 1
z$hapmarr[z$hapmar==2] <- 2
z$hapmarr[z$hapmar==1] <- 3

z$hapmar <- NULL
z <- rename(z, c(hapmarr="hapmar"))

z$vhapmar <- NA
z$vhapmar[z$hapmar==1 | z$hapmar==2] <- 0
z$vhapmar[z$hapmar==3] <- 1

# work hours into bins

z$hrs_cat <- trunc(z$hrs1/10)
z$sphrs_cat <- trunc(z$sphrs1/10)

z$hrs_ft <- NULL
z$hrs_ft[z$hrs1<40] <- 0 
z$hrs_ft[z$hrs1>=40] <- 1

z$sphrs_ft <- NULL
z$sphrs_ft[z$sphrs1<40] <- 0 
z$sphrs_ft[z$sphrs1>=40] <- 1

z$working_ft <- as.numeric(z$working_ft)

###############
# table specific variables
###############

z$sexcat <- NULL
z$sexcat[z$sex==1] <- "Male"
z$sexcat[z$sex==2] <- "Female"

z$spwrkcat <- NULL
z$spwrkcat[z$spwrksta==1] <- "Full-time"
z$spwrkcat[z$spwrksta==2] <- "Part-time"
z$spwrkcat[z$spwrksta==7] <- "Keeping house"

z$hrscat <- NULL
z$hrscat[z$hrs_cat==0] <- "0-9"
z$hrscat[z$hrs_cat==1] <- "10-19"
z$hrscat[z$hrs_cat==2] <- "20-29"
z$hrscat[z$hrs_cat==3] <- "30-39"
z$hrscat[z$hrs_cat==4] <- "40-49"
z$hrscat[z$hrs_cat==5] <- "50-59"
z$hrscat[z$hrs_cat==6] <- "60-69"
z$hrscat[z$hrs_cat==7] <- "70-79"
z$hrscat[z$hrs_cat==8] <- "80+"

z$sphrscat <- NULL
z$sphrscat[z$sphrs_cat==0] <- "0-9"
z$sphrscat[z$sphrs_cat==1] <- "10-19"
z$sphrscat[z$sphrs_cat==2] <- "20-29"
z$sphrscat[z$sphrs_cat==3] <- "30-39"
z$sphrscat[z$sphrs_cat==4] <- "40-49"
z$sphrscat[z$sphrs_cat==5] <- "50-59"
z$sphrscat[z$sphrs_cat==6] <- "60-69"
z$sphrscat[z$sphrs_cat==7] <- "70-79"
z$sphrscat[z$sphrs_cat==8] <- "80+"

z$income_status[z$career==1] <- "High-income"
z$income_status[z$career==0] <- "Low-income"

z$incstat[z$career1==1] <- "High-income"
z$incstat[z$career1==0] <- "Low-income"

z$speducat <- NULL
z$speducat[z$speduc<12] <- 1
z$speducat[z$speduc==12] <- 2
z$speducat[z$speduc>12 & z$educ<16] <- 3
z$speducat[z$speduc>=16] <- 4


# Data-set "t" is limited to the years where "career" is defined
z = z[z$year >= 1977 & z$year < 2012,]

################################
## Tables
################################

####The Code

# 2-Way Frequency Table 
attach(mydata)
mytable <- table(A,B) # A will be rows, B will be columns 
mytable # print table 

margin.table(mytable, 1) # A frequencies (summed over B) 
margin.table(mytable, 2) # B frequencies (summed over A)

prop.table(mytable) # cell percentages
prop.table(mytable, 1) # row percentages 
prop.table(mytable, 2) # column percentages


# 2-Way Cross Tabulation
library(gmodels)
CrossTable(mydata$myrowvar, mydata$mycolvar)

# 3-Way Frequency Table 
mytable <- table(A, B, C) 
ftable(mytable)

mytable <- xtabs(~A+B+c, data=mydata)
ftable(mytable) # print table 
summary(mytable) # chi-square test of indepedence

####The Code

# Gender and Spouse Work Status
ge_sp_wrkst <- table(z$sexcat[z$educat==4], z$spwrkcat[z$educat==4])
table(z$sexcat[z$educat==4], z$spwrkcat[z$educat==4])
prop.table(ge_sp_wrkst, 1)

# Gender and Work Hours
ge_hrs <- table(z$sexcat[z$educat==4 & z$married==1], z$hrscat[z$educat==4 & z$married==1])
prop.table(ge_hrs, 1)

# Gender and Spouse Work Hours
ge_hrs <- table(z$sexcat[z$educat==4 & z$married==1], z$sphrscat[z$educat==4 & z$married==1])
prop.table(ge_hrs, 1)

# Gender, income and Spouse Work Status
ge_sp_ca <- table(z$sexcat[z$educat==4 & z$married==1], z$incstat[z$educat==4 & z$married==1], z$spwrkcat[z$educat==4 & z$married==1]) 
ftable(ge_sp_ca, 1)



######### TEST: generate frequency table (with probabilities)
t = as.data.frame.table(table(z))

names(t) = c("sexcat","income_status","spwrkcat","freq") # Make names of t different from d1 so we can attach both
attach(z)
attach(t)

ge_sp_ca2 <- xtabs(Freq~sexcat+income_status+spwrkcat, data = z[z$educat==4 & z$married==1,]) 
ftable(ge_sp_ca2, row.vars=1:2)
ftable(prop.table(ge_sp_ca, row.vars=1:2))
############

# Gender, income and spouse education
# Gender and Spouse Work Hours
ge_speducat <- table(z$sexcat[z$married==1], z$speducat[z$married==1])
prop.table(ge_speducat, 1)

ge_sp_edu <- table(z$sexcat[z$married==1], z$incstat[z$married==1], z$speducat[z$married==1]) 
ftable(ge_sp_edu, 1)





ftable(table(g1,g2,g3), row.vars=1:2)
ftable(xtabs(z$sexcat[z$educat==4 & z$married==1]+z$career1[z$educat==4 & z$married==1]+z$spwrkcat[z$educat==4 & z$married==1]), row.vars=1:2)
