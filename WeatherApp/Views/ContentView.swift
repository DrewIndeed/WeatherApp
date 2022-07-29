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
    @State var backgroundColor: Color = Color(hue: 0.656, saturation: 0.932, brightness: 0.475) // dark blue
    @State var weatherManager = WeatherManager()
    @State var weatherData: WeatherResponseModel?
    
    var body: some View {
        ZStack {
            // background
            backgroundColor.ignoresSafeArea(.all)
            
            // if location found, show views content
            if let location = locationManager.location {
                // content
                // if weather is feathed successfully
                if weatherData != nil {
                    Text("Weather data successfully fetched!")
                } else {
                    // if not, show loading and try again
                    ActivityIndicatorView()
                        .task {
                            do {
                                weatherData = try await
                                weatherManager
                                    .getCurrentWeather(
                                        latitude: location.latitude,
                                        longitude: location.longitude)
                            } catch {
                                print("[ERROR GETTING WEATHER]: \(error)")
                            }
                        }
                }
            } else {
                // if there has been no location
                if locationManager.isLoading {
                    ActivityIndicatorView()
                } else {
                    WelcomeView()
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
