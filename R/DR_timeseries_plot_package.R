#' Plot raw and infilled monthly time series
#' @export
#' @param raw_data data frame with columns: date - year - month - day - station (Type date and numeric the rest). Assumes station data is in the 5th column.
#' @param infilled_data data frame from DR function (wide format: year, month1, month2, ...).
#' @import dplyr tidyr ggplot2
#'
DR_timeseries_plot <- function(raw_data, infilled_data){

  # Ensure 'date' column in raw_data is Date type
  raw_data[[1]] <- as.Date(raw_data[[1]])

  # Prepare original data (assuming station is the 5th column)
  df_original_plot <- raw_data %>%
    select(date = 1, Value = 5) %>%
    mutate(Type = "Original")

  # Prepare infilled data
  df_infilled_plot <- infilled_data %>%
    pivot_longer(cols = -year, names_to = "Month_abb", values_to = "Value") %>%
    mutate(
      Month_num = match(Month_abb, month.abb),
      date = as.Date(paste(year, Month_num, "01", sep = "-"), format = "%Y-%m-%d"),
      Type = "Infilled"
    ) %>%
    select(date, Value, Type)

  # Combine data
  df_combined <- bind_rows(df_original_plot, df_infilled_plot)

  # Plotting
  ggplot(df_combined, aes(x = date, y = Value, color = Type)) +
    geom_line() +
    labs(
      title = "Raw vs. Infilled Monthly Time Series",
      x = "Date",
      y = "Value"
    ) +
    theme_bw() +
    scale_color_manual(values = c("Original" = "blue", "Infilled" = "red"))
}

