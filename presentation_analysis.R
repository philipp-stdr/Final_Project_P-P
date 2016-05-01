##################################################
# Brainstorm Analysis #
##################################################

# set your working directory.
setwd("~/R_data/Final_Project_P-P") # Staender
setwd("~/Documents/CDA/collaborative_projects/Final_Project_P-P") # Unger

(library(ggplot2)
library(dplyr)
library(plyr)
library(repmis)
library(MASS)
library(Hmisc)
)
#load dataset
load("~/R_data/Final_Project_P-P/data/data_final.rda")

##################################################
#Create/manipulate variables
##################################################

# Variables from Assignment 3

##Fig1
happy_dist <- table(z$happy)/sum(table(z$happy))*100
satjob_dist <- table(z$satjob)/sum(table(z$happy))*100

##Fig5
z$workstatus <- NA
z$workstatus[z$wrkstat==1] <- "Full-time work"
z$workstatus[z$wrkstat==2] <- "Part-time work"
z$workstatus[z$wrkstat==7] <- "Keeping house"


##Fig6
#z = z[z$year >= 1977 & z$year < 2012,] #Keep in mind that using the career/income variable requires to 
                                        # limit the sample.

z$income_status[z$career==1] <- "High-income"
z$income_status[z$career==0] <- "Low-income"

z$career1 <- z$rinc > z$p50
z$career1 <- as.numeric(z$career1)
z$career1[is.na(z$career1)] <- 0 

z$income_status1[z$career1==1] <- "High-income"
z$income_status1[z$career1==0] <- "Low-income"

##Fig7
z$meanhap <- NA
z$meanhap[z$family==0 & z$career==0] <- "Low-inc., no family"
z$meanhap[z$family==0 & z$career==1] <- "High-inc., no family"
z$meanhap[z$family==1 & z$career==0] <- "Low-inc., family"
z$meanhap[z$family==1 & z$career==1] <- "High-inc., family"

##Fig8
z$working_ft <- as.numeric(z$working_ft)
z$working_pt <- as.numeric(z$working_pt)

# Additional variables

##Spouse Education
z$speducat <- NA
z$speducat[z$speduc<12] <- 1
z$speducat[z$speduc==12] <- 2
z$speducat[z$speduc>12 & z$speduc<16] <- 3
z$speducat[z$speduc>=16] <- 4

##Education match 
z$coupedu <- NA
z$coupedu[z$educat<4 & z$speducat<4] <- "R low, Sp low"
z$coupedu[z$educat==4 & z$speducat<4] <- "R high, Sp low"
z$coupedu[z$educat<4 & z$speducat==4] <- "R low, Sp high"
z$coupedu[z$educat==4 & z$speducat==4] <- "R high, Sp high"
table(z$coupedu, z$sex)

##R share of family income

z$shareinc <- NA
z$shareinc <- z$def_rinc/z$def_inc
describe(z$shareinc)

##Breadwinner
z$breadwin <- NA
z$breadwin[z$married==1 & z$shareinc<0.3] <- 0
z$breadwin[z$married==1 & z$shareinc>=0.3 & z$shareinc<0.7] <- 1
z$breadwin[z$married==1 & z$shareinc>0.7] <- 2
table(z$breadwin, z$sex)

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


###
table(z$vhapmar, z$vhappyb)
table(z$vhapmar, z$satjob)
table(z$kid, z$happy)
### 
tab_hapma_sex <- table(z$hapmar, z$sex)
prop.table(tab_hapma_sex, 2)

describe(z$satjob)
##################################################
#Additional analysis
##################################################

# Family Income and happiness 
ggplot(z, aes(x=factor(inc), y=vhappyb)) + stat_summary(fun.y="mean", geom="bar", fill="navyblue")

# Respondents Income and happiness
ggplot(z, aes(x=factor(def_rinc), y=vhappyb)) + stat_summary(fun.y="mean", geom="bar", fill="navyblue")

# Education matches within married couples
ggplot() + 
  stat_summary(data = z[z$sex == 1,], aes(x=factor(coupedu), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = z[z$sex == 2,], aes(x=factor(coupedu), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("College educ of respondent and spouse ", limits=c("R low, Sp low", 
                   "R high, Sp low", "R low, Sp high", "R high, Sp high")) +
  scale_y_continuous("Percentage very happy") +
  theme_bw()

# Happiness of breadwinner
ggplot() + 
  stat_summary(data = z[z$sex == 1 & z$educat==4,], aes(x=factor(breadwin), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = z[z$sex == 2 & z$educat==4,], aes(x=factor(breadwin), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Breadwinner") +
  scale_y_continuous("Percentage very happy") +
  theme_bw()

# Happiness of breadwinner
ggplot() + 
  stat_summary(data = z[z$sex == 1 & z$educat==4,], aes(x=factor(breadwin), y=vhapmar), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = z[z$sex == 2 & z$educat==4,], aes(x=factor(breadwin), y=vhapmar), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Breadwinner") +
  scale_y_continuous("Percentage very happy with marriage") +
  theme_bw()

#Happiness of having kids
ggplot() + 
  stat_summary(data = z[z$sex == 1 & z$educat==4 & z$married==1,], aes(x=factor(kid), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = z[z$sex == 2 & z$educat==4 & z$married==1,], aes(x=factor(kid), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Having kid") +
  scale_y_continuous("Percentage very happy with marriage") +
  theme_bw()

ggplot() + 
  stat_summary(data = z[z$sex == 1 & z$educat==4 & z$married==1 & z$age < 35,], aes(x=factor(kid), y=vjobsat1), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = z[z$sex == 2 & z$educat==4 & z$married==1 & z$age < 35,], aes(x=factor(kid), y=vjobsat1), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Having kid") +
  scale_y_continuous("Percentage very happy") +
  expand_limits(y=c(0.20,0.60)) +
  theme_bw()

#Kids and happiness
ggplot() + 
  stat_summary(data = z[z$sex == 1 & z$educat==4 & z$married==1 & z$career1 == 1,], aes(x=factor(kid), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = z[z$sex == 2 & z$educat==4 & z$married==1 & z$career1 == 1,], aes(x=factor(kid), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Having kid") +
  scale_y_continuous("Percentage very happy") +
  expand_limits(y=c(0.20,0.60)) +
  theme_bw()

#Kids and job happiness
ggplot() + 
  stat_summary(data = z[z$sex == 1 & z$educat==4 & z$married==1 & z$career1 == 1,], aes(x=factor(kid), y=satjob), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = z[z$sex == 2 & z$educat==4 & z$married==1 & z$career1 == 1,], aes(x=factor(kid), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Having kid") +
  scale_y_continuous("Percentage very happy") +
  expand_limits(y=c(0.20,0.60)) +
  theme_bw()

#Kids and happiness with marriage
ggplot() + 
  stat_summary(data = z[z$sex == 1 & z$educat==4 & z$married==1 & z$career1 == 1,], aes(x=factor(kid), y=vhapmar), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = z[z$sex == 2 & z$educat==4 & z$married==1 & z$career1 == 1,], aes(x=factor(kid), y=vhapmar), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Having kid") +
  scale_y_continuous("Percentage very happy") +
  expand_limits(y=c(0.20,0.60)) +
  theme_bw()


