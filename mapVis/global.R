####setwd("X:/Claire/shiny/MARXAN/mapVis")
library(DT)
library(shiny)
library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)
library(devtools)
library(grDevices)
library(raster)
library(wesanderson)
library(plotrix)
library("highcharter")
library("ggplot2")
library("shinythemes")
library(rgdal)


source("rasters.R")


##############Merging HC Themes#################
thm <- hc_theme_merge(
  hc_theme_darkunica(),
  hc_theme(
    chart = list(
      backgroundColor = "transparent"),
    title = list(
      style = list(
        color = '#004890',
        fontFamily = "Open Sans"
      )
    )
  )
)

############Council Boundary############

#councilB <- readOGR(dsn="MSA_FMC_US_Atlantic_GOM.shp",layer = "MSA_FMC_US_Atlantic_GOM")    







