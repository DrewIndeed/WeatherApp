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
//  ContentView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 28/07/2022.
//

import SwiftUI

struct ContentView: View {
    /*
     Using StateObject to notify the View everytime
     the @Publish variables in Location Manager are updated
     */
    @StateObject var locationManager = LocationManager()
    @StateObject var weatherManager = WeatherManager()
    
    // dark blue
    @State var backgroundColor: Color = Color(hue: 0.656, saturation: 0.787, brightness: 0.354)
    
    var body: some View {
        ZStack {
            // background
            backgroundColor.ignoresSafeArea(.all)
            
            // if location found, show views content
            if let location = locationManager.location {
                // if weather has been feathed successfully
                if let weatherData = weatherManager.weatherData {
                    // then, display weather details view
                    WeatherDetailsView(weather: weatherData)
                        .environmentObject(locationManager)
                        .environmentObject(weatherManager)
                } else {
                    // if not, show loading and start fetching
                    ActivityIndicatorView(divideValue: 9.0)
                        .task {
                            do {
                                try await weatherManager
                                    .getCurrentWeather(
                                        latitude: location.latitude,
                                        longitude: location.longitude
                                    )
                            } catch {
                                print("[ERROR GETTING WEATHER at ContentView]: \(error)")
                            }
                        }
                }
            } else {
                // if there has been no current location
                if locationManager.isLoading {
                    ActivityIndicatorView(divideValue: 9.0)
                } else {
                    // show welcome view
                    WelcomeView()
                        .transition(.move(edge: .leading))
                        .environmentObject(locationManager)
                        .environmentObject(weatherManager)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
