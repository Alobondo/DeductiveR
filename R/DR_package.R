#' Apply the Deductive Rational Method to a monthly series of flow or
#' precipitation data to fill in missing data.
#' @export
#' @param data data frame with columns: date - year - month - day - station (Type date and numeric the rest)
#' @import dplyr reshape2

DR <- function(data){
  # The method only allows you to fill in up to 11 months for incomplete years
  # and requires a record with at least 10 full years.

  # A matrix of years x months is created
  data_wide <- as.data.frame(acast(data, year ~ month))
  data_wide <- cbind(year = rownames(data_wide), data_wide)

  # A long format DF a is created
  data_long <- data_wide %>% melt(id.vars=c("year"))
  colnames(data_long)[3] <- "Station"

  # Count missing months by chronological years
  meses_faltantes <- stats::aggregate(Station ~ year, data=data_long, function(x) {sum(is.na(x))}, na.action = NULL)

  # Number of complete years
  complete_y <- sum(meses_faltantes$Station == 0, na.rm=TRUE)
  if(complete_y < 10){stop("There is less than 10 years with 12 monthly data")}

  # Number of incomplete years
  incomplete_y <- sum(meses_faltantes$Station != 0, na.rm=TRUE)

  # Number of years with 12 missing months
  incomplete_y_12 <- sum(meses_faltantes$Station > 11, na.rm=TRUE)

  # Years without data
  agnos_sin <- filter(meses_faltantes, meses_faltantes$Station > 11)

  # Years without data is eliminated
  if (length(agnos_sin$year) != 0) {
  data_wide <- data_wide %>% slice(-match(agnos_sin$year, data_wide$year))
  }

  # Sum of each year
  Suma <- data_wide %>% select(-1) %>% rowSums(na.rm=T)
  data_wide <- data_wide %>% mutate(Suma)

  #  Percentages matrix
  data_porc <- (select(data_wide, -1, -14) / Suma) * 100

  # Average percentages vector
  Porc_prom <- data_porc %>% summarise_if(is.numeric, mean,na.rm=T)

  # Auxiliary matrix
  Aux <- data_wide %>% select(-1, -14) %>% "*"(0)
  Aux[is.na(Aux)] <- 1

  # Auxiliary vectors with missing percentages
  V_aux <- as.matrix(Aux) %*% t(Porc_prom)
  V_aux_comp <- 100 - V_aux

  # Auxiliary vectors to generate fill values with DR method
  Rep_aux <- rep(V_aux_comp, each = 12)
  Rep_aux_2 <- rep(Suma, each = 12)
  Rep_aux_3 <- as.double(rep(Porc_prom, times = length(Rep_aux)/12))
  Rep_aux_4 <- as.vector(t(as.matrix(Aux)))

  # Values are calculated to fill in missing months
  DR <- ((Rep_aux_2 * Rep_aux_3) / Rep_aux)*Rep_aux_4

  # Final element with existing and filled data
  DR_final <- data_wide %>% select(-1, -14)
  DR_final[is.na(DR_final)] <- 0

  DR <- t(matrix(DR,nrow = 12))
  DR_final <- DR_final + DR

  DR_final <- cbind(data_wide$year, DR_final)
  colnames(DR_final) <- c("year",month.abb[seq(1,12)]) # Column names

  print(paste0("Number of complete years: ",complete_y))

  print(paste0("Number of incomplete years: ",incomplete_y))

  print(paste0("Number of years without data: ",incomplete_y_12))

  DR_final

}
