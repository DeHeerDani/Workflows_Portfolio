#' Remove missing values from a dataset
#'
#' @param df data.frame
#' @return cleaned data.frame
#' @export
clean_data <- function(df) {
  df <- na.omit(df)
  return(df)
}
