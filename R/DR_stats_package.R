#' Statistics for the result from the application of the Deductive Rational Method
#' @export
#' @param dr data frame from DR function
#' @import dplyr reshape2 moments

DR_stats <- function(dr){
  data_long_month <- dr %>%  melt(id.vars=c("year"))
  colnames(data_long_month)[2:3] <- c("Month", "Value")

  data_long_month %>% group_by(data_long_month$Month) %>%
    summarise(Max = max(data_long_month$Value), Min = min(data_long_month$Value), Mean = mean(data_long_month$Value),
              SD = stats::sd(data_long_month$Value), Median = stats::median(data_long_month$Value), CV = stats::sd(data_long_month$Value)/stats::median(data_long_month$Value),
              Skew = skewness(data_long_month$Value), Kurtosis = kurtosis(data_long_month$Value), IQR = stats::IQR(data_long_month$Value),
              Qs_2 = stats::quantile(data_long_month$Value, 0.25), Qs_4 = stats::quantile(data_long_month$Value, 0.75))

}
