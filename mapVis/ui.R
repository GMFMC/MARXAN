shinyUI(navbarPage("", id="nav", inverse = TRUE,
                   
                   tabPanel("MARXAN Visualization",
                            div(class="outer",
                                
                                tags$head(
                                  # Include our custom CSS
                                  ##using 5-class Dark2 (qualitative color scheme)
                                  includeCSS("styles.css")#,
                                  
                                ),
                                includeCSS("slidertheme.css"),
                            
                                tags$style(HTML(".btn.btn-primary {margin-top: 20px}")),
                                tags$style(HTML(".btn.btn-primary {background: #3078a8}")),
                                
                                tags$style(HTML(".irs-min {color: #a8c0d8}")),
                                tags$style(HTML(".irs-max {color: #a8c0d8}")),
                                tags$style(HTML(".irs-min {background: #a8c0d8}")),
                                tags$style(HTML(".irs-max {background: #a8c0d8}")),
                                
                                
                                
                                
                                leafletOutput("map1", width="100%", height="100%"),
                                # DT::dataTableOutput('tbl1'),
                                absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                                              draggable = FALSE, top = 60, left = "auto", right = 20, bottom = "auto",
                                              width = 330, height = "auto",
                                              
                                              h2("MARXAN Explorer"),
                                              
                                              
                                              selectInput("species", 
                                                          label = "Iterations",
                                                          choices = c( 
                                                            "Any Depth", "50 m to 2000 m","50 m to EEZ",
                                                            "100 m to 2000 m","100 m to EEZ",
                                                            "150 m to 2000 m","150 m to EEZ",
                                                            "VMS 100%","VMS 80% ELB 20%","VMS 60% ELB 40%",
                                                            "VMS 40% ELB 60%","VMS 20% ELB 80%","ELB 100%"),
                                                          
                                                          selected = "ELB 100%"),
                                              selectInput("entries", 
                                                          label = "Entries",
                                                          choices = c( 
                                                            "Black Coral", "Stony Coral", "Octocoral",
                                                            "VMS", "ELB"),
                                                          
                                                          selected = "ELB")
                                              
                                              
                                              # sliderInput("quantile", label="Filter Abundance by Quantile",min=0,
                                              #             max=1, value=c(0.25,0.75), step=0.01),
                                              # 
                                              # submitButton("Submit")#,
                                              
                                              
                                              
                                              
                                ) ## absolutePanel
                                
                                
                                
                            ) ## div
                   ) #tabPanel
                                
                                
                           
                   
) ## navbarPage
)## ShinyUI
