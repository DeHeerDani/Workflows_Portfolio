#' Count NA values
#'
#' @param x vector
#' @return number of NA values
#' @export
na_count <- function(x) {
  sum(is.na(x))
}
