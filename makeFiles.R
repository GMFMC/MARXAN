
##Make some folders and copy contents from seed to folders
## For now, copy the exe to the folders. 
## can write the input files later
setwd("K:/marxanAuto")
for(i in 1:2){
folderName <- paste0("test", i)
dir.create(folderName)
current.folder <- "K:/marxanAuto/seed"
list.of.files <- list.files(current.folder, full.names=TRUE, pattern = "\\.exe")
newFolder <- folderName
file.copy(list.of.files, newFolder)
  }

## Later, will put this into loop above. 
setwd(paste0("K:/marxanAuto/", newFolder))
system("Marxan_x64.exe",wait=T,invisible=T, input="Marxan_x64") # Call Marxan to execute
## Copy exe from seed to 

