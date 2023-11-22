


# Define server logic for app
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
 
#Create template data frame, couldn't figure out how to host online for download until later
 obs_date <- c(NA, NA, NA, NA, NA, NA, NA, NA)
 time_start  <- c(NA, NA, NA, NA, NA, NA, NA, NA)
 time_end <- c(NA, NA, NA, NA, NA, NA, NA, NA)
 init_coords <- c(NA, NA, NA, NA, NA, NA, NA, NA)
 final_coords <- c(NA, NA, NA, NA, NA, NA, NA, NA)
 species <- c("Ambystoma maculatum", "Plethodon cinereus", "Ambystoma laterale", "Notophthalmus viridescens", "Hemidactylium scutatum", "Desmognathus fuscus", "Eurycea bislineata", "Gyrinophilus porphyriticus")
 count_num <- c(0, 0, 0, 0, 0, 0, 0, 0)
 temp <- c(NA, NA, NA, NA, NA, NA, NA, NA)
 precip_conditions <- c(NA, NA, NA, NA, NA, NA, NA, NA)
 observer_num <- c(NA, NA, NA, NA, NA, NA, NA, NA)
 lead_observer_email <- c(NA, NA, NA, NA, NA, NA, NA, NA)
 obs_template <- data.frame(obs_date, time_start, time_end, init_coords, final_coords, species, count_num, temp, precip_conditions, observer_num, lead_observer_email)

#Mutate data frame with input from user 
 data_output <- reactive({
   obs_template %>% 
     mutate(obs_date = input$obs_date) %>% 
     mutate(time_start = hms::as_hms(input$start_time)) %>% 
     mutate(time_end = hms::as_hms(input$end_time)) %>% 
     mutate(init_coords = str_c(input$lat_init, ", ", input$lng_init)) %>% 
     mutate(final_coords = str_c(input$lat_final, ", ", input$lng_final)) %>% 
     mutate(count_num = case_when(species == "Ambystoma maculatum" ~ input$count_ambystoma_maculatum, 
                                 species == "Plethodon cinereus" ~ input$count_plethodon_cinereus,
                                 species == "Ambystoma laterale" ~ input$count_ambystoma_laterale,
                                 species == "Notophthalmus viridescens" ~ input$count_notophthalmus_viridescens,
                                 species == "Hemidactylium scutatum" ~ input$count_hemidactylium_scutatum,
                                 species == "Desmognathus fuscus" ~ input$count_desmognathus_fuscus,
                                 species == "Eurycea bislineata" ~ input$count_eurycea_bislineata,
                                 species == "Gyrinophilus porphyriticus" ~ input$count_gyrinophilus_porphyriticus)) %>% 
     mutate(temp = input$temp_f) %>% 
     mutate(precip_conditions = input$weather_select) %>% 
     mutate(observer_num = input$observers) %>% 
     mutate(lead_observer_email = input$email) %>% 
     filter(count_num > 0)
  }) 
#Download data as .csv if the button is selected
 output$download_df <- downloadHandler(
   filename = function() {"big_night_data.csv"},
   content = function(file) {write.csv(data_output(), file)
   }
 )
}



