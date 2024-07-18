library(torch)

rosenbrock <- function(x, y, a = 1, b = 100) {
  (a - x)^2 + b * (y - x^2)^2
}

x <- torch_tensor(c(-1, -1), requires_grad = TRUE)

optimizer <- optim_lbfgs(x, line_search_fn = "strong_wolfe")
#optimizer <- optim_lbfgs(x)

calc_loss <- function() {
  optimizer$zero_grad()
  
  value <- rosenbrock(x[1], x[2])
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

x.axis <- seq(-1, 2, 0.01)
y.axis <- seq(-1, 2, 0.01)
z <- outer(x.axis, y.axis, rosenbrock)

contour(x.axis, y.axis, z, levels=4^(0:10), main="R torch L-BFGS",
        asp=1, xlim=c(-1,2))
points(xhist[,1], xhist[,2], pch=16)
lines(xhist[,1], xhist[,2], lwd=3)