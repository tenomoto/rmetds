library(dotCall64)

dyn.load("gaqd.so")

gaqd <- function(nlat) {
  w <- 0
  lwork <- 0L
  gaus <- .C64("gaqd",
       c("integer", "double", "double", "double", "integer", "integer"),
       nlat, theta = numeric_dc(nlat), wts = numeric_dc(nlat),
       w, lwork, ierror= integer_dc(1),
       INTENT=c("rw", "w", "w", "r", "r", "w"))
  gaus[c(1, 2, 3, 6)]
}