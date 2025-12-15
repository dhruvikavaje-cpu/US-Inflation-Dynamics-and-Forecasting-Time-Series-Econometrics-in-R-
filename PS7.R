# R-script for EC2208 
# Author: <Keres Vaje>
# Date: <22 November 2025>
# Load relevant libraries
library(AER) # load Applied Econometrics with R library
library(quantmod) # Load quantmod library for time series analysis
library(readxl) # Load readxl to load spreadsheet data
library(stats) # Load stats to compute acf functions
# Read US quarterly macro series into dataframe usmac
usmac <- as.data.frame(us_macro_quarterly)
# Relabel column names in dataframe
colnames(usmac) <- c("Date", "GDPC96", "JAPAN_IP", "PCECTPI",
                     "GS10", "GS1", "TB3MS", "UNRATE", "EXUSUK", "CPIAUCSL")
# Fix format of date
usmac$Date <- as.yearqtr(usmac$Date, format = "%Y:0%q")

# Question 1
# PCECTPI series as xts object
PI <- xts(usmac$PCECTPI, usmac$Date) ["1963::2023"]
# Inflation series (annualized) as xts object
infl<- xts(400 * log(PI/lag(PI)))
# Inflation plot
plot(as.zoo(infl),
     main = "Inflation in the US (1963Q1-2013Q4)",
     xlab = "Year",
     ylab = "Annualised Inflation Rate [%]")

# Question 2
d_infl <- diff(infl)
plot(as.zoo(d_infl),
     main = "Changes in US Inflation (1963Q1 - 2013Q4",
     xlab = "Year",
     ylab = "Changes in Inflation Rate [Percentage Points]")

# Question 3
d_infl.acor <- acf(na.omit(d_infl), lag.max = 8, type = "correlation", 
                 plot = FALSE)
plot(d_infl.acor,
     main = "Autocorrelation Function for Inflation")

# Question 4
T <-length(d_infl) 
# Length of observed series
d_infl.t <- as.numeric(d_infl[2:T]) 
# Discard 1st observation
d_infl.lag1 <- as.numeric(d_infl[1:(T-1)]) 
# Discard last observation
ar1d_infl.lm <- lm(d_infl.t ~ d_infl.lag1) 
# OLS estimation
ar1d_infl.lm 
summary(ar1d_infl.lm)
# Calculating robust standard errors
parameters(ar1d_infl.lm, robust = TRUE, vcov_type = "HC1")


# Question 5
T <-length(d_infl) 
# Length of observed series
d_infl.t <- as.numeric(d_infl[5:T]) # Discard 1st observation
# First lag
d_infl.lag1 <- as.numeric(d_infl[4:(T-1)]) 
# Second lag
d_infl.lag2 <- as.numeric(d_infl[3:(T-2)]) 
ar2d_infl.lm <- lm(d_infl.t ~ d_infl.lag1 +
                   d_infl.lag2)
summary (ar2d_infl.lm)
parameters(ar2d_infl.lm, robust = TRUE, vcov_type = "HC1")

# Question 6 
T <-length(d_infl) 
# Length of observed series
d_infl.t <- as.numeric(d_infl[5:T]) # Discard 1st observation
# First lag
d_infl.lag1 <- as.numeric(d_infl[4:(T-1)]) 
# Second lag
d_infl.lag2 <- as.numeric(d_infl[3:(T-2)]) 
# Third lag
d_infl.lag3 <- as.numeric(d_infl[2:(T-3)])
ar3d_infl.lm <- lm(d_infl.t ~ d_infl.lag1 +
                   d_infl.lag2 + d_infl.lag3)
summary (ar3d_infl.lm)
parameters(ar3d_infl.lm, robust = TRUE, vcov_type = "HC1")

# Question 7
last_two <- tail(na.omit(d_infl), 2)
d_infl_lag1_2014Q1 <- as.numeric(last_two[2])  # Δinfl_2013Q4
d_infl_lag2_2014Q1 <- as.numeric(last_two[1])  # Δinfl_2013Q3
# Build newdata for prediction
newdata_ar2 <- data.frame (d_infl.lag1 = d_infl_lag1_2014Q1, 
                           d_infl.lag2 = d_infl_lag2_2014Q1)
# forecast
forecast_ar2 <- predict(ar2d_infl.lm, newdata = newdata_ar2, 
                        interval = "prediction")
forecast_ar2

# Question 8
# Last observed inflation (2013Q4)
last_infl <- as.numeric(tail(na.omit(infl), 1))
d_infl_forecast <- forecast_ar2[1, "fit"]
infl_2014Q1_forecast <- last_infl + d_infl_forecast
infl_2014Q1_forecast


