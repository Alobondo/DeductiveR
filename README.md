# DeductiveR <img src="man/Figures/DeductiveR_Logo.png" align="right" width="180px" height="195px" />
Deductive Rational Method for fill in missing data of flow or precipitation monthly time series.

# Requirements
Dependencies:
  dplyr, tidyr, ggplot2, moments, ggpubr, lmomco

# Installation
You can install the currently-released version of **DeductiveR** from CRAN with this R command:
```
install.packages("DeductiveR")
```
Alternatively, you can install the development version from GitHub with:
```
# install.packages("remotes")
remotes::install_github("Alobondo/DeductiveR")
library(DeductiveR)
```

# Usage
Functions | Description |
--- | --- |
```DR()``` | Apply the Deductive Rational Method to a monthly series of flow or precipitation data to fill in missing data. |
```DR_plot()``` | Plot the result from the application of the Deductive Rational Method. |
```DR_boxplot()``` | BoxPlot from the result from the application of the Deductive Rational Method. |
```DR_stats()``` | Statistics for the result from the application of the Deductive Rational Method. |
```DR_SVC()``` | Seasonal Variation Curves considering results from the application of the Deductive Rational Method. |
```DR_timeseries_plot()``` | Plot raw and infilled monthly time series.Seasonal Variation Curves considering results from the application of the Deductive Rational Method. |
```DeductiveR::data``` | Load the example data. |

```DR()``` works with a dataframe with columns: date - year - month - day - station number (type date the first column and numeric the rest). This follows the same format as CAMELS-CL (```https://camels.cr2.cl/```) monthly flow file.

```DR()``` has negative logical parameter, if TRUE (recommended for runoff and rainfall data), negative values will be set to zero in the final result. Default is FALSE.
```DR_plot()``` has facet logical parameter, if TRUE, the plot will be faceted by year.

# Reporting bugs
If you find an error in some function, want to report a typo in the documentation or submit a recommendation, you can do it [here](https://github.com/Alobondo/DeductiveR/issues)

# Keywords
Hydrology, R package, Time Series
