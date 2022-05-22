//
//  WeatherModel.swift
//  Weather
//
//  Created by Emmanuel Solis on 3/8/22.
//

import Foundation

struct Post: Codable {
  let coord: Coord
  let weather: [Weather]
  let base: String
  let main: Main
  let visibility: Int
  let wind: Wind
  let clouds: Clouds
  let dt: Int
  let sys: Sys
  let timezone, id: Int
  let name: String
  let cod: Int
}

  // MARK: - Clouds
struct Clouds: Codable {
  let all: Int
}

  // MARK: - Coord
struct Coord: Codable {
  let lon, lat: Double
}

  // MARK: - Main
struct Main: Codable {
  let temp, feelsLike, tempMin, tempMax: Double
  let pressure, humidity: Int
  
  enum CodingKeys: String, CodingKey {
    case temp
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case tempMax = "temp_max"
    case pressure, humidity
  }
}

  // MARK: - Sys
struct Sys: Codable {
  let type, id: Int
  let country: String
  let sunrise, sunset: Int
}

  // MARK: - Weather
struct Weather: Codable {
  let id: Int
  let main, weatherDescription, icon: String
  
  enum CodingKeys: String, CodingKey {
    case id, main
    case weatherDescription = "description"
    case icon
  }
}

  // MARK: - Wind
struct Wind: Codable {
  let speed: Double
  let deg: Int
}

class WeatherZone {
  let API_KEY = "516d124642cee1bdb8aff459b08903ff"
  let BASE_URL = "https://api.openweathermap.org/data/2.5/weather?"
  
  var weather_info: Post?
  var latitud: Double
  var longitud: Double
  
  init() {
    // Silicon Valley by default.
    self.latitud = 37.37
    self.longitud = -122.04
  }
  
  func build_request_url (my_lon: Double, my_lat: Double, my_key: String) -> String {
    var url: String = self.BASE_URL
    url += "lat="
    url += String(my_lat)
    url += "&lon="
    url += String(my_lon)
    url += "&appid="
    url += my_key
    
    return url
  }
  
  func fetch_data (my_request_url: String) -> Void {
    let my_url = URL(string: my_request_url)!
    let my_url_session = URLSession.shared
    
    my_url_session.dataTask(with: my_url) { my_data, my_header, my_error in
      if let my_data = my_data {
        // Parsing data.
        self.weather_info = try! JSONDecoder().decode(Post.self, from: my_data)
        print(self.weather_info!)
      }
    }.resume()
  }

  func make_request() {
    let url = self.build_request_url(my_lon: self.longitud, my_lat: self.latitud, my_key: self.API_KEY)
    self.fetch_data(my_request_url: url)
  }
}
