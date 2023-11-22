#Load packages
library(shiny)
library(htmltools)
library(tidyverse)
library(data.table)
library(sp)
library(lubridate)
library(shinyTime)
library(hms)
library(bslib)

# Define UI for application
ui <- fluidPage(
    #Set theme to dark
    theme = bslib::bs_theme(bootswatch = "darkly"),
    # Application title
    titlePanel(title = "Big Night Amphibian Data Collection", windowTitle = "Big Night Amphibian Data Collection"),
    fluidPage(
    ),
    #Create a sidebar panel with every form question except those for species counts
    sidebarLayout(
        sidebarPanel(
          width = 3,
          dateInput("obs_date", "Date of observation:"),
          timeInput("start_time", "When did obserservations begin?"),
          timeInput("end_time", "When did observations end?"),
        #leafletOutput("map1")),
          numericInput("lat_init", "Latitude of initial point of observation", min = -90, max = 90, value = 0, step = 1),
          numericInput("lng_init", "Longitude of initial point of observation", min = -180, max = 180, value = 0, step = 1),      
          numericInput("lat_final", "Latitude of final point of observation", min = -90, max = 90, value = 0, step = 1),
          numericInput("lng_final", "Longitude of final point of observation", min = -180, max = 180, value = 0, step = 1),
          numericInput("temp_f", "What was the temperature in Fareheit at the first observation?", min = 0, max = 120, value = 0, step = 1),
          selectInput("weather_select", "What was the level of precipitation during the first observation?", c("Please select an option" = "NA", 
                                                                                                         "Dry" = "dry",
                                                                                                         "Previously raining" = "previously_raining",
                                                                                                         "Misty" = "misty",
                                                                                                         "Drizzling" = "drizzling",
                                                                                                         "Raining" = "raining",
                                                                                                         "Downpour" = "downpour")),
          numericInput("observers", "How many people were involved with observing?", value = 1),
          textInput("email", "At what email can we contact you with questions about your data?")
        ),
        #Fill main panel with a number selector for each species
        mainPanel(
          width = 9,
          numericInput("count_ambystoma_maculatum", "Spotted Salamander (Ambystoma maculatum)", value = 0),
          numericInput("count_plethodon_cinereus", "Eastern Red Backed Salamander (Plethodon cinereus)", value = 0),
          numericInput("count_ambystoma_laterale", "Blue Spotted Salamander (Ambystoma laterale)", value = 0),
          numericInput("count_notophthalmus_viridescens", "Eastern Newt (Notophthalmus viridescens)", value = 0),
          numericInput("count_hemidactylium_scutatum", "Four Toed Salamander (Hemidactylium scutatum)", value = 0),
          numericInput("count_desmognathus_fuscus", "Northern Dusky Salamander (Desmognathus fuscus)", value = 0),
          numericInput("count_eurycea_bislineata", "Northern Two-lined Salamander (Eurycea bislineata)", value = 0),
          numericInput("count_gyrinophilus_porphyriticus", "Spring Salamander (Gyrinophilus porphyriticus)", value = 0),
          downloadButton("download_df", "Download the data set")
        )
    )
)

