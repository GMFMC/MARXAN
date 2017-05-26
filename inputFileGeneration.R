library(rgdal)
setwd("X:/Claire/Management Strategy Evaluation/demo/pulayer")
x <- readOGR(dsn="pu_10km_cost_hab.shp",layer="pu_10km_cost_hab")

##### write pu.dat file #####
z <- coordinates(x)
z <- data.frame(z)

id <- x@data$PUID
cost <- x@data$cost
status <- x@data$status
xloc <- z$X1
yloc <- z$X2
pu <- data.frame(cbind(id,cost,status,xloc,yloc)) 
write.table(pu,"X:/Claire/Management Strategy Evaluation/demo/inputs/pu.dat",
            sep="\t",quote=FALSE,row.names=FALSE)

##### write spec.dat file ####

id <- c(7,8,9) ### refers to column number for stony, black and octocorals

### theoretically would loop this portion to generate a number of different#########
######## conservation targets ########################################
prop <-c(0.019,0.019,0.020)
##################################################################
target <- c(0.0,0.0,0.0)
target2 <- c(0,0,0)
spf <- c(1.0,1.0,1.0)
name <- c("stony","black","octo")

spec <- data.frame(cbind(id,prop,target,target2,spf,name))
write.table(spec,"X:/Claire/Management Strategy Evaluation/demo/inputs/spec.dat",
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

write.table(puvspr,"X:/Claire/Management Strategy Evaluation/demo/inputs/puvspr.dat",
            sep="\t",quote=FALSE,row.names=FALSE)

#### puvspr_sporder.dat file ####

puvspr_sporder <- arrange(puvspr,species)

write.table(puvspr_sporder,"X:/Claire/Management Strategy Evaluation/demo/inputs/puvspr_sporder.dat",
            sep="\t",quote=FALSE,row.names=FALSE)
