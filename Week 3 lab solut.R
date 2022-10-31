#week 3 lab sol r

#Q2.1 

#[a]
#internet <- read.csv("internet.csv")
internet <- read.csv(file.choose())
internet <- data.frame(internet)
head(internet)
#attach(internet)
#plot(Int ~ Gdp)
#lm(Int ~ Gdp)

my.result <- lm(Int ~ Gdp, data=internet)
abline(my.result)

#[b]
Gdp_new <- 20
Int_fit <- my.result$coefficients[1] + my.result$coefficients[2] * Gdp_new
Int_fit
round(Int_fit, 3)  # round it to have 3 dp

Gdp_new2 <- data.frame(Gdp = c(20,28) )
predict(lm(Int ~ Gdp, data=internet), newdata=Gdp_new2)

#[C] 
#? plot
plot(Int ~ Gdp, data=internet, main="My Fav Plot", xlab="Gdp pc", ylab="Int user %")
abline(my.result)
anova(my.result)   

summary(my.result)


####### additional below
Logint <- log(Int)
my.result2 <- lm(Logint ~ Gdp)
summary(my.result2)

plot(Logint ~ Gdp)
abline(my.result2)
plot(Int ~ Gdp)
plot(my.result2, 1)

Sqrtint <- Int^0.5
Sqrtint <- sqrt(Int)
plot(Sqrtint ~ Gdp)
mr3 <- lm(Sqrtint ~ Gdp)
summary(mr3)

abline(mr3)
Loggdp <- log(Gdp)
plot(Logint ~ Loggdp)

mr4 <- lm(Logint ~ Loggdp)
abline(mr4)
summary(mr4)

#Q2

electricity <- read.csv(file.choose())

head(electricity)
attach(electricity) 
head(electricity, 3) #display first 3 values

#[a]
 
# Economically, Gdp may have pisitive impact on Elec, 
# so b1 > 0

#[b]
plot(Elec ~ Gdp) #positive, strong, linear, 2 outliers
my_reg <- lm(Elec ~ Gdp, data=electricity)
abline(my_reg)

summary(my_reg)
 
#[C]
electricity$Gdp
order(electricity$Gdp) #find largest 2 Gdp values #4 and #29 
#[29]  4 29
electric <- electricity[-c(4,29),]
#attach(electric) # to update Elec and Gdp
#fit a new model with #4 and #29 removed
mr_new <- lm(Elec ~ Gdp, data=electric)
  plot(Gdp, Elec)
abline(mr_new)

#[d]

summary(mr_new) #check p value = 6.01e-11 < 0.05
#p value in output is for H0: b1=0   vs  H1: b1=/=0

# note: if test H0: b1=0   vs  H1: b1 > 0  (RHS)
# use 1 tailed/RHS p value = (6.01e-11)/2   < 0.05
#
# here b1_hat = 0.18596 > 0
# no need to worry about or test H0: b1=0 vs H1: b1 < 0

#[e]
#install.packages("tidyverse")
library(tidyverse)           #install the package and then load it
res_new <- mr_new$residuals  #new model's residuals

electric_res <- electric %>% mutate(res_new) %>% arrange(res_new)    
                          # add a column of the residuals to the dataset
                          # arrange the new data by the res_new column 
                          # from smallest to largest
electric_res[c(1, length(res_new)), ]   
                          #display rows of the smallest and largest redsiduals for all columns
                          #here number 1 is smallest (negative), n_th is the largest (positive)


######2.10  
Costs <- c(1000, 2180, 2240, 2410, 2590, 2820, 3060)
Covers <- c(0, 60, 120, 133, 143, 175, 175)
my.fit <- lm(Costs ~ Covers)
summary(my.fit)


#[2.10e]
se <- 224  # summary: Residual standard error 224

# qnorm(0.975)  # z_c for 95% CI
#[1] 1.959964

two_se <- 2 * se   #use 2 for z_c = 1.959964 by 95% CI
two_se  # get 448

   
###########
#lecture examples
data()
head(trees,2)
? trees 
plot(Volume ~ Girth, data = trees)

plot(trees$Girth, trees$Volume)
cor(trees$Volume,   trees$Girth)

mylm1 <- lm(Volume ~ Girth, data = trees)
mylm1

anova(mylm1)
summary(mylm1)

abline(mylm1)
plot(mylm1)

#fit_vol = -36.943 + 5.066 * Girth
 fit_vol = -36.943 + 5.066 * 10
 fit_vol
 
 #####
 country <- read.csv(file.choose())
 head(country, 2)
 tail(country, 2)
 
 plot(country$Life ~ country$Pop)
 cor(country$Life, country$Pop)
 
 mylm2 <- lm(country$Life ~ country$Pop)
 anova(mylm2)
 summary(mylm2)
 abline(mylm2)
 
 
 