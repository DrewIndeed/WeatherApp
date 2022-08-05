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
//  ModelData.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 29/07/2022.
//

import Foundation

/*
 Method to read and parse JSON data from JSON file
 */
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

// load preview weather JSON data
var previewWeather: WeatherResponseModel = load("weatherData.json")

// load preview AU cities JSON data
var previewCities: CitiesResponseModel = load("auCitiesData.json")
