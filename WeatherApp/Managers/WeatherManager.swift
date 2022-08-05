/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Le Nguyen Truong An
  ID: 3820098
  Last modified: 05/08/2022
  Acknowledgement:
    + https://www.hackingwithswift.com/
    + https://openweathermap.org/
    + https://stackoverflow.com/
    + https://peterfriese.dev/
    + https://www.tutorialspoint.com/
    + https://www.github.com/
*/

//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 29/07/2022.
//


import Foundation
import CoreLocation

class WeatherManager: NSObject, ObservableObject {
    @Published var weatherData: WeatherResponseModel? // remember to be Optional
    
    /*
     Method to make HTTP request to get weather from OpenWeather API
     */
    func getCurrentWeather(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees
    ) async throws {
        // API key
        let API_KEY = "8cefcd7047392abd796820e4610483a9";
        
        // create URL with suitable queries
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(API_KEY)&units=metric")
        else { fatalError("Missing URL") }
        
        // create URL request
        let urlRequest = URLRequest(url: url)
        
        // create fetching session
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // if the request made successffully
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching weather data") }
        
        // decode JSON response and return
        let decodedData = try JSONDecoder().decode(WeatherResponseModel.self, from: data)
        
        // SOLVED: Publishing changes from background threads is not allowed
        await MainActor.run {
            weatherData = decodedData
        }
    }
}
