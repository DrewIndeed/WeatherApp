//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Andrew Le Nguyen on 28/07/2022.
//

import SwiftUI

// for the Location Button
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        VStack {
            // textual content
            VStack (spacing: 20) {
                Text("Welcome to the Weather App").bold().font(.largeTitle)
                
                Text("Let's choose where you want to know about the weather, even your area by clicking 'Share Current Location'")
                    .padding()
            }
            .multilineTextAlignment(.center)
            .lineSpacing(5)
            .padding()
            
            // get location permission -> if yes, get location coordinates
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(width: .infinity, height: .infinity)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
