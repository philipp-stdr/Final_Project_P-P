#########################################
#         Fun and regressions           #
#########################################


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

# Data-set "t" is limited to the years where "career" is defined
t <- z
t = t[t$year >= 1977 & t$year < 2012,]

# Replications of Table 1 in Bertrand (2013)
M1a <- lm(vhappy ~ career*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4))
summary(M1a)

M1c <- lm(vhappy ~ career*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & age>=40))
summary(M1c)

# Replications of Table 1 in Bertrand (2013) - Men instead of women.
M1ma <- lm(vhappy ~ career + married + career*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4))
summary(M1ma)

M1mc <- lm(vhappy ~ career + married + career*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4 & age>=40))
summary(M1mc)

# Replications of Table 1 in Bertrand (2013) - p50 carreer variable
M1a_c1 <- lm(vhappy ~ career1 + married + career1*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4))
summary(M1a_c1)

M1c_c1 <- lm(vhappy ~ career1 + married + career1*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & age>=40))
summary(M1c_c1)

# Replications of Table 1 in Bertrand (2013) - p50 carreer variable - Men sample
M1ma_c1 <- lm(vhappy ~ career1 + married + career1*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex==1 & educat == 4))
summary(M1ma_c1)

M1mc_c1 <- lm(vhappy ~ career1 + married + career1*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex==1 & educat == 4 & age>=40))
summary(M1mc_c1)

# Replication of Table 2 in Bertrand (2013)

M2a <- lm(vhappy ~ career + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2a)

M2b <- lm(vhappy ~ career + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2b)

M2c <- lm(vhappy ~ career + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2c)

# # Replication of Table 2 in Bertrand (2013): Male sample
M3a <- lm(vhappy ~ career + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4 & married == 1))
summary(M3a)

M3b <- lm(vhappy ~ career + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4 & married == 1))
summary(M3b)

M3c <- lm(vhappy ~ career + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4 & married == 1))
summary(M3c)

# # Replication of Table 2 in Bertrand (2013): p50 career variable 

M2a_c1 <- lm(vhappy ~ career1 + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2a_c1)

M2b_c1 <- lm(vhappy ~ career1 + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2b_c1)

M2c_c1 <- lm(vhappy ~ career1 + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2c_c1)

# # Replication of Table 2 in Bertrand (2013): p50 career variable - Men sample
M3a_c1 <- lm(vhappy ~ career1 + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4 & married == 1))
summary(M3a_c1)

M3b_c1 <- lm(vhappy ~ career1 + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4 & married == 1))
summary(M3b_c1)

M3c_c1 <- lm(vhappy ~ career1 + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4 & married == 1))
summary(M3c_c1)

# Stargazer output
stargazer(M2a, M2b, M2c, M3a, M3b, M3c, type="text",
         out="bertrand table 2 - women and men.txt")

stargazer(M2a_c1, M2b_c1, M2c_c1, M3a_c1, M3b_c1, M3c_c1, type="text",
          out="bertrand table 2 - career1 - women and men.txt")

stargazer(M1a, M1c, M1ma, M1mc, type="text",
          out="bertrand table 1 - women and men.txt")

stargazer(M1a_c1, M1c_c1, M1ma_c1, M1mc_c1, type="text",
          out="bertrand table 1 - career1 - women and men.txt")


# Bertrand table 2, including child dummy (career1)

W3c_c1 <- lm(vhappy ~ career1 + keepinghouse + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
             data = subset(t, sex==2 & educat == 4 & married == 1))
summary(W3c_c1)

Men3c_c1 <- lm(vhappy ~ career1 + keepinghouse + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
             data = subset(t, sex==1 & educat == 4 & married == 1))
summary(Men3c_c1)

## Adding a dummy for children does not change the overall results.

# Bertrand table 2, including child and interaction (career1)

W3c_c1_k <- lm(vhappy ~ career1 + keepinghouse + kid + kid*career1 + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex==2 & educat == 4 & married == 1))
summary(W3c_c1_k)

Men3c_c1_k <- lm(vhappy ~ career1 + keepinghouse + kid + kid*career1 + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
              data = subset(t, sex==1 & educat == 4 & married == 1))
summary(Men3c_c1_k)

stargazer(W3c_c1, W3c_c1_k, Men3c_c1, Men3c_c1_k, type="text",
          out="bertrand table 2 - career1 - kids.txt")

table(t$kid[t$sex==1 & t$educat == 4 & t$married == 1])
################################################################

## New section: What determines loss of life-satisfaction. 

PenM1 <- lm(vhappy ~ career1 + married + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
                 data = subset(t, sex == 1 & educat == 4 & vjobsat1 == 1))
summary(PenM1)

PenF1 <- lm(vhappy ~ career1 + married + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 2 & educat == 4 & vjobsat1 == 1))
summary(PenF1)

PenM2 <- lm(vhappy ~ married*career1 + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 1 & educat == 4 & vjobsat1 == 1))
summary(PenM2)

PenF2 <- lm(vhappy ~ married*career1 + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 2 & educat == 4 & vjobsat1 == 1))
summary(PenF2)

PenM3 <- lm(vhappy ~ married*career1 + hrs1 + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 1 & educat == 4 & vjobsat1 == 1))
summary(PenM3)

PenF3 <- lm(vhappy ~ career1 + married + married*career1 + hrs1 + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 2 & educat == 4 & vjobsat1 == 1))
summary(PenF3)

PenM4 <- lm(vhappy ~ career1 + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 1 & educat == 4 & married == 1 & vjobsat1 == 1))
summary(PenM4)

PenF4 <- lm(vhappy ~ career1 + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 2 & educat == 4 & married == 1 & vjobsat1 == 1))
summary(PenF4)

## Spouse work

PenM5 <- lm(vhappy ~ career1 + spouse_ft + spouse_home + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 1 & educat == 4 & married == 1 & vjobsat1 == 1))
summary(PenM5)

PenF5 <- lm(vhappy ~ career1 + spouse_ft + spouse_home + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 2 & educat == 4 & married == 1 & vjobsat1 == 1))
summary(PenF5)

stargazer(PenM1, PenF1, PenM2, PenF2, PenM3, PenF3, PenM4, PenF4, PenM5, PenF5, type="text",
          out="New regressions - lifesat penalty.txt")

## New double click --> Importance of spouse work

PenM6 <- lm(vhappy ~ career1 + spouse_ft + spouse_home + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 1 & educat == 4 & family == 1 & vjobsat1 == 1))
summary(PenM6)

PenF6 <- lm(vhappy ~ career1 + spouse_ft + spouse_home + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 2 & educat == 4 & family == 1 & vjobsat1 == 1))
summary(PenF6)

PenM7 <- lm(vhappy ~ career1 + career1*kid + spouse_ft + spouse_home + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 1 & educat == 4 & family == 1 & vjobsat1 == 1))
summary(PenM7)

PenF7 <- lm(vhappy ~ career1 + career1*kid + spouse_ft + spouse_home + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 2 & educat == 4 & family == 1 & vjobsat1 == 1))
summary(PenF7)



stargazer(PenM6, PenF6, PenM7, PenF7, type="text",
          out="New regressions 2 - lifesat penalty.txt")

######################################
## Spouse hrs worked (cat)

SpF1 <- lm(vhappy ~ as.factor(hrs_cat) + as.factor(sphrs_cat) + spouse_home + kid + as.factor(rinccat) + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & married ==1))
summary(SpF1)

SpM1 <- lm(vhappy ~ as.factor(hrs_cat) + as.factor(sphrs_cat) + spouse_home + kid + as.factor(rinccat) + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & married ==1))
summary(SpM1)

# --> interesting difference here! women don't like to work more than 40 hrs and don't like their husbands working less than 30 hrs (10%)

## Spouse hrs worked (dummy)

SpF2 <- lm(vhappy ~ hrs_ft + sphrs_ft + spouse_home + kid + keepinghouse + as.factor(rinccat) + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & married ==1))
summary(SpF2)

SpM2 <- lm(vhappy ~ hrs_ft + sphrs_ft + spouse_home + keepinghouse + kid + as.factor(rinccat) + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & married ==1))
summary(SpM2)

######################################### 
# keepinghouse working_pt working_ft 
# spouse_home spouse_pt spouse_ft

## Spouse Work Status (people with high job sat)

SpF3 <- lm(vhappyb ~ spouse_ft + spouse_pt + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & married ==1 & vjobsat1 == 1))
summary(SpF3)

SpM3 <- lm(vhappyb ~ spouse_ft + spouse_pt + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 1 & educat == 4 & married ==1 & vjobsat1 == 1))
summary(SpM3)
# --> Interesting Non-findings: For people who are very happy with their job, spouse work status does not impact life happiness

## Spouse Work Status

SpF4 <- lm(vhappyb ~ spouse_ft + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & married ==1))
summary(SpF4)

SpM4 <- lm(vhappy ~ spouse_ft + spouse_pt + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & married ==1))
summary(SpM4)

# --> Men are significantly less happy when spouse works ft. [Also if you drop spouse_pt]

## Quick attempt: For women comparing to homegoing men might not make sense 
SpF4_test <- lm(vhappyb ~ spouse_ft + spouse_home + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
                data = subset(t, sex == 2 & educat == 4 & married ==1))
summary(SpF4_test)

## Change base category to pt

SpF5 <- lm(vhappy ~ spouse_ft + spouse_home + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & married ==1))
summary(SpF5)

SpM5 <- lm(vhappy ~ spouse_ft + spouse_home + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & married ==1))
summary(SpM5)

## Spouse Work Status (nonft)

SpF5 <- lm(vhappy ~ sp_nonft + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & married ==1))
summary(SpF5)

SpM5 <- lm(vhappy ~ sp_nonft + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & married ==1))
summary(SpM5)

########################
## Marriage happiness  #
########################

## Spouse hrs worked (cat)

MarF1 <- lm(vhapmar ~ as.factor(hrs_cat) + as.factor(sphrs_cat) + spouse_home + kid + as.factor(rinccat) + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & married ==1))
summary(MarF1)

MarM1 <- lm(vhapmar ~ as.factor(hrs_cat) + as.factor(sphrs_cat) + spouse_home + kid + as.factor(rinccat) + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & married ==1))
summary(MarM1)

## Spouse work status

MarF2 <- lm(vhapmar ~ spouse_ft + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & married ==1))
summary(MarF2)

MarM2 <- lm(vhapmar ~ spouse_ft + spouse_pt + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & family ==1))
summary(MarM2)

################################
## Comparing men and women     #
################################

GM1 <- lm(vhappy ~ sex*sp_nonft + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, educat == 4 & married ==1))
summary(GM1)

GM2 <- lm(vhappy ~ sex*spouse_home + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, educat == 4 & married ==1))
summary(GM2)


###################################################
#   Specifications focusing on career individuals #
###################################################

CarM <- lm(vhappyb ~ spouse_ft + spouse_home + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & family ==1 & career1 == 1))
summary(CarM)

CarF <- lm(vhappy ~ spouse_ft + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & family ==1 & career == 1))
summary(CarF)

CarM_mar <- lm(vhapmar ~ spouse_ft + spouse_home + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & married ==1 & career1 == 1))
summary(CarM_mar)

#- Men are less happy with their marriage when they have a career (p50 only) and wife works full time. 
#- Works for family as well as marriage. 

CarM_mar2 <- lm(vhapmar ~ spouse_ft + spouse_home + kid + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
               data = subset(t, sex == 1 & educat == 4 & married ==1 & career1 == 1))
summary(CarM_mar2)

CarF_mar <- lm(vhapmar ~ spouse_ft + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
               data = subset(t, sex == 2 & educat == 4 & married ==1 & career1 == 1))
summary(CarF_mar)

CarF_mar <- lm(vhapmar ~ spouse_ft + kid + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
               data = subset(t, sex == 2 & educat == 4 & married ==1 & career1 == 1))
summary(CarF_mar)

#- Opposite for women, but nowhere close to significance. 


#- These two regressions are quite interesting. Analysis of career individuals. 
############### !!!!!!!!!!! ##############

CarM_job <- lm(vjobsat1 ~ spouse_ft + spouse_home + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 1 & educat == 4 & married ==1 & career1 == 1))
summary(CarM_job)


CarF_mar <- lm(vhappy ~ spouse_ft + kid + as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & family ==1 & career == 1))
summary(CarF)




###############################################
#        Games with small children            #
###############################################


t$young_child <- 0
t$young_child[t$old1 <= 4 | t$old2 <= 4 | t$old3 <= 4 | t$old4 <= 4 | t$old5 <= 4 | t$old6 <= 4 
              | t$old7 <= 4 | t$old8 <= 4 | t$old9 <= 4 | t$old10 <= 4] <- 1

t$young_child2 <- 0
t$young_child2[t$old1 <= 2 | t$old2 <= 2 | t$old3 <= 2 | t$old4 <= 2 | t$old5 <= 2 | t$old6 <= 2 
               | t$old7 <= 2 | t$old8 <= 2 | t$old9 <= 2 | t$old10 <= 2] <- 1


# Replication of Table 2 in Bertrand (2013)
Lort1 <- lm(vhappyb ~  keepinghouse*young_child + young_child*career1 + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex==2 & educat == 4 & family == 1))
summary(Lort1)

#- This is pretty sweet. Women with a family are much more happy with their career when they don't have a small child. 

Lort2 <- lm(vhapmar ~  keepinghouse*young_child + young_child*career1 + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex==2 & educat == 4 & family == 1))
summary(Lort2)

#- On marriage happiness, women can have it all. But less so when both having a career and young child. 

Lort3 <- lm(vhappyb ~  young_child*career1 + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex==1 & educat == 4 & family == 1))
summary(Lort3)


###############
# What else can I do? 
###########

CarF <- lm(vhappy ~ spouse_ft*young_child+ as.factor(inccat) + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & family ==1 & career == 1))
summary(CarF)

#- When looking at women with a career, there is no penalty to having a young child. 

CarM <- lm(vhappyb ~ spouse_ft*young_child +  age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & family ==1))
summary(CarM)

#- The spouse analysis doesn't seem to be driven by child age. Why not?




################################################
# Management                                   #
################################################

t$management <- NA
t$management[t$year >= 1988] <- 0
t$management[t$year >= 1988 & t$occ80 < 40] <- 1

table(t$management)

Test <- lm(vhappyb ~ management*young_child + as.factor(othinccat) +  age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex == 2 & educat == 4 & family ==1))
summary(Test)
