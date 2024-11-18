library(shiny)
library(DBI)
library(RSQLite)
library(ggplot2)
library(leaflet)

# Connect to SQLite database
db <- dbConnect(SQLite(), "air_quality.db")

# UI
ui <- fluidPage(
  titlePanel("Air Quality Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput("city", "Select City:", choices = c("New York City")),
      dateRangeInput("date_range", "Select Date Range:", start = Sys.Date() - 30, end = Sys.Date())
    ),
    mainPanel(
      plotOutput("aq_plot"),
      leafletOutput("map")
    )
  )
)

# Server
server <- function(input, output) {
  
  # Reactive: Query data from SQL based on input
  air_quality_data <- reactive({
    query <- paste0("SELECT * FROM air_quality WHERE city = '", input$city, 
                    "' AND datetime BETWEEN '", input$date_range[1], 
                    "' AND '", input$date_range[2], "'")
    dbGetQuery(db, query)
  })
  
  # Plot air quality data
  output$aq_plot <- renderPlot({
    data <- air_quality_data()
    ggplot(data, aes(x = datetime, y = pm25)) +
      geom_line() +
      labs(title = "PM2.5 Levels Over Time", x = "Date", y = "PM2.5 (µg/m³)")
  })
  
  # Map with leaflet
  output$map <- renderLeaflet({
    data <- air_quality_data()
    leaflet(data) %>%
      addTiles() %>%
      addMarkers(lng = data$longitude[1], lat = data$latitude[1], popup = input$city)
  })
}

# Run the app
shinyApp(ui = ui, server = server)
