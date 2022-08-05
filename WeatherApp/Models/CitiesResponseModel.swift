//
//  CitiesResponseModel.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 03/08/2022.
//

import Foundation

// Model of the response body, get from calling the OpenWeather API
struct CitiesResponseModel: Decodable {
    var citiesList: [CityContent]
    
    struct CityContent: Decodable {
        var city: String
        var lat: String
        var lng: String
        var population: String
        var admin_name: String
    }
}
