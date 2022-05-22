import UIKit
import Foundation

  // This file was generated from JSON Schema using quicktype, do not modify it directly.
  // To parse the JSON, add this file to your project and do:
  //
  //   let post = try? newJSONDecoder().decode(Post.self, from: jsonData)

  // MARK: - Post
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
  let BASE_URL = "api.openweathermap.org/data/2.5/weather?"
  
  var weather_info: Post?
  var latitud: Double
  var longitud: Double
  
  let test_data = """
  {
  "coord": {
    "lon": -122.08,
    "lat": 37.39
  },
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 282.55,
    "feels_like": 281.86,
    "temp_min": 280.37,
    "temp_max": 284.26,
    "pressure": 1023,
    "humidity": 100
  },
  "visibility": 16093,
  "wind": {
    "speed": 1.5,
    "deg": 350
  },
  "clouds": {
    "all": 1
  },
  "dt": 1560350645,
  "sys": {
    "type": 1,
    "id": 5122,
    "message": 0.0139,
    "country": "US",
    "sunrise": 1560343627,
    "sunset": 1560396563
  },
  "timezone": -25200,
  "id": 420006353,
  "name": "Mountain View",
  "cod": 200
  }
  """
  
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
    
    return "https://api.openweathermap.org/data/2.5/weather?lat=37.39&lon=-122.08&appid=516d124642cee1bdb8aff459b08903ff"
  }
  
  func fetch_data (my_request_url: String) -> Void {
    let my_url = URL(string: my_request_url)!
    let my_url_session = URLSession.shared
    var response_data = Data()
    
    my_url_session.dataTask(with: my_url) { my_data, my_header, my_error in
      if let my_data = my_data {
        response_data = my_data
        // Parsing data.
        //print(response_data)
        let response = try! JSONDecoder().decode(Post.self, from: my_data)
        print(response)
      }
    }.resume()
  }
  
  func parse_json_data() -> Void {
    let my_data = test_data.data(using: .utf8)!
    let response = try! JSONDecoder().decode(Post.self, from: my_data)
    print(response)
  }
  
  
  func make_request() {
    let url = self.build_request_url(my_lon: self.longitud, my_lat: self.latitud, my_key: self.API_KEY)
    self.fetch_data(my_request_url: url)
  }
}

var wea = WeatherZone()
wea.make_request()
//wea.parse_json_data()
