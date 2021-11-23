#' Plot the result from the application of the rational deductive method
#' @export
#' @param rd data frame from RD function
#' @import dplyr reshape ggplot2

RD_plot <- function(rd){
  data_long_month <- rd %>% melt(id.vars=c("year"))
  colnames(data_long_month)[2:3] <- c("Month", "Value")

  aux <- as.data.frame(cbind(month.abb[seq(1,12)],colMeans(rd)[2:13]))
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
