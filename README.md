# Air Quality Dashboard

This project demonstrates API integration, SQL storage, and data visualization using RShiny.

## Setup Instructions

1. Clone the repository: `git clone https://github.com/yourusername/AirQualityDashboard.git`
2. Install required R packages: `shiny`, `DBI`, `RSQLite`, `ggplot2`, `leaflet`, `httr`, `jsonlite`
3. Replace `your_api_key_here` in `api_integration.R` with your OpenWeatherMap API key.
4. Run `api_integration.R` to fetch and store data.
5. Start the Shiny app: `shiny::runApp('shiny_app')`.

## Features

- Interactive plot of PM2.5 levels over time.
- Map showing selected city's air quality station.

## License
MIT License
