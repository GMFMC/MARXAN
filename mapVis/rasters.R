library(raster)
library(rgdal)
####setwd("X:/Claire/shiny/MARXAN/mapVis")

anyDepth <- raster("anyDepthOneBand.tif")
fifty <- raster("50-2000_oneBand.tif")
fiftyEEZ <- raster("50-EEZ_oneBand.tif")
onehund <- raster("100-2000_oneBand.tif")
onehundEEZ <- raster("100-EEZ_oneBand.tif")
oneFifty <- raster("150-2000_oneBand.tif")
oneFiftyEEZ <- raster("150-EEZ_oneBand.tif")
ELB_100 <- raster("ELB100_oneBand.tif")
VMS_100 <- raster("VMS100_oneBand.tif")
VMS_20_ELB_80 <- raster("VMS20ELB80_oneBand.tif")
VMS_40_ELB_60 <- raster("VMS40ELB60_oneBand.tif")
VMS_60_ELB_40 <- raster("VMS60ELB40_oneBand.tif")
VMS_80_ELB_20 <- raster("VMS80ELB20_oneBand.tif")

####### input layers ##########

black <- raster("black.tif")
octo <- raster("octo.tif")
stony <- raster("stony.tif")
VMS <- raster("vms.tif")
ELB <- raster("elb.tif")



