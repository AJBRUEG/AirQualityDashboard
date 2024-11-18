library(DBI)
library(RSQLite)

# Connect to SQLite database
db <- dbConnect(SQLite(), "air_quality.db")

# Create the table (if not exists)
dbExecute(db, "CREATE TABLE IF NOT EXISTS air_quality (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    city TEXT,
    latitude REAL,
    longitude REAL,
    datetime TEXT,
    aqi INTEGER,
    pm25 REAL,
    pm10 REAL,
    ozone REAL
)")

# Insert API data
store_data <- function(data, city, lat, lon) {
  for (entry in data) {
    dbExecute(db, "INSERT INTO air_quality (city, latitude, longitude, datetime, aqi, pm25, pm10, ozone)
                  VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
              params = list(city, lat, lon, entry$dt, entry$main$aqi,
                            entry$components$pm2_5, entry$components$pm10, entry$components$o3))
  }
}

# Example: Store NYC data
store_data(nyc_data, "New York City", 40.7128, -74.0060)

# Disconnect
dbDisconnect(db)
