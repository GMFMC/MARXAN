## add best solutions to pu.shp ##

library(rgdal)
setwd("X:/Claire/dump/treat0.01/pulayer")

x <- readOGR(dsn="pu_10km_cost_hab.shp",layer="pu_10km_cost_hab")

setwd("X:/Claire/dump/treat0.01/output")
out0.01 <- read.table("output_best.txt", sep=",", header=TRUE)
out0.01sol <- out0.01[,2]
x@data$out0.01sol <- out0.01sol

setwd("X:/Claire/dump/treat0.02/output")
out0.02 <- read.table("output_best.txt", sep=",", header=TRUE)
out0.02sol <- out0.02[,2]
x@data$out0.02sol <- out0.02sol

setwd("X:/Claire/dump/treat0.05/output")
out0.05 <- read.table("output_best.txt", sep=",", header=TRUE)
out0.05sol <- out0.05[,2]
x@data$out0.05sol <- out0.05sol

setwd("X:/Claire/dump/treat0.1/output")
out0.10 <- read.table("output_best.txt", sep=",", header=TRUE)
out0.10sol <- out0.10[,2]
x@data$out0.10sol <- out0.10sol

writeOGR(x,"X:/Claire/dump/treatment","allSols",driver="ESRI Shapefile")
library(raster)
setwd("X:/Claire/dump/treatment")

x <- readOGR(dsn="allSols.shp",layer="allSols")
r<- raster()
extent(r)<- extent(x)
xR <- rasterize(x,r,field=x@data[,14],fun="mean",na.rm=TRUE)
closeAllConnections()




