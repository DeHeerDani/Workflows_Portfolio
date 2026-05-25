#' Quick scatter plot
#'
#' @param df data.frame
#' @param x column name (string)
#' @param y column name (string)
#' @return ggplot object
#' @export
quick_plot <- function(df, x, y) {
  ggplot2::ggplot(df, ggplot2::aes(x = .data[[x]], y = .data[[y]])) +
    ggplot2::geom_point()
}
