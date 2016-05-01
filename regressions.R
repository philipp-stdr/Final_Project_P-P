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

z$spouse_home <- NULL
z$spouse_home[z$spwrksta==7] <- 1
z$spouse_home[z$spwrksta==1 | z$spwrksta==2] <- 0


# Data-set "t" is limited to the years where "career" is defined
t <- z
t = t[t$year >= 1977 & t$year < 2012,]

# Regressions from Bertrand (2013), table 1
M1a <- lm(vhappy ~ career + married + career*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4))
summary(M1a)

M1c <- lm(vhappy ~ career + married + career*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & age>=40))
summary(M1c)

# Regressions from Bertrand (2013), table 1 - men
M1ma <- lm(vhappy ~ career + married + career*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4))
summary(M1ma)

M1mc <- lm(vhappy ~ career + married + career*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4 & age>=40))
summary(M1mc)

# Regressions from Bertrand (2013) - carrer1, table 1
M1a_c1 <- lm(vhappy ~ career1 + married + career1*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4))
summary(M1a_c1)

M1c_c1 <- lm(vhappy ~ career1 + married + career1*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & age>=40))
summary(M1c_c1)

# Regressions from Bertrand (2013)- carrer1, table 1 - men
M1ma_c1 <- lm(vhappy ~ career1 + married + career1*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex==1 & educat == 4))
summary(M1ma_c1)

M1mc_c1 <- lm(vhappy ~ career1 + married + career1*married + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
           data = subset(t, sex==1 & educat == 4 & age>=40))
summary(M1mc_c1)

# Regressions from Bertrand (2013), table 2

M2a <- lm(vhappy ~ career + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2a)

M2b <- lm(vhappy ~ career + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2b)

M2c <- lm(vhappy ~ career + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2c)

# Do the same for men
M3a <- lm(vhappy ~ career + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4 & married == 1))
summary(M3a)

M3b <- lm(vhappy ~ career + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4 & married == 1))
summary(M3b)

M3c <- lm(vhappy ~ career + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==1 & educat == 4 & married == 1))
summary(M3c)

# Regressions from Bertrand (2013), table 2 (career 1)

M2a_c1 <- lm(vhappy ~ career1 + age + agesq + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2a_c1)

M2b_c1 <- lm(vhappy ~ career1 + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2b_c1)

M2c_c1 <- lm(vhappy ~ career1 + keepinghouse + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
          data = subset(t, sex==2 & educat == 4 & married == 1))
summary(M2c_c1)

# Do the same for men (carreer1)
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

## Life-satisfaction penalty

# Bertrand table 2, including child dummy (career1)

W3c_c1 <- lm(vhappy ~ career1 + keepinghouse + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
             data = subset(t, sex==2 & educat == 4 & married == 1))
summary(W3c_c1)

Men3c_c1 <- lm(vhappy ~ career1 + keepinghouse + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
             data = subset(t, sex==1 & educat == 4 & married == 1))
summary(Men3c_c1)

# Bertrand table 2, including child and interaction (career1)

W3c_c1_k <- lm(vhappy ~ career1 + keepinghouse + kid + kid*career1 + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex==2 & educat == 4 & married == 1))
summary(W3c_c1_k)

Men3c_c1_k <- lm(vhappy ~ career1 + keepinghouse + kid + kid*career1 + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
              data = subset(t, sex==1 & educat == 4 & married == 1))
summary(Men3c_c1_k)

stargazer(W3c_c1, W3c_c1_k, Men3c_c1, Men3c_c1_k, type="text",
          out="bertrand table 2 - career1 - kids.txt")


## New section: What determines loss of life-satisfaction. 

PenM1 <- lm(vhappy ~ career1 + married + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
                 data = subset(t, sex == 1 & educat == 4 & vjobsat1 == 1))
summary(PenM1)

PenF1 <- lm(vhappy ~ career1 + married + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 2 & educat == 4 & vjobsat1 == 1))
summary(PenF1)

PenM2 <- lm(vhappy ~ career1 + married + married*career1 + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 1 & educat == 4 & vjobsat1 == 1))
summary(PenM2)

PenF2 <- lm(vhappy ~ career1 + married + married*career1 + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
            data = subset(t, sex == 2 & educat == 4 & vjobsat1 == 1))
summary(PenF2)

PenM3 <- lm(vhappy ~ career1 + married + married*career1 + hrs1 + kid + age + agesq + as.factor(othinccat) + as.factor(year) + as.factor(race) + as.factor(bdec), 
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

## New double click

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