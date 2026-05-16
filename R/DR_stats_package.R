#' Statistics for the result from the application of the Deductive Rational Method
#' @export
#' @param dr data frame from DR function
#' @import dplyr tidyr moments

DR_stats <- function(dr){
  data_long_month <- dr %>% pivot_longer(cols = -year, names_to = "Month", values_to = "Value")

  # order the result by month from Jan to Dec
  data_long_month %>% group_by(Month) %>%
    summarise(
      N = n(),
      Max = max(Value, na.rm = TRUE),
      Min = min(Value, na.rm = TRUE),
      Mean = mean(Value, na.rm = TRUE),
      SD = stats::sd(Value, na.rm = TRUE),
      Median = stats::median(Value, na.rm = TRUE),
      CV = stats::sd(Value, na.rm = TRUE) / mean(Value, na.rm = TRUE),
      Skew = skewness(Value, na.rm = TRUE),
      Kurtosis = kurtosis(Value, na.rm = TRUE),
      IQR = stats::IQR(Value, na.rm = TRUE),
      Qs_2 = stats::quantile(Value, 0.25, na.rm = TRUE),
      Qs_4 = stats::quantile(Value, 0.75, na.rm = TRUE)
    ) %>%
    mutate(Month = factor(Month, levels = month.abb)) %>%
    arrange(Month)

}
