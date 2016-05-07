###############################
# Analysis supplement         #
###############################


library(stargazer)
library(ggplot2)
library(plyr)

# Set working directory
setwd("~/Documents/CDA/collaborative_projects/Final_Project_P-P")

# Variables
t$d_sex <- t$sex == 1
t$d_sex <- as.numeric(t$d_sex)

t$rinccat_new <- trunc(t$def_rinc/5000)
t$rinccat_new[is.na(t$def_rinc)] <- -1
table(t$rinccat_new)

# Descriptive analysis: Income-buckets and average happiness

ggplot() + 
  stat_summary(data = t[t$sex == 1 & t$educat == 4,], aes(x=factor(rinccat_new), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") + 
  stat_summary(data = t[t$sex == 2 & t$educat == 4,], aes(x=factor(rinccat_new), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") + 
  scale_x_discrete("Respondent income group") +
  scale_y_continuous("Percentage very happy") +
  expand_limits(y=c(20,60)) +
  theme_bw()


################################
# Adding loess lines to charts #
################################


# Collapsed data
test <- ddply(t[t$educat == 4,], c("rinccat_new", "sex"), summarise,
              vhappyb = mean(vhappyb, na.rm=TRUE))

test <- na.omit(test)

ggplot() +
  geom_point(data = test[test$sex == 1,], aes(x=rinccat_new, y=vhappyb), color="Navyblue") + 
  geom_point(data = test[test$sex == 2,], aes(x=rinccat_new, y=vhappyb), color="Red") +
  stat_smooth(data = test[test$sex == 2,], aes(x=rinccat_new, y=vhappyb), method ="loess") +
  stat_smooth(data = test[test$sex == 1,], aes(x=rinccat_new, y=vhappyb), method ="loess", col="green")

  
ggplot(test, aes(x=rinccat_new, y=vhappyb)) +
  geom_smooth(method ="loess", formula = y ~ x)

#####################################
# Job-satisfaction across genders   #
#####################################

Jobsat1 <- lm(vjobsat1 ~ kid*d_sex*career1 + as.factor(occ80),
            data = subset(t, educat == 4 & married == 1))
summary(Jobsat1)

Jobsat1 <- lm(vjobsat1 ~ career1*sex + career1*kid + spouse_ft + spouse_home + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
              data = subset(t, sex == 2 & educat == 4 & family == 1 & vjobsat1 == 1))
summary(Jobsat1)

## Preliminary result: Women does not seem to derive less happiness from work. 
## We could inquire in certain types of occupations, e.g. managerial occupations, but I am not hopefull. 


########################################
#  A cohortian inquiry                 #
########################################

# Cohort variable creation (from prep_dynamic)
# z$cohort <- NA
# z$cohort[z$by>=1898 & z$by<=1923] <- 2
# z$cohort[z$by>=1924 & z$by<=1943] <- 3
# z$cohort[z$by>=1944 & z$by<=1957] <- 4
# z$cohort[z$by>=1958 & z$by<=1973] <- 5
# z$cohort[z$by>=1974 & z$by<=1991] <- 6

# z$cohortb <- NA
# z$cohortb[z$cohort<=3] <- 3
# z$cohortb[z$cohort==4] <- 4
# z$cohortb[z$cohort>=5] <- 5

t$cohortc <- NA
t$cohortc[t$by>=1898 & z$by<=1940] <- 2
t$cohortc[t$by>=1941 & t$by<=1969] <- 3
t$cohortc[t$by>=1970 & t$by<=2000] <- 4

t$cohortd <- NA
t$cohortd[t$by>=1941 & t$by<=1959] <- 0
t$cohortd[t$by>=1960 & t$by<=2000] <- 1

table(t$cohortd)

## Cohort specific tests - Family based ## 

t$income_status[t$career==1] <- "High-income"
t$income_status[t$career==0] <- "Low-income"

# Following Bertrand (2013), respondents who report no income (Not applicable) is coded as
# having low-income. Thus there are no N/A's in the career variables (see also below). 

t$meanhap <- NA
t$meanhap[t$family==0 & t$career==0] <- "Low-inc., no family"
t$meanhap[t$family==0 & t$career==1] <- "High-inc., no family"
t$meanhap[t$family==1 & t$career==0] <- "Low-inc., family"
t$meanhap[t$family==1 & t$career==1] <- "High-inc., family"

t$meanhap1 <- NA
t$meanhap1[t$family==0 & t$career1==0] <- "Low-inc., no family"
t$meanhap1[t$family==0 & t$career1==1] <- "High-inc., no family"
t$meanhap1[t$family==1 & t$career1==0] <- "Low-inc., family"
t$meanhap1[t$family==1 & t$career1==1] <- "High-inc., family"

# Based on marriage rather than family

t$meanhap_m <- NA
t$meanhap_m[t$married==0 & t$career==0] <- "Low-inc., no family"
t$meanhap_m[t$married==0 & t$career==1] <- "High-inc., no family"
t$meanhap_m[t$married==1 & t$career==0] <- "Low-inc., family"
t$meanhap_m[t$married==1 & t$career==1] <- "High-inc., family"

t$meanhap_m1 <- NA
t$meanhap_m1[t$family==0 & t$career1==0] <- "Low-inc., no family"
t$meanhap_m1[t$family==0 & t$career1==1] <- "High-inc., no family"
t$meanhap_m1[t$family==1 & t$career1==0] <- "Low-inc., family"
t$meanhap_m1[t$family==1 & t$career1==1] <- "High-inc., family"

# - ggplot based on three cohorts
ggplot() + 
  stat_summary(data = t[t$sex == 2 & t$educat==4 & t$cohort == 4,], aes(x=factor(meanhap_m1), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = t[t$sex == 2 & t$educat==4 & t$cohort == 5,], aes(x=factor(meanhap_m1), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  stat_summary(data = t[t$sex == 2 & t$educat==4 & t$cohort == 6,], aes(x=factor(meanhap_m1), y=vhappyb), 
               fun.y="mean", geom="point", col="Purple") +
    scale_x_discrete("Family-work combination", limits=c("Low-inc., no family", 
                                                       "High-inc., no family", "Low-inc., family", "High-inc., family")) +
  scale_y_continuous("Percentage very happy") +
  theme_bw()

#- Take-aways: 1. With family and p25, we have a narrative that there are few generational changes. Issue, it cannot
#- be implemented in a regression design as the observations are way too few in the high-income, family group. 
#- 2. With p50, family, the point is different in high, fam, who "have it all". However, there is no significance. 
#- 3. Married and p25 the narrative is blurry. But we do seem to see a "bettering". 

# - test of observation distribution
table(t$meanhap_m1[t$sex == 2 & t$educat==4 & t$cohort == 4])
table(t$meanhap_m1[t$sex == 2 & t$educat==4 & t$cohort == 5])
table(t$meanhap_m1[t$sex == 2 & t$educat==4 & t$cohort == 6])


# - ggplot based on two cohorts

ggplot() + 
  stat_summary(data = t[t$sex == 2 & t$educat==4 & t$cohortd == 1,], aes(x=factor(meanhap1), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = t[t$sex == 2 & t$educat==4 & t$cohortd == 2,], aes(x=factor(meanhap1), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Family-work combination", limits=c("Low-inc., no family", 
                                                       "High-inc., no family", "Low-inc., family", "High-inc., family")) +
  scale_y_continuous("Percentage very happy") +
  theme_bw()

# Take away women: 
#- family, p25: No generational differences. 
#- family, p50: Generational differences.
#-married, p50: Big generational differences. (Good) 
#- married, p25: Less pronounced, but same story.

#- Take-away men: With p25, family looks normal, whereas for married there is no happiness premium in new generations
#- With p50, family: the thing looks weird. Big generational differences. 
#- With p50, married: Stuff looks equally weird, also generational differences. 

#- test of observation distribution
table(t$meanhap1[t$sex == 2 & t$educat==4 & t$cohortd == 1])
table(t$meanhap1[t$sex == 2 & t$educat==4 & t$cohortd == 2])

# Regression framework

# Bertrand table 2; married - cohorts
M2c <- lm(vhappy ~ career + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4 & family == 1 & cohortd==2))
summary(M2c)

# Bertrand table 2; no cohort controls
M2c <- lm(vhappy ~  cohortd*career1 + cohortd*keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race), 
          data = subset(t, sex==2 & educat == 4 & family == 1))
summary(M2c)

#- cohortd*career1 for married individuals shows signs of something. 

# Bertrand table 2; married and career1
M2c_c1 <- lm(vhappy ~ career1 + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
             data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2c_c1)
