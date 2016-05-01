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

stargazer(m1, m2, m3, m4, type="text",
          dep.var.labels=c("Miles/(US) gallon","Fast car (=1)"),
          covariate.labels=c("Gross horsepower","Rear axle ratio","Four foward gears",
                             "Five forward gears","Type of transmission (manual=1)"), out="models.txt")
