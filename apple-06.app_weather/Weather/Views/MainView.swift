//
//  ContentView.swift
//  Weather
//
//  Created by Emmanuel Solis on 3/6/22.
//

import SwiftUI

struct MainView: View {
  @State private var latitud: String = ""
  @State private var longitud: String = ""
  @State private var country: String = "" // Using ISO 3166 country codes.
  @State private var city: String = ""
  @State private var zip_code: String = ""
  @State private var weather = WeatherZone()
  var countries = [
    "Costa Rica",
    "United States"
  ]
  
  var body: some View {
    // Header
    VStack {
      Image("Profile_Photo")
        .resizable()
        .scaledToFit()
        .frame(width: 250.0, height: 250.0, alignment: .top)
        .border(Color.black, width: 3.0)
      Text("Emmanuel's Weather App")
        .font(.title)
    }
    // Search by Coordenates.
    VStack {
      HStack {
        TextField(
          "Enter Latitud",
          text: $latitud)
          .border(Color(UIColor.secondaryLabel))
        TextField(
          "Enter Longitud",
          text: $longitud)
          .border(Color(UIColor.secondaryLabel))
      }
      Button(action: {
        weather.make_request()
      }) {
        Text("Search by Coordenates").font(.headline)
      }
    }
    // Search by location name.
    VStack {
      HStack {
        TextField(
          "Enter City",
          text: $city)
          .border(Color(UIColor.secondaryLabel))
        Picker("Color Scheme", selection: $country) {
          ForEach(countries, id: \.self) { my_country in
            Text(my_country)
          }
        }.border(Color(UIColor.secondaryLabel))
      }
      Button(action: {
        weather.make_request()
      }) {
        Text("Search by City name").font(.headline)
      }
    }
    // Seach by Zip Code.
    VStack {
      HStack {
        TextField(
          "Enter Zip Code",
          text: $zip_code)
          .border(Color(UIColor.secondaryLabel))
        Picker("Color Scheme", selection: $country) {
          ForEach(countries, id: \.self) { my_country in
            Text(my_country)
          }
        }.border(Color(UIColor.secondaryLabel))
      }
      Button(action: {
        weather.make_request()
      }) {
        Text("Search by Zip Code").font(.headline)
        /*HStack {
          Image(systemName: "bookmark.fill")
          Text("Search by zip code")
        }
        .padding(10.0)
        .overlay(
          RoundedRectangle(cornerRadius: 10.0)
            .stroke(lineWidth: 2.0))*/
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

