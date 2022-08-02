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
    @State var backgroundColor: Color = Color(hue: 0.656, saturation: 0.787, brightness: 0.354) // dark blue
    @State var weatherManager = WeatherManager()
    @State var weatherData: WeatherResponseModel?
    
    var body: some View {
        ZStack {
            // background
            backgroundColor.ignoresSafeArea(.all)
            
            // if location found, show views content
            if let location = locationManager.location {
                // content
                // if weather has been feathed successfully
                if let weatherData = weatherData {
                    // then, display weather details view
                    WeatherView(weather: weatherData)
                        .environmentObject(locationManager)
                } else {
                    // if not, show loading and start fetching
                    ActivityIndicatorView(divideValue: 9.0)
                        .task {
                            do {
                                weatherData = try await
                                weatherManager
                                    .getCurrentWeather(
                                        latitude: location.latitude,
                                        longitude: location.longitude
                                    )
                            } catch {
                                print("[ERROR GETTING WEATHER]: \(error)")
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
