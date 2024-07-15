library(RNetCDF)

nc <- open.nc("thickness.mon.mean.nc")
time <- var.get.nc(nc, "time")
tunit <- att.get.nc(nc, "time", "units")
time.posixct <- utcal.nc(tunit, time, type="c")
ymd <- as.POSIXct(paste(c(1969, 12, 1), collapse="-"))
t <- which.min(abs(time.posixct - ym))