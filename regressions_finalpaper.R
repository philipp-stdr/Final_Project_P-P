############################################
#     Regressions for the final paper      #
############################################



library(stargazer)

# Set working directory
setwd("~/Documents/CDA/collaborative_projects/Final_Project_P-P")

# Load the data set
load("data/data_final.rda")

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
#z$hrs_cat <- NULL
#z$hrs_cat[z$hrs1==0] <- 0
#z$hrs_cat[z$hrs1>0 & z$hrs1<10] <- 1
#z$hrs_cat[z$hrs1>=10 & z$hrs1<20] <- 2
#z$hrs_cat[z$hrs1>=20 & z$hrs1<30] <- 3
#z$hrs_cat[z$hrs1>=30 & z$hrs1<40] <- 4
#z$hrs_cat[z$hrs1>=40 & z$hrs1<50] <- 5
#z$hrs_cat[z$hrs1>=50 & z$hrs1<60] <- 6
#z$hrs_cat[z$hrs1>=60 & z$hrs1<70] <- 7
#z$hrs_cat[z$hrs1>=70 & z$hrs1<80] <- 8
#z$hrs_cat[z$hrs1>=80] <- 9

z$hrs_cat <- trunc(z$hrs1/10)
z$sphrs_cat <- trunc(z$sphrs1/10)

z$hrs_ft <- NULL
z$hrs_ft[z$hrs1<40] <- 0 
z$hrs_ft[z$hrs1>=40] <- 1

z$sphrs_ft <- NULL
z$sphrs_ft[z$sphrs1<40] <- 0 
z$sphrs_ft[z$sphrs1>=40] <- 1

z$working_ft <- as.numeric(z$working_ft)


#########################################
#      Family vs. high-income           #
#########################################

# Four possibilities. Use family or married and p25 or p50. 


t$income_status[t$career==1] <- "High-income"
t$income_status[t$career==0] <- "Low-income"

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

# p25 and family
ggplot() + 
  stat_summary(data = t[t$sex == 1 & t$educat==4,], aes(x=factor(meanhap), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = t[t$sex == 2 & t$educat==4,], aes(x=factor(meanhap), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Family-work combination", limits=c("Low-inc., no family", 
                                                       "High-inc., no family", "Low-inc., family", "High-inc., family")) +
  scale_y_continuous("Percentage very happy") +
  theme_bw()

# p50 and family
ggplot() + 
  stat_summary(data = t[t$sex == 1 & t$educat==4,], aes(x=factor(meanhap1), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = t[t$sex == 2 & t$educat==4,], aes(x=factor(meanhap1), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Family-work combination", limits=c("Low-inc., no family", 
                                                       "High-inc., no family", "Low-inc., family", "High-inc., family")) +
  scale_y_continuous("Percentage very happy") +
  theme_bw()


# p25 and married
ggplot() + 
  stat_summary(data = t[t$sex == 1 & t$educat==4,], aes(x=factor(meanhap_m), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = t[t$sex == 2 & t$educat==4,], aes(x=factor(meanhap_m), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Family-work combination", limits=c("Low-inc., no family", 
                                                       "High-inc., no family", "Low-inc., family", "High-inc., family")) +
  scale_y_continuous("Percentage very happy") +
  theme_bw()

# p50 and married
ggplot() + 
  stat_summary(data = t[t$sex == 1 & t$educat==4,], aes(x=factor(meanhap_m1), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = t[t$sex == 2 & t$educat==4,], aes(x=factor(meanhap_m1), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Family-work combination", limits=c("Low-inc., no family", 
                                                       "High-inc., no family", "Low-inc., family", "High-inc., family")) +
  scale_y_continuous("Percentage very happy") +
  theme_bw()

# Text: The graphical analysis of family constellation and high-income works in all four specifications.
# Makes life easier (y).



#########################################
#      Table 1                          #
#########################################


M1a <- lm(vhappyb ~ career1*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(z, sex==2 & educat == 4))
M2a <- lm(vhappyb ~ career1*married + age + agesq + as.factor(year) +as.factor(race) + as.factor(bdec), 
          data = subset(z, sex==1 & educat == 4))

M3a <- lm(vhappyb ~ career1*family + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(z, sex==2 & educat == 4))
M4a <- lm(vhappyb ~ career1*family + age + agesq + as.factor(year) +as.factor(race) + as.factor(bdec), 
          data = subset(z, sex==1 & educat == 4))


stargazer::stargazer(M1a, M2a, M3a, M4a,
                     type = 'text',
                     omit = c("age", "agesq", "year", "bdec", "race"),
                     omit.labels = c("Age", "Age-squared", "Year", "Race", "Cohort"),
                     column.labels = c("Women", "Men", "Women", "Men"),
                     dep.var.labels   = "Very happy")

## Issue: The first table (Bertrand's first) only makes sense for married vs. unmarried (both p25 and p50). 
## The graphical analysis preceding it is based on family, so they don't follow naturally. 
## --> It works a little for family with p25, but it is somewhat problematic. 


#########################################
#      Table 2                          #
#########################################

# Create a variable for partner's income
t$othinccat <- trunc(t$def_othinc/10000)
t$othinccat[is.na(t$othinc)] <- -1

# Regressions
M3 <- lm(vhappyb ~ career1 + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) 
         +  as.factor(bdec), data = subset(t, sex==2 & educat == 4 & married == 1))

M4 <- lm(vhappyb ~ career1 + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) 
         + as.factor(bdec), data = subset(t, sex==1 & educat == 4 & married == 1))

M5 <- lm(vhappyb ~ career + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) 
         +  as.factor(bdec), data = subset(t, sex==2 & educat == 4 & married == 1))

M6 <- lm(vhappyb ~ career + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) 
         + as.factor(bdec), data = subset(t, sex==1 & educat == 4 & married == 1))

stargazer(M3, M4, M5, M6,
                     type = 'text',
                     omit = c("othinccat", "age", "agesq", "year", "bdec", "race"),
                     omit.labels = c("Partner's income", "Age", "Age-squared", "Year", "Race", "Cohort"),
                     column.labels = c("Women", "Men"),
                     dep.var.labels   = "Very happy")

## Table 2 works best if we use p50.

################################################
# Table 2 framework but with young-child       #
################################################

LortF0 <- lm(vhappyb ~ career1 + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) 
         +  as.factor(bdec), data = subset(t, sex==2 & educat == 4 & family == 1))
summary(LortF0)

LortF1 <- lm(vhappyb ~  keepinghouse*young_child + young_child*career1 + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex==2 & educat == 4 & family == 1))
summary(LortF1)


LortM0 <- lm(vhappyb ~ career1 + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) 
             +  as.factor(bdec), data = subset(t, sex==1 & educat == 4 & married == 1))
summary(LortM0)

LortM1 <- lm(vhappyb ~ young_child*career1 + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
             data = subset(t, sex==1 & educat == 4 & family == 1))
summary(LortM1)

# We basically only have something with p50 and family. But Bertrand table 2 works best with marriage.
# But does this make any sense? Somewhat. Also what Bertrand finds. 


#############################################
#        Spouse-relationships               #
#############################################

# General spouse work status

## Spouse Work Status With Controls

SpF4 <- lm(vhappyb ~ spouse_ft + spouse_home + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & married ==1))
summary(SpF4)

table(t$spouse_home[t$sex==1 & t$educat == 4 & t$married == 1])

SpM4 <- lm(vhappyb ~ spouse_ft + spouse_pt + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & married ==1))
summary(SpM4)

#- Uncertain on perfect specification due to few but happy homegoing male spouses. But story: Men prefer their women 
#- to not work full-time, women the opposite, though not significant. 

# Spouse Work Status with controls - based on family. 
SpF5 <- lm(vhappyb ~ spouse_ft + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & family ==1))
summary(SpF5)

table(t$spouse_ft[t$sex==2 & t$educat == 4 & t$family == 1])

SpM5 <- lm(vhappyb ~ spouse_ft + spouse_pt + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & family ==1))
summary(SpM5)

#- Doesn't tell terribly much. 

# Spouse Work Status with controls - based on family and young children
SpF6 <- lm(vhappyb ~ spouse_ft*young_child + spouse_pt*young_child + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & family ==1))
summary(SpF6)

## Spouse work status and Marriage happiness

MarF1 <- lm(vhapmar ~ spouse_ft + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(z, sex == 2 & educat == 4 & married ==1))
summary(MarF1)

MarF2 <- lm(vhapmar ~ spouse_ft + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(z, sex == 2 & educat == 4 & family ==1))
summary(MarF2)

MarM1 <- lm(vhapmar ~ spouse_ft + spouse_pt + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(z, sex == 1 & educat == 4 & married ==1))
summary(MarM1)

MarM2 <- lm(vhapmar ~ spouse_ft + spouse_pt + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(z, sex == 1 & educat == 4 & family ==1))
summary(MarM2)

#- As we expect. Women significantly more happy when spouse is in full-time employment. 

## --> From here we need a double click. 

### Spouse-work and career ###

CarM <- lm(vhappyb ~ spouse_ft + spouse_home + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(z, sex == 1 & educat == 4 & married ==1 & career1 == 1))
summary(CarM)

CarF <- lm(vhappyb ~ spouse_ft + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(z, sex == 2 & educat == 4 & married ==1 & career == 1))
summary(CarF)

#- Women are substantially less happy with marriage when husband is working full-time and career1. 

CarM_mar <- lm(vhapmar ~ spouse_ft + spouse_home + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
               data = subset(z, sex == 1 & educat == 4 & married ==1 & career1 == 1))
summary(CarM_mar)

CarF_mar <- lm(vhapmar ~ spouse_ft + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
               data = subset(z, sex == 2 & educat == 4 & family ==1 & career1 == 1))
summary(CarF_mar)

#- The marriage happiness story here is quite strong. 

CarkidM_mar <- lm(vhapmar ~ spouse_ft + spouse_home + young_child + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
               data = subset(z, sex == 1 & educat == 4 & family ==1 & career1 == 1))
summary(CarkidM_mar)

CarkidF_mar <- lm(vhappyb ~ spouse_ft + young_child + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
                  data = subset(z, sex == 2 & educat == 4 & family ==1 & career1 == 1))
summary(CarkidF_mar)

#### Marriage happiness and young children ### 

############################################
#    Generational differences              #
############################################

## Populate!!! 

#- The results are quite sensitive to specification. 

# Three-way generational differences. 
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

# Take-aways (three cohorts):
# 1. p25/family: No generational differences (we can't have it all). Interesting difference in no-family scenario 
#    - newer generations report higher happiness when income is high. 
# 2. p50/family: Generational differences. Young can have it all, old can't. 
# 3. p25/married: Middle-way. We can kind of have it all, but not much. Weak story. 
# 4. p50/married: Generational differences / we can have it all. 

# Two-way generational differences

ggplot() + 
  stat_summary(data = t[t$sex == 1 & t$educat==4 & t$cohortd == 0,], aes(x=factor(meanhap_m1), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = t[t$sex == 1 & t$educat==4 & t$cohortd == 1,], aes(x=factor(meanhap_m1), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  scale_x_discrete("Family-work combination", limits=c("Low-inc., no family", 
                                                       "High-inc., no family", "Low-inc., family", "High-inc., family")) +
  scale_y_continuous("Percentage very happy") +
  theme_bw()

# Take away women: 
#- family, p25: No generational differences. 
#- family, p50: Generational differences.
#-married, p50: Big generational differences. (Good if that is our narrative). 
#- married, p25: Less pronounced, but small generational differences. Or probably not... 

#- Take-away men: With p25, family looks normal, whereas for married there is no happiness premium in new generations
#- With p50, family: the thing looks weird. Big generational differences. 
#- With p50, married: Stuff looks equally weird, also generational differences. 

## Regression framework.

M2c <- lm(vhappyb ~  cohortd*career1 + kid + cohortd*keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2c)

## Note: I have played around with it. Not anything signficant. Perhaps let's use three generations, avoid regressions
## and argue suggestively that generations don't seem to have an effect. 

## --> Requires family, p25, unfortunately. Except if we want to argue the opposite --> then marriage is quite good
## graphically. Espcially with p50, but we have very few observations. 