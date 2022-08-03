//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 02/08/2022.
//

import SwiftUI

struct WeatherDetailsView: View {
    @EnvironmentObject var locationManager: LocationManager
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
                            
                            if (locationManager.location != nil) {
                                locationManager.location = nil
                            }
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
                        
                        Text("\(Date().formatted(.dateTime.weekday().month().day().hour().minute()))"
                        )
                        .fontWeight(.light)
                    }
                    .foregroundColor(.white)
                    .frame(
                        maxWidth: .infinity,
                        alignment: .trailing
                    )
                    .padding([.leading, .trailing], 20)
                }
                // --- [END] backbutton + location name + current date ---
                
                // --- [START] ScrollView - weather data attributes ---
                ScrollView {
                    VStack (spacing: 20) {
                        // --- [START] HStack - description + temperature ---
                        HStack (spacing: 10) {
                            VStack(spacing: 6) {
                                Image(systemName: "\(weather.weather[0].main)".checkIconName())
                                    .renderingMode(.original)
                                    .font(.system(size: 40))
                                
                                Text("\(weather.weather[0].description)".capitalized)
                                    .font(.system(size: 20))
                                    .bold()
                                    .foregroundColor(.cyan)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(
                                width: 120,
                                height: 120,
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
                            
                            Spacer()
                            
                            Text(weather.main.temp.roundDouble(pointnum: 0) + "°C")
                                .font(.system(size: 65))
                                .foregroundColor(.yellow)
                                .multilineTextAlignment(.center)
                                .frame(
                                    width: 165,
                                    height: 120,
                                    alignment: .center
                                )
                                .padding([.leading, .trailing], 20)
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
                                            
                                            WeatherRow(logo: "thermometer.sun.fill", name: "Feels like",
                                                       value: (weather.main.feelsLike.roundDouble(pointnum: 2) + "°C"))
                                            
                                            WeatherRow(logo: "thermometer", name: "Max temp",
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
