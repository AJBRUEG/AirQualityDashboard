CREATE TABLE air_quality (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    city TEXT,
    latitude REAL,
    longitude REAL,
    datetime TEXT,
    aqi INTEGER,
    pm25 REAL,
    pm10 REAL,
    ozone REAL
);
