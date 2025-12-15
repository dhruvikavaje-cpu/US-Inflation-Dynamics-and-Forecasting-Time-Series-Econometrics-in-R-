# US Inflation Dynamics and Forecasting  
### Time-Series Econometric Analysis in R

## Overview
This project analyses the dynamics of US inflation using quarterly macroeconomic data from 1963Q1 to 2013Q4.  
The objective is to examine inflation persistence, evaluate autoregressive (AR) models, and generate out-of-sample forecasts using standard econometric techniques.

The analysis is conducted in **R**, applying time-series methods commonly used in macroeconomic research and policy analysis.

---

## Data
- **Source:** US quarterly macroeconomic data (`us_macro_quarterly`)
- **Inflation Measure:** Personal Consumption Expenditures (PCE) Price Index
- **Frequency:** Quarterly
- **Sample Period:** 1963Q1 – 2013Q4

Inflation is constructed as an **annualised log change** in the PCE price index:
\[
\pi_t = 400 \times \log\left(\frac{P_t}{P_{t-1}}\right)
\]

---

## Methodology

### 1. Inflation Construction and Visualisation
- Converted the PCE price index into an annualised quarterly inflation rate.
- Visualised inflation trends over time to identify volatility and structural patterns.

### 2. Stationarity and Persistence
- Computed first differences of inflation to analyse changes in inflation.
- Examined persistence using the **autocorrelation function (ACF)**.

### 3. Autoregressive Models
Estimated the following models using Ordinary Least Squares (OLS):
- **AR(1):** Inflation changes depend on one lag
- **AR(2):** Extended to capture additional persistence
- **AR(3):** Tested deeper lag dynamics

All models were estimated using **heteroskedasticity-robust standard errors (HC1)**.

---

## Forecasting
- Generated an **out-of-sample forecast** for inflation changes in **2014Q1** using the AR(2) model.
- Converted the forecasted change into a predicted **inflation level**.
- Constructed prediction intervals to quantify forecast uncertainty.

---

## Key Insights
- Changes in inflation exhibit short-run persistence, motivating the use of autoregressive models.
- Additional lags beyond AR(2) provide limited incremental explanatory power.
- The AR(2) specification offers a reasonable balance between model fit and parsimony for forecasting.

---

## Tools & Libraries
- `AER` – Applied econometrics methods
- `quantmod` – Time-series handling
- `stats` – Autocorrelation and regression analysis
- `readxl` – Data handling

---

## Files
- `inflation_analysis.R` — Main analysis script
- `README.md` — Project documentation

---

## Author
**Keres Vaje**  
BSc Mathematics and Economics, Royal Holloway, University of London

---

## Notes
This project was originally developed as part of an undergraduate econometrics module and has been refined for clarity and reproducibility.
