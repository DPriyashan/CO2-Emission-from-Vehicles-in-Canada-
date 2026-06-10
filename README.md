# 🚗 CO₂ Emission from Vehicles in Canada

> **ST3008 – Applied Statistical Models** | Department of Statistics, Faculty of Science, University of Colombo | August 2025

Analysis of vehicle CO₂ emissions using **Multiple Linear Regression** and **Binary Logistic Regression**, applied to real-world fuel consumption data from the Canadian government.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Dataset](#dataset)
- [Objectives](#objectives)
- [Methodology](#methodology)
- [Key Results](#key-results)
- [Repository Structure](#repository-structure)
- [Technologies Used](#technologies-used)
- [Team](#team)

---

## Overview

Carbon dioxide (CO₂) emissions from vehicles are a major contributor to global warming and climate change. This project investigates which internal vehicle attributes — such as engine size, fuel type, transmission, and fuel consumption — are statistically associated with CO₂ emissions, using a dataset of 7,385 Canadian commercial vehicles spanning 2014–2020.

Two regression models were built:
- A **Multiple Linear Regression (MLR)** model to predict the continuous CO₂ emission value (g/km)
- A **Binary Logistic Regression** model to classify vehicles as *High* or *Low* emitters

---

## Dataset

| Attribute | Details |
|-----------|---------|
| **Source** | Canadian Government Fuel Consumption Ratings Programme |
| **Records** | 7,385 vehicles |
| **Period** | 2014 – 2020 |
| **Car brands** | 42 |
| **Car models** | 2,053 |
| **Variables** | 12 (engine size, fuel type, transmission, fuel consumption, CO₂ emissions, etc.) |

📥 Available on [Kaggle](https://www.kaggle.com/datasets/debajyotipodder/co2-emission-by-vehicles) and the [Canadian Open Government Portal](https://open.canada.ca/data/en/dataset/98f1a129-f628-4ce4-b24d-6f16bf24dd64).

---

## Objectives

1. Perform **descriptive and exploratory analysis** to identify which vehicle features most influence CO₂ emissions.
2. Build a **Multiple Linear Regression model** to predict CO₂ emissions (g/km) from vehicle attributes.
3. Develop a **Binary Logistic Regression model** to classify vehicles as high or low emitters.

---

## Methodology

### Variable Engineering
- **Vehicle Class** condensed from 16 → 3 categories: *Small*, *Medium*, *Large*
- **Fuel Type** consolidated from 5 → 3 categories: *Gasoline*, *Diesel*, *Ethanol*
- **Transmission** regrouped into 4 categories: *Automatic*, *Manual*, *Variable (CVT)*, *Automated Manual*
- Make and model excluded (characteristics already captured by other variables)
- City and highway fuel consumption excluded (combined figure used instead)

### Model Building
- **Forward selection** used for both models, based on F-statistics (MLR) and AIC/deviance reduction (logistic)
- **Interaction term** (`Fuel Consumption × Fuel Type`) added to the MLR after residual diagnostics indicated model improvement
- **Dummy variable coding** applied to all categorical predictors

### Diagnostics
- MLR: Residuals vs. Fitted, Q-Q plot, Scale-Location, Residuals vs. Leverage, VIF
- Logistic: Hosmer–Lemeshow test, ROC curve (AUC), GIVF

---

## Key Results

### Multiple Linear Regression

| Metric | Value |
|--------|-------|
| R² (final model with interaction) | **99.75%** |
| Residual Standard Error | 2.926 g/km |
| Significant predictors | Fuel Consumption, Fuel Type, Cylinders, Transmission, Vehicle Class |

**Final model equation:**

```
CO₂ Emissions (g/km) = 1.988
  + 22.974 × FuelConsumptionComb
  + 1.189 × FuelD  −  7.112 × (FuelConsumptionComb × FuelE)
  + 3.414 × FuelE  +  3.638 × (FuelConsumptionComb × FuelD)
  + 0.332 × TransAM  +  0.185 × TransA  −  0.482 × TransV
  + 0.335 × Cylinders
  −  0.488 × VClassM  −  0.882 × VClassS
```

**Key findings:**
- Fuel consumption has the strongest positive effect on CO₂ emissions
- Diesel vehicles emit ~1.19 g/km less than gasoline after controlling for other factors
- Variable (CVT) transmissions produce the lowest emissions among transmission types
- Smaller vehicle classes are associated with meaningfully lower emissions

---

### Binary Logistic Regression

| Metric | Value |
|--------|-------|
| AUC (ROC curve) | **0.9994** |
| Hosmer–Lemeshow p-value | 0.9998 |
| Significant predictors | Fuel Consumption, Fuel Type, Vehicle Class, Transmission |

**Key findings:**
- Each 1 L/100 km increase in fuel consumption increases the log odds of high CO₂ emission by 16.60
- Large vehicles have 3.59× the odds of high emissions compared to medium, and 4.86× compared to small
- The positive diesel coefficient in the logistic model (vs. negative in MLR) reflects the confounding effect of vehicle class — large diesel vehicles have higher overall emissions due to greater fuel consumption and engine size

---



## Technologies Used

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![RStudio](https://img.shields.io/badge/RStudio-75AADB?style=for-the-badge&logo=RStudio&logoColor=white)

**R packages:** `ggplot2`, `dplyr`, `car` (VIF), `pROC` (ROC/AUC), `ResourceSelection` (Hosmer–Lemeshow), `MASS` (forward selection)

---

## Team

**Group 07 — Department of Statistics, Faculty of Science, University of Colombo**

| Name | Index |
|------|-------|
| D. A. Yahathugoda | s16877 |
| Dinusha Priyashan Haputhanthiri | s16798 |
| Ranindu Kariyapperuma | s16810 |
| Harsha Milinda Dharmasena | s16977 |
| Kavindu Anjana Perera | s16829 |

---

*ST3008 – Applied Statistical Models · August 2025*
