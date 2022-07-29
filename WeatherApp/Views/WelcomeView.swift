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
                Text("Welcome to the Weather App")
                    .bold()
                    .font(.system(size: 40))
                    .foregroundColor(Color(hue: 0.951, saturation: 0.636, brightness: 0.999))
                
                Text("Let's choose where you want to know about the weather, even your area by clicking 'Share Current Location'")
                    .font(.subheadline)
                    .padding()
            }
            .multilineTextAlignment(.center)
            .lineSpacing(5)
            .padding()
            
            // get location permission -> if yes, get location coordinates
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLocation()
            }
            .frame(width: 250, height: 60)
            .background(Color(red: 0.0, green: 0.47843137254901963, blue: 1.0))
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
