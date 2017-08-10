shinyServer(function(input, output, session) {
  
  ## Interactive Map ###########################################
  
  
  # Select <- reactive({
  #   switch(input$species,
  #          "Benthic Grazers"=R1,
  #          "Bivalves"=R2,"Blue Crab"=R3,"Brown Shrimp"=R4,"Carnivorous Macrobenthos"=R5,
  #          "Crabs and Lobsters"=R6,"Deep Serranidae"=R7,'Flatfish'=R8,"Infaunal meiobethos"=R9,
  #          'Jacks'=R10,'Jellyfish'=R11,'Large Pelagic Fish'=R12,'Large Reef Fish'=R13,'Large Sharks'=R14,
  #          "Lutjanidae"=R15,'Medium Pelagic Fish'=R16,'Menhaden'=R17,'Other Demersal Fish'=R18,
  #          "Other Shrimp"=R19,"Pinfish"=R20,"Pink Shrimp"=R21,'Red Grouper'=R22,'Red Snapper'=R23,
  #          'Sciaenidae'=R24,'Seatrout'=R25,'Sessile Filter Feeders'=R26,'Shallow Serranidae'=R27,
  #          'Skates and Rays'=R28,'Small Demersal Fish'=R29,'Small Pelagic Fish'=R30,'Small Reef Fish'=R31,'Spanish Mackerel'=R32,
  #          "Spanish Sardine"=R33,"Squid"=R34,'Vermilion Snapper'=R35,"White Shrimp"=R36
  #   )
  #   
  #   
  # }) # reactive
  # 
  # 
  # 
  # SubSet <- reactive({
  #   subset(Select(), Select()$Percent>=input$quantile[1] & Select()$Percent <=input$quantile[2])
  # }) #reactive
  # 
  # 
  # 
  # 
  # Raster<-reactive({
  #   R.fit<-rasterFromXYZ(SubSet()[,c(1:2,5)])
  #   proj4string(R.fit) <- CRS("+init=epsg:4326")
  #   R.fit
  #   
  # })
  Select <- reactive({
    switch(input$entries,
           "Black Coral" = black, "Stony Coral"=stony, "Octocoral"=octo,
           "VMS"=VMS, "ELB"=ELB
           )
  })
  
  Select2 <- reactive({
    switch(input$species,
           
           "Any Depth"=anyDepth, "50 m to 2000 m"=fifty,"50 m to EEZ"=fiftyEEZ,
           "100 m to 2000 m"=onehund,"100 m to EEZ"=onehundEEZ,
           "150 m to 2000 m"=oneFifty,"150 m to EEZ"=oneFiftyEEZ,
           "VMS 100%"=VMS_100,"VMS 80% ELB 20%"=VMS_80_ELB_20,"VMS 60% ELB 40%"=VMS_60_ELB_40,
           "VMS 40% ELB 60%"=VMS_40_ELB_60,"VMS 20% ELB 80%"=VMS_20_ELB_80,"ELB 100%"=ELB_100)
    # #
    # #
  })#reactive
  
  
 
  # Create the map
  output$map1 <- renderLeaflet({
    leaflet() %>%
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
               options = providerTileOptions(noWrap = TRUE)) %>%
      addTiles('http://server.arcgisonline.com/ArcGIS/rest/services/Reference/World_Boundaries_and_Places/Mapserver/tile/{z}/{y}/{x}',
               options = providerTileOptions(noWrap = TRUE)) %>%
      #addPolylines(data=councilB, color = "red") %>% 
      
      setView(-89.87, 25.15, zoom = 6)
    
    
    
  }) ## renderLeaflet
 
  observe({
    factpal <- colorNumeric(c("#3B9AB2", "#78B7C5",
                              "#EBCC2A", "#E1AF00" ,"#F21A00"),
                            na.color="transparent",values(Select2()))


    leafletProxy("map1") %>%
      clearImages() %>%

      addRasterImage(Select2(), colors = factpal, opacity = 0.8, group="Turn on/off layer") %>%
      addRasterImage(Select(),colors=factpal,opacity=0.8) %>% 
      addLayersControl(overlayGroups = "Turn on/off layer",
                       options=layersControlOptions(collapsed=FALSE),
                       position=c("bottomleft"))





  }) ##observe
  
  
  observe({
    
    factpal <- colorNumeric(c("#3B9AB2", "#78B7C5",
                              "#EBCC2A", "#E1AF00" ,"#F21A00"), na.color="transparent",values(Select2()))
    # 
    # factpal <- colorBin(c("#3B9AB2", "#78B7C5",
    #                        "#EBCC2A", "#E1AF00" ,"#F21A00"), 
    #                      na.color="transparent",values(Select2()),bins=7)
    # factpal <- colorNumeric(c('#ffffb2','#fed976','#feb24c','#fd8d3c','#fc4e2a','#e31a1c','#b10026'),
    #                         na.color="transparent",values(Select2()))
    
    
    proxy <- leafletProxy("map1", data =Select2())
    proxy %>% clearControls()
    # proxy %>% addLegend(position = "bottomright",
    #                     pal = factpal, values = ColorData)
    proxy %>% addLegend(pal = factpal, values = values(Select2()), 
                        title = "Number of contributing runs", position="bottomleft")
  })#observe
  

  
  
  
})#shiny server
#    
# 
#   # 
