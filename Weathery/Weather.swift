import Foundation

struct WeatherData: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Coord: Codable {
    let lon, lat: Double
}

struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}
