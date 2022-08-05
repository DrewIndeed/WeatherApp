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
