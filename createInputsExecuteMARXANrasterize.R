library(rgdal)


### To execute Marxan in loop

w <- seq(0.01,0.20, by = 0.01)

for(i in w){
#setwd("X:/Claire/dump")
 setwd("X:/Claire/Management Strategy Evaluation/MARXAN_RUNS")
### Create directory with treatment name, copy redundant files/folders into new directory

folderName <- paste0("treat",i)
dir.create(folderName)
#current.folder <- "X:/Claire/dump/MARXAN-copy"
 current.folder <- "X:/Claire/Management Strategy Evaluation/MARXAN_RUNS/MARXAN-copy"
list.of.files <- list.files(current.folder,full.names=TRUE,include.dirs = TRUE)
newFolder <- folderName
file.copy(list.of.files, newFolder,recursive=TRUE)


#### generate new input files ####
setwd(paste0(getwd(),"/",newFolder,"/pulayer"))

### write pu.dat file ###

x <- readOGR(dsn="pu_10km_cost_hab.shp",layer="pu_10km_cost_hab")
z <- coordinates(x)
z <- data.frame(z)
id <- x@data$PUID
cost <- x@data$cost
status <- x@data$status
xloc <- z$X1
yloc <- z$X2
pu <- data.frame(cbind(id,cost,status,xloc,yloc)) 
write.table(pu,paste0("X:/Claire/Management Strategy Evaluation/MARXAN_RUNS/",newFolder,"/input/pu.dat"),
            sep="\t",quote=FALSE,row.names=FALSE)

##### write spec.dat file ####

id <- c(7,8,9) ### refers to column number for stony, black and octocorals

### theoretically would loop this portion to generate a number of different#########
######## conservation targets ########################################
prop <-c(i,i,i)
##################################################################
target <- c(0.0,0.0,0.0)
target2 <- c(0,0,0)
spf <- c(1.0,1.0,1.0)
name <- c("stony","black","octo")

spec <- data.frame(cbind(id,prop,target,target2,spf,name))
write.table(spec,paste0("X:/Claire/Management Strategy Evaluation/MARXAN_RUNS/",newFolder,"/input/spec.dat"),
            sep="\t",quote=FALSE,row.names=FALSE)
#### write puvspr.dat ####
y <- x@data

library(plyr)

z <-rename(y, c('left'=0,'top'=1,'right'=2,'bottom'=3,
                'id'=4,'reserve'=5,'status'=6,'stony'=7,'black'=8,'octo'=9,
                'cost'=10,'PUID'=11,'best'=12))

### subset polygon data for stony coral (7) ###

seven <- z[,c(5,8)]
seven$species <- 7
seven <- rename(seven,c('7'="amount",'4'='pu'))
seven <- seven[c("species", "pu", "amount")]

### subset polygon data for black coral (8) ###

eight <- z[,c(5,9)]
eight$species <- 8
eight <- rename(eight,c('8'="amount",'4'='pu'))
eight <- eight[c("species", "pu", "amount")]

### subset polygon data for octocoral (9) ###

nine <- z[,c(5,10)]
nine$species <- 9
nine <- rename(nine,c('9'="amount",'4'='pu'))
nine <- nine[c("species", "pu", "amount")]

puvspr <- rbind(seven,eight,nine)
puvspr$pu <- as.numeric(as.character(puvspr$pu))
puvspr <- arrange(puvspr,pu)

write.table(puvspr,paste0("X:/Claire/Management Strategy Evaluation/MARXAN_RUNS/",newFolder,"/input/puvspr.dat"),
            sep="\t",quote=FALSE,row.names=FALSE)

#### puvspr_sporder.dat file ####

puvspr_sporder <- arrange(puvspr,species)

write.table(puvspr_sporder,paste0("X:/Claire/Management Strategy Evaluation/MARXAN_RUNS/",newFolder,"/input/puvspr_sporder.dat"),
            sep="\t",quote=FALSE,row.names=FALSE)

setwd(paste0("X:/Claire/Management Strategy Evaluation/MARXAN_RUNS/", newFolder))
system("Marxan_x64.exe",wait=T,invisible=T, input="Marxan_x64")
}# Call Marxan to execute







### Solutions loop ###
library(plyr)
library(raster)

setwd("C:/Users/claire.GMFMC/Desktop/WFH files/dump/MARXAN-copy/pulayer")
z <- readOGR(dsn="pu_10km_cost_hab.shp",layer="pu_10km_cost_hab")

for(i in c(0.01,0.02,0.05,0.10)){

folderName <- paste0("treat",i)

setwd(paste0("C:/Users/claire.GMFMC/Desktop/WFH files/dump/",folderName,
             "/output"))

x <- read.table("output_best.txt", sep=",", header=TRUE)
y <- x[,2]
z@data$out <- y

names(z@data)[names(z@data)=="out"] <- folderName
r<- raster()
extent(r)<- extent(z)
rast<- rasterize(z,r,field=z@data[,folderName],fun="mean",na.rm=TRUE)
closeAllConnections()

rasterName <- paste0("rast",i)

writeRaster(rast,filename = paste0("C:/Users/claire.GMFMC/Desktop/WFH files/dump/",rasterName,".tif"))

}

fs <- list.files(path="C:/Users/claire.GMFMC/Desktop/WFH files/dump", pattern = "tif$", full.names = TRUE)

s <- raster::stack(fs)
writeRaster(s, "stack.TIF")
s.brick <- brick(s)
plot(mean(s.brick))


