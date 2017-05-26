##Generic files to read in test file
##Files are tab delimited.  
setwd("X:/Claire/Management Strategy Evaluation/demo/inputs")

pu <- read.table("pu.dat", sep="\t", header=TRUE)
head(pu)

bound <- read.table("bound.dat", sep="\t", header=TRUE)
head(bound)

puvspr <- read.table("puvspr.dat", sep="\t", header=TRUE)
head(puvspr)

puvspr_sporder <- read.table("puvspr_sporder.dat", sep="\t", header=TRUE)
head(puvspr_sporder)

spec <- read.table("spec.dat", sep="\t", header=TRUE)
head(spec)

setwd("X:/Claire/Management Strategy Evaluation/demo")

input <- read.table("input.dat", sep="\t", header=FALSE,
                    blank.lines.skip=FALSE)

write.table(input, "inputout.dat", row.names=FALSE, quote=FALSE, 
          col.names=FALSE)

setwd("K:/marxanAuto/seed - Copy")

input <- read.table("input.dat", sep="\t", header=FALSE,
                    blank.lines.skip=FALSE)
write.table(input, "input.dat", row.names=FALSE, quote=FALSE, 
            col.names=FALSE)

