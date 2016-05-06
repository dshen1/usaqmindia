#' Calendar plot for one city
#'
#' @import ggTimeSeries
#' @import viridis
#'
#' @importFrom dplyr "%>%" filter_ group_by summarize
#' @importFrom lazyeval interp
#'
#' @param cityplot the city, "Delhi", "Chennai", "Kolkata", "Hyderabad", "Mumbai".
#'
#' @return
#' @export
#'
#' @examples
#' usaqmindia_calendar(cityplot = "Chennai")
usaqmindia_calendar <- function(cityplot = NULL){
  utils::data("pm25_india", package = "usaqmindia", envir = environment())
  pm25day <- pm25_india %>%
    filter_(interp(~ city == cityplot)) %>%
    group_by(day = as.Date(datetime)) %>%
    summarize(conc = mean(conc, na.rm = TRUE))
  # base plot
  p1 <- ggplot_calendar_heatmap(
    pm25day,
    'day',
    'conc'
  )

  # adding some formatting
  p1 +
    xlab(NULL) +
    ylab(NULL)+
    scale_fill_viridis(option = "plasma",
                       limit = c(0, max(pm25day$conc)))  +
    facet_wrap(~Year, ncol = 1)
}