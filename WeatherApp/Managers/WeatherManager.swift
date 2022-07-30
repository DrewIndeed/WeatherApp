//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 29/07/2022.
//


import Foundation
import CoreLocation

class WeatherManager {
    /*
     Method to make HTTP request to get weather from OpenWeather API
     */
    func getCurrentWeather(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees
    ) async throws -> WeatherResponseModel {
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
        
        return decodedData
    }
}
