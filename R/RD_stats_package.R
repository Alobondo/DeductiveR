#' Statistics for the result from the application of the rational deductive method
#' @export
#' @param rd data frame from RD function
#' @import dplyr reshape moments

RD_stats <- function(rd){
  data_long_month <- rd %>%  melt(id.vars=c("year"))
  colnames(data_long_month)[2:3] <- c("Month", "Value")

  data_long_month %>% group_by(Month) %>%
    summarise(Max = max(Value), Min = min(Value), Mean = mean(Value),
              SD = sd(Value), Median = median(Value), CV = sd(Value)/median(Value),
              Skew = skewness(Value), Kurtosis = kurtosis(Value), IQR = IQR(Value),
              Qs_2 = quantile(Value, 0.25), Qs_4 = quantile(Value, 0.75))

}
