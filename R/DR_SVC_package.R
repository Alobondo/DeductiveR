#' Seasonal Variation Curves considering results from the application of the Deductive Rational Method
#' @export
#' @param dr data frame from DR function
#' @import dplyr reshape2 ggplot2 lmomco ggpubr

DR_SVC <- function(dr){
  Ordenados <- as.data.frame(apply(dr[,2:13], 2, sort, decreasing=TRUE))
  Ordenados <- as.data.frame(cbind(Exd_Probb = pp(Ordenados[,1]), Ordenados))

  CVE_probb <- data.frame(Exd_Probb = c(0.05, 0.25, 0.50, 0.75, 0.85, 0.90, 0.95))

  for (i in 2:13) {
    aux3 <- stats::approx(x = Ordenados$Exd_Probb, y = Ordenados[,i], xout = CVE_probb$Exd_Probb,
                   method = "linear", n = 1)
    CVE_probb <- cbind(CVE_probb,aux3$y)
  }

  colnames(CVE_probb)[2:13] <- colnames(Ordenados)[2:13]

  data_long_CVE_probb <- CVE_probb %>%  melt(id.vars=c("Exd_Probb"))

  data_long_CVE_probb <- data_long_CVE_probb[order(data_long_CVE_probb$Exd_Probb), ]

  plot1 <- ggplot(data = data_long_CVE_probb, aes(x = data_long_CVE_probb$variable, y = data_long_CVE_probb$value, color = factor(data_long_CVE_probb$Exd_Probb*100))) +
    geom_point(shape = 1, size = 2, fill = "white") +
    geom_line(aes(group = data_long_CVE_probb$Exd_Probb),size = 0.85) +
    scale_x_discrete(labels=month.abb[seq(1,12)], guide = guide_axis(angle = 90))+
    ggtitle("Seasonal Variation Curves for monthly values \nfilled with Rational Deductive Method") +
    labs(color = "Exd. Probb. [%]") + xlab("Month") + ylab("Value") +
    theme_bw()

  tbl <- ggtexttable(cbind('Exd. Probb [%]' = CVE_probb[,1]*100, round(CVE_probb[,2:13],3)),rows=NULL)

  ggarrange(plot1, tbl,
            ncol = 1, nrow = 2,
            heights = c(1.8,1))

}
