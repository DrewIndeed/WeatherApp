//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 30/07/2022.
//

import SwiftUI

struct WeatherView: View {
    var weather: WeatherResponseModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack (spacing: 20) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(weather.name), \(weather.sys.country)")
                        .bold()
                        .font(.title)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                
                Spacer()
                
                VStack {
                    HStack {
                        Spacer()
                        
                        VStack(spacing: 5) {
                            Image(systemName: "sun.max")
                                .font(.system(size: 40))
                                .foregroundColor(.yellow)
                            
                            Text("\(weather.weather[0].main)")
                                .foregroundColor(.cyan)
                        }
                        
                        Spacer()
                        
                        Text(weather.main.temp.roundDouble(pointnum: 0) + "°C")
                            .font(.system(size: 90))
                            .foregroundColor(Color(hue: 0.951, saturation: 0.636, brightness: 0.999))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .padding(0)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        ActivityIndicatorView(
                            divideValue: 10.0)
                        .foregroundColor(.cyan)
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                VStack(alignment: .center, spacing: 20) {
                    Text("Current Status")
                        .font(.system(size: 20.0))
                        .bold()
                    
                    HStack(alignment: .center) {
                        WeatherRow(logo: "thermometer", name: "Min temp",
                                   value: (weather.main.temp_min.roundDouble(pointnum: 2) + ("°C")))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp",
                                   value: (weather.main.temp_max.roundDouble(pointnum: 2) + "°C"))
                    }
                    
                    HStack(alignment: .center, spacing: 20) {
                        WeatherRow(logo: "wind", name: "Wind speed",
                                   value: (weather.wind.speed.roundDouble(pointnum: 2) + " m/s"))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity",
                                   value: "\(weather.main.humidity.roundDouble(pointnum: 0))%")
                        Spacer()
                            .frame(width: 7)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.white)
                .cornerRadius(40, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
