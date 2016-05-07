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
## We could inquire in certain types of occupations, e.g. managerial occupations. 


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

table(t$cohortc)

# Cohort specific tests

t$income_status[t$career==1] <- "High-income"
t$income_status[t$career==0] <- "Low-income"

# Following Bertrand (2013), respondents who report no income (Not applicable) is coded as
# having low-income. Thus there are no N/A's in the career variables (see also below). 


t$meanhap <- NA
t$meanhap[t$family==0 & t$career1==0] <- "Low-inc., no family"
t$meanhap[t$family==0 & t$career1==1] <- "High-inc., no family"
t$meanhap[t$family==1 & t$career1==0] <- "Low-inc., family"
t$meanhap[t$family==1 & t$career1==1] <- "High-inc., family"

ggplot() + 
  stat_summary(data = t[t$sex == 2 & t$educat==4 & t$cohort == 4,], aes(x=factor(meanhap), y=vhappyb), 
               fun.y="mean", geom="point", col="Navyblue") +
  stat_summary(data = t[t$sex == 2 & t$educat==4 & t$cohort == 5,], aes(x=factor(meanhap), y=vhappyb), 
               fun.y="mean", geom="point", col="Red") +
  stat_summary(data = t[t$sex == 2 & t$educat==4 & t$cohort == 6,], aes(x=factor(meanhap), y=vhappyb), 
               fun.y="mean", geom="point", col="Purple") +
    scale_x_discrete("Family-work combination", limits=c("Low-inc., no family", 
                                                       "High-inc., no family", "Low-inc., family", "High-inc., family")) +
  scale_y_continuous("Percentage very happy") +
  theme_bw()

table(t$meanhap[t$sex == 2 & t$educat==4 & t$cohort == 4])
table(t$meanhap[t$sex == 2 & t$educat==4 & t$cohort == 5])
table(t$meanhap[t$sex == 2 & t$educat==4 & t$cohort == 6])
