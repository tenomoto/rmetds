G <- 6.6743e-11
M <- 5.9742e24
a <- 6.371e6
calc.g <- function(z) {
  G * M / (a + z)^2
}