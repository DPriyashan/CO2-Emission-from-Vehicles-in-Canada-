#MULTIPLE LINEAR REGRESSION

attach(CO2_emission_with_binary)
str(CO2_emission_with_binary)

FuelType=relevel(as.factor(FuelType),ref = "Gasoline")

Transmission=relevel(as.factor(Transmission),ref = "Manual")

#null model
m=lm(CO2Emissionsgkm~1)
summary(m)

#1 add FuelConsumptionCombL100km
m1=lm(CO2Emissionsgkm~FuelConsumptionCombL100km)
summary(m1)
anova(m1)


#2nd add Fuel type
m2=lm(CO2Emissionsgkm~FuelConsumptionCombL100km+as.factor(FuelType))
summary(m2)
anova(m2)
anova(m1,m2)

#3rd add cylinders
m3=lm(CO2Emissionsgkm~FuelConsumptionCombL100km+as.factor(FuelType)+Cylinders)
summary(m3)
anova(m3)
anova(m2,m3)


#4th add transmission
m4=lm(CO2Emissionsgkm~FuelConsumptionCombL100km+as.factor(FuelType)+Cylinders+as.factor(Transmission))
summary(m4)
anova(m4)
anova(m3,m4)

#add vehicle class
m5=lm(CO2Emissionsgkm~FuelConsumptionCombL100km+as.factor(FuelType)+Cylinders+as.factor(Transmission)+as.factor(VehicleClass))
summary(m5)
anova(m5)
anova(m4,m5)

#final model
m6=lm(CO2Emissionsgkm~FuelConsumptionCombL100km+as.factor(FuelType)+Cylinders+as.factor(Transmission)+as.factor(VehicleClass))
summary(m6)

#check multicolinearity
library(car)
vif(m5)

par(mfrow = c(2, 2))
plot(m6, which = 1)
plot(m6, which = 2) 
plot(m6, which = 3) 
plot(m6, which = 5)

par(mfrow = c(1,1))

#log transformation
m6=lm(log(CO2Emissionsgkm)~FuelConsumptionCombL100km+as.factor(FuelType)+Cylinders+as.factor(Transmission)+as.factor(VehicleClass))

par(mfrow = c(2, 2))
plot(m6, which = 1)
plot(m6, which = 2) 
plot(m6, which = 3) 
plot(m6, which = 5)

#polynomial term
m6=lm(CO2Emissionsgkm~FuelConsumptionCombL100km+as.factor(FuelType)+Cylinders+as.factor(Transmission)+as.factor(VehicleClass) + I(FuelConsumptionCombL100km^2))

par(mfrow = c(2, 2))
plot(m6, which = 1)
plot(m6, which = 2) 
plot(m6, which = 3) 
plot(m6, which = 5)

par(mfrow = c(1, 1))

#Final model with interactions
final=lm(CO2Emissionsgkm~FuelConsumptionCombL100km+as.factor(FuelType)+Cylinders+as.factor(Transmission)+as.factor(VehicleClass) 
      + FuelConsumptionCombL100km*as.factor(FuelType))

summary(final)

par(mfrow = c(2, 2))
plot(final, which = 1)
plot(final, which = 2) 
plot(final, which = 3) 
plot(final, which = 5)

par(mfrow = c(1, 1))



#LOGISTIC REGRESSION
attach(CO2_emission_with_binary)
str(CO2_emission_with_binary)
FuelType=relevel(as.factor(FuelType),ref = "Gasoline")

Transmission=relevel(as.factor(Transmission),ref = "Manual")

library(dplyr)
response=recode(CO2EmissionBinary,High=1,Low=0)
CO2_emission_with_binary=cbind(CO2_emission_with_binary,response)
str(CO2_emission_with_binary)

#null
logm=glm(response~1,family=binomial("logit"))
summary(logm)

#1
logm1=glm(response~FuelConsumptionCombL100km,family=binomial("logit"))
summary(logm1)
qchisq(0.95,1)
qchisq(0.95,7379)
anova(logm,logm1, test = "Chisq")

#2
logm2=glm(response~FuelConsumptionCombL100km+as.factor(FuelType),family=binomial("logit"))
summary(logm2)
qchisq(0.95,2)
qchisq(0.95,7377)
anova(logm1,logm2, test = "Chisq")

#3
logm3=glm(response~FuelConsumptionCombL100km+as.factor(FuelType)+as.factor(VehicleClass),family=binomial("logit"))
summary(logm3)
qchisq(0.95,2)
qchisq(0.95,7375)
anova(logm2,logm3, test = "Chisq")

#4
logm4=glm(response~FuelConsumptionCombL100km+as.factor(FuelType)+as.factor(VehicleClass)+as.factor(Transmission),family=binomial("logit"))
summary(logm4)
qchisq(0.95,7372)
anova(logm3,logm4, test = "Chisq")

#5
logm5=glm(response~FuelConsumptionCombL100km+as.factor(FuelType)+as.factor(VehicleClass)+as.factor(Transmission)+EngineSizeL,family=binomial("logit"))
summary(logm5)
qchisq(0.95,7372)
qchisq(0.95,1)
anova(logm4,logm5, test = "Chisq")

logm5=glm(response~FuelConsumptionCombL100km+as.factor(FuelType)+as.factor(VehicleClass)+as.factor(Transmission)+Cylinders,family=binomial("logit"))
summary(logm5)
qchisq(0.95,7372)
qchisq(0.95,1)
anova(logm4,logm5, test = "Chisq")


#final model
logm=glm(response~FuelConsumptionCombL100km+as.factor(FuelType)+as.factor(VehicleClass)+as.factor(Transmission),family=binomial("logit"))
summary(logm)
qchisq(0.95,7372)


library(car)
vif(logm)

#hosmer and lemeshow test
library(ResourceSelection)
model <- glm(response ~ FuelConsumptionCombL100km + FuelType + VehicleClass + Transmission, family = binomial, data = CO2_emission_with_binary)
hoslem_test <- hoslem.test(model$y, fitted(model), g = 10)
print(hoslem_test)  # p-value > 0.05 is good

#ROC curve
library(pROC)
model <- glm(response ~ FuelConsumptionCombL100km + FuelType + VehicleClass + Transmission, family = binomial)
roc_obj <- roc(response, fitted(model))
plot(roc_obj, main = "ROC Curve")
auc(roc_obj)


#Discriptive Analysis
library(ggplot2)

ggplot(df, aes(x =  CO2Emissionsgkm)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  labs(title = "Distribution of CO2 Emissions", x = "CO2 Emissions (g/km)", y = "Frequency") +
  theme_minimal()



ggplot(df, aes(x = EngineSizeL, y = CO2Emissionsgkm)) +
  geom_point(color = "blue", alpha = 0.5) +
  geom_smooth(method = "lm", color = "red") +  # Adds a linear trend line
  labs(title = "Engine Size vs. CO2 Emissions", x = "Engine Size (L)", y = "CO2 Emissions (g/km)") +
  theme_minimal()


ggplot(df, aes(x = FuelType, y = CO2Emissionsgkm, fill = FuelType)) +
  geom_boxplot() +
  labs(title = "CO2 Emissions by Fuel Type", x = "Fuel Type", y = "CO2 Emissions (g/km)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


ggplot(df, aes(x = Transmission, y = CO2Emissionsgkm, fill = Transmission)) +
  geom_boxplot() +
  labs(title = "CO2 Emissions by Transmission", x = "Transmission", y = "CO2 Emissions (g/km)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


ggplot(df, aes(x = FuelConsumptionCombL100km, y = CO2Emissionsgkm)) +
  geom_point(color = "purple", alpha = 0.5) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Fuel Consumption Comb vs. CO2 Emissions", x = "Fuel Consumption Comb (L/100 km)", y = "CO2 Emissions (g/km)") +
  theme_minimal()



library(reshape2)

numeric_df <- df[, c("EngineSizeL", "Cylinders", "FuelConsumptionCombL100km", "CO2Emissionsgkm")]
cor_matrix <- cor(numeric_df)

melted_cor <- melt(cor_matrix)
ggplot(melted_cor, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  geom_text(aes(label = round(value, 2)), color = "white") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white") +
  labs(title = "Correlation Heatmap of Numerical Variables", x= "",) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



















