//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 30/07/2022.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject var locationManager: LocationManager
    var weather: WeatherResponseModel
    
    // 1. .fixed(value), .flexible(), .adaptive()
    let columns: [GridItem] = [
        GridItem(.fixed(50), spacing: 30, alignment: .leading),
        GridItem(.fixed(50), spacing: 30, alignment: .leading),
    ]
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack (spacing: 20) {
                HStack {
                    // clear location to get back to welcome view
                    Button {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            locationManager.location = nil
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .padding(.leading, 10)
                    }
                    
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("\(weather.name.checkCityTrailing()), \(weather.sys.country)")
                            .bold()
                            .font(.title2)
                        
                        Text("\(Date().formatted(.dateTime.weekday().month().day().hour().minute()))"
                        )
                        .fontWeight(.light)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 10)
                }
                
                Spacer()
                
                VStack {
                    HStack (alignment: .center, spacing: 30) {
                        VStack(spacing: 6) {
                            Image(systemName: "\(weather.weather[0].main)".checkIconName())
                                .renderingMode(.original)
                                .font(.system(size: 40))
                            
                            Text("\(weather.weather[0].description)".capitalized)
                                .font(.system(size: 14))
                                .bold()
                                .foregroundColor(.cyan)
                        }
                        .frame(width: 110, height: 110, alignment: .center)
                        .background(
                            Color(
                                hue: 0.656,
                                saturation: 0.787,
                                brightness: 0.354,
                                opacity: 0.4
                            )
                        )
                        .cornerRadius(30)
                        
                        Text(weather.main.temp.roundDouble(pointnum: 0) + "°C")
                            .font(.system(size: 75))
                            .foregroundColor(Color(hue: 0.951, saturation: 0.503, brightness: 1.0))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .frame(width: 220, height: 120, alignment: .center)
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
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .center) {
                VStack {
                    Spacer()
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
                                WeatherRow(logo: "thermometer", name: "Min temp",
                                           value: (weather.main.tempMin.roundDouble(pointnum: 2) + ("°C")))
                                
                                WeatherRow(logo: "thermometer", name: "Max temp",
                                           value: (weather.main.tempMax.roundDouble(pointnum: 2) + "°C"))
                                
                                WeatherRow(logo: "wind", name: "Wind speed",
                                           value: (weather.wind.speed.roundDouble(pointnum: 2) + " m/s"))
                                WeatherRow(logo: "humidity", name: "Humidity",
                                           value: "\(weather.main.humidity.roundDouble(pointnum: 0))%")
                            }
                        )
                        .padding(.bottom, 20)
                    }
                    .frame(
                        minWidth: nil, maxWidth: .infinity,
                        minHeight: nil, maxHeight: 250,
                        alignment: .center
                    )
                    .foregroundColor(.white)
                    .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354, opacity: 0.4))
                    .cornerRadius(40,
                                  corners: [.topLeft, .topRight, .bottomLeft, .bottomRight]
                    )
                }
            }
            .padding(20)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            BgVideoView(videoName: "weather_vid")
        )
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
