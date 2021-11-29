#' Plot the result from the application of the Deductive Rational Method
#' @export
#' @param dr data frame from DR function
#' @import dplyr reshape2 ggplot2

DR_plot <- function(dr){
  data_long_month <- dr %>% melt(id.vars=c("year"))
  colnames(data_long_month)[2:3] <- c("Month", "Value")

  aux <- as.data.frame(cbind(month.abb[seq(1,12)],colMeans(dr)[2:13]))
  colnames(aux) <- c("Month","Mean")
  aux$Mean <- as.numeric(aux$Mean)

  ggplot(data_long_month, aes(x=as.factor(Month), y=Value, group=year, color=year)) +
    geom_line(size = 1) +
    scale_x_discrete(labels=month.abb[seq(1,12)], guide = guide_axis(angle = 90)) +
    geom_line(data = aux,aes(x=factor(Month, levels = month.abb),y=Mean,fill="mean"),size = 1.5, color = "red", linetype = "dashed", group =1,show.legend = TRUE) +
    scale_fill_manual("line", values=c(1),guide=guide_legend(override.aes = list(colour=c("red")))) +
    ggtitle("Monthly values filled with Rational Deductive Method") +
    xlab("Month") + ylab("Value") +
    theme_bw()

}
