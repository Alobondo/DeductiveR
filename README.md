# RacDeductive
Rational Deductive method for fill in missing data of flow or precipitation monthly time series.

# Requirements
Dependencies:
  dplyr, reshape, ggplot2, moments


# Installation
You can install the development version of **RacDeductive** from GitHub with:
```
# install.packages("RacDeductive")
remotes::install_github("Alobondo/RacDeductive")
library(RacDeductive)
```

# Data sources
Functions | Description |
--- | --- |
```RD()``` | Apply the rational deductive method to a monthly series of flow or precipitation data to fill in missing data. |
```RD_plot()``` | Plot the result from the application of the rational deductive method |
```RD_stats()``` | Statistics for the result from the application of the rational deductive method |

# Keywords
Hydrology, R package, Time Series
