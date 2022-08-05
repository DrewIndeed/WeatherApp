//
//  AustraliaCitiesView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 03/08/2022.
//

import SwiftUI
import CoreLocation

struct AustraliaCitiesView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var weatherManager: WeatherManager
    var cities: CitiesResponseModel
    
    @State var isCitySelected: Bool = false
    @State var backgroundColor: Color = Color(hue: 0.656, saturation: 0.787, brightness: 0.354) // dark blue
    
    var body: some View {
        ZStack {
            // background
            backgroundColor.ignoresSafeArea(.all)
            
            // if a city clicked
            if (isCitySelected) {
                // if weatherData has been updated / fetched
                if weatherManager.weatherData != nil {
                    // show ContentView
                    ContentView()
                } else {
                    // if not, show loading and start fetching
                    ActivityIndicatorView(divideValue: 9.0)
                        .task {
                            do {
                                // fetch new weather data based on selected city coors
                                try await weatherManager
                                    .getCurrentWeather(
                                        latitude: locationManager.location!.latitude,
                                        longitude: locationManager.location!.longitude
                                    )
                            } catch {
                                print("[ERROR GETTING WEATHER at AustraliaCitiesView]: \(error)")
                            }
                        }
                }
            } else {
                List {
                    ForEach(0..<cities.citiesList.count, id: \.self) { index in
                        // set new location based on chosen city
                        Button(action: {
                            locationManager.location = CLLocationCoordinate2D (
                                latitude: Double(cities.citiesList[index].lat)!, longitude: Double(cities.citiesList[index].lng)!
                            )
                        }, label: {
                            VStack (alignment: .leading) {
                                HStack (spacing: 30) {
                                    Text("\( (cities.citiesList[index].city).substring(toIndex: 1) )")
                                        .font(.system(size: 30))
                                        .foregroundColor(.yellow)
                                        .bold()
                                        .frame(width: 50, height: 50)
                                        .overlay(
                                            Circle().stroke(.pink, lineWidth: 3)
                                        )
                                    
                                    Text("\(cities.citiesList[index].city)")
                                        .font(.system(size: 25))
                                        .foregroundColor(.white)
                                }
                                .padding(.leading, 20)
                                
                                Divider()
                                    .frame(height: 2)
                                    .background(.white)
                            }
                            .padding(.top, 20)
                        })
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .frame(minWidth: nil, maxWidth: .infinity,
                               minHeight: nil, maxHeight: .infinity,
                               alignment: .leading)
                        .background(backgroundColor)
                    }
                }
                .listStyle(.plain)
                .navigationBarTitle("Choose One City", displayMode: .inline)
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct AustraliaCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AustraliaCitiesView(cities: previewCities)
    }
}
