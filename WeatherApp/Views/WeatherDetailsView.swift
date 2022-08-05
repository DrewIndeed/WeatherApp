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
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 02/08/2022.
//

import SwiftUI

struct WeatherDetailsView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var weatherManager: WeatherManager
    var weather: WeatherResponseModel
    
    // grid layout for Current Status
    let columns: [GridItem] = [
        GridItem(.fixed(60), spacing: 35, alignment: .leading),
        GridItem(.fixed(60), spacing: 35, alignment: .leading),
        GridItem(.fixed(60), spacing: 35, alignment: .leading),
    ]
    
    // main render
    var body: some View {
        // --- [START] - ZStack wrapper ---
        ZStack(alignment: .leading) {
            // --- [START] - ZStack content ---
            VStack {
                // --- [START] backbutton + location name + current date ---
                HStack {
                    Button {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            // clear location to get back to welcome view
                            locationManager.location = nil
                            
                            // clear weatherData to inject new data later for different coors
                            weatherManager.weatherData = nil
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .frame(width: 60, height: 60)
                    }
                    .frame(width: 60, height: 60)
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("\(weather.name.checkCityTrailing()), \(weather.sys.country)")
                            .font(.title2)
                            .bold()
                            .multilineTextAlignment(.trailing)
                            .lineLimit(2)
                        
                        Text("\(Date().formatted(.dateTime.weekday().month().day().hour().minute()))"
                        )
                        .fontWeight(.medium)
                        
                        Text("\(weather.weather[0].description)".capitalized)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.white)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .trailing
                    )
                    .padding([.leading, .trailing, .top], 20)
                }
                // --- [END] backbutton + location name + current date ---
                
                // --- [START] ScrollView - weather data attributes ---
                ScrollView {
                    VStack (spacing: 20) {
                        // --- [START] HStack - description + temperature ---
                        HStack (spacing: 0) {
                            Text(weather.main.temp.roundDouble(pointnum: 0) + "°C")
                                .font(.system(size: 60))
                                .foregroundColor(Color(hue: 0.145, saturation: 1.0, brightness: 1.0))
                                .multilineTextAlignment(.center)
                                .frame(
                                    minWidth: 120, maxWidth: .infinity,
                                    minHeight: 100, maxHeight: .infinity,
                                    alignment: .center
                                )
                                .background(
                                    Color(
                                        hue: 0.656,
                                        saturation: 0.787,
                                        brightness: 0.354,
                                        opacity: 0.4
                                    )
                                )
                                .cornerRadius(40)
                            
                            Spacer().frame(width: 20)
                            
                            Image(systemName: "\(weather.weather[0].main)".checkIconName())
                                .renderingMode(.original)
                                .font(.system(size: 40))
                                .frame(
                                    minWidth: 80, maxWidth: 120,
                                    minHeight: 80, maxHeight: 120,
                                    alignment: .center
                                )
                                .background(
                                    Color(
                                        hue: 0.656,
                                        saturation: 0.787,
                                        brightness: 0.354,
                                        opacity: 0.4
                                    )
                                )
                                .cornerRadius(40)
                        }
                        // --- [END] HStack - description + temperature ---
                        .padding(.top, 20)
                        .padding([.leading, .trailing], 40)
                        
                        // --- [START] HStack - sunrise ---
                        HStack {
                            HStack(alignment: .center, spacing: 20) {
                                Image(systemName: "sunrise.fill")
                                    .renderingMode(.original)
                                    .font(.system(size: 40))
                                
                                Text("Sun Rise at \(weather.sys.sunrise.convertDate(formate: "HH:mm:ss"))")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(
                                minWidth: nil, maxWidth: .infinity,
                                minHeight: 120, maxHeight: .infinity,
                                alignment: .center
                            )
                            .background(
                                Color(
                                    hue: 0.656,
                                    saturation: 0.787,
                                    brightness: 0.354,
                                    opacity: 0.4
                                )
                            )
                            .cornerRadius(40)
                        }
                        // --- [END] HStack - sunrise ---
                        .padding([.leading, .trailing], 40)
                        
                        // --- [START] HStack - sunset ---
                        HStack {
                            HStack(alignment: .center, spacing: 20) {
                                Image(systemName: "sunset.fill")
                                    .renderingMode(.original)
                                    .font(.system(size: 40))
                                
                                Text("Sun Set at \(weather.sys.sunset.convertDate(formate: "HH:mm:ss"))")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(
                                minWidth: nil, maxWidth: .infinity,
                                minHeight: 120, maxHeight: .infinity,
                                alignment: .center
                            )
                            .background(
                                Color(
                                    hue: 0.656,
                                    saturation: 0.787,
                                    brightness: 0.354,
                                    opacity: 0.4
                                )
                            )
                            .cornerRadius(40)
                        }
                        // --- [END] HStack - sunset ---
                        .padding([.leading, .trailing], 40)
                        
                        // --- [START] HStack - main weather attributes ---
                        HStack (alignment: .center) {
                            VStack (alignment: .center) {
                                VStack(alignment: .center, spacing: 30) {
                                    Text("Current Status")
                                        .font(.system(size: 25.0))
                                        .bold()
                                    
                                    LazyHGrid(
                                        rows: columns,
                                        spacing: 20,
                                        
                                        // set if you want the titles to fixed on scroll
                                        pinnedViews: [.sectionHeaders],
                                        
                                        content: {
                                            WeatherRow(logo: "thermometer.sun", name: "Min temp",
                                                       value: (weather.main.tempMin.roundDouble(pointnum: 2) + ("°C")))
                                            
                                            WeatherRow(logo: "thermometer", name: "Feels like",
                                                       value: (weather.main.feelsLike.roundDouble(pointnum: 2) + "°C"))
                                            
                                            WeatherRow(logo: "thermometer.sun.fill", name: "Max temp",
                                                       value: (weather.main.tempMax.roundDouble(pointnum: 2) + "°C"))
                                            
                                            WeatherRow(logo: "wind", name: "Wind speed",
                                                       value: (weather.wind.speed.roundDouble(pointnum: 2) + " m/s"))
                                            
                                            WeatherRow(logo: "humidity", name: "Humidity",
                                                       value: "\(weather.main.humidity.roundDouble(pointnum: 0))%")
                                            
                                            WeatherRow(logo: "heart.circle.fill", name: "Pressure",
                                                       value: "\(weather.main.pressure.roundDouble(pointnum: 0)) hPa")
                                        }
                                    )
                                }
                                .frame(
                                    minWidth: nil, maxWidth: .infinity,
                                    minHeight: nil, maxHeight: .infinity,
                                    alignment: .center
                                )
                                .padding(20)
                                .foregroundColor(.white)
                                .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.4))
                                .cornerRadius(
                                    45, corners: [.topLeft, .topRight, .bottomLeft, .bottomRight]
                                )
                                
                                // space under the Current Status box
                                Spacer().frame(height: 100)
                            }
                        }
                        // --- [END] HStack - main weather attributes ---
                        .padding([.leading, .trailing], 40)
                    }
                }
                // --- [END] ScrollView - weather data attributes ---
                .frame(
                    minWidth: 200, maxWidth: .infinity,
                    minHeight: 200, maxHeight: .infinity
                )
            }
            // --- [END] - ZStack content ---
            .frame(
                minWidth: 200, maxWidth: .infinity,
                minHeight: 200, maxHeight: .infinity
            )
            .background(
                BgVideoView(videoName: "\(weather.weather[0].main)")
            )
        }
        // --- [END] - ZStack wrapper ---
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView(weather: previewWeather)
    }
}
