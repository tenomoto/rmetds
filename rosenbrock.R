library(torch)

rosen <- function(x, y, a = 1, b = 100) {
  (a - x)^2 + b * (y - x^2)^2
}

rosenbrock <- function(x) {
  rosen(x[1], x[2])
}

x <- torch_tensor(c(-1, -1), requires_grad = TRUE, device = "mps")
#x <- torch_tensor(c(-1, -1), requires_grad = TRUE, device = "mps")

optimizer <- optim_lbfgs(x, line_search_fn = "strong_wolfe")

calc_loss <- function() {
  optimizer$zero_grad()
  
  value <- rosenbrock(x)
  cat("value is:", as.numeric(value), "\n")
  
  value$backward()
  value
}

num_iterations <- 3
xhist <- as.numeric(x)
for (i in 1:num_iterations) {
  cat("\n", "iteration:", i, "\n")
  optimizer$step(calc_loss)
  cat("x=", as.numeric(x), "\n")
  xhist <- rbind(xhist, as.numeric(x))
}

x <- seq(-1, 2, 0.01)
y <- seq(-1, 2, 0.01)
z <- outer(x, y, rosen)

contour(x, y, z, levels=4^(0:10), main="R torch L-BFGS", asp=1)
points(xhist[,1], xhist[,2], pch=16)
lines(xhist[,1], xhist[,2], lwd=3)