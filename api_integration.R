library(httr)
library(jsonlite)

# API Details
base_url <- "http://api.openweathermap.org/data/2.5/air_pollution"
#enter your API key here (when you create an API key, sometimes it takes a while to activate)
api_key <- "04ce34a24fbd43e4f6f986fce31b0b30"

# Function to fetch air quality data
fetch_air_quality <- function(lat, lon) {
  url <- paste0(base_url, "?lat=", lat, "&lon=", lon, "&appid=", api_key)
  response <- GET(url)
  
  if (status_code(response) == 200) {
    data <- fromJSON(content(response, as = "text", encoding = "UTF-8"))
    return(data$list)
  } else {
    stop("API request failed. Check your API key and coordinates.")
  }
}

# Example: Fetch data for New York City
nyc_data <- fetch_air_quality(lat = 40.7128, lon = -74.0060)
print(nyc_data)
