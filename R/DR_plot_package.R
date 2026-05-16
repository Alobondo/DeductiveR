#' Plot the result from the application of the Deductive Rational Method
#' @export
#' @param dr data frame from DR function
#' @param facet logical, if TRUE, the plot will be faceted by year
#' @import dplyr tidyr ggplot2

DR_plot <- function(dr, facet = FALSE){
  data_long_month <- dr %>% pivot_longer(cols = -year, names_to = "Month", values_to = "Value")
  data_long_month$year <- as.numeric(data_long_month$year)

  aux <- as.data.frame(cbind(month.abb[seq(1,12)],colMeans(dr[2:13])))
  colnames(aux) <- c("Month","Mean")
  aux$Mean <- as.numeric(aux$Mean)

  ggplot(data_long_month, aes(x=as.factor(data_long_month$Month), y=data_long_month$Value, group=data_long_month$year, color=data_long_month$year)) +
    labs(color='year') +
    geom_line(size = 1, alpha = 0.75) +
    scale_x_discrete(labels=month.abb[seq(1,12)], guide = guide_axis(angle = 90)) +
    geom_line(data = aux,aes(x=factor(aux$Month, levels = month.abb),y=aux$Mean,fill="mean"),size = 1.75, color = "red", linetype = "dashed", group =1,show.legend = TRUE) +
    scale_fill_manual("line", values=c(1),guide=guide_legend(override.aes = list(colour=c("red")))) +
    ggtitle("Monthly values filled with Deductive Rational Method") +
    xlab("Month") + ylab("Value") +
    theme_bw() +
    if (facet) facet_wrap(~ year)

}
