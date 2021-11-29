# DeductiveR
Deductive Rational Method for fill in missing data of flow or precipitation monthly time series.

# Requirements
Dependencies:
  dplyr, reshape2, ggplot2, moments


# Installation
You can install the development version of **DeductiveR** from GitHub with:
```
# install.packages("remotes")
remotes::install_github("Alobondo/DeductiveR")
library(DeductiveR)
```

# Data sources
Functions | Description |
--- | --- |
```DR()``` | Apply the Deductive Rational Method to a monthly series of flow or precipitation data to fill in missing data. |
```DR_plot()``` | Plot the result from the application of the Deductive Rational Method |
```DR_stats()``` | Statistics for the result from the application of the Deductive Rational Method |

# Keywords
Hydrology, R package, Time Series
