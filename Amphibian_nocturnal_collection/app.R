#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(htmltools)
library(tidyverse)
library(data.table)


# Define server logic required to draw a histogram
server <- function(input, output, session) {
  # output$map1 <- renderLeaflet({
  #   topoData <- readLines("https://rstudio.github.io/leaflet/json/us-10m.json") %>% paste(collapse = "\n")
  # 
  #   leaflet() %>% setView(lng = -97, lat = 38, zoom = 4) %>%
  #    addTiles() %>%
  #    addTopoJSON(topoData, weight = 0.01, color = "#444444", fill = FALSE)
  # })
  # observe({ #Commented out because I couldn't get the reactive click input to work, but it just needs to be debugged
  #   loc_click <- input$map1_click
  #   if (is.null(loc_click))
  #     return()
  #   addPopups(output$map1, loc_click$lat, loc_click$lng, popup = htmlEscape("Yo"))
  #   }) 
  
  #Create template data frame, couldn't figure out how to host online for download  
  obs_date <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  time_start  <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  time_end <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  init_coords <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  final_coords <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  species <- c("Ambystoma maculatum", "Plethodon cinereus", "Ambystoma laterale", "Notophthalmus viridescens", "Hemidactylium scutatum", "Desmognathus fuscus", "Eurycea bislineata", "Gyrinophilus porphyriticus")
  count <- c(0, 0, 0, 0, 0, 0, 0, 0)
  temp <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  precip_conditions  <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  observer_num <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  lead_observer_email <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  obs_template <- data.frame(obs_date, time_start, time_end, init_coords, final_coords, species, count, temp, precip_conditions, observer_num, lead_observer_email)
  
  data_output <- reactive({
    date <- c(output$date)
    date2 <- c(output$date)
    data.frame(date, date2)
  })  
  output$download_df <- downloadHandler(
    filename = "herp_df.csv",
    content = function(file) {fwrite(data_output, file)},
    contentType = "text/csv"
  )
}



# Define server logic required to draw a histogram
server <- function(input, output, session) {
  # output$map1 <- renderLeaflet({
  #   topoData <- readLines("https://rstudio.github.io/leaflet/json/us-10m.json") %>% paste(collapse = "\n")
  # 
  #   leaflet() %>% setView(lng = -97, lat = 38, zoom = 4) %>%
  #    addTiles() %>%
  #    addTopoJSON(topoData, weight = 0.01, color = "#444444", fill = FALSE)
  # })
  # observe({ #Commented out because I couldn't get the reactive click input to work, but it just needs to be debugged
  #   loc_click <- input$map1_click
  #   if (is.null(loc_click))
  #     return()
  #   addPopups(output$map1, loc_click$lat, loc_click$lng, popup = htmlEscape("Yo"))
  #   }) 
  
  #Create template data frame, couldn't figure out how to host online for download  
  obs_date <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  time_start  <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  time_end <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  init_coords <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  final_coords <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  species <- c("Ambystoma maculatum", "Plethodon cinereus", "Ambystoma laterale", "Notophthalmus viridescens", "Hemidactylium scutatum", "Desmognathus fuscus", "Eurycea bislineata", "Gyrinophilus porphyriticus")
  count <- c(0, 0, 0, 0, 0, 0, 0, 0)
  temp <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  precip_conditions  <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  observer_num <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  lead_observer_email <- c(NA, NA, NA, NA, NA, NA, NA, NA)
  obs_template <- data.frame(obs_date, time_start, time_end, init_coords, final_coords, species, count, temp, precip_conditions, observer_num, lead_observer_email)
  
  data_output <- reactive({
    date <- c(output$date)
    date2 <- c(output$date)
    data.frame(date, date2)
  })  
  output$download_df <- downloadHandler(
    filename = "herp_df.csv",
    content = function(file) {fwrite(data_output, file)},
    contentType = "text/csv"
  )
}

# Run the application 
shinyApp(ui = ui, server = server)
