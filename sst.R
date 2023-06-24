fname <- "mgd_sst_glb_D20220618.txt.gz"
nlon <- 1440
nlat <- 720
dlon <- 360 / nlon
dlat <- 180 / nlat
df <- read.fwf(gzfile(fname), widths=rep(3, nlon), header=F, skip=1, nrow=nlat, na.strings=c("888", "999"))
sst <- t(as.matrix(df)[nrow(df):1,]) * 0.1
lon <- seq(0+dlon/2, 360-dlon/2, dlon)
lat <- seq(-90+dlat/2, 90-dlat/2, dlat)
filled.contour(lon, lat, sst, asp=2)
